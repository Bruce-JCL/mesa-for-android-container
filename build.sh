#!/bin/bash
set -euo pipefail

source_dir=$(cd "$(dirname "$0")" && pwd)
workspace_dir=$(dirname "$source_dir")
action="${1:-build}"
build_dir="${BUILD_DIR:-$source_dir/build-aarch64}"
meson_py="${MESON:-$workspace_dir/.build-tools/meson-1.4.2/meson.py}"
host_tools="$workspace_dir/.build-tools/host/usr"
toolchain_host_lib=/mnt/jiangchangliang/toolchain/usr/lib/x86_64-linux-gnu

export PATH="$host_tools/bin:$PATH"
export LD_LIBRARY_PATH="$host_tools/lib/x86_64-linux-gnu:$toolchain_host_lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export BISON_PKGDATADIR="$host_tools/share/bison"

meson_args=(
  --cross-file "$source_dir/cross-aarch64-linux-gnu.ini"
  --native-file "$source_dir/native-build-tools.ini"
  --prefix=/usr
  --libdir=lib/aarch64-linux-gnu
  -Dplatforms=x11,wayland
  -Dgallium-drivers=freedreno,zink,virgl,llvmpipe
  -Dgallium-va=disabled
  -Dgallium-mediafoundation=disabled
  -Dvulkan-drivers=freedreno
  -Dvulkan-layers=
  -Degl=enabled
  -Dgles2=enabled
  -Dglvnd=enabled
  -Dglx=dri
  -Dlibunwind=disabled
  -Dintel-rt=disabled
  -Dmicrosoft-clc=disabled
  -Dvalgrind=disabled
  -Dgles1=disabled
  -Dfreedreno-kmds=kgsl
  -Dbuildtype=release
)

configure() {
  if [ ! -f "$build_dir/build.ninja" ]; then
    env -u http_proxy -u https_proxy -u HTTP_PROXY -u HTTPS_PROXY \
      python3 "$meson_py" setup "$build_dir" "${meson_args[@]}"
  fi
}

case "$action" in
  configure)
    configure
    ;;
  build)
    configure
    ninja -C "$build_dir"
    ;;
  deb)
    configure
    ninja -C "$build_dir"
    "$source_dir/debian/package-all-debs.sh" "$build_dir" "$source_dir"
    ;;
  *)
    echo "用法: $0 {configure|build|deb}"
    exit 1
    ;;
esac
