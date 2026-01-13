# Build packages compatible with package managers

If you need to build installable packages that can be managed by package managers (such as `apt`, `dnf`, or `pacman`), refer to the following commands. Before running them, please ensure that the source repositories are enabled.

## Debian/Ubuntu

```bash
# Install the dependencies
sudo apt install build-essential devscripts fakeroot quilt git-buildpackage pristine-tar
sudo apt build-dep mesa

# Clone the corresponding branch. If you need to build the Turnip driver separately, clone a branch with the 'turnip' prefix.
# For Debian:
git clone -b adreno-debian-trixie https://github.com/lfdevs/mesa-for-android-container.git  
# For Ubuntu:
git clone -b adreno-ubuntu-noble-updates https://github.com/lfdevs/mesa-for-android-container.git  

cd mesa-for-android-container

# Generate the source tarball
origtargz
# Start the build; the final DEB packages will be placed in the parent directory
gbp buildpackage -uc -us -jauto --git-ignore-branch
```

## Fedora

```bash
# Install the dependencies
sudo dnf install git fedpkg fedora-packager rpmdevtools
sudo dnf builddep mesa
# Clone the corresponding branch. If you need to build the Turnip driver separately, clone a branch with the 'turnip' prefix.
git clone -b adreno-fedora-f43 https://github.com/lfdevs/mesa-for-android-container.git  
cd mesa-for-android-container
# Download the Mesa source tarball for the corresponding version
wget https://archive.mesa3d.org/mesa-25.2.7.tar.xz  
# Start the build; the final RPM packages will be generated in '~/rpmbuild/RPMS/aarch64/'
rpmbuild -ba mesa.spec --define "_sourcedir $(pwd)" --define "_specdir $(pwd)"
```

## Arch Linux

```bash
# Install the dependencies
sudo pacman -S base-devel git
# Clone the 'freedreno' branch. If you need to build the Turnip driver separately, clone the 'turnip' branch instead.
git clone -b freedreno https://github.com/lfdevs/archlinuxarm-PKGBUILDs.git  
cd archlinuxarm-PKGBUILDs/extra/mesa/
# Start the build; the final packages will be generated in the current directory
makepkg -s
```
