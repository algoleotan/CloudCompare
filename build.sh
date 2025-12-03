cd build

# 配置说明：
# ✅ 已启用插件及其依赖:
# - QMESH_BOOLEAN: 网格布尔运算 (需要 CGAL + libigl + Eigen) ✓ 已安装
# - Q3DMASC: 点云多尺度特征提取
# - QPCV: 环境光遮蔽
# - QPOISSON_RECON: 泊松曲面重建
#
# ❌ 未启用的插件:
# - QPCL: PCL 算法接口 (Qt5/Qt6 冲突 - 系统 PCL 使用 Qt5)
# - QCORK: 网格布尔运算 (仅支持 Windows)
#
# 详情请参考: PLUGIN_DEPENDENCIES.md 或 RUN_ME.txt

cmake .. -DCMAKE_PREFIX_PATH=/home/kfusion/Qt/6.10.0/gcc_64/lib/cmake/Qt6 \
         -DPLUGIN_STANDARD_3DMASC=ON \
         -DPLUGIN_STANDARD_QPCV=ON \
         -DPLUGIN_STANDARD_QPOISSON_RECON=ON \
         -DPLUGIN_STANDARD_QMESH_BOOLEAN=ON \
         -DLIBIGL_INCLUDE_DIR=/home/kfusion/libigl/include \
         -DEIGEN_ROOT_DIR=/usr/include/eigen3

cmake --build . -j20
sudo cmake --install .
