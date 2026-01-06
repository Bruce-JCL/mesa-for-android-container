# Turnip-only build for freedreno Vulkan driver with KGSL support
# Only builds the Vulkan driver, no OpenGL/Gallium
%global with_hardware 1
%global with_freedreno 1

Name:           mesa
Summary:        Mesa graphics libraries
%global ver 25.2.7
Version:        %{lua:ver = string.gsub(rpm.expand("%{ver}"), "-", "~"); print(ver)}
Release:        4%{?dist}
License:        MIT AND BSD-3-Clause AND SGI-B-2.0
URL:            http://www.mesa3d.org

Source0:        https://archive.mesa3d.org/mesa-%{ver}.tar.xz
# src/gallium/auxiliary/postprocess/pp_mlaa* have an ... interestingly worded license.
# Source1 contains email correspondence clarifying the license terms.
# Fedora opts to ignore the optional part of clause 2 and treat that code as 2 clause BSD.
Source1:        Mesa-MLAA-License-Clarification-Email.txt

Patch10:        gnome-shell-glthread-disable.patch

# fix zink/device-select bug
Patch11:        0001-device-select-add-a-layer-setting-to-disable-device-.patch
Patch12:        0002-zink-use-device-select-layer-settings-to-disable-dev.patch

BuildRequires:  meson >= 1.3.0
BuildRequires:  gcc
BuildRequires:  gcc-c++
BuildRequires:  gettext
%if 0%{?with_hardware}
BuildRequires:  kernel-headers
BuildRequires:  systemd-devel
%endif
# We only check for the minimum version of pkgconfig(libdrm) needed so that the
# SRPMs for each arch still have the same build dependencies. See:
# https://bugzilla.redhat.com/show_bug.cgi?id=1859515
BuildRequires:  pkgconfig(libdrm) >= 2.4.122
BuildRequires:  pkgconfig(expat)
BuildRequires:  pkgconfig(zlib) >= 1.2.3
BuildRequires:  pkgconfig(libzstd)
BuildRequires:  pkgconfig(wayland-scanner)
BuildRequires:  pkgconfig(wayland-protocols) >= 1.34
BuildRequires:  pkgconfig(wayland-client) >= 1.11
BuildRequires:  pkgconfig(wayland-server) >= 1.11
BuildRequires:  pkgconfig(wayland-egl-backend) >= 3
BuildRequires:  pkgconfig(x11)
BuildRequires:  pkgconfig(xext)
BuildRequires:  pkgconfig(xdamage) >= 1.1
BuildRequires:  pkgconfig(xfixes)
BuildRequires:  pkgconfig(xcb-glx) >= 1.8.1
BuildRequires:  pkgconfig(xxf86vm)
BuildRequires:  pkgconfig(xcb)
BuildRequires:  pkgconfig(x11-xcb)
BuildRequires:  pkgconfig(xcb-dri2) >= 1.8
BuildRequires:  pkgconfig(xcb-dri3)
BuildRequires:  pkgconfig(xcb-present)
BuildRequires:  pkgconfig(xcb-sync)
BuildRequires:  pkgconfig(xshmfence) >= 1.1
BuildRequires:  pkgconfig(dri2proto) >= 2.8
BuildRequires:  pkgconfig(glproto) >= 1.4.14
BuildRequires:  pkgconfig(xcb-xfixes)
BuildRequires:  pkgconfig(xcb-randr)
BuildRequires:  pkgconfig(xrandr) >= 1.3
BuildRequires:  bison
BuildRequires:  flex
BuildRequires:  pkgconfig(libelf)
BuildRequires:  pkgconfig(libglvnd) >= 1.3.2
BuildRequires:  llvm-devel >= 7.0.0
BuildRequires:  python3-devel
BuildRequires:  python3-mako
BuildRequires:  python3-pycparser
BuildRequires:  python3-pyyaml
BuildRequires:  vulkan-headers
BuildRequires:  glslang

%description
%{summary}.

%package filesystem
Summary:        Mesa driver filesystem
Provides:       mesa-dri-filesystem = %{?epoch:%{epoch}:}%{version}-%{release}

%description filesystem
%{summary}.

%package vulkan-drivers
Summary:        Mesa Vulkan drivers
Requires:       vulkan%{_isa}
Requires:       %{name}-filesystem%{?_isa} = %{?epoch:%{epoch}:}%{version}-%{release}
Obsoletes:      mesa-vulkan-devel < %{?epoch:%{epoch}:}%{version}-%{release}

%description vulkan-drivers
The drivers with support for the Vulkan API.

%prep
%autosetup -n %{name}-%{ver} -p1
cp %{SOURCE1} docs/


%build
# We've gotten a report that enabling LTO for mesa breaks some games. See
# https://bugzilla.redhat.com/show_bug.cgi?id=1862771 for details.
# Disable LTO for now
%define _lto_cflags %{nil}

%meson \
  -Dplatforms=x11,wayland \
  -Dgallium-drivers= \
  -Dgallium-vdpau=disabled \
  -Dgallium-va=disabled \
  -Dgallium-mediafoundation=disabled \
  -Dvulkan-drivers=freedreno \
  -Dvulkan-layers= \
  -Dgles1=disabled \
  -Dgles2=disabled \
  -Dopengl=false \
  -Dgbm=disabled \
  -Dglx=disabled \
  -Dxlib-lease=disabled \
  -Dfreedreno-kmds=kgsl \
  -Degl=disabled \
  -Dglvnd=disabled \
  -Dintel-rt=disabled \
  -Dmicrosoft-clc=disabled \
  -Dllvm=disabled \
  -Dvalgrind=disabled \
  -Dbuild-tests=false \
  -Dlibunwind=disabled \
  -Dlmsensors=disabled \
  -Dandroid-libbacktrace=disabled \
  %{nil}
%meson_build

%install
%meson_install

# Remove files that belong to dri-drivers package (not built in this config)
rm -rf %{buildroot}%{_datadir}/drirc.d

%files filesystem
%doc docs/Mesa-MLAA-License-Clarification-Email.txt
%dir %{_datadir}/vulkan
%dir %{_datadir}/vulkan/icd.d
%exclude %{_datadir}/drirc.d/00-mesa-defaults.conf


%files vulkan-drivers
# freedreno vulkan driver (Turnip)
%{_libdir}/libvulkan_freedreno.so
%{_datadir}/vulkan/icd.d/freedreno_icd.*.json

%changelog
%autochangelog
