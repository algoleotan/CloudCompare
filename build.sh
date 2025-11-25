cd build
cmake .. -DCMAKE_PREFIX_PATH=/home/kfusion/Qt/6.10.0/gcc_64/lib/cmake/Qt6 \
         -DPLUGIN_STANDARD_3DMASC=ON \
         -DPLUGIN_STANDARD_QPCL=ON
cmake --build .
sudo cmake --install .
