FROM alpine:3.8 AS llvm-toolchain
RUN [ "apk", "add", "--no-cache", "g++" ]
RUN [ "apk", "add", "--no-cache", "cmake" ]
RUN [ "apk", "add", "--no-cache", "ninja" ]
RUN [ "apk", "add", "--no-cache", "python2" ]
RUN [ "apk", "add", "--no-cache", "linux-headers" ]

WORKDIR /src
COPY src .

WORKDIR /build
RUN [ \
	"cmake", "-G", "Ninja", \
	"-DLLVM_BUILD_STATIC=ON", \
	"-DLLVM_INCLUDE_DOCS=OFF", \
	"-DLLVM_INCLUDE_TESTS=OFF", \
	"-DLLVM_INCLUDE_EXAMPLES=OFF", \
	"-DLLVM_ENABLE_PROJECTS=all", \
	"-DLLVM_INSTALL_TOOLCHAIN_ONLY=ON", \
	"-DLLVM_INSTALL_BINUTILS_SYMLINKS=ON", \
	"-DLLVM_ENABLE_LIBXML2=OFF", \
	"-DLLDB_DISABLE_PYTHON=ON", \
	"-DLLDB_DISABLE_CURSES=ON", \
	"-DLLDB_DISABLE_LIBEDIT=ON", \
	"/src/llvm" \
]
RUN [ "ninja" ]

# "-DBUILD_SHARED_LIBS=OFF"
# "-DCLANG_ENABLE_BOOTSTRAP=ON"
# "-DBOOTSTRAP_LLVM_ENABLE_LLD=ON"
# "-DLIBCXXABI_ENABLE_SHARED=OFF"
# "-DLIBCXX_ENABLE_SHARED=OFF"
