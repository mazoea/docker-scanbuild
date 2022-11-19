FROM ubuntu:18.04

ENV CLANGVER=10 \
    CHECKERS="-disable-checker deadcode.DeadStores -enable-checker alpha.core.CastSize -enable-checker alpha.core.CastToStruct -enable-checker alpha.core.IdenticalExpr -enable-checker alpha.core.SizeofPtr -enable-checker alpha.security.ArrayBoundV2 -enable-checker alpha.security.MallocOverflow -enable-checker alpha.security.ReturnPtrRange -enable-checker alpha.unix.SimpleStream -enable-checker alpha.unix.cstring.BufferOverlap -enable-checker alpha.unix.cstring.NotNullTerminated -enable-checker alpha.unix.cstring.OutOfBounds -enable-checker alpha.core.FixedAddr -enable-checker unix -enable-checker security.insecureAPI.strcpy"

RUN apt-get update && \
    apt-get install -y clang-$CLANGVER clang-tools-$CLANGVER cmake libc++-dev libfindbin-libs-perl links \
                        libleptonica-dev libfreetype6-dev \
                        zlib1g-dev libjpeg-dev libtiff-dev libpng-dev libgif-dev libwebp-dev libjbig-dev liblzma-dev liblz-dev && \
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
    (ln -s /usr/bin/scan-build-$CLANGVER /usr/bin/scan-build || true)

ENV EXTCMD=scan-build\ -v\ --use-analyzer=/usr/bin/clang-$CLANGVER

WORKDIR /opt/src/
CMD [ "clang", "--version" ]
