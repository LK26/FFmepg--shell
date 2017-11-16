# FFmepg--down
```
这里是对FFmepg进行下载shell文件源代码
```
```
当然您也可以去忘光进行下载,解压就可以使用了.
```
```
#!/bin/bash
#库名称
source="ffmpeg-3.4"
#下载这个库
if [ ! -r $source ]
then
#没有下载,那么我需要执行下载操作
echo "没有FFmpeg库,我们需要下载....."
#下载:怎么下载?
#"curl"命令表示:它可以通过Http\ftp等等这样的网路方式下载和上传问加你(它是一个强大网路工具)
#基本格式:curl地址
#指定下载版本
#下载完成之后,那么我们需要解压(通过自动解压)
#"tar"命令:表示解压和压缩(打包)
#基本语法:tar options
#例如: tar xj
#options选项分为很多种类型
#-x 表示: 解压文件选项
#-j 表示: 是否需要解压bz2压缩包(压缩包格式类型有很多:zip,bz2等等...)
curl https://ffmpeg.org/releases/${source}.tar.bz2 | tar xj || exit 1
fi

```
# FFmpeg-build
```
这是对FFmpeg库进行编译源码
```
```
#!/bin/bash
#1.首先:定义下载的库名称
source="ffmpeg-3.4"
#2.其次:定义".h/.mm/.c"文件编译的结果目录
#目录作用:用于保存.h/.m/.c文件编译后的结果.o问加你
cache="cache"
#3.定义".a"静态库保存目录
#pwd命令:表示获取当前目录
staticdir=`pwd`/"lk-ffmpeg-iOS"
#4.添加FFmpeg配置选项->默认配置
#Toolchain options:工具链选项(指定我们需要编译平台CUP架构类型)
#--enable-cross-compile:交叉编译
#Developer options:开发者选项
#--disable-debug:禁止使用调试模式
#Program options选项
#--disable-programs:禁用程序(不允许建立命令行程序)
#Documentation options:文档选项
#--disable--doc:不需要编译文档
#Toolchain options:工具链选项
#--enable-pic:允许建立与位置无关代码
configure_flags="--enable-cross-compile --disable-debug --disable-programs --disable-doc --enable-pic"
#5.定义默认CPU平台架构类型
#arm64 armv7->真机->CPU架构类型
#x86_64 i386->模拟器->CPU架构类型
archs="arm64 armv7 x86_64 i386"

#6.指定我们的这个库编译系统版本-iOS系统下的7.0以及以上版本使用这个静态库
targetversion="10.1"

#7.接受命令后输入参数
#动态接受命令输入CPU平台架构类型(输入参数:编译指定的CPU库)
if [ "$*" ]
then
#存在输入参数,也就说:外部指定需要编译CPU架构类型
archs="$*"
fi
#8.安装汇编器->yasm
#判断一下是否存在这个汇编器
#目的:通过软件管理器(Homebrew),然后下载安装(或者更新)汇编器
#一个命令就能够帮助我们完成所有的操作
if [ ! `which yasm` ]
then
#Homebrew:软件管理器
#下载一个软件管理器:安装,卸载,更新,搜索等等...
if [ ! `which brew` ]
then
echo "安装brew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || exit 1
fi
echo "安装yasm"
#成功了
#下载安装这个汇编器
#exit -1 ->安装失败了,那么退出程序
brew install yasm || exit 1
fi

echo "循环编译"

#9.for循环编译FFmpeg静态库
currentdir=`pwd`
for arch in $archs
do
echo "开始编译"
#9.1.创建目录
#在编译结果目录下-创建对应的平台架构类型
mkdir -p "$cache/$arch"
#9.2.进入这个目录
cd "$cache/$arch"
#9.3配置编译CPU架构类型->指定当前编译CPU架构类型
archflags="-arch $arch"
#9.4.判定一下你倒是是编译的模拟器.a静态库,还是真机.a静态库
if [ "$arch" = "i386" -o "$arch" = "x86_64" ]
then
#模拟器
platform="iPhoneSimulator"
#支持最小系统版本->iOS系统
archflags="$archflags -mios-simulator-version-min=$targetversion"
else
#真机(mac,iOS都支持)
platform="iPhoneOS"
#支持最小系统版本->iOS系统
archflags="$archflags -mios-version-min=$targetversion -fembed-bitcode"
#注意:优化处理(可有可无)
#如果架构类型是"arm64",那么
if [ "$arch" = "arm64" ]
then
#GNU汇编器(GNU Assembler),简称为GAS
#GASPP->汇编器预处理程序
#解决问题:分段错误
#通俗一点:就是程序运行时,变量访问越界一类的问题
EXPORT="GASPP_FIX_XCODE5=1"
fi
fi
#10.正式编译
#tr命令可以对来自标准输入的字符进行替换,压缩和删除
#'[:upper:]'->将小写转成大写
#'[:lower:]'->将大写转成小写
#将platform->转成大写或者小写
XCRUN_SDK=`echo $platform | tr '[:upper:]' '[:lower:]'`
#编译器->编译平台
CC="xcrun -sdk $XCRUN_SDK clang"
#架构类型->arm64
if [ "$arch" = "arm64" ]
then
#音视频默认一个编译命令
#preprocessor.pl帮助我们编译FFmpeg->arm64位静态库
AS="gas-preprocessor.pl -arch aarch64 -- $CC"
else
#默认编译平台
AS="$CC"
fi

echo "执行到了1"
#目录找到FFmepg编译源代码目录->设置编译配置->编译FFmpeg源码
#--target-os:目录系统->darwin(mac系统早期版本名字)
#darwin:是mac系统,iOS系统祖宗
#--arch:CPU平台架构类型
#--cc:指定编译器类型选项
#--as:汇编程序
#$configure_flags最初配置
#--extra-cflags
#--prefix:静态库输出目录
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

echo "执行了"

#解决问题->分段错误问题
#安装->导出静态库(编译.a静态库)
#执行命令
make -j3 install $EXPORT || exit 1

#回到了我们的脚本文件目录
cd $currentdir
done
```
# 执行sh文件后
* 如果您在编译过程中遇到了如下问题
```
GNU assembler not found, install/update gas-preprocessor
```

```
如果这一步出错,因为没有把pl文件放在同一目录下,才导致的错误.
所以您可以最新下载的pl文件,放在同一目录下进行编译.
```
这里有两种解决办法,当然如果您也有更好的办法,也可以使用的.
一.
```
1. 下载最新的gas-preprocessor.pl
2.右键点Finder->前往文件夹，输入/usr，
在里面新建local文件夹，进入local文件夹中![C compiler test failed.png]
(http://upload-images.jianshu.io/upload_images/2960658-41ad8a2bf4758ada.png?
imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
再新建bin文件夹，
拷贝下载的gas-preprocessor.pl到该目录下；
3. 打开终端，输入 chmod 777 /usr/local/bin/gas-preprocessor.pl
```
二.
```
1.下载gas－preprocessor安装包
2.复制gas-preprocessor.pl到/usr/sbin下
3.chmod 777 /usr/local/bin/gas-preprocessor.pl
```
* C compiler test failed

解决方法:
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

附上我的博客地址:http://www.jianshu.com/p/6e7e494b7c85
有什么问题到我博客?互相交流.









