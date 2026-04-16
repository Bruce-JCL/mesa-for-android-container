pipeline {
    agent {
        docker {
            image 'fedora:43'
            args  '--privileged --user root'
            label 'linux-arm64'
        }
    }

    parameters {
        string(
            name: 'TAG',
            defaultValue: 'adreno-fedora-f43',
            description: 'Branch or tag to build'
        )
        booleanParam(
            name: 'DRAFT_RELEASE',
            defaultValue: false,
            description: 'Draft a new release after build'
        )
    }

    options {
        timestamps()
        ansiColor('xterm')
    }

    environment {
        CCACHE_DIR    = '/root/.ccache'
        MESA_REPO_URL = 'https://github.com/lfdevs/mesa-for-android-container.git'
        RELEASE_REPO  = 'lfdevs/mesa-for-android-container'
    }

    stages {

        stage('Install Dependencies') {
            steps {
                sh '''#!/bin/bash
                    set -euo pipefail
                    echo "assumeyes=True" >> /etc/dnf/dnf.conf
                    dnf install -y dnf-plugins-core git ccache fedpkg fedora-packager \
                        rpmdevtools libarchive-devel
                    dnf config-manager setopt fedora-source.enabled=1 updates-source.enabled=1
                    dnf makecache
                    dnf builddep -y mesa
                '''
            }
        }

        stage('Configure ccache') {
            steps {
                sh '''#!/bin/bash
                    ccache --max-size=2G
                    ccache --show-config
                    ccache --zero-stats
                    ccache --show-stats
                '''
            }
        }

        stage('Clone Repository') {
            steps {
                sh '''#!/bin/bash
                    set -euo pipefail
                    cd ~
                    git config --global user.email "jenkins@localhost"
                    git config --global user.name "Jenkins"
                    rm -rf mesa-for-android-container
                    git clone -b "$TAG" --depth 1 "$MESA_REPO_URL" mesa-for-android-container
                '''
            }
        }

        stage('Build Mesa') {
            steps {
                sh '''#!/bin/bash
                    set -euo pipefail
                    echo "Building Mesa..."
                    cd ~/mesa-for-android-container
                    version=$(grep -oP "%global\\s+ver\\s+\\K[0-9.]+" mesa.spec)
                    curl -L -O "https://archive.mesa3d.org/mesa-${version}.tar.xz"
                    if [ $? -ne 0 ]; then
                        echo "Error: Failed to download mesa-${version}.tar.xz"
                        exit 1
                    fi
                    rpmbuild -ba mesa.spec \
                        --define "_sourcedir $(pwd)" \
                        --define "_specdir $(pwd)"
                    echo "Mesa build completed successfully!"
                '''
            }
            post {
                always { sh 'ccache --show-stats || true' }
            }
        }

        stage('Collect Packages') {
            steps {
                script {
                    sh '''#!/bin/bash
                        set -euo pipefail
                        cd ~/rpmbuild/RPMS/aarch64
                        rm -f *devel* *debug*
                    '''

                    if (params.TAG.contains('turnip')) {
                        sh '''#!/bin/bash
                            set -euo pipefail
                            cd ~/rpmbuild/RPMS/aarch64
                            find . -maxdepth 1 -type f -name "*.rpm" ! -name "mesa-vulkan-drivers*" -delete
                        '''
                    }

                    sh '''#!/bin/bash
                        set -euo pipefail
                        cd ~/rpmbuild/RPMS/aarch64
                        echo "Calculating sha256 checksums..."
                        find . -maxdepth 1 -name "*.rpm" -type f \
                            -printf "%P\\0" | xargs -0 sha256sum | sort -k2 > sha256sums.txt
                        cat sha256sums.txt && echo
                        cp ~/rpmbuild/RPMS/aarch64/sha256sums.txt "$WORKSPACE/sha256sums.txt"
                        cp ~/rpmbuild/RPMS/aarch64/*.rpm "$WORKSPACE/" 2>/dev/null || true
                    '''

                    archiveArtifacts(
                        artifacts: '*.rpm, sha256sums.txt',
                        fingerprint: true
                    )
                }
            }
        }

        stage('Draft Release') {
            when {
                expression { return params.DRAFT_RELEASE }
            }
            steps {
                script {
                    sh '''#!/bin/bash
                        set -euo pipefail

                        checksums=$(cat "$WORKSPACE/sha256sums.txt" 2>/dev/null \
                            | awk "NF>=2 {print \$1 \"  \" \$2}" | sort -k2,2 || true)

                        cat > release_body.md << 'MDEOF'
## Checksums
```plaintext
MDEOF
                        printf "%s\\n" "$checksums" >> release_body.md
                        printf "%s\\n" '```' >> release_body.md
                    '''

                    sh 'cat release_body.md'

                    sh """
                        set -euo pipefail
                        rpm_file=\$(find "\$WORKSPACE" -maxdepth 1 -name 'mesa-vulkan-drivers*.rpm' \
                            -type f -print -quit || true)
                        if [ -n "\$rpm_file" ]; then
                            basename_=\$(basename "\$rpm_file")
                            without_ext="\${basename_%.rpm}"
                            version_with_arch="\${without_ext#mesa-vulkan-drivers-}"
                            version="\${version_with_arch%.*}"
                        else
                            version="unknown"
                        fi
                        tag="${params.TAG}"
                        if [[ "\$tag" == *"turnip"* ]]; then
                            title="turnip-\${version}_fedora_43"
                        else
                            title="\${version}_fedora_43"
                        fi
                        echo "Release title: \$title"
                        echo "\$title" > "\$WORKSPACE/.release_title"
                    """

                    withCredentials([string(credentialsId: 'github-cli-token', variable: 'GH_TOKEN')]) {
                        sh """
                            set -euo pipefail
                            tag="${params.TAG}"
                            title=\$(cat "\$WORKSPACE/.release_title")
                            gh release create "\$tag" \
                                --title "\$title" \
                                --notes-file release_body.md \
                                --draft \
                                --repo "\$RELEASE_REPO" \
                                \$WORKSPACE/*.rpm \
                                || gh release edit "\$tag" \
                                    --title "\$title" \
                                    --notes-file release_body.md \
                                    --draft \
                                    --repo "\$RELEASE_REPO"
                        """
                    }
                }
            }
        }

    } // end stages

    post {
        always {
            echo "Pipeline finished with status: ${currentBuild.currentResult}"
        }
        success {
            echo "All stages completed successfully."
        }
        failure {
            echo "Pipeline failed. Check individual stage logs for details."
        }
    }
}
