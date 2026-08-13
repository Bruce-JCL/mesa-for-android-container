#!/bin/bash
set -euo pipefail

build_dir=$(realpath "${1:?缺少 Meson build 目录}")
source_dir=$(realpath "${2:-$(dirname "$0")/..}")
meson_py="$(dirname "$source_dir")/.build-tools/meson-1.4.2/meson.py"
version="${MESA_DEB_VERSION:-25.3.0-devel-20250725+xory1}"
wayland_version="${WAYLAND_PROTOCOLS_DEB_VERSION:-1.41-1+xory1}"
arch=arm64
work_dir=$(mktemp -d "${TMPDIR:-/tmp}/mesa-deb.XXXXXX")
stage_dir="$work_dir/stage"
packages_dir="$work_dir/packages"
output_dir="$build_dir/deb-packages"

cleanup() { rm -rf "$work_dir"; }
trap cleanup EXIT

DESTDIR="$stage_dir" python3 "$meson_py" install -C "$build_dir"
mkdir -p "$packages_dir" "$output_dir"
rm -f "$output_dir"/*.deb

make_control() {
  local package=$1 architecture=$2 depends=$3 description=$4 root="$packages_dir/$1"
  mkdir -p "$root/DEBIAN" "$root/usr/share/doc/$package"
  cat >"$root/DEBIAN/control" <<EOF
Package: $package
Version: $version
Architecture: $architecture
Maintainer: Xory Build <xory@localhost>
Section: libs
Priority: optional
Depends: $depends
Description: $description
 Cross-compiled Xory Mesa build with Freedreno KGSL and DRI3 sharing support.
EOF
  if [ -f "$source_dir/docs/license.rst" ]; then
    cp "$source_dir/docs/license.rst" "$root/usr/share/doc/$package/copyright"
  fi
}

move_path() {
  local package=$1 path=$2
  local src="$stage_dir/$path" dst="$packages_dir/$package/$path"
  [ -e "$src" ] || [ -L "$src" ] || { echo "缺少安装产物: /$2" >&2; exit 1; }
  mkdir -p "$(dirname "$dst")"
  mv "$src" "$dst"
}

move_tree() {
  local package=$1 path=$2
  local src="$stage_dir/$path" dst="$packages_dir/$package/$path"
  [ -d "$src" ] || { echo "缺少安装目录: /$2" >&2; exit 1; }
  mkdir -p "$(dirname "$dst")"
  mv "$src" "$dst"
}

make_control libgl1-mesa-dri "$arch" \
  'libc6 (>= 2.34), libdrm2, libelf1, libexpat1, libgcc-s1, libllvm15, libstdc++6, libxcb-dri3-0, libxcb-present0, libxcb-randr0, libxcb-xfixes0, libxcb1, libzstd1, zlib1g' \
  'Mesa DRI modules and Gallium drivers for Xory'
make_control libegl-mesa0 "$arch" \
  "libc6 (>= 2.34), libdrm2, libexpat1, libgbm1 (= $version), libgl1-mesa-dri (= $version), libwayland-client0, libxcb-dri3-0, libxcb-present0, libxcb-randr0, libxcb-xfixes0, libxcb1" \
  'Mesa EGL vendor library for Xory'
make_control libglx-mesa0 "$arch" \
  "libc6 (>= 2.34), libdrm2, libexpat1, libgl1-mesa-dri (= $version), libx11-6, libxcb-dri3-0, libxcb-glx0, libxcb-present0, libxcb-xfixes0, libxcb1, libxext6, libxxf86vm1" \
  'Mesa GLX vendor library for Xory'
make_control libgbm1 "$arch" \
  "libc6 (>= 2.34), libdrm2, libexpat1, libgl1-mesa-dri (= $version)" \
  'Mesa generic buffer management runtime for Xory'
make_control mesa-vulkan-drivers "$arch" \
  'libc6 (>= 2.34), libdrm2, libexpat1, libgcc-s1, libstdc++6, libudev1, libvulkan1, libwayland-client0, libxcb-dri3-0, libxcb-present0, libxcb-randr0, libxcb-sync1, libxcb-xfixes0, libxcb1, libxshmfence1, libzstd1' \
  'Mesa Freedreno Vulkan driver for Xory'
make_control libegl1-mesa-dev "$arch" 'libegl-dev, libglvnd-dev' \
  'Mesa EGL development files for Xory'
make_control libgbm-dev "$arch" "libgbm1 (= $version)" \
  'Mesa GBM development files for Xory'
make_control mesa-common-dev "$arch" 'libdrm-dev, libgl-dev, libglx-dev, libx11-dev' \
  'Mesa common development files for Xory'
make_control wayland-protocols all '' \
  'Wayland protocol definitions used by this Mesa build'
sed -i "s/^Version: .*/Version: $wayland_version/" \
  "$packages_dir/wayland-protocols/DEBIAN/control"

