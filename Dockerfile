FROM ubuntu:24.04

ENV CLANGVER=20 \
    CHECKERS="\
    -enable-checker alpha.core.CastSize \
    -enable-checker alpha.core.CastToStruct \
    -enable-checker alpha.security.ReturnPtrRange \
    -enable-checker alpha.unix.cstring.BufferOverlap \
    -enable-checker alpha.unix.cstring.OutOfBounds \
    -enable-checker alpha.core.FixedAddr \
    -enable-checker optin.cplusplus.UninitializedObject \
    -enable-checker unix \
    -enable-checker core \
    -enable-checker nullability \
    -enable-checker cplusplus \
    -enable-checker security"

# 2023/01 - python3-distutils-extra for `asan_symbolize`
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y libc++-dev libfindbin-libs-perl links wget gpg \
                        libleptonica-dev libfreetype6-dev \
                        zlib1g-dev libjpeg-dev libtiff-dev libpng-dev libgif-dev libwebp-dev libjbig-dev liblzma-dev \
                        sudo && \
    apt-get install -y clang-$CLANGVER clang-tools-$CLANGVER cmake && \
    rm -rf /var/lib/apt/lists/*

ENV CC=/usr/bin/clang-$CLANGVER \
    CXX=/usr/bin/clang++-$CLANGVER \
    CCC_CC=/usr/bin/clang-$CLANGVER \
    CCC_CXX=/usr/bin/clang++-$CLANGVER \
    CMAKE_CXX_COMPILER=/usr/share/clang/scan-build-$CLANGVER/libexec/c++-analyzer \
    CMAKE_C_COMPILER=/usr/share/clang/scan-build-$CLANGVER/libexec/ccc-analyzer

RUN ls -lah /usr/bin/clang* && \
    (ln -s $CC /usr/bin/clang || true) &&  \
    (ln -s $CXX /usr/bin/clang++ || true) &&  \
    (ln -s /usr/bin/scan-build-$CLANGVER /usr/bin/scan-build || true) && \
    (ln -s /usr/bin/asan_symbolize-$CLANGVER /usr/bin/asan_symbolize || true)

RUN cmake --version

ENV EXTCMD=scan-build\ -v\ --use-analyzer=/usr/bin/clang-$CLANGVER

WORKDIR /opt/src/
USER ubuntu
CMD [ "clang", "--version" ]
