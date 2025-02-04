ROOT=$(pwd)
echo $ROOT

git submodule update --init --recursive

pushd third_party/eigen3
mkdir build_cmake
cd build_cmake
cmake -DCMAKE_DEBUG_POSTFIX="" -DINSTALL_LIBS=ON -DCMAKE_BUILD_TYPE=Release  -DCMAKE_INSTALL_PREFIX:PATH=local_install  ..
make -j4
make install
popd
cd $ROOT

pushd third_party/bullet3
mkdir build_cmake
cd build_cmake

cmake  -DUSE_DOUBLE_PRECISION=ON -DCMAKE_DEBUG_POSTFIX="" -DINSTALL_LIBS=ON -DCMAKE_BUILD_TYPE=Release  -DCMAKE_INSTALL_PREFIX:PATH=local_install  ..
make -j4
make install

popd
cd $ROOT

pushd third_party/gflags
mkdir build_cmake
cd build_cmake
cmake   -DCMAKE_DEBUG_POSTFIX="" -DINSTALL_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=$ROOT/third_party/gflags/build_cmake/local_install ..
make -j4
make install
popd
cd $ROOT

pushd third_party/glog
mkdir build_cmake
cd build_cmake
cmake  -DCMAKE_DEBUG_POSTFIX="" -DINSTALL_LIBS=ON -DCMAKE_BUILD_TYPE=Release -Dgflags_DIR=$ROOT/third_party/gflags/build_cmake -DCMAKE_INSTALL_PREFIX:PATH=$ROOT/third_party/glog/build_cmake/local_install ..
make -j4
make install
popd
cd $ROOT


pushd third_party/ceres-solver
mkdir build_cmake
cd build_cmake
cmake  -DBUILD_EXAMPLES=OFF -DBUILD_BENCHMARKS=OFF -DBUILD_TESTING=OFF -Dgflags_DIR=$ROOT/third_party/gflags/build_cmake -Dglog_DIR=$ROOT/third_party/glog/build_cmake -DEigen3_DIR=$ROOT/third_party/eigen3/build_cmake  -DCMAKE_DEBUG_POSTFIX="" -DINSTALL_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=$ROOT/third_party/ceres-solver/build_cmake/local_install ..
make -j4
make install
popd
cd $ROOT



pushd third_party/boost
./bootstrap.sh
./b2 --with-serialization
popd
cd $ROOT


pushd third_party/osqp
mkdir build_cmake
cd build_cmake
cmake   -DCMAKE_DEBUG_POSTFIX="d" -DINSTALL_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=$ROOT/third_party/osqp/build_cmake/local_install ..
cmake  --build .  --target INSTALL  --config Debug
cmake  --build .  --target INSTALL  --config Release
popd
cd $ROOT

pushd third_party/qpoases
mkdir build_cmake
cd build_cmake
cmake   -DCMAKE_DEBUG_POSTFIX="d" -DINSTALL_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=$ROOT/third_party/qpoases/build_cmake/local_install ..
cmake  --build .  --target INSTALL  --config Debug
cmake  --build .  --target INSTALL  --config Release
popd
cd $ROOT


pushd third_party/osqp
mkdir build_cmake
cd build_cmake
cmake   -DINSTALL_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=$ROOT/third_party/osqp/build_cmake/local_install ..
make -j4 
make install
popd
cd $ROOT




mkdir build_cmake
cd build_cmake

cmake  -DBullet_DIR=$ROOT/third_party/bullet3/build_cmake -Dgflags_DIR=$ROOT/third_party/gflags/build_cmake -Dglog_DIR=$ROOT/third_party/glog/build_cmake -DEigen3_DIR=$ROOT/third_party/eigen3/build_cmake -DCeres_DIR=$ROOT/third_party/ceres-solver/build_cmake/local_install/lib/cmake/Ceres -DUSE_CPPAD=ON -DUSE_CERES=OFF -DPAGMO_WITH_EIGEN3=ON -DBoost_DIR:PATH=$ROOT/third_party/boost/stage/lib/cmake/Boost-1.75.0  -DUSE_CERES=OFF -DUSE_OSQP=ON -Dosqp_DIR=$ROOT/third_party/osqp/build_cmake  ..

make -j4

