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
