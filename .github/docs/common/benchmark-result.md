# Benchmark Results
## Adreno 660
### Redmi K40 Pro
Mesa version: `25.3.0-devel-20250725`

Container: Debian 13 **LXC**
#### glmark2
```log
MESA-LOADER: failed to retrieve device information
MESA: error: kgsl_pipe_get_param:103: invalid param id: 13
=======================================================
    glmark2 2023.01
=======================================================
    OpenGL Information
    GL_VENDOR:      freedreno
    GL_RENDERER:    FD660
    GL_VERSION:     4.6 (Compatibility Profile) Mesa 25.3.0-devel (git-6fb40f7c28)
    Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0 samples=0
    Surface Size:   800x600 windowed
=======================================================
[build] use-vbo=false: FPS: 872 FrameTime: 1.148 ms
[build] use-vbo=true: FPS: 924 FrameTime: 1.083 ms
[texture] texture-filter=nearest: FPS: 925 FrameTime: 1.082 ms
[texture] texture-filter=linear: FPS: 899 FrameTime: 1.113 ms
[texture] texture-filter=mipmap: FPS: 930 FrameTime: 1.076 ms
[shading] shading=gouraud: FPS: 933 FrameTime: 1.072 ms
[shading] shading=blinn-phong-inf: FPS: 949 FrameTime: 1.054 ms
[shading] shading=phong: FPS: 950 FrameTime: 1.053 ms
[shading] shading=cel: FPS: 929 FrameTime: 1.077 ms
[bump] bump-render=high-poly: FPS: 898 FrameTime: 1.114 ms
[bump] bump-render=normals: FPS: 953 FrameTime: 1.050 ms
[bump] bump-render=height: FPS: 952 FrameTime: 1.051 ms
[effect2d] kernel=0,1,0;1,-4,1;0,1,0;: FPS: 948 FrameTime: 1.055 ms
[effect2d] kernel=1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 948 FrameTime: 1.055 ms
[pulsar] light=false:quads=5:texture=false: FPS: 945 FrameTime: 1.059 ms
[desktop] blur-radius=5:effect=blur:passes=1:separable=true:windows=4: FPS: 946 FrameTime: 1.057 ms
[desktop] effect=shadow:windows=4: FPS: 951 FrameTime: 1.052 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 923 FrameTime: 1.084 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=subdata: FPS: 754 FrameTime: 1.328 ms
[buffer] columns=200:interleave=true:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 801 FrameTime: 1.250 ms
[ideas] speed=duration: FPS: 728 FrameTime: 1.374 ms
[jellyfish] <default>: FPS: 796 FrameTime: 1.257 ms
[terrain] <default>: FPS: 297 FrameTime: 3.368 ms
[shadow] <default>: FPS: 757 FrameTime: 1.323 ms
[refract] <default>: FPS: 606 FrameTime: 1.652 ms
[conditionals] fragment-steps=0:vertex-steps=0: FPS: 780 FrameTime: 1.282 ms
[conditionals] fragment-steps=5:vertex-steps=0: FPS: 768 FrameTime: 1.303 ms
[conditionals] fragment-steps=0:vertex-steps=5: FPS: 805 FrameTime: 1.243 ms
[function] fragment-complexity=low:fragment-steps=5: FPS: 799 FrameTime: 1.253 ms
[function] fragment-complexity=medium:fragment-steps=5: FPS: 805 FrameTime: 1.242 ms
[loop] fragment-loop=false:fragment-steps=5:vertex-steps=5: FPS: 795 FrameTime: 1.258 ms
[loop] fragment-steps=5:fragment-uniform=false:vertex-steps=5: FPS: 786 FrameTime: 1.273 ms
[loop] fragment-steps=5:fragment-uniform=true:vertex-steps=5: FPS: 799 FrameTime: 1.252 ms
=======================================================
                                  glmark2 Score: 842
=======================================================
```
#### glmark2-es2
```log
MESA-LOADER: failed to retrieve device information
MESA: error: kgsl_pipe_get_param:103: invalid param id: 13
=======================================================
    glmark2 2023.01
=======================================================
    OpenGL Information
    GL_VENDOR:      freedreno
    GL_RENDERER:    FD660
    GL_VERSION:     OpenGL ES 3.2 Mesa 25.3.0-devel (git-6fb40f7c28)
    Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0 samples=0
    Surface Size:   800x600 windowed
=======================================================
[build] use-vbo=false: FPS: 797 FrameTime: 1.255 ms
[build] use-vbo=true: FPS: 810 FrameTime: 1.236 ms
[texture] texture-filter=nearest: FPS: 807 FrameTime: 1.239 ms
[texture] texture-filter=linear: FPS: 807 FrameTime: 1.239 ms
[texture] texture-filter=mipmap: FPS: 805 FrameTime: 1.243 ms
[shading] shading=gouraud: FPS: 799 FrameTime: 1.252 ms
[shading] shading=blinn-phong-inf: FPS: 806 FrameTime: 1.241 ms
[shading] shading=phong: FPS: 806 FrameTime: 1.242 ms
[shading] shading=cel: FPS: 803 FrameTime: 1.246 ms
[bump] bump-render=high-poly: FPS: 752 FrameTime: 1.330 ms
[bump] bump-render=normals: FPS: 803 FrameTime: 1.246 ms
[bump] bump-render=height: FPS: 808 FrameTime: 1.238 ms
[effect2d] kernel=0,1,0;1,-4,1;0,1,0;: FPS: 801 FrameTime: 1.249 ms
[effect2d] kernel=1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 808 FrameTime: 1.239 ms
[pulsar] light=false:quads=5:texture=false: FPS: 809 FrameTime: 1.237 ms
[desktop] blur-radius=5:effect=blur:passes=1:separable=true:windows=4: FPS: 793 FrameTime: 1.262 ms
[desktop] effect=shadow:windows=4: FPS: 781 FrameTime: 1.281 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 703 FrameTime: 1.423 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=subdata: FPS: 741 FrameTime: 1.351 ms
[buffer] columns=200:interleave=true:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 790 FrameTime: 1.266 ms
[ideas] speed=duration: FPS: 800 FrameTime: 1.251 ms
[jellyfish] <default>: FPS: 808 FrameTime: 1.239 ms
[terrain] <default>: FPS: 288 FrameTime: 3.480 ms
[shadow] <default>: FPS: 780 FrameTime: 1.283 ms
[refract] <default>: FPS: 606 FrameTime: 1.651 ms
[conditionals] fragment-steps=0:vertex-steps=0: FPS: 784 FrameTime: 1.276 ms
[conditionals] fragment-steps=5:vertex-steps=0: FPS: 803 FrameTime: 1.247 ms
[conditionals] fragment-steps=0:vertex-steps=5: FPS: 810 FrameTime: 1.236 ms
[function] fragment-complexity=low:fragment-steps=5: FPS: 797 FrameTime: 1.255 ms
[function] fragment-complexity=medium:fragment-steps=5: FPS: 809 FrameTime: 1.236 ms
[loop] fragment-loop=false:fragment-steps=5:vertex-steps=5: FPS: 810 FrameTime: 1.236 ms
[loop] fragment-steps=5:fragment-uniform=false:vertex-steps=5: FPS: 809 FrameTime: 1.237 ms
[loop] fragment-steps=5:fragment-uniform=true:vertex-steps=5: FPS: 767 FrameTime: 1.304 ms
=======================================================
                                  glmark2 Score: 771
=======================================================
```
#### vkmark
```log
=======================================================
    vkmark 2025.01
=======================================================
    Vendor ID:      0x5143
    Device ID:      0x6060001
    Device Name:    Turnip Adreno (TM) 660
    Driver Version: 104865891
    Device UUID:    9b8368a2ae967de07da9b591ed389b09
=======================================================
[vertex] device-local=true: FPS: 999 FrameTime: 1.001 ms
[vertex] device-local=false: FPS: 1188 FrameTime: 0.842 ms
[texture] anisotropy=0: FPS: 1106 FrameTime: 0.904 ms
[texture] anisotropy=16: FPS: 1258 FrameTime: 0.795 ms
[shading] shading=gouraud: FPS: 1148 FrameTime: 0.871 ms
[shading] shading=blinn-phong-inf: FPS: 1160 FrameTime: 0.862 ms
[shading] shading=phong: FPS: 1107 FrameTime: 0.903 ms
[shading] shading=cel: FPS: 1112 FrameTime: 0.899 ms
[effect2d] kernel=edge: FPS: 1234 FrameTime: 0.810 ms
[effect2d] kernel=blur: FPS: 745 FrameTime: 1.342 ms
[desktop] <default>: FPS: 1248 FrameTime: 0.801 ms
[cube] <default>: FPS: 1364 FrameTime: 0.733 ms
[clear] <default>: FPS: 1552 FrameTime: 0.644 ms
=======================================================
                                   vkmark Score: 1170
=======================================================
```
## Adreno 730
### Xiaomi Pad 6 Pro
Mesa version: `26.2.0-devel-20260610`

