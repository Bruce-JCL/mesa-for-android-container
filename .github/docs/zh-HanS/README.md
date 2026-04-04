# Mesa for Android Container
Forked From [Mesa - The 3D Graphics Library](https://gitlab.freedesktop.org/mesa/mesa)  

[English](../../README.md) | **简体中文** | [繁體中文](../zh-HanT/README.md)  

---  
一个适用于 Android 容器（Proot、Chroot、LXC 等）的 [Mesa](https://gitlab.freedesktop.org/mesa/mesa) 构建，支持 Adreno GPU 的硬件加速。  

## 特性
  - Mesa 26.0.0 及以上版本的 Freedreno 和 Turnip 驱动支持 Adreno 8xx GPU。  
  - 在多个主流的 Linux 发行版的 arm64 Chroot 容器下分别编译，兼容性更好，以 Android 为宿主机的 Proot、Chroot、LXC 容器均可使用本项目编译的 Mesa 驱动。  
  - 对于部分 Adreno 6xx/7xx/8xx GPU，OpenGL、OpenGL ES、Vulkan 均可使用 Freedreno 驱动，不再需要使用 Zink 进行图形 API 调用转换，极大地提高了 GPU 的利用效率。  
  - 只编译与绝大部分 Android 设备相关的驱动，减小包体体积。  
## 兼容性
这里只展示了经我和其他人实测后确认支持的 GPU 型号，**不代表其他的 GPU 型号不支持**。你可以在 [freedreno_devices.py](https://github.com/lfdevs/mesa-for-android-container/blob/turnip-main/src/freedreno/common/freedreno_devices.py) 文件中搜索你设备的 GPU 型号（例如，Adreno 725 可搜索`725`），若该型号有完整的设备定义，则它很可能受支持。欢迎在 [Issues](https://github.com/lfdevs/mesa-for-android-container/issues) 中分享驱动在你的设备上的运行情况，这将帮助我们完善下面的这张表。  

|              GPU               | OpenGL | OpenGL ES | Vulkan |
| :----------------------------: | :----: | :-------: | :----: |
|         **Adreno 660**         |  ✔️支持  |   ✔️支持    |  ✔️支持  |
| **Adreno 710/720/730/735/740/750** |  ✔️支持  |   ✔️支持    |  ✔️支持  |
|       **Adreno 829/830/840**       |  ✔️支持  |   ✔️支持    |  ✔️支持  |

实验性支持（by [**whitebelyash**](https://github.com/whitebelyash)）：**Adreno 810/825**  
## 安装
本项目的 Releases 有两种形式的安装包，一种可以使用 Linux 发行版的软件包管理器安装，另一种只能直接解压来安装。推荐使用第一种安装包，若需要最新的 Mesa 特性（如 **Adreno 8xx 的支持**），则可以使用第二种。  
若常规的 Release （标题不带`turnip-`前缀）的 Turnip 驱动不能正常运行，可以使用**未打补丁的 Turnip 驱动**（标题带`turnip-`前缀），直接覆盖安装即可。  
**PS:** 本项目提到的“未打补丁”指的是没有应用 xMeM 的原始补丁，依然会应用一些必要的补丁（如更多的 GPU 支持）。  
### 使用软件包管理器
根据使用的 Linux 发行版，前往 [Releases](https://github.com/lfdevs/mesa-for-android-container/releases) 下载某个对应的 Release 的所有软件包，按照 Release 说明中的安装说明进行安装。以下为一些主流的 Linux 发行版对应的最新 Release：  

|    Linux 发行版     |                                                              最新 Release                                                              |                                                               未打补丁的 Turnip 驱动                                                               |
| :--------------: | :----------------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------: |
|    Debian 13     |            [25.0.7-2+deb13u1](https://github.com/lfdevs/mesa-for-android-container/releases/tag/debian%2F25.0.7-2-adreno)            |            [turnip-25.0.7-2+deb13u1](https://github.com/lfdevs/mesa-for-android-container/releases/tag/debian%2F25.0.7-2-turnip)            |
| Ubuntu 24.04 LTS | [25.0.7-0ubuntu0.24.04.2](https://github.com/lfdevs/mesa-for-android-container/releases/tag/import%2F25.0.7-0ubuntu0.24.04.2-adreno) | [turnip-25.0.7-0ubuntu0.24.04.2](https://github.com/lfdevs/mesa-for-android-container/releases/tag/import%2F25.0.7-0ubuntu0.24.04.2-turnip) |
|    Fedora 43     |             [25.2.7-4.fc43](https://github.com/lfdevs/mesa-for-android-container/releases/tag/mesa-25.2.7-4.fc43-adreno)             |               [turnip-25.2.7-4.fc43](https://github.com/lfdevs/mesa-for-android-container/releases/tag/turnip-25.2.7-4.fc43)                |
|    Arch Linux    |               [26.1.0-4](https://github.com/lfdevs/mesa-for-android-container/releases/tag/mesa-26.1.0-devel-20260404)               |              [turnip-26.1.0-4](https://github.com/lfdevs/mesa-for-android-container/releases/tag/turnip-26.1.0-devel-20260404)              |
### 直接解压
ℹ️**注意**：Releases 中`.tar.gz`格式的安装包只能覆盖原来的 Mesa 驱动，卸载时需要手动删除解压得到的文件，仅供测试使用。  

1. 前往 [Releases](https://github.com/lfdevs/mesa-for-android-container/releases) 下载`.tar.gz`格式的安装包。请注意文件名中的 Linux 发行版后缀，如`debian_trixie_arm64`，只能安装发行版匹配的安装包。对于 **Adreno 7xx/8xx**，一般先解压标准安装包（包含 Freedreno），再解压未打补丁的 Turnip 安装包。两者最新的 Release 如下：  

|                                                         标准安装包                                                         |                                                        未打补丁的 Turnip 安装包                                                        |
| :-------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------: |
| [26.1.0-devel-20260404](https://github.com/lfdevs/mesa-for-android-container/releases/tag/mesa-26.1.0-devel-20260404) | [turnip-26.1.0-devel-20260404](https://github.com/lfdevs/mesa-for-android-container/releases/tag/turnip-26.1.0-devel-20260404) |
2. 直接将安装包解压到根目录。  
```bash
sudo tar -zxvf mesa-for-android-container_26.0.0-devel-xxxxxxxx_debian_trixie_arm64.tar.gz -C /
sudo tar -zxvf turnip_26.0.0-devel-xxxxxxxx_debian_trixie_arm64.tar.gz -C /
```
3. 刷新动态链接器缓存。  
```bash
sudo ldconfig
```

卸载可参考以下命令：  
```bash
# 复制这条命令输出的文件列表
tar tf mesa-for-android-container_26.0.0-devel-xxxxxxxx_debian_trixie_arm64.tar.gz | grep -v '/$' | tr '\n' ' ' ; echo
cd /
# 替换 <file-list> 为实际的文件列表
sudo rm <file-list>
# 重新安装发行版维护的 Mesa 驱动
# Debian 或 Ubuntu:
sudo apt update
sudo apt install --reinstall libegl-mesa0 libgbm1 libgl1-mesa-dri libglx-mesa0 mesa-libgallium mesa-vulkan-drivers
# Fedora:
sudo dnf reinstall mesa-filesystem mesa-libglapi mesa-libgbm mesa-libEGL mesa-libGL mesa-vulkan-drivers mesa-dri-drivers mesa-libOpenCL
# Arch Linux:
sudo pacman -S mesa mesa-docs opencl-mesa vulkan-freedreno vulkan-mesa-implicit-layers vulkan-mesa-layers
```
## 使用
在运行特定程序时指定环境变量`MESA_LOADER_DRIVER_OVERRIDE`和`TU_DEBUG`，如：  
```bash
MESA_LOADER_DRIVER_OVERRIDE=kgsl TU_DEBUG=noconform glmark2
```
或者将其添加到`/etc/environment`文件中以便在开启容器时自动加载：  
```plaintext
MESA_LOADER_DRIVER_OVERRIDE=kgsl
TU_DEBUG=noconform
```
## 构建
### GitHub Actions
本项目支持使用 [GitHub Actions](https://github.com/lfdevs/mesa-for-android-container/actions) 进行构建。你可以 Fork 本仓库，然后在 Fork 里启用 Actions。 
#### 工作流
本仓库共有五条工作流，简单介绍如下：  

|         文件         |          名称           |                             适用分支                             |          构建目标           |
| :----------------: | :-------------------: | :----------------------------------------------------------: | :---------------------: |
|    `build.yml`     |         Build         |                        `adreno-main`等                        |        最新的标准安装包         |
| `build-turnip.yml` |     Build Turnip      |                        `turnip-main`等                        |   最新的未打补丁的 Turnip 驱动    |
| `build-debian.yml` | Build Debian Packages |        `adreno-debian-trixie`、`turnip-debian-trixie`等        | 能够使用`apt`安装的 Debian 安装包 |
| `build-ubuntu.yml` | Build Ubuntu Packages | `adreno-ubuntu-noble-updates`、`turnip-ubuntu-noble-updates`等 | 能够使用`apt`安装的 Ubuntu 安装包 |
| `build-fedora.yml` | Build Fedora Packages |           `adreno-fedora-f43`、`turnip-fedora-f43`等           | 能够使用`dnf`安装的 Fedora 安装包 |

**PS:** 由于 Arch Linux “滚动更新”的特性，能够使用`pacman`安装的 Arch Linux 安装包直接由`build.yml`、`build-turnip.yml`构建。  
#### 输入参数
所有工作流手动触发时均有两个输入参数，简单介绍如下：  

|       参数        |         名称          |              说明               |
| :-------------: | :-----------------: | :---------------------------: |
|      `tag`      |    Branch or tag    |       构建目标，支持分支或该分支下的标签       |
| `draft_release` | Draft a new release | 自动生成草稿 Release（适用于构建目标为标签的情况） |

### 本地构建
详细构建过程请参照 Mesa 官方说明（[Compilation and Installation Using Meson — The Mesa 3D Graphics Library latest documentation](https://docs.mesa3d.org/meson.html)），构建可以使用软件包管理器（如`apt`、`dnf`、`pacman`）安装的安装包的关键命令可参考[此文档](../common/build-for-distros.md)。以下为在 Debian 13 arm64 环境下构建的关键步骤：  

1. 检查是否启用了源码软件源。若使用传统格式（`/etc/apt/sources.list`）的软件源，可检查是否有类似于以下的配置。  
```plaintext
deb-src https://deb.debian.org/debian trixie main contrib non-free non-free-firmware
```
2. 安装构建 Mesa 所需的依赖。  
```bash
sudo apt build-dep mesa
```
3. 克隆本项目的仓库。  
```bash
git clone https://github.com/lfdevs/mesa-for-android-container.git
```
4. 切换到已经应用了相关补丁的分支，如`adreno-main`。  
```bash
cd mesa-for-android-container
git checkout adreno-main
```
5. 初始化构建目录。可以参照 [meson.options](https://github.com/lfdevs/mesa-for-android-container/blob/main/meson.options) 文件查看所有的构建选项。  
```bash
meson setup build/ \
    --prefix=/usr \
    -Dplatforms=x11,wayland \
    -Dgallium-drivers=freedreno,zink,virgl,llvmpipe \
    -Dgallium-va=disabled \
    -Dgallium-mediafoundation=disabled \
    -Dvulkan-drivers=freedreno \
    -Dvulkan-layers= \
    -Degl=enabled \
    -Dgles2=enabled \
    -Dglvnd=enabled \
    -Dglx=dri \
    -Dlibunwind=disabled \
    -Dintel-rt=disabled \
    -Dmicrosoft-clc=disabled \
    -Dvalgrind=disabled \
    -Dgles1=disabled \
    -Dfreedreno-kmds=kgsl \
    -Dbuildtype=release
```
若需要单独构建 Turnip 驱动，可以使用下面的初始化命令：  
```bash
meson setup build/ \
    --prefix=/usr \
    -Dplatforms=x11,wayland \
    -Dgallium-drivers= \
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
    -Dbuildtype=release
```
6. 开始构建。  
```bash
ninja -C build/
```
7. 若直接在编译设备上安装，可运行以下命令：  
```bash
ninja -C build/ install
```
8. 若需打包构建好的 Mesa 驱动，并在相同发行版的其他设备上安装，可参考以下命令：  
```bash
export MESA_RELEASE_NAME_SUFFIX=26.0.0-devel-xxxxxxxx_debian_trixie_arm64
sudo mkdir /tmp/mesa-install-tmp
sudo DESTDIR=/tmp/mesa-install-tmp meson install -C build/
sudo tar -zcvf mesa-for-android-container_${MESA_RELEASE_NAME_SUFFIX}.tar.gz -C /tmp/mesa-install-tmp .
sudo chown $USER:$USER mesa-for-android-container_${MESA_RELEASE_NAME_SUFFIX}.tar.gz
chmod 644 mesa-for-android-container_${MESA_RELEASE_NAME_SUFFIX}.tar.gz
sudo rm -rf /tmp/mesa-install-tmp
```
## 基准测试
详细的测试结果：[benchmark-result](../common/benchmark-result.md)  

|        设备         |     型号     |        SoC         |    GPU     | glmark2 | glmark2-es2 | vkmark |
| :---------------: | :--------: | :----------------: | :--------: | ------: | ----------: | -----: |
|   Redmi K40 Pro   | M2012K11G  |      高通骁龙 888      | Adreno 660 |     842 |         771 |   1170 |
| Xiaomi Pad 6 Pro  | 23046RP50C |   高通骁龙 8+ Gen 1    | Adreno 730 |    1169 |        1143 |    263 |
|   REDMI K80 Pro   | 24122RKC7C |    高通骁龙 8 Elite    | Adreno 830 |    3081 |        3083 |    308 |
| Xiaomi 17 Pro Max | 2509FPN0BC | 高通骁龙 8 Elite Gen 5 | Adreno 840 |    2947 |        2901 |    未测试 |
|    OnePlus 15     |   PLK110   | 高通骁龙 8 Elite Gen 5 | Adreno 840 |    3574 |        3621 |    未测试 |

**PS:** Xiaomi 17 Pro Max 执行基准测试时连接了电源，性能有折损，正常情况下实际分数会更高。  
## 感谢
  - [Lucas Fryzek](https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21570)：Mesa Freedreno 驱动的 KGSL 后端代码的作者。  
  - [xMeM](https://github.com/xMeM/termux-packages/commit/401982b8d9eaef70669762bfff2a963341c65e52)：将 Freedreno 驱动的 KGSL 后端移植到了 Termux:X11。  
  - [Robert Kirkman](https://github.com/robertkirkman/termux-packages/commit/06a959eeddf153cebd0d3ea1a6c2eb2921b5f786)：整合并完善了 xMeM 的补丁。  
  - [Rob Clark](https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/38450)：为 Adreno Gen8 架构（包含 Adreno 840）引入了 Freedreno （包含 Turnip）支持。  
  - [whitebelyash](https://github.com/whitebelyash/mesa-tu8)：为 Adreno 810/825/829 添加实验性支持。  
