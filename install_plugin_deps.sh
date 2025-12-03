#!/bin/bash
# CloudCompare 插件依赖安装脚本

echo "============================================="
echo "CloudCompare 插件依赖安装"
echo "============================================="
echo ""

# 检查是否有 root 权限
if [ "$EUID" -ne 0 ]; then
    echo "请使用 sudo 运行此脚本:"
    echo "  sudo bash install_plugin_deps.sh"
    exit 1
fi

echo "正在更新软件包列表..."
apt-get update

echo ""
echo "正在安装 CGAL (用于 qMeshBoolean 插件)..."
apt-get install -y libcgal-dev

echo ""
echo "============================================="
echo "系统依赖安装完成！"
echo "============================================="
echo ""
echo "接下来需要下载 libigl (如果尚未下载):"
echo "  cd /tmp"
echo "  git clone --depth 1 https://github.com/libigl/libigl.git"
echo ""
echo "然后重新配置并编译 CloudCompare:"
echo "  cd /home/kfusion/github/CloudCompare/build"
echo "  rm -rf CMakeCache.txt CMakeFiles/"
echo "  cmake .. -DCMAKE_PREFIX_PATH=/home/kfusion/Qt/6.10.0/gcc_64/lib/cmake/Qt6 \\"
echo "           -DPLUGIN_STANDARD_3DMASC=ON \\"
echo "           -DPLUGIN_STANDARD_QPCL=ON \\"
echo "           -DPLUGIN_STANDARD_QPCV=ON \\"
echo "           -DPLUGIN_STANDARD_QPOISSON_RECON=ON \\"
echo "           -DPLUGIN_STANDARD_QMESH_BOOLEAN=ON \\"
echo "           -DLIBIGL_INCLUDE_DIR=/tmp/libigl/include \\"
echo "           -DEIGEN_ROOT_DIR=/usr/include/eigen3"
echo "  cmake --build . -j20"
echo "  sudo cmake --install ."
echo ""