Container: Debian 13 **Chroot**
#### glmark2
```log
MESA-LOADER: failed to retrieve device information
MESA: error: kgsl_pipe_get_param:103: invalid param id: 13
=======================================================
    glmark2 2023.01
=======================================================
    OpenGL Information
    GL_VENDOR:      freedreno
    GL_RENDERER:    FD725
    GL_VERSION:     4.6 (Compatibility Profile) Mesa 26.2.0-devel (git-9c8bdb4f2e)
    Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0 samples=0
    Surface Size:   800x600 windowed
=======================================================
[build] use-vbo=false: FPS: 1698 FrameTime: 0.589 ms
[build] use-vbo=true: FPS: 2006 FrameTime: 0.499 ms
[texture] texture-filter=nearest: FPS: 1573 FrameTime: 0.636 ms
[texture] texture-filter=linear: FPS: 1153 FrameTime: 0.867 ms
[texture] texture-filter=mipmap: FPS: 1354 FrameTime: 0.739 ms
[shading] shading=gouraud: FPS: 1691 FrameTime: 0.591 ms
[shading] shading=blinn-phong-inf: FPS: 1840 FrameTime: 0.544 ms
[shading] shading=phong: FPS: 2282 FrameTime: 0.438 ms
[shading] shading=cel: FPS: 1282 FrameTime: 0.781 ms
[bump] bump-render=high-poly: FPS: 1915 FrameTime: 0.522 ms
[bump] bump-render=normals: FPS: 1849 FrameTime: 0.541 ms
[bump] bump-render=height: FPS: 1685 FrameTime: 0.593 ms
[effect2d] kernel=0,1,0;1,-4,1;0,1,0;: FPS: 2229 FrameTime: 0.449 ms
[effect2d] kernel=1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 851 FrameTime: 1.175 ms
[pulsar] light=false:quads=5:texture=false: FPS: 903 FrameTime: 1.108 ms
[desktop] blur-radius=5:effect=blur:passes=1:separable=true:windows=4: FPS: 527 FrameTime: 1.900 ms
[desktop] effect=shadow:windows=4: FPS: 772 FrameTime: 1.296 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 204 FrameTime: 4.905 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=subdata: FPS: 241 FrameTime: 4.153 ms
[buffer] columns=200:interleave=true:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 236 FrameTime: 4.245 ms
[ideas] speed=duration: FPS: 452 FrameTime: 2.216 ms
[jellyfish] <default>: FPS: 2082 FrameTime: 0.480 ms
[terrain] <default>: FPS: 170 FrameTime: 5.884 ms
[shadow] <default>: FPS: 936 FrameTime: 1.069 ms
[refract] <default>: FPS: 564 FrameTime: 1.775 ms
[conditionals] fragment-steps=0:vertex-steps=0: FPS: 2654 FrameTime: 0.377 ms
[conditionals] fragment-steps=5:vertex-steps=0: FPS: 1767 FrameTime: 0.566 ms
[conditionals] fragment-steps=0:vertex-steps=5: FPS: 2146 FrameTime: 0.466 ms
[function] fragment-complexity=low:fragment-steps=5: FPS: 1876 FrameTime: 0.533 ms
[function] fragment-complexity=medium:fragment-steps=5: FPS: 1055 FrameTime: 0.948 ms
[loop] fragment-loop=false:fragment-steps=5:vertex-steps=5: FPS: 1918 FrameTime: 0.522 ms
[loop] fragment-steps=5:fragment-uniform=false:vertex-steps=5: FPS: 1632 FrameTime: 0.613 ms
[loop] fragment-steps=5:fragment-uniform=true:vertex-steps=5: FPS: 1395 FrameTime: 0.717 ms
=======================================================
                                  glmark2 Score: 1360
=======================================================
```
#### glmark2-es2
```log
MESA-LOADER: failed to retrieve device information
MESA: error: kgsl_pipe_get_param:103: invalid param id: 13
=======================================================
    glmark2 2023.01
=======================================================
    OpenGL Information
    GL_VENDOR:      freedreno
    GL_RENDERER:    FD725
    GL_VERSION:     OpenGL ES 3.2 Mesa 26.2.0-devel (git-9c8bdb4f2e)
    Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0 samples=0
    Surface Size:   800x600 windowed
=======================================================
[build] use-vbo=false: FPS: 1437 FrameTime: 0.696 ms
[build] use-vbo=true: FPS: 1661 FrameTime: 0.602 ms
[texture] texture-filter=nearest: FPS: 1300 FrameTime: 0.770 ms
[texture] texture-filter=linear: FPS: 1613 FrameTime: 0.620 ms
[texture] texture-filter=mipmap: FPS: 1586 FrameTime: 0.631 ms
[shading] shading=gouraud: FPS: 1822 FrameTime: 0.549 ms
[shading] shading=blinn-phong-inf: FPS: 1733 FrameTime: 0.577 ms
[shading] shading=phong: FPS: 1757 FrameTime: 0.569 ms
[shading] shading=cel: FPS: 2218 FrameTime: 0.451 ms
[bump] bump-render=high-poly: FPS: 2054 FrameTime: 0.487 ms
[bump] bump-render=normals: FPS: 907 FrameTime: 1.104 ms
[bump] bump-render=height: FPS: 948 FrameTime: 1.056 ms
[effect2d] kernel=0,1,0;1,-4,1;0,1,0;: FPS: 1000 FrameTime: 1.000 ms
[effect2d] kernel=1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 2142 FrameTime: 0.467 ms
[pulsar] light=false:quads=5:texture=false: FPS: 853 FrameTime: 1.173 ms
[desktop] blur-radius=5:effect=blur:passes=1:separable=true:windows=4: FPS: 541 FrameTime: 1.850 ms
[desktop] effect=shadow:windows=4: FPS: 758 FrameTime: 1.319 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 211 FrameTime: 4.752 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=subdata: FPS: 235 FrameTime: 4.272 ms
[buffer] columns=200:interleave=true:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 242 FrameTime: 4.144 ms
[ideas] speed=duration: FPS: 456 FrameTime: 2.195 ms
[jellyfish] <default>: FPS: 2025 FrameTime: 0.494 ms
[terrain] <default>: FPS: 172 FrameTime: 5.815 ms
[shadow] <default>: FPS: 1757 FrameTime: 0.569 ms
[refract] <default>: FPS: 551 FrameTime: 1.815 ms
[conditionals] fragment-steps=0:vertex-steps=0: FPS: 847 FrameTime: 1.182 ms
[conditionals] fragment-steps=5:vertex-steps=0: FPS: 1865 FrameTime: 0.536 ms
[conditionals] fragment-steps=0:vertex-steps=5: FPS: 1210 FrameTime: 0.827 ms
[function] fragment-complexity=low:fragment-steps=5: FPS: 2185 FrameTime: 0.458 ms
[function] fragment-complexity=medium:fragment-steps=5: FPS: 1076 FrameTime: 0.930 ms
[loop] fragment-loop=false:fragment-steps=5:vertex-steps=5: FPS: 852 FrameTime: 1.175 ms
[loop] fragment-steps=5:fragment-uniform=false:vertex-steps=5: FPS: 1582 FrameTime: 0.632 ms
[loop] fragment-steps=5:fragment-uniform=true:vertex-steps=5: FPS: 789 FrameTime: 1.268 ms
=======================================================
                                  glmark2 Score: 1222
=======================================================
```
#### vkmark
```log
=======================================================
    vkmark 2025.01
=======================================================
    Vendor ID:      0x5143
    Device ID:      0x7030002
    Device Name:    Turnip Adreno (TM) 725
    Driver Version: 109056099
    Device UUID:    1c64138e88333d4deff93f5698755ef1
=======================================================
[vertex] device-local=true: FPS: 2615 FrameTime: 0.382 ms
[vertex] device-local=false: FPS: 2806 FrameTime: 0.356 ms
[texture] anisotropy=0: FPS: 2702 FrameTime: 0.370 ms
[texture] anisotropy=16: FPS: 2706 FrameTime: 0.370 ms
[shading] shading=gouraud: FPS: 2660 FrameTime: 0.376 ms
[shading] shading=blinn-phong-inf: FPS: 2644 FrameTime: 0.378 ms
[shading] shading=phong: FPS: 2690 FrameTime: 0.372 ms
[shading] shading=cel: FPS: 2668 FrameTime: 0.375 ms
[effect2d] kernel=edge: FPS: 2825 FrameTime: 0.354 ms
[effect2d] kernel=blur: FPS: 2655 FrameTime: 0.377 ms
[desktop] <default>: FPS: 2498 FrameTime: 0.400 ms
[cube] <default>: FPS: 2646 FrameTime: 0.378 ms
[clear] <default>: FPS: 2593 FrameTime: 0.386 ms
=======================================================
                                   vkmark Score: 2669
=======================================================
```
## Adreno 830
### REDMI K80 Pro
Mesa version: `26.2.0-devel-20260610`

