####1.FFmepg编译环境及结构
* 下载FFmepg
* FFmpeg配置选项介绍
* 下载gas-preprocessor.pl及安装
* 编写脚本代码(执行源码)
* 执行脚本结果一览
* 编译中出现的问题
* 个人总结

####2.下载FFmepg
首先呢,我们先下载音视频框架
这里提供两种下载方法:
* 一:官网下载(https://ffmpeg.org)

![FFmpeg下载.png](http://upload-images.jianshu.io/upload_images/2960658-a01961adc66d2194.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


* 二:执行下面的FFmpeg-down(shell脚本文件)(可以到我的github下载)
![ffmpeg-down.png](http://upload-images.jianshu.io/upload_images/2960658-5cb5aec4548cac95.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 执行结果:在终端执行文件ffmpeg-down文件,就可以进行下载FFmpeg,下图正在下载...

![ffmpeg_down_结果.png](http://upload-images.jianshu.io/upload_images/2960658-86d7c31e8f055b77.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
####3.查看FFmpeg配置选项介绍
首先呢,我们进入下载好的FFmpeg框架包中,打开终端,cd到目录下,执行如下命令,就可以配置选项的组成
```
./configure --help
```

选项(options)介绍:
* Help options:FFmpeg帮助选项(帮助文档)
![help options.png](http://upload-images.jianshu.io/upload_images/2960658-47329d9f4405b668.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* --help 帮组信息(打印此消息)
* --quiet  抑制显示信息输出
* --list-decoders  显示所有可用的解码器
* --list-encoders  显示所有可用的编码器
* --list-hwaccesl  显示所有可用的硬件加速器
* --list-muxers 显示所有可用的视音频复用器
视音频复用器（Muxer）即是将视频压缩数据（例如H.264）和音频压缩数据（例如AAC）合并到一个封装格式数据（例如MKV）中去。如图所示。在这个过程中并不涉及到编码和解码。
![视音频复用器（Muxer）.jpeg](http://upload-images.jianshu.io/upload_images/2960658-ecac611ae04195c4.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* --list-demuxers  显示所有可用的视音频分离器
* --list-parsers 显示所有可用的解析器
* --list-protocols  显示所有可用的协议
* --list-bsfs  显示所有可用的比特流过滤
* --list-indevs 显示所有可用的输入设备
* --list-outdevs 显示所有可用的输出设备
* --list-filters 显示所有可用的过滤器

* Standard options:标准选项
![stanard options.png](http://upload-images.jianshu.io/upload_images/2960658-6f1057d2baeef67b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* --logfile=FILE   记录测试并输出到ffbuild/config.log文件
* --disable-logging 没有日志配置调试信息
* --fatal-warnigns  致命的警告,配置警告生成
* --prefix=PREFIX  前缀默认[/usr/local]
* --bindir=DIR   二进制文件默认[PREFIX/bin]
* --datadir=DIR 数据文件默认[PREFIX/share/ffmpeg]
* --docdir=DIR  doc文档默认[PREFIX/share/doc/ffmpeg]
* --libdir=DIR  安装库到指定目录[PREFIX/lib]
* --shlibdir=DIR 指定共享库路径[LIBDIR]
* --incdir=DIR 指定includes路径[PREFIX/include]
* --mandir=DIR 指定安装手册路径[PREFIX/share/man]
* --pkgconfigdir=DIR 指定配置文件路径[LIBDIR/pkgconfig]

* Licensing options:许可选项(侵权)
![licensing options.png](http://upload-images.jianshu.io/upload_images/2960658-da3ddd3b3ef36a65.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* --enable-gpl   允许使用GPL（默认关闭）
* --enable-version3  gpl升级到版本3(默认关闭)
* --enable-nonfree  允许用户使用非免费代码(默认关闭)

* Configuration options:配置备选选项
![configuration options.png](http://upload-images.jianshu.io/upload_images/2960658-bd65219fa4ff76a6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* --disable-static 不能编译静态库(默认关闭)
* --enable-shared 编译共享库(默认关闭)
* --enable-small 启用优化文件尺寸大小(牺牲速度)
* --disable-runtime-cpudetect  在运行时禁用cpu检测功能
* --enable-gray 灰度支持
* --disable-swscale-alpha  禁用在swscale alpha通道支持
* --disable-all 禁止编译组件,库,代码
* --disable-autodetect  禁用自动检测外部库(默认关闭)


* program options: 程序选项
![program options.png](http://upload-images.jianshu.io/upload_images/2960658-8349a6632527200a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* --disable-programs  不能编译命令行代码
* --disable-ffmpeg    ffmpeg禁止编译
* --disable-ffplay   ffplay禁止编译
* --disable-ffprobe  ffprobe禁止编译
* --disable-ffserver  ffserver禁止编译


* documentation options:文件选项
![documentation options.png](http://upload-images.jianshu.io/upload_images/2960658-419e3495b7b59a6d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* --disable-doc 不能编译文档
* --disable-htmlpages 不能编译html文档页面
* --disable-manpages 不能编译操作手册文档页面
* --disable-podpages 不能编译pod文档页面
* --disable-txtpages 不能编译文本文档页面

* component options:组件选项
![component options.png](http://upload-images.jianshu.io/upload_images/2960658-57fa8b71879924e4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* --disable-avdevice  禁止 libavcodec 构造
* --disable-avcodec   禁止 libavcore 构造
* --disable-avformat  禁止 libavformat 构造
* --disable-swresample  禁止 libswresample 构造
* --disable-swscale 禁止libswscale构造
* --disable-postproc  禁止libpostproc构造
* --disable-avfilter 禁止libavfilter 构造
* --enable-avresample  开启libavresample构造(默认关闭)
* --disable-pthreads   禁用 pthreads [默认：自动]
* --disable-w32threads  禁用 Win32 线程[默认：自动]
* --disable-os2threads   禁用0S/2线程[默认:自动]
* --disable-network  禁用网络支持[默认:关闭]
* --disable-dct  禁用DCT代码
* --disable-dwt 禁用DWT代码
* --disable-error-resilience   禁用错误resilience 代码
* --disable-lsp  禁用LSP代码
* --disable-lzo  禁用LZO代码
* --disable-mdct 禁用MDCT代码
* --disable-rdft  禁用RDFT代码
* --disable-fft 禁用FFT代码
* --disable-faan 禁用浮点 AAN(I)DCT代码

* Individual component options:个人组件选项
![individual component options.png](http://upload-images.jianshu.io/upload_images/2960658-e1dfc4bb0bedb316.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* --disable-everything 禁止下列所有组件
* --disable-encoder=NAME 禁止NAME的编码器
* --enable-encoder=NAME  启用NAME的编码器
* --disable-encoders  禁用所有编码器
* --disable-decoder=NAME 禁用NAME的解码器
* --enable-decoder=NAME 启用NAME的解码器
* --disable-decoders 禁用所有的解码器
* --disable-hwaccel=NAME 禁用NAME的硬件加速计
* --enable-hwaccel=NAME 启用NAME的硬件加速计
* --disable-muxer=NAME 禁用NAME的复用器
* --enable-muxer=NAME 启用NAME的复用器
* --disable-muxers 禁用所有的复用器
* --disable-demuxer=NAME 禁用NAME的分离器
* --enable-demuxer=NAME 启用NAME的分离器
* --disable-demuxers 禁用所有的分离器
* --enable-parser=NAME 启用NAME的解析器
* --disable-parser=NAME 禁用NAME的解析器
* --disable-parsers 禁用所有的解析器
* --enable-bsf=NAME 启用NAME的比特流过滤器
* --disable-bsf=NAME 禁用NAME的比特流过滤器
* --disable-bsfs 禁用所有的比特流过滤器
* --enable-protocol=NAME 启用NAME的协议
* --disable-protocol=NAME 禁用NAME的协议
* --disable-protocols 禁用所有的协议
* --enable-indev=NAME 启用NAME的输入设备
* --disable-indev=NAME 禁用NAME的输入设备
* --disable-indevs 禁用所有输入设备
* --enable-outdev=NAME 启用NAME的输出设备
* --disable-outdev=NAME 禁用NAME的输出设备
* --disable-devices 禁用所有的输出设备
* --enable-filter=NAME 启用NAME的过滤器
* --disable-filter=NAME 禁用NAME的过滤器
* --disable-filters 禁用所有的过滤器
* --disable-v412_m2m 禁用V4L2 mem2mem代码 [自动]

* External library support：外部库支持(重点)
![externalLibrary Support_1.png](http://upload-images.jianshu.io/upload_images/2960658-8056bcf55244e2b4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* --disable-alsa  禁止ALSA支持[自动检测]
* --disable-appkit 禁止苹果AppKit框架[自动检测]
* --disable-avfoundation 禁止苹果AVFoundation框架[自动检测]
* --disable-avisynth  启用读取AviSynth脚本文件[默认关闭]
* --disable-bzlib  禁用 bzlib [自动检测]
* --disable-coreimage  禁用苹果CoreImage框架[自动检测]
* --enable-chromaprint  Chromaprint：可提供一个客户端的公共库，能够通过特定算法计算音频文件的指纹，是AcoustID项目的核心。[默认关闭]
* --enable-freior  启用freior视频过滤[默认关闭]
* --enable-gcrypt  启用gcrypt,需要rtmp(t)e支持,如果openssl,librtmp,gmp没有被使用[默认关闭]
* --enable-gmp  启用gmp,需要rtmp(t)e支持,如果openssl或者librtmp没有被使用[默认关闭]
* --enable-gnutls 启用gnutls,需要https支持,如果opensll不能使用[默认关闭]
* --disable-iconv 禁用iconv[自动检测]
* --disable-jack  禁用libjack支持[自动检测]
* --enable-jni 启用JNI支持[默认关闭]
* --enable-ladspa 启用LADSPA 视频过滤[默认关闭]
* --enable-libass  启用libass字幕渲染,需要字幕和ass过滤[默认关闭]

![externalLibrary Support_2.png](http://upload-images.jianshu.io/upload_images/2960658-deebba5aaaabfed7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* 
* --enable-libbluray  启用蓝光,使用libbluray [默认关闭]
* --enable-libbs2b   启用bs2b DSP库[默认关闭]
* --enable-libcaca 启用文本显示,使用libcaca[默认关闭]
* --enable-libcelt 启用CELT通过解码libcelt[默认关闭]
* --enable-libcdio 启用视频CD,使用libcdio[默认关闭]
* --enable-libdc1394  启用 IIDC-1394 ,使用libdc1394和libraw1394[默认关闭]
* --enable-libfdk-aac 启用AAC 编码/解码通过libfdk-aac[默认关闭]
* --enable-libflite 启用过滤器支持通过libflite
* --enable-libfontconfig  启用libfontconfig,用于drawtext过滤器[默认关闭]
* --enable-libfreetype 启用libfreetype,需要darwtext过滤器[默认关闭]
* --enable-libfribidi 启用libfribidi ,优化darwtext过滤器[默认关闭]
* --enable-libgme 启用游戏音乐通过libgme[默认关闭]
* --enable-libgsm 启用GSM 编码/解码 通过libgsm[默认关闭]
* --enable-libiec61883 启用 iec61883 通过使用libiec61883[默认关闭]
* --enable-libilbc 启用iLBC 编码/解码通过libilbc[默认关闭]
* --enable-libkvazaar 启用HEVC 编码通过使用libkvazaar[默认关闭]
* --enable-libmodplug 启用ModPlug 通过libmodplug[默认关闭]
* --enable-libmp3lame 启用MP3编码通过libmp3lame[默认关闭]
* --enable-libopencore-amrnb 启用AMR-NB 编码/解码通过使用libopencore-amrnb[默认关闭]
* --enable-libopencore-amrwb 启用AMR-WB编码通过libopencore-amrwb[默认关闭]
* --enable-libopnecv 启用视频过滤器通过使用libopencv[默认关闭]
* --enable-libopenh264 启用H.264编码通过OpenH264[默认关闭]
* --enable-libopenjpeg 启用 JPEG 2000 编码/解码通过OpenJPEG[默认关闭]
* --enable-libopenmpt 启用编码追踪文件通过libopenmpt[默认关闭]
* --enable-libopus 启用Opus 编码/解码通过libpulse[默认关闭]
* --enable-libpulse 启用音频脉冲输入通过使用libpulse[默认关闭]
* --enable-librsvg 启用SVG 栅格化通过使用librsvg[默认关闭]
* --enable-librubberband 启用拖框需要拖框过滤器[默认关闭]
* --enable-librtmp 启用RTMP[E]支持通过使用librtmp[默认关闭]
* --enable-libshine 启用固定点MP3编码通过使用librsvg[默认关闭]
* --enable-libsmbclient 启用Samba协议通过使用libsmbclient[默认关闭]
* --enable-libsnappy 启用Snappy压缩,需要hap编码[默认关闭]
* --enable-libsoxr 启用libsoxr重采样[默认关闭]
* --enable-libspeex 启用speex 编码/解码通过使用libspeex[默认关闭]
* --enable-libssh 启用SFTP协议通过使用libspeex[默认关闭]
* --enable-libtesseract 启用Tesseract,需要ocr过滤器[默认关闭]
* --enable-libtheora 启用Theora编码通过使用libtheora[默认关闭]
* --enable-libtwolame 启用MP2编码通过使用libtwolame[默认关闭]
* --enable-lib412 启用libv412/v4l-utils[默认关闭]
* --enable-libvidstab 启用基于视频图像稳定,通过使用vid.stab[默认关闭]
* --enable-libvmaf 启用vmaf过滤器通过使用libvmaf[默认关闭]
* --enable-libvo-amrwbenc 启用AMR-WB编码通过使用libvo-amrwbenc[默认关闭]
* --enable-libvorbis 启用Vorbis编码/解码通过libvorbis,本地已经实现[默认关闭]
* --enable-libvpx 启用VP8和VP9编码/解码通过使用libvpx[默认关闭]
* --enable-libwavpack 启用wavpack编码通过使用libwavpack[默认关闭]
* --enable-libwebp 启用WebP编码通过使用libwebp[默认关闭]
* --enable-libx264 启用H.264编码通过使用x264[默认关闭]
* --enable-libx265 启用HEVC编码通过使用x265[默认关闭]
* --enable-libxavs 启用AVS编码通过使用xavs[默认关闭]
* --enable-libxcb  启用X11抓取XCB[自动检测]
* --enable-libxcb-shm 启用X11抓取shm交互[自动检测]
* --enable-libxcb-xfixes 启用X11抓取mouse渲染[自动检测]
* --enable-libxcb-shape 启用X11抓取图像渲染[自动检测]
* --enable-libxvid 启用Xvid编码通过使用xvidcore,本地MPEG-4/Xvid编码已经存在[默认关闭]
![externalLibrary Support_3.png](http://upload-images.jianshu.io/upload_images/2960658-b59ca71202e8d948.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
*
* --enable-libxml2 启用XML解析,使用C语言库libxml2[默认关闭]
* --enable-libzimg 启用z.lib 需要zscale过滤器[默认关闭]
* --enable-libzmq 启用消息传递通过使用libzmq[默认关闭]
* --enable-libzvbi 启用点在文本支持通过使用llibzvbi[默认关闭]
* --disable-lzma 禁用lzma[自动检测]
* --enable-decklink  启用黑魔法 DeckLind I/O支持[默认关闭]
* --enable-libndi_newtek 启用Newteck NDI I/O支持[默认关闭]
* --enable-mediacodec 启用安卓媒体编解码器支持[默认关闭]
* --enable-libmysofa 启用libmysofa,需要sofalizer过滤器[默认关闭]
* --enable-openal 启用OpenAL 1.1 捕获支持[默认关闭]
* --enable-onencl 启用OpenCl代码
* --enable-opengl 启用OpenGL渲染[默认关闭]
* --enable-openssl 启用openssl,需要https支持,如果没有使用[默认关闭]
* --disable-sndio 禁用sndio支持[自动检测]
* --disable-schannel 禁用 schannel SSP,需要TLS支持在Windows,如果openssl 和gnutls没有使用[自动检测]
* --disable-sdl2 禁用sdl2[自动检测]
* --disable-securetransport 禁用 安全传输,需要TLS支持在OSX如果openssl和gnutls没有使用[自动检测]
* --disable-xlib 禁用xlib[自动检测]
* --disable-zlib 禁用zlib[自动检测]
* --disable-audiotoolbox 禁用苹果AUdioToolbox代码[自动检测]
* --disable-cuda  禁用动态链接Nvidia CUDA代码[自动检测]
* --enable-cuda-sdk 启用CUDA特性,需要CUDA SDK[自动检测]
* --disable-cuvid 禁用 Nvidia CUVID 支持[自动检测]
* --disable-d3d11va 禁用Microsof Direct3D 11 视频加速器代码[自动检测]
* --disable-dxva2 禁用Microsof DirectX 9 视频加速器代码[自动检测]
* --enable-libdrm  启用DRM代码(Linux)[默认关闭]
* --enable-libmfx 启用Intel MediaSDK代码通过时会用libmfx[默认关闭]
* --enable-libnpp 启用Nvidia性能基本代码[默认关闭]
* --enable-mmal 启用多媒体抽象层通过使用MMAL[默认关闭]
* --disable-nvenc 禁用Nvidi视频编码代码[自动检测]
* --enable-omx 启用OpenMAX IL 代码[默认关闭]
* --enable-omx-rpi 启用OpenMAX IL 代码树莓派[默认关闭]
* --enable-rkmpp 启用媒体平台代码[默认关闭]
* --disable-vaapi 禁用视频加速器API代码[自动检测]
* --disable-vda 禁用苹果视频解码加速器代码[自动检测]
* --disable-vdpau 禁用Nvidia视频解码和展示Unix代码的API[自动检测]
* --disable-videotoolbox 禁用VideoToolbox代码[自动检测]


* Toolchain options:工具链选项(指定需要编译平台CPU架构类型,arm64,x86,arm7等等)
![toolchain options.png](http://upload-images.jianshu.io/upload_images/2960658-420feae492f73f7d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* --arch=ARCH 选择体系结构
* --cpu=CPU 选择最小需要的CPU
* --cross-prefix=PREFIX 使用前缀为编译的工具
* --progs-cross-compile  程序名后缀
* --sysroot=PATH 根交叉构建树
* --sysinclude=PATH 编译系统头文件的路径
* --target-os=OS 编译平台系统
* --target-exec=CMD 执行的目标文件
* --target-path=DIR 编译母的的路径
* --target-samples=DIR 样例目录的路径
* --tempprefix=PATH  固定目录/前缀代替mktmep的检查
* --toolchain=NAME 设置tool默认名
* --nm=NM 使用nm工具NM[nm -g]
* --ar=AR  使用归档工具AR[ar]
* --as=AS 使用汇编程序AS
* --ln_s=LN_S 使用特殊符号链接工具LN_S[ln -s -f]
* --strip=STRIP  使用带工具条工具STRIP[strip]
* --windres=WINDRES 使用windows资源编译WINDRES[windres]
* --x86asmexe=EXE 使用nasm-compatible汇编程序EXE[nasm]
* --cc=CC 使用C编译CC[gcc]
* --cxx=CXX 使用C编译CXX[g++]
* --objcc=OCC 使用ObjC编译OCC[gcc]
* --dep-cc=DEPCC  使用依赖生成器DEPCC[gcc]
* --nvcc=NVCC 使用Nvidia CUDA编译NVCC[nvcc]
* --ld=LD 使用链接者LD[]
* --pkg-config=PKGCONFIG 使用包配置工具PKGCONFIG[pkg-config]
* --pkg-config-flags=FLAGS 通过额外的标志到pkgconf []
* --ranlib=RANLIB 使用ranlib RANLIB[ranlib]
* --doxygen=DOXYGEN 使用DOXYGEN生成API文档[doxygen]
* --host-cc=HOSTCC 使用host C 编译HOSTCC
* --host-cflags=HCFLAGS  使用HCFLAGS编译host
* --host-cpflags= HCPPELAGS 使用HCPPELAGS编译host
* --host-ld=HOSTLD 使用host链接HOSTLD
* --host-ldflags=HLDFLAGS 使用HLDFLAGS 链接host
* --host-libs=HLIBS  使用库HLIBS链接host
* --host-os=OS  编译host系统[]
* --extra-cflags=ECFLAGS 添加ECFLAGS到CFLAGS []
* --extra-cxxflags=ECFLAGS  添加ECFLAGS到CXXFLAGS []
* --extra-objcflags=FLAGS 添加FLAGS到OBJCFLAGS []
* --extra-ldflags=ELDFLAGS 添加ELDFLAGS到LDFLAGS[]
* --extra-ldexeflags=ELDFLAGS 添加ELDFLAGS到LDEXEFLAGS []
* --extra-ldlibflags=ELDFLAGS 添加ELDFLAGS 到LDLIBFLAGS []
* --extra-libs=ELIBS 添加ELIBS []
* --extra-version=STRING 版本字符串后缀[]
* --optflags=OPTFLAGS 重载优化相关的编译器
* --nvccflags=OPTFLAGS 重载nvcc [-gencode arch=compute_30,code=sm_30 -02]
* --build-suffix=SUFFIX 库名的后缀 []
* --enable-pic 编译位置独立的代码
* --enable-thumb 编译thumb指令集
* --enable-lto  使用链接时优化
* --env="ENV=override" 重载环境变量

* Advanced options：高级选项
![advanced options.png](http://upload-images.jianshu.io/upload_images/2960658-21842b62bd175905.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* --malloc-prefix=PREFIX  分配内存与相关名字的前缀
* --custom-allocator=NAME  使用受支持的自定义分配程序
* --disable-symver 禁用符号版本控制
* --enable-hardcoded-tables  使用硬编码表代替运行时生成
* --disable-safe-bitstream-reader  在bitread时,禁止缓冲器边界check
* --sws-max-filter-size=N  最大过滤size[默认256]

* Optimization options (experts only)：优化选项
![optimization options.png](http://upload-images.jianshu.io/upload_images/2960658-098ba76a11861dfa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* --disable-asm 禁止所有优化
* --disable-altivec 禁止单指令流多数据流优化
* --disable-vsx 禁止VSX优化
* --disable-power8 禁止POWER8优化
* --disable-amd3dnow 禁止3DNow!优化
* --disable-amd3nowext  禁止3DNow!扩展优化
* --disable-mmx 禁止MMX优化
* --disable-mmxext 禁止MMXEXT优化
* --disable-sse 禁止SSE优化
* --disable-sse2 禁止SSE2优化
* --disable-sse3 禁止SSE3优化
* --disable-sse4 禁止SSE4优化
* --disable-sse42 禁止SSE4,2 优化
* --disable-avx 禁止AVX优化
* --disable-xop 禁止XOP优化
* --disable-fma3 禁止FMA3优化
* --disable-fma4 禁止FMA4优化
* --disable-avx2 禁止AVX2优化
* --disable-aesni 禁止AESNI优化
* --disable-armv5te 禁止armv5te 优化 
* --disable-armv6 禁止armv6优化
* --disable-armv6t2 禁止armv6t2优化
* --disable-vfp 禁止VFP优化
* --disable-neon 禁止NEON优化
* --disable-inline-asm  禁止使用内联汇编
* --disable-x86asm 禁止使用独立的x86汇编
* --disable-mipsdsp 禁止MIPS DSP ASE R1优化
* --disable-mipsdspr2 禁止MIPS DSP ASE R2 优化
* --disable-msa 禁止MSA优化
* --disable-mipsfpu 禁止浮点MIPS优化
* --disable-mmi 禁止处理器SIMD优化
* --disable-fast-unaligned 考虑未对齐的访问缓慢

* Developer options：开发者选项
![developer options.png](http://upload-images.jianshu.io/upload_images/2960658-ff48051f4e498be1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* --disable-debug 禁止调试
* --enable-debug=LEVEL 设置调试等级
* --disable-optimizations 禁止编译器优化
* --enable-extra-warnings 启用多个编译器警告
* --disable-stripping 删除可执行文件和共享库
* --assert-level=level 0(默认),1或者2,断言测试的数量,2导致运行时减速
* --enable-memory-poisoning  用任意的数据运行填充未初始化的空间，通过valgrind进行测试，以使用指定的valgrind二进制代码来检测内存泄漏和错误。
* --valgrind=VALGRIND 运行测试通过valgrind检测内存泄漏和错误,使用指定的valgrind二进制
* --enable-ftrapv 算术溢出
* --samples=PATH  测试样品路径,如果在调用是时间没有设置$FATE_SAMPLES
* --enable-neon-clobber-test  检查NEON寄存器(仅用于调试目的)
* --enable-xmm-clobber-test  检查XMM寄存器(仅仅Win64,仅用于调试目的) 
* --enable-random  任意地启用组件
* --disable-random 任意地禁用组件
* --enable-random=LIST 随机启用特定组件或组件组,列表是一个以逗号分隔的名称[:PROB],PROB与组件名相关,默认值是0.5
* --disable-random=LIST 随机禁用特定组件或组件组,列表是一个以逗号分隔的名称[:PROB],PROB与组件名相关,默认值是0.5
* --random-seed=VALUE 根据值来启用/禁用random
* --disable-valgrind-backtrace  不能在Valgrind下输出向后追踪
* --enable-osfuzz 支持构建fuzzer工具
* --libfuzzer=PATH libfuzzer的路径
* --ignore-tests=TESTS 测试列表的结果是可以忽略
* --enable-linux-perf  使用Linux性能监视器API

>把这些options(选项)终于翻译完了,到这一步,笔者确实累了.
1.要把英文翻译过来,
2.结合技术词汇进行翻译.
这里选项大家根据自己需要各取所需,加入到自己编译shell中.


####4.下载gas-preprocessor.pl及安装

* 下载
同样有两种办法:

```
一: github地址：https://github.com/libav/gas-preprocessor 
```
```
二: 到我的github下载:请查看文章底部
```
```
把gas-preprocessor.pl文件与执行sh文件放到同一目录下.
```
![sh_pl同一目录.png](http://upload-images.jianshu.io/upload_images/2960658-1c4ce64e01d66760.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 安装
同样两种办法:
```
一:
1. 下载最新的gas-preprocessor.pl
2.右键点Finder->前往文件夹，输入/usr，
在里面新建local文件夹，进入local文件夹中![C compiler test failed.png]
(http://upload-images.jianshu.io/upload_images/2960658-41ad8a2bf4758ada.png?
imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
再新建bin文件夹，
拷贝下载的gas-preprocessor.pl到该目录下；
3. 打开终端，输入 chmod 777 /usr/local/bin/gas-preprocessor.pl
```
```
二:
1.下载gas－preprocessor安装包
2.复制gas-preprocessor.pl到/usr/sbin下
3.chmod 777 /usr/local/bin/gas-preprocessor.pl
```

####5.编写脚本代码
* 定义下载库名称
```
source="ffmpeg-3.4"
```
* 定义".h/.mm/.c文件编译的结果目录"
```
cache="cache"
```
* 定义.a静态库保存目录
```
staticdir=`pwd`/"lk-ffmpeg-iOS"
```
* 添加FFmpeg配置选项->默认配置
```
Toolchain options:工具链选项(指定我们需要编译平台CPU架构类型)
--enable-cross-compile:交叉编译
--enable-pic:允许建立与位置无关代码
```
```
Developer options:开发者选项
--disable-debug:禁止使用调试模式
```
```
Program options选项
--disable-programs:禁用程序(不允许建立命令行程序)
```
```
Documentation options:文档选项
--disable-doc:不需要编译文档
```
```
configure_flags="--enable-cross-compile --disable-debug --disable-programs 
--disable-doc --enable-pic"
```
* 定义默认CPU平台架构类型
```
arm64 armv7->真机->CPU架构类型
x86_64 i386->模拟器->CPU架构类型
```
```
archs="arm64 armv7 x86_64 i386"
```
* 指定我们的这个库编译系统版本-iOS系统7.0以及以上版本使用这个静态库
```
targetversion="7.0"
```
* 接受命令后输入参数
```
动态接受命令输入CPU平台架构类型
```
```
if [ "$*" ]
then
#存在输入参数,也就说:外部指定需要编译CPU架构类型
archs="$*"
fi
```
* 安装汇编器->yasm 
```
下载yasm最新版本：http://www.tortall.net/projects/yasm/releases/ 
```
```
首先判断是否存在汇编器,然后通过软件管理器,下载安装汇编器
```
```
if [  ! `which yasm` ]
then
if [ ! `which brew` ]
then
echo "安装brew"
ruby -e "$(curl -fsSL
https://raw.githubusercontent.com/Homebrew/install/master/install)" || exit 1
fi
echo "安装yasm"
brew install yasm || exit 1
fi 
```
* for循环编译FFmpeg静态库
```
currentdir=`pwd`
for arch in #archs
do
echo "开始编译"
#创建目录
mkdir -p "$cache/$arch"
#进入这个目录
cd "$cache/$arch"
#配置编译CPU架构类型->指定当前编译CPU架构类型
archflags="-arch $arch"
#判定一下是编译的模拟器.a静态库,还是真机.a静态库
if [ "$arch" = "i386" -o "$arch" = "x86_64"]
then
#模拟器
platform="iPhoneSimulator"
#支持最小系统版本->iOS系统
archflags="$archflags -mios-simulator-version-min=$targetversion"
else
#真机(mac,iOS都支持)
platform="iPhoneOS"
#支持最小系统版本->iOS系统
archflags="$archflags -mios-version-min=$targetversion -
fembed-bitcode"
#优化处理
#如果架构类型是"arm64",那么
if [ "$arch" = "arm64" ]
then
#程序运行时,变量访问越界问题
EXPORT="GASPP_FIX_XCODE5=1"  
fi
fi
```
* 编译
```
将platform->转成大写或者小写
```
```
XCRUN_SDK=`echo $platform | tr '[:upper:]''[:lower:]'`
```
```
编译器->编译平台
```
```
CC="xcrun -sdk $XCRUN_SDK clang"
```
```
架构类型->arm64
```
```
if [ "$arch" = "arm64" ]
then
#preprocessor.pl帮助我们编译FFmpeg->arm64位静态库
AS="gas-preprocessor.pl -arch aarch64 -- $CC"
else
#默认编译平台
AS="$CC"
fi
```
```
--target-os:目录系统->darwin(mac系统早期版本)
--arch:CPU平台架构类型
--cc:指定编译器类型选项
--as:汇编程序
$configure_flags最初配置
--extra-cflags
--prefix:静态库输出目录
```
```
TMPDIR=${TMPDIR/%\/} $currentdir/$source/configure \
--target-os=darwin \
--arch=$arch \
--cc="$CC" \
--as="$AS" \
$configure_flags \
--extra-cflags="$archflags" \
--extra-ldflags="$archflags" \
--prefix="$staticdir/$arch" \
|| exit 1
```
```
#执行命令 安装导出静态库
make -j3 install $EXPORT || exit 1
#回到了我们的脚本文件目录
cd $currentdir
done
```

####6.执行脚本结果一览
* 执行成功后,这里需要等待一小会时间,此时,你可以放首音乐听听,等待一下
我们可以在文件夹中看到
![执行结果_1.png](http://upload-images.jianshu.io/upload_images/2960658-cbba6cd6851afc78.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)![执行结果_2.png](http://upload-images.jianshu.io/upload_images/2960658-ff3311daa95b0696.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

####7.编译过程中遇到的问题

* GNU assembler not found, install/update gas-preprocessor

![GNU assembler not found, install:update gas-preprocessor.png](http://upload-images.jianshu.io/upload_images/2960658-fe42d6907c4dc9c5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
如果这一步出错,因为没有把pl文件放在同一目录下,才导致的错误.
所以您可以最新下载的pl文件,放在同一目录下进行编译.
```
```
那就需要您查看第四步操作进行下载和安装
```

* C compiler test failed

![C compiler test failed.png](http://upload-images.jianshu.io/upload_images/2960658-2b4bff9d724c0fc1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
1.打开终端。
输入并回车
cd /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.
platform/developer/SDKs/
然后输入 
ls 
可以查看到你当前iOS SDK的版本
2.修改iOS SDK版本。
3.再次执行脚本
```
####8.个人总结
好了,到这里呢?

您就完成了FFmepg--静态库的编译,

当您完成这些操作,还是蛮有成就的,

编译自己想要的静态库,需要花费时间,需要静心等待,

编译出错就需要您想办法解决,

个人觉得写编译脚本不是一件困难的事,关键是遇到了编译出错的问题,你是否可以自己解决.

考验了一下个人能力时候到了,如果您觉得对您有帮助,请🌹和👍支持一波.

以上遇到的2种编译问题呢?是个人遇到的,如果您也遇到了其他的问题呢,自己解决了,也可以发给我,我把这个问题和解决办法加上去,希望帮组更多的小伙伴.

如果有什么问题咱么可以交流一下,借用名人的一句话,"有问题就说,不要憋出内伤".😆😁

如果需要FFmepg--shell的编译及下载源代码,请到我的github下载:
https://github.com/LK26/FFmepg--shell

如果需要转载,请注明原著地址,谢谢!!
# 联系我
附上我的博客地址:http://www.jianshu.com/p/6e7e494b7c85
有什么问题可以到简书联系我?
咱们互相交流.