for package in libgl1-mesa-dri libegl-mesa0 libglx-mesa0 libgbm1 mesa-vulkan-drivers; do
  cat >"$packages_dir/$package/DEBIAN/postinst" <<'EOF'
#!/bin/sh
set -e
ldconfig
EOF
  cat >"$packages_dir/$package/DEBIAN/postrm" <<'EOF'
#!/bin/sh
set -e
ldconfig
EOF
  chmod 0755 "$packages_dir/$package/DEBIAN/postinst" \
    "$packages_dir/$package/DEBIAN/postrm"
done

libdir=usr/lib/aarch64-linux-gnu

move_path libgl1-mesa-dri "$libdir/libgallium-25.3.0-devel.so"
move_tree libgl1-mesa-dri "$libdir/dri"
move_path libgl1-mesa-dri usr/share/drirc.d/00-mesa-defaults.conf

move_path libegl-mesa0 "$libdir/libEGL_mesa.so.0.0.0"
move_path libegl-mesa0 "$libdir/libEGL_mesa.so.0"
move_path libegl-mesa0 usr/share/glvnd/egl_vendor.d/50_mesa.json
move_path libegl1-mesa-dev "$libdir/libEGL_mesa.so"
move_tree libegl1-mesa-dev usr/include/EGL

move_path libglx-mesa0 "$libdir/libGLX_mesa.so.0.0.0"
move_path libglx-mesa0 "$libdir/libGLX_mesa.so.0"
move_path libglx-mesa0 "$libdir/libGLX_mesa.so"

move_path libgbm1 "$libdir/libgbm.so.1.0.0"
move_path libgbm1 "$libdir/libgbm.so.1"
move_tree libgbm1 "$libdir/gbm"
move_path libgbm-dev "$libdir/libgbm.so"
move_path libgbm-dev "$libdir/pkgconfig/gbm.pc"
move_path libgbm-dev usr/include/gbm.h
move_path libgbm-dev usr/include/gbm_backend_abi.h

move_path mesa-common-dev "$libdir/pkgconfig/dri.pc"
move_tree mesa-common-dev usr/include/GL

move_path mesa-vulkan-drivers "$libdir/libvulkan_freedreno.so"
move_tree mesa-vulkan-drivers usr/share/vulkan

move_tree wayland-protocols usr/share/wayland-protocols
move_path wayland-protocols usr/share/pkgconfig/wayland-protocols.pc

# Empty directories are harmless; any remaining file is an unassigned artifact
# and must stop packaging so that new libraries can never be silently omitted.
mapfile -t leftovers < <(find "$stage_dir" \( -type f -o -type l \) -print)
if ((${#leftovers[@]})); then
  echo '以下 Meson 安装产物未分配到 deb:' >&2
  printf '  %s\n' "${leftovers[@]#$stage_dir}" >&2
  exit 1
fi

for package_root in "$packages_dir"/*; do
  package=$(basename "$package_root")
  chmod 0755 "$package_root/DEBIAN"
  if find "$package_root/usr" -type f -print0 | xargs -0 -r file | grep -q 'ELF'; then
    while IFS= read -r -d '' elf; do
      file "$elf" | grep -q 'ELF' && /mnt/jiangchangliang/toolchain/usr/bin/aarch64-linux-gnu-strip --strip-unneeded "$elf"
    done < <(find "$package_root/usr" -type f -print0)
  fi
  (cd "$package_root" && find usr -type f -exec md5sum {} + >DEBIAN/md5sums)
  dpkg-deb --root-owner-group --build "$package_root" "$output_dir/${package}_${version}_${arch}.deb" >/dev/null
done

# Architecture-all packages conventionally use _all in their filename.
mv "$output_dir/wayland-protocols_${version}_${arch}.deb" \
   "$output_dir/wayland-protocols_${wayland_version}_all.deb"

echo "已生成全部 Mesa deb: $output_dir"
ls -1 "$output_dir"/*.deb
