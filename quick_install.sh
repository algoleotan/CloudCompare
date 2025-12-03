#!/bin/bash
# 快速安装 qPCL 和 qMeshBoolean 依赖并重新编译

set -e  # 遇到错误立即退出

echo "=========================================="
echo "安装 qPCL 和 qMeshBoolean 插件依赖"
echo "=========================================="
echo ""

# 检查是否在正确的目录
if [ ! -f "CMakeLists.txt" ]; then
    echo "错误: 请在 CloudCompare 根目录运行此脚本"
    exit 1
fi

# 安装 CGAL
echo "步骤 1/4: 安装 CGAL..."
sudo apt-get update
sudo apt-get install -y libcgal-dev
echo "✓ CGAL 安装完成"
echo ""

# 下载 libigl
echo "步骤 2/4: 下载 libigl..."
if [ -d "/tmp/libigl" ]; then
    echo "libigl 已存在，跳过下载"
else
    cd /tmp
    echo "尝试从 GitHub 下载..."
    if ! git clone --depth 1 https://github.com/libigl/libigl.git; then
        echo "GitHub 下载失败，尝试 gitee 镜像..."
        git clone --depth 1 https://gitee.com/mirrors/libigl.git libigl
    fi
    cd -
fi

if [ ! -d "/tmp/libigl/include" ]; then
    echo "错误: libigl 下载失败"
    exit 1
fi
echo "✓ libigl 下载完成"
echo ""

# 重新配置
echo "步骤 3/4: 重新配置 CMake..."
cd build
rm -rf CMakeCache.txt CMakeFiles/
cmake .. -DCMAKE_PREFIX_PATH=/home/kfusion/Qt/6.10.0/gcc_64/lib/cmake/Qt6 \
         -DPLUGIN_STANDARD_3DMASC=ON \
         -DPLUGIN_STANDARD_QPCL=ON \
         -DPLUGIN_STANDARD_QPCV=ON \
         -DPLUGIN_STANDARD_QPOISSON_RECON=ON \
         -DPLUGIN_STANDARD_QMESH_BOOLEAN=ON \
         -DLIBIGL_INCLUDE_DIR=/tmp/libigl/include \
         -DEIGEN_ROOT_DIR=/usr/include/eigen3
echo "✓ CMake 配置完成"
echo ""

# 编译
echo "步骤 4/4: 编译 CloudCompare..."
cmake --build . -j20
echo "✓ 编译完成"
echo ""

# 显示结果
echo "=========================================="
echo "安装完成！"
echo "=========================================="
echo ""
echo "已编译的插件:"
ls -lh plugins/core/Standard/qPCL/*.so 2>/dev/null || echo "  - qPCL (查找失败)"
ls -lh plugins/core/Standard/qMeshBoolean/*.so 2>/dev/null || echo "  - qMeshBoolean (查找失败)"
echo ""
echo "要安装到系统，运行:"
echo "  sudo cmake --install ."
echo ""
