#!/bin/bash

set -e
set -x

if [[ $PY3K -eq 1 || $PY3K == "True" ]]; then
  BUILD_PYTHON="-DBUILD_PYTHON_INTERFACE=ON"
else
  BUILD_PYTHON="-DBUILD_PYTHON2_INTERFACE=ON"
fi

mkdir -p build && cd build
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  ${BUILD_PYTHON} \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DBUILD_HELICS_TESTS=OFF \
  -DBUILD_HELICS_EXAMPLES=OFF \
  ..

make -j $CPU_COUNT
make install

cp -v ${PREFIX}/python/_helics.so ${SP_DIR}/
cp -v ${PREFIX}/python/helics.py ${SP_DIR}/
