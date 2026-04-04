# Mesa for Android Container
Forked From [Mesa - The 3D Graphics Library](https://gitlab.freedesktop.org/mesa/mesa)  

[English](../../README.md) | [简体中文](../zh-HanS/README.md) | **繁體中文**  

---  
一個適用於 Android 容器（Proot、Chroot、LXC 等）的 [Mesa](https://gitlab.freedesktop.org/mesa/mesa) 建置版本，支援 Adreno GPU 的硬體加速。  

## 特性
- Mesa 26.0.0 及以上版本的 Freedreno 與 Turnip 驅動程式支援 Adreno 8xx GPU。  
- 在多個主流 Linux 發行版的 arm64 Chroot 容器環境下分別編譯，相容性更佳，以 Android 為主機系統的 Proot、Chroot、LXC 容器皆可使用本專案所編譯的 Mesa 驅動程式。  
- 對於部分 Adreno 6xx/7xx/8xx GPU，OpenGL、OpenGL ES、Vulkan 均可直接使用 Freedreno 驅動程式，不再需要透過 Zink 進行圖形 API 呼叫轉換，大幅提升了 GPU 的利用效率。  
- 僅編譯與絕大多數 Android 裝置相關的驅動程式，以縮小套件體積。  
## 相容性
這裡只展示了經我和其他人實測後確認支援的 GPU 型號，**不代表其他的 GPU 型號不支援**。你可以在 [freedreno_devices.py](https://github.com/lfdevs/mesa-for-android-container/blob/turnip-main/src/freedreno/common/freedreno_devices.py) 檔案中搜尋你裝置的 GPU 型號（例如，Adreno 725 可搜尋`725`），若該型號有完整的裝置定義，則它很可能受支援。歡迎在 [Issues](https://github.com/lfdevs/mesa-for-android-container/issues) 中分享驅動程式在你裝置上的執行情況，這將幫助我們完善下面的這張表。  

|              GPU               | OpenGL | OpenGL ES | Vulkan |
| :----------------------------: | :----: | :-------: | :----: |
|         **Adreno 660**         |  ✔️支援  |   ✔️支援    |  ✔️支援  |
| **Adreno 710/720/730/735/740/750** |  ✔️支援  |   ✔️支援    |  ✔️支援  |
|       **Adreno 829/830/840**       |  ✔️支援  |   ✔️支援    |  ✔️支援  |

實驗性支援（by [**whitebelyash**](https://github.com/whitebelyash)）：**Adreno 810/825**  
## 安裝
本專案的 Releases 有兩種形式的安裝包，一種可以使用 Linux 發行版的套件管理器安裝，另一種只能直接解壓來安裝。推薦使用第一種安裝包，若需要最新的 Mesa 功能（例如 **Adreno 8xx 的支援**），則可以使用第二種。  
若常規的 Release（標題不帶 `turnip-` 前綴）中的 Turnip 驅動無法正常運作，可使用**未打補丁的 Turnip 驅動**（標題帶 `turnip-` 前綴），直接覆蓋安裝即可。  
**PS:** 本專案所提及的「未打補丁」指的是未套用 xMeM 的原始補丁，但仍會套用一些必要的補丁（例如新增更多 GPU 支援）。  
### 使用套件管理器
根據所使用的 Linux 發行版，前往 [Releases](https://github.com/lfdevs/mesa-for-android-container/releases) 下載對應 Release 的所有套件，並依照 Release 說明中的安裝指示進行安裝。以下為一些主流 Linux 發行版對應的最新 Release：  

|    Linux 發行版     |                                                              最新 Release                                                              |                                                               未打補丁的 Turnip 驅動                                                               |
| :--------------: | :----------------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------: |
|    Debian 13     |            [25.0.7-2+deb13u1](https://github.com/lfdevs/mesa-for-android-container/releases/tag/debian%2F25.0.7-2-adreno)            |            [turnip-25.0.7-2+deb13u1](https://github.com/lfdevs/mesa-for-android-container/releases/tag/debian%2F25.0.7-2-turnip)            |
| Ubuntu 24.04 LTS | [25.0.7-0ubuntu0.24.04.2](https://github.com/lfdevs/mesa-for-android-container/releases/tag/import%2F25.0.7-0ubuntu0.24.04.2-adreno) | [turnip-25.0.7-0ubuntu0.24.04.2](https://github.com/lfdevs/mesa-for-android-container/releases/tag/import%2F25.0.7-0ubuntu0.24.04.2-turnip) |
|    Fedora 43     |             [25.2.7-4.fc43](https://github.com/lfdevs/mesa-for-android-container/releases/tag/mesa-25.2.7-4.fc43-adreno)             |               [turnip-25.2.7-4.fc43](https://github.com/lfdevs/mesa-for-android-container/releases/tag/turnip-25.2.7-4.fc43)                |
|    Arch Linux    |               [26.1.0-4](https://github.com/lfdevs/mesa-for-android-container/releases/tag/mesa-26.1.0-devel-20260404)               |              [turnip-26.1.0-4](https://github.com/lfdevs/mesa-for-android-container/releases/tag/turnip-26.1.0-devel-20260404)              |
### 直接解壓
ℹ️**注意**：Releases 中 `.tar.gz` 格式的安裝包僅能覆蓋原有的 Mesa 驅動程式，卸載時需手動刪除解壓出來的檔案，僅供測試使用。  

1. 前往 [Releases](https://github.com/lfdevs/mesa-for-android-container/releases) 下載 `.tar.gz` 格式的安裝包。請注意檔案名稱中的 Linux 發行版後綴（例如 `debian_trixie_arm64`），僅可安裝與發行版相符的安裝包。對於 **Adreno 7xx/8xx**，一般先解壓標準安裝包（包含 Freedreno），再解壓未打補丁的 Turnip 安裝包。兩者最新的 Release 如下：  

|                                                         標準安裝包                                                         |                                                        未打補丁的 Turnip 安裝包                                                        |
| :-------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------: |
| [26.1.0-devel-20260404](https://github.com/lfdevs/mesa-for-android-container/releases/tag/mesa-26.1.0-devel-20260404) | [turnip-26.1.0-devel-20260404](https://github.com/lfdevs/mesa-for-android-container/releases/tag/turnip-26.1.0-devel-20260404) |
2.  直接將安裝包解壓縮到根目錄。  
```bash
sudo tar -zxvf mesa-for-android-container_26.0.0-devel-xxxxxxxx_debian_trixie_arm64.tar.gz -C /
sudo tar -zxvf turnip_26.0.0-devel-xxxxxxxx_debian_trixie_arm64.tar.gz -C /
```
3.  更新動態連結器快取。  
```bash
sudo ldconfig
```

卸載可參考以下指令：  
```bash
# 複製這條指令輸出的檔案清單
tar tf mesa-for-android-container_26.0.0-devel-xxxxxxxx_debian_trixie_arm64.tar.gz | grep -v '/$' | tr '\n' ' ' ; echo
cd /
# 將 <file-list> 替換為實際的檔案清單
sudo rm <file-list>
# 重新安裝發行版維護的 Mesa 驅動程式
# Debian 或 Ubuntu：
sudo apt update
sudo apt install --reinstall libegl-mesa0 libgbm1 libgl1-mesa-dri libglx-mesa0 mesa-libgallium mesa-vulkan-drivers
# Fedora:
sudo dnf reinstall mesa-filesystem mesa-libglapi mesa-libgbm mesa-libEGL mesa-libGL mesa-vulkan-drivers mesa-dri-drivers mesa-libOpenCL
# Arch Linux:
sudo pacman -S mesa mesa-docs opencl-mesa vulkan-freedreno vulkan-mesa-implicit-layers vulkan-mesa-layers
```
## 使用
在執行特定程式時指定環境變數`MESA_LOADER_DRIVER_OVERRIDE`和`TU_DEBUG`，例如：  
```bash
MESA_LOADER_DRIVER_OVERRIDE=kgsl TU_DEBUG=noconform glmark2
```
或者將其新增至`/etc/environment`檔案中，以便在開啟容器時自動載入：  
```plaintext
MESA_LOADER_DRIVER_OVERRIDE=kgsl
TU_DEBUG=noconform
```
## 建置
### GitHub Actions
本專案支援使用 [GitHub Actions](https://github.com/lfdevs/mesa-for-android-container/actions) 進行建置。你可以 Fork 本儲存庫，然後在 Fork 中啟用 Actions。 
#### 工作流程
本儲存庫共有五條工作流程，簡單介紹如下：  

|         檔案         |          名稱           |                             適用分支                             |           建置目標            |
| :----------------: | :-------------------: | :----------------------------------------------------------: | :-----------------------: |
|    `build.yml`     |         Build         |                        `adreno-main`等                        |         最新的標準安裝包          |
| `build-turnip.yml` |     Build Turnip      |                        `turnip-main`等                        |    最新的未打補丁的 Turnip 驅動     |
| `build-debian.yml` | Build Debian Packages |        `adreno-debian-trixie`、`turnip-debian-trixie`等        | 能夠使用 `apt` 安裝的 Debian 安裝包 |
| `build-ubuntu.yml` | Build Ubuntu Packages | `adreno-ubuntu-noble-updates`、`turnip-ubuntu-noble-updates`等 | 能夠使用 `apt` 安裝的 Ubuntu 安裝包 |
| `build-fedora.yml` | Build Fedora Packages |           `adreno-fedora-f43`、`turnip-fedora-f43`等           | 能夠使用 `dnf` 安裝的 Fedora 安裝包 |

**PS:** 由於 Arch Linux 「滾動更新」的特性，能夠使用 `pacman` 安裝的 Arch Linux 安裝包直接由 `build.yml`、`build-turnip.yml` 進行建置。  
#### 輸入參數
所有工作流程手動觸發時均有兩個輸入參數，簡單介紹如下：  

|       參數        |         名稱          |              說明               |
| :-------------: | :-----------------: | :---------------------------: |
|      `tag`      |    Branch or tag    |       建置目標，支援分支或該分支下的標籤       |
| `draft_release` | Draft a new release | 自動產生草稿 Release（適用於建置目標為標籤的情況） |

### 本地建置
詳細的建置流程請參照 Mesa 官方說明（[Compilation and Installation Using Meson — The Mesa 3D Graphics Library latest documentation](https://docs.mesa3d.org/meson.html)），建構可使用套件管理器（如 `apt`、`dnf`、`pacman`）安裝的安裝包之關鍵指令可參考[此文件](../common/build-for-distros.md)。以下為在 Debian 13 arm64 環境下建置的關鍵步驟：  

1.  檢查是否已啟用原始碼軟體來源。若使用傳統格式（`/etc/apt/sources.list`）的軟體來源，可檢查是否有類似於以下的設定。  
```plaintext
deb-src https://deb.debian.org/debian trixie main contrib non-free non-free-firmware
```
2.  安裝建置 Mesa 所需的依賴套件。  
```bash
sudo apt build-dep mesa
```
3.  複製本專案的儲存庫。  
```bash
git clone https://github.com/lfdevs/mesa-for-android-container.git
```
4.  切換到已應用相關修補程式的分支，如 `adreno-main`。  
```bash
cd mesa-for-android-container
git checkout adreno-main
```
5.  初始化建置目錄。可以參照 [meson.options](https://github.com/lfdevs/mesa-for-android-container/blob/main/meson.options) 檔案來查看所有的建置選項。  
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
若需要單獨建構 Turnip 驅動程式，可使用下列的初始化指令：  
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
6.  開始建置。  
```bash
ninja -C build/
```
7.  若要直接在編譯裝置上安裝，可執行以下指令：  
```bash
ninja -C build/ install
```
8.  若需打包建置好的 Mesa 驅動程式，並在相同發行版的其他裝置上安裝，可參考以下指令：  
```bash
export MESA_RELEASE_NAME_SUFFIX=26.0.0-devel-xxxxxxxx_debian_trixie_arm64
sudo mkdir /tmp/mesa-install-tmp
sudo DESTDIR=/tmp/mesa-install-tmp meson install -C build/
sudo tar -zcvf mesa-for-android-container_${MESA_RELEASE_NAME_SUFFIX}.tar.gz -C /tmp/mesa-install-tmp .
sudo chown $USER:$USER mesa-for-android-container_${MESA_RELEASE_NAME_SUFFIX}.tar.gz
chmod 644 mesa-for-android-container_${MESA_RELEASE_NAME_SUFFIX}.tar.gz
sudo rm -rf /tmp/mesa-install-tmp
```
## 基準測試
詳細的測試結果： [benchmark-result](../common/benchmark-result.md)  

|        裝置         |     型號     |        SoC         |    GPU     | glmark2 | glmark2-es2 | vkmark |
| :---------------: | :--------: | :----------------: | :--------: | ------: | ----------: | -----: |
|   Redmi K40 Pro   | M2012K11G  |      高通驍龍 888      | Adreno 660 |     842 |         771 |   1170 |
| Xiaomi Pad 6 Pro  | 23046RP50C |   高通驍龍 8+ Gen 1    | Adreno 730 |    1169 |        1143 |    263 |
|   REDMI K80 Pro   | 24122RKC7C |    高通驍龍 8 Elite    | Adreno 830 |    3081 |        3083 |    308 |
| Xiaomi 17 Pro Max | 2509FPN0BC | 高通驍龍 8 Elite Gen 5 | Adreno 840 |    2947 |        2901 |    未測試 |
|    OnePlus 15     |   PLK110   | 高通驍龍 8 Elite Gen 5 | Adreno 840 |    3574 |        3621 |    未測試 |

**PS：** Xiaomi 17 Pro Max 執行基準測試時連接了電源，效能有所折損，正常情況下實際分數會更高。  
## 感謝
  - [Lucas Fryzek](https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21570)：Mesa Freedreno 驅動程式的 KGSL 後端程式碼的作者。  
  - [xMeM](https://github.com/xMeM/termux-packages/commit/401982b8d9eaef70669762bfff2a963341c65e52)：將 Freedreno 驅動程式的 KGSL 後端移植至 Termux:X11。  
  - [Robert Kirkman](https://github.com/robertkirkman/termux-packages/commit/06a959eeddf153cebd0d3ea1a6c2eb2921b5f786)：整合並完善了 xMeM 的修補程式。  
  - [Rob Clark](https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/38450)：為 Adreno Gen8 架構（包含 Adreno 840）引入了 Freedreno （包含 Turnip）支援。  
  - [whitebelyash](https://github.com/whitebelyash/mesa-tu8)：為 Adreno 810/825/829 新增實驗性支援。  
