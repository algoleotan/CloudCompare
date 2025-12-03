#!/bin/bash
# CloudCompare 启动脚本
# 设置 Qt 6.10.0 库路径

export LD_LIBRARY_PATH=/home/kfusion/Qt/6.10.0/gcc_64/lib:$LD_LIBRARY_PATH

CloudCompare "$@"
