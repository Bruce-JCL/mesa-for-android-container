pipeline {
    agent {
        docker {
            image 'debian:trixie'
            args  '--privileged --user root'
            label 'linux-arm64'
        }
    }

    parameters {
        string(
            name: 'TAG',
            defaultValue: 'adreno-debian-trixie',
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
        CCACHE_DIR   = '/root/.ccache'
        MESA_REPO_URL = 'https://github.com/lfdevs/mesa-for-android-container.git'
        RELEASE_REPO  = 'lfdevs/mesa-for-android-container'
    }

    stages {

        stage('Install Dependencies') {
            steps {
                sh '''#!/bin/bash
                    set -euo pipefail
                    export DEBIAN_FRONTEND=noninteractive
                    sed -i "s/^Types: deb$/Types: deb deb-src/" /etc/apt/sources.list.d/debian.sources
                    apt update
                    apt build-dep -y mesa
                    apt install -y git ccache build-essential devscripts fakeroot quilt \
                        git-buildpackage pristine-tar libxfixes-dev libarchive-dev
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
                    origtargz
                    gbp buildpackage -uc -us -jauto --git-ignore-branch
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
                        cd ~
                        rm -f *dev* *dbgsym* libosmesa*.deb mesa-va-drivers*.deb mesa-vdpau-drivers*.deb
                    '''

                    if (params.TAG.contains('turnip')) {
                        sh '''#!/bin/bash
                            set -euo pipefail
                            cd ~
                            find . -maxdepth 1 -type f -name "*.deb" ! -name "mesa-vulkan-drivers*" -delete
                        '''
                    }

                    sh '''#!/bin/bash
                        set -euo pipefail
                        cd ~
                        echo "Calculating sha256 checksums..."
                        find . -maxdepth 1 -name "*.deb" -type f \
                            -printf "%P\\0" | xargs -0 sha256sum | sort -k2 > sha256sums.txt
                        cat sha256sums.txt && echo
                        cp ~/sha256sums.txt "$WORKSPACE/sha256sums.txt"
                        cp ~/*.deb "$WORKSPACE/" 2>/dev/null || true
                    '''

                    archiveArtifacts(
                        artifacts: '*.deb, sha256sums.txt',
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
                        version=\$(find "\$WORKSPACE" -maxdepth 1 -name 'mesa-vulkan-drivers*.deb' \
                            -type f -print -quit | xargs basename | cut -d'_' -f2 || echo "unknown")
                        tag="${params.TAG}"
                        if [[ "\$tag" == *"turnip"* ]]; then
                            title="turnip-\${version}_debian_trixie"
                        else
                            title="\${version}_debian_trixie"
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
                                \$WORKSPACE/*.deb \
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