Container: Debian 13 **PRoot**
#### glmark2
```log
MESA-LOADER: failed to retrieve device information
MESA: error: kgsl_pipe_get_param:103: invalid param id: 13
=======================================================
    glmark2 2023.01
=======================================================
    OpenGL Information
    GL_VENDOR:      freedreno
    GL_RENDERER:    Adreno (TM) 830
    GL_VERSION:     4.6 (Compatibility Profile) Mesa 26.2.0-devel (git-9c8bdb4f2e)
    Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0 samples=0
    Surface Size:   800x600 windowed
=======================================================
[build] use-vbo=false: FPS: 2441 FrameTime: 0.410 ms
[build] use-vbo=true: FPS: 2642 FrameTime: 0.379 ms
[texture] texture-filter=nearest: FPS: 2598 FrameTime: 0.385 ms
[texture] texture-filter=linear: FPS: 2590 FrameTime: 0.386 ms
[texture] texture-filter=mipmap: FPS: 2612 FrameTime: 0.383 ms
[shading] shading=gouraud: FPS: 2633 FrameTime: 0.380 ms
[shading] shading=blinn-phong-inf: FPS: 2602 FrameTime: 0.384 ms
[shading] shading=phong: FPS: 2632 FrameTime: 0.380 ms
[shading] shading=cel: FPS: 2599 FrameTime: 0.385 ms
[bump] bump-render=high-poly: FPS: 2617 FrameTime: 0.382 ms
[bump] bump-render=normals: FPS: 2607 FrameTime: 0.384 ms
[bump] bump-render=height: FPS: 2596 FrameTime: 0.385 ms
[effect2d] kernel=0,1,0;1,-4,1;0,1,0;: FPS: 2633 FrameTime: 0.380 ms
[effect2d] kernel=1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 2628 FrameTime: 0.381 ms
[pulsar] light=false:quads=5:texture=false: FPS: 2566 FrameTime: 0.390 ms
[desktop] blur-radius=5:effect=blur:passes=1:separable=true:windows=4: FPS: 1342 FrameTime: 0.745 ms
[desktop] effect=shadow:windows=4: FPS: 1699 FrameTime: 0.589 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 622 FrameTime: 1.609 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=subdata: FPS: 393 FrameTime: 2.548 ms
[buffer] columns=200:interleave=true:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 786 FrameTime: 1.272 ms
[ideas] speed=duration: FPS: 1425 FrameTime: 0.702 ms
[jellyfish] <default>: FPS: 2479 FrameTime: 0.403 ms
[terrain] <default>: FPS: 911 FrameTime: 1.098 ms
[shadow] <default>: FPS: 2262 FrameTime: 0.442 ms
[refract] <default>: FPS: 1523 FrameTime: 0.657 ms
[conditionals] fragment-steps=0:vertex-steps=0: FPS: 2601 FrameTime: 0.385 ms
[conditionals] fragment-steps=5:vertex-steps=0: FPS: 2610 FrameTime: 0.383 ms
[conditionals] fragment-steps=0:vertex-steps=5: FPS: 2576 FrameTime: 0.388 ms
[function] fragment-complexity=low:fragment-steps=5: FPS: 2606 FrameTime: 0.384 ms
[function] fragment-complexity=medium:fragment-steps=5: FPS: 2510 FrameTime: 0.399 ms
[loop] fragment-loop=false:fragment-steps=5:vertex-steps=5: FPS: 2760 FrameTime: 0.362 ms
[loop] fragment-steps=5:fragment-uniform=false:vertex-steps=5: FPS: 2733 FrameTime: 0.366 ms
[loop] fragment-steps=5:fragment-uniform=true:vertex-steps=5: FPS: 2169 FrameTime: 0.461 ms
=======================================================
                                  glmark2 Score: 2211
=======================================================
```
#### glmark2-es2
```log
MESA-LOADER: failed to retrieve device information
MESA: error: kgsl_pipe_get_param:103: invalid param id: 13
=======================================================
    glmark2 2023.01
=======================================================
    OpenGL Information
    GL_VENDOR:      freedreno
    GL_RENDERER:    Adreno (TM) 830
    GL_VERSION:     OpenGL ES 3.2 Mesa 26.2.0-devel (git-9c8bdb4f2e)
    Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0 samples=0
    Surface Size:   800x600 windowed
=======================================================
[build] use-vbo=false: FPS: 2734 FrameTime: 0.366 ms
[build] use-vbo=true: FPS: 2640 FrameTime: 0.379 ms
[texture] texture-filter=nearest: FPS: 2404 FrameTime: 0.416 ms
[texture] texture-filter=linear: FPS: 2552 FrameTime: 0.392 ms
[texture] texture-filter=mipmap: FPS: 2583 FrameTime: 0.387 ms
[shading] shading=gouraud: FPS: 2628 FrameTime: 0.381 ms
[shading] shading=blinn-phong-inf: FPS: 2630 FrameTime: 0.380 ms
[shading] shading=phong: FPS: 2602 FrameTime: 0.384 ms
[shading] shading=cel: FPS: 2603 FrameTime: 0.384 ms
[bump] bump-render=high-poly: FPS: 2588 FrameTime: 0.387 ms
[bump] bump-render=normals: FPS: 2605 FrameTime: 0.384 ms
[bump] bump-render=height: FPS: 2645 FrameTime: 0.378 ms
[effect2d] kernel=0,1,0;1,-4,1;0,1,0;: FPS: 2605 FrameTime: 0.384 ms
[effect2d] kernel=1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 2440 FrameTime: 0.410 ms
[pulsar] light=false:quads=5:texture=false: FPS: 2562 FrameTime: 0.390 ms
[desktop] blur-radius=5:effect=blur:passes=1:separable=true:windows=4: FPS: 1339 FrameTime: 0.747 ms
[desktop] effect=shadow:windows=4: FPS: 1716 FrameTime: 0.583 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 632 FrameTime: 1.583 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=subdata: FPS: 379 FrameTime: 2.645 ms
[buffer] columns=200:interleave=true:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 780 FrameTime: 1.283 ms
[ideas] speed=duration: FPS: 1422 FrameTime: 0.704 ms
[jellyfish] <default>: FPS: 2462 FrameTime: 0.406 ms
[terrain] <default>: FPS: 905 FrameTime: 1.106 ms
[shadow] <default>: FPS: 2185 FrameTime: 0.458 ms
[refract] <default>: FPS: 1555 FrameTime: 0.643 ms
[conditionals] fragment-steps=0:vertex-steps=0: FPS: 2619 FrameTime: 0.382 ms
[conditionals] fragment-steps=5:vertex-steps=0: FPS: 2561 FrameTime: 0.391 ms
[conditionals] fragment-steps=0:vertex-steps=5: FPS: 2601 FrameTime: 0.385 ms
[function] fragment-complexity=low:fragment-steps=5: FPS: 2502 FrameTime: 0.400 ms
[function] fragment-complexity=medium:fragment-steps=5: FPS: 2600 FrameTime: 0.385 ms
[loop] fragment-loop=false:fragment-steps=5:vertex-steps=5: FPS: 2594 FrameTime: 0.386 ms
[loop] fragment-steps=5:fragment-uniform=false:vertex-steps=5: FPS: 2587 FrameTime: 0.387 ms
[loop] fragment-steps=5:fragment-uniform=true:vertex-steps=5: FPS: 2584 FrameTime: 0.387 ms
=======================================================
                                  glmark2 Score: 2206
=======================================================
```
#### vkmark
```log
=======================================================
    vkmark 2025.01
=======================================================
    Vendor ID:      0x5143
    Device ID:      0x44050001
    Device Name:    Adreno (TM) 830
    Driver Version: 109056099
    Device UUID:    25b24aff7bfdcd631b166cd4446deda8
=======================================================
[vertex] device-local=true: FPS: 1072 FrameTime: 0.933 ms
[vertex] device-local=false: FPS: 1140 FrameTime: 0.877 ms
[texture] anisotropy=0: FPS: 1154 FrameTime: 0.867 ms
[texture] anisotropy=16: FPS: 1178 FrameTime: 0.849 ms
[shading] shading=gouraud: FPS: 1175 FrameTime: 0.851 ms
[shading] shading=blinn-phong-inf: FPS: 1194 FrameTime: 0.838 ms
[shading] shading=phong: FPS: 1180 FrameTime: 0.847 ms
[shading] shading=cel: FPS: 1184 FrameTime: 0.845 ms
[effect2d] kernel=edge: FPS: 1201 FrameTime: 0.833 ms
[effect2d] kernel=blur: FPS: 1186 FrameTime: 0.843 ms
[desktop] <default>: FPS: 1170 FrameTime: 0.855 ms
[cube] <default>: FPS: 1174 FrameTime: 0.852 ms
[clear] <default>: FPS: 989 FrameTime: 1.011 ms
=======================================================
                                   vkmark Score: 1153
=======================================================
```
## Adreno 840
### OnePlus 15
Mesa version: `26.0.0-devel-20260116`

