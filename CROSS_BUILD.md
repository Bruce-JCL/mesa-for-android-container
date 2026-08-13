# ARM64 交叉编译与完整 deb 打包

本工程使用 `/mnt/jiangchangliang/toolchain` 的 AArch64 GCC 和
`/mnt/jiangchangliang/sysroot` 的 Ubuntu 22.04 ARM64 依赖。

```bash
./build.sh build
./build.sh deb
```

`deb` 会先完成构建，再把 Meson 的全部安装产物拆分到 Ubuntu 对应的包中。
产物位于 `build-aarch64/deb-packages/`。打包脚本发现任何未归属文件时会失败，
因此新增 `.so` 不会被静默遗漏。

生成的包包括：`libegl-mesa0`、`libegl1-mesa-dev`、`libgbm1`、
`libgbm-dev`、`libgl1-mesa-dri`、`libglx-mesa0`、`mesa-common-dev`、
`mesa-vulkan-drivers` 和构建所用的 `wayland-protocols`。

板端安装后可执行：

```bash
sudo apt-mark hold libegl-mesa0 libegl1-mesa-dev libgbm1 libgbm-dev \
  libgl1-mesa-dri libglx-mesa0 mesa-common-dev mesa-vulkan-drivers \
  wayland-protocols
```