Container: Debian 13 **PRoot**
#### glmark2
```log
MESA-LOADER: failed to retrieve device information                                 MESA: error: kgsl_pipe_get_param:103: invalid param id: 13
=======================================================
    glmark2 2023.01
=======================================================
    OpenGL Information
    GL_VENDOR:      freedreno
    GL_RENDERER:    Adreno (TM) 840
    GL_VERSION:     4.6 (Compatibility Profile) Mesa 26.0.0-devel (git-28147648f6)
    Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0 samples=0
    Surface Size:   800x600 windowed
=======================================================
[build] use-vbo=false: FPS: 4130 FrameTime: 0.242 ms
[build] use-vbo=true: FPS: 4371 FrameTime: 0.229 ms
[texture] texture-filter=nearest: FPS: 4375 FrameTime: 0.229 ms
[texture] texture-filter=linear: FPS: 4334 FrameTime: 0.231 ms
[texture] texture-filter=mipmap: FPS: 4342 FrameTime: 0.230 ms
[shading] shading=gouraud: FPS: 4298 FrameTime: 0.233 ms
[shading] shading=blinn-phong-inf: FPS: 4365 FrameTime: 0.229 ms
[shading] shading=phong: FPS: 4350 FrameTime: 0.230 ms
[shading] shading=cel: FPS: 4353 FrameTime: 0.230 ms
[bump] bump-render=high-poly: FPS: 4279 FrameTime: 0.234 ms
[bump] bump-render=normals: FPS: 4390 FrameTime: 0.228 ms
[bump] bump-render=height: FPS: 3986 FrameTime: 0.251 ms
[effect2d] kernel=0,1,0;1,-4,1;0,1,0;: FPS: 4268 FrameTime: 0.234 ms
[effect2d] kernel=1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 4469 FrameTime: 0.224 ms
[pulsar] light=false:quads=5:texture=false: FPS: 4358 FrameTime: 0.229 ms
[desktop] blur-radius=5:effect=blur:passes=1:separable=true:windows=4: FPS: 1070 FrameTime: 0.935 ms
[desktop] effect=shadow:windows=4: FPS: 3313 FrameTime: 0.302 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 381 FrameTime: 2.629 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=subdata: FPS: 1459 FrameTime: 0.685 ms
[buffer] columns=200:interleave=true:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 553 FrameTime: 1.811 ms
[ideas] speed=duration: FPS: 1022 FrameTime: 0.979 ms
[jellyfish] <default>: FPS: 4141 FrameTime: 0.242 ms
[terrain] <default>: FPS: 837 FrameTime: 1.195 ms
[shadow] <default>: FPS: 4348 FrameTime: 0.230 ms
[refract] <default>: FPS: 2001 FrameTime: 0.500 ms
[conditionals] fragment-steps=0:vertex-steps=0: FPS: 4262 FrameTime: 0.235 ms
[conditionals] fragment-steps=5:vertex-steps=0: FPS: 4245 FrameTime: 0.236 ms
[conditionals] fragment-steps=0:vertex-steps=5: FPS: 4312 FrameTime: 0.232 ms
[function] fragment-complexity=low:fragment-steps=5: FPS: 4316 FrameTime: 0.232 ms
[function] fragment-complexity=medium:fragment-steps=5: FPS: 4291 FrameTime: 0.233 ms
[loop] fragment-loop=false:fragment-steps=5:vertex-steps=5: FPS: 4291 FrameTime: 0.233 ms
[loop] fragment-steps=5:fragment-uniform=false:vertex-steps=5: FPS: 4221 FrameTime: 0.237 ms
[loop] fragment-steps=5:fragment-uniform=true:vertex-steps=5: FPS: 4257 FrameTime: 0.235 ms
=======================================================
                                  glmark2 Score: 3574
=======================================================
```
#### glmark2-es2
```log
MESA-LOADER: failed to retrieve device information
MESA: error: kgsl_pipe_get_param:103: invalid param id: 13
=======================================================
    glmark2 2023.01
=======================================================
    OpenGL Information
    GL_VENDOR:      freedreno
    GL_RENDERER:    Adreno (TM) 840
    GL_VERSION:     OpenGL ES 3.2 Mesa 26.0.0-devel (git-28147648f6)
    Surface Config: buf=32 r=8 g=8 b=8 a=8 depth=24 stencil=0 samples=0
    Surface Size:   800x600 windowed
=======================================================
[build] use-vbo=false: FPS: 4248 FrameTime: 0.235 ms
[build] use-vbo=true: FPS: 4437 FrameTime: 0.225 ms
[texture] texture-filter=nearest: FPS: 4395 FrameTime: 0.228 ms
[texture] texture-filter=linear: FPS: 4321 FrameTime: 0.231 ms
[texture] texture-filter=mipmap: FPS: 4352 FrameTime: 0.230 ms
[shading] shading=gouraud: FPS: 4340 FrameTime: 0.230 ms
[shading] shading=blinn-phong-inf: FPS: 4370 FrameTime: 0.229 ms
[shading] shading=phong: FPS: 4385 FrameTime: 0.228 ms
[shading] shading=cel: FPS: 4361 FrameTime: 0.229 ms
[bump] bump-render=high-poly: FPS: 4353 FrameTime: 0.230 ms
[bump] bump-render=normals: FPS: 4369 FrameTime: 0.229 ms
[bump] bump-render=height: FPS: 4401 FrameTime: 0.227 ms
[effect2d] kernel=0,1,0;1,-4,1;0,1,0;: FPS: 4368 FrameTime: 0.229 ms
[effect2d] kernel=1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;: FPS: 4425 FrameTime: 0.226 ms
[pulsar] light=false:quads=5:texture=false: FPS: 4329 FrameTime: 0.231 ms
[desktop] blur-radius=5:effect=blur:passes=1:separable=true:windows=4: FPS: 1279 FrameTime: 0.782 ms
[desktop] effect=shadow:windows=4: FPS: 3007 FrameTime: 0.333 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 359 FrameTime: 2.790 ms
[buffer] columns=200:interleave=false:update-dispersion=0.9:update-fraction=0.5:update-method=subdata: FPS: 1486 FrameTime: 0.673 ms
[buffer] columns=200:interleave=true:update-dispersion=0.9:update-fraction=0.5:update-method=map: FPS: 558 FrameTime: 1.793 ms
[ideas] speed=duration: FPS: 1124 FrameTime: 0.890 ms
[jellyfish] <default>: FPS: 4171 FrameTime: 0.240 ms
[terrain] <default>: FPS: 845 FrameTime: 1.184 ms
[shadow] <default>: FPS: 4486 FrameTime: 0.223 ms
[refract] <default>: FPS: 2034 FrameTime: 0.492 ms
[conditionals] fragment-steps=0:vertex-steps=0: FPS: 4333 FrameTime: 0.231 ms
[conditionals] fragment-steps=5:vertex-steps=0: FPS: 4331 FrameTime: 0.231 ms
[conditionals] fragment-steps=0:vertex-steps=5: FPS: 4399 FrameTime: 0.227 ms
[function] fragment-complexity=low:fragment-steps=5: FPS: 4341 FrameTime: 0.230 ms
[function] fragment-complexity=medium:fragment-steps=5: FPS: 4391 FrameTime: 0.228 ms
[loop] fragment-loop=false:fragment-steps=5:vertex-steps=5: FPS: 4314 FrameTime: 0.232 ms
[loop] fragment-steps=5:fragment-uniform=false:vertex-steps=5: FPS: 4386 FrameTime: 0.228 ms
[loop] fragment-steps=5:fragment-uniform=true:vertex-steps=5: FPS: 4260 FrameTime: 0.235 ms
=======================================================
                                  glmark2 Score: 3621
=======================================================
```
#### vkmark
Not tested.