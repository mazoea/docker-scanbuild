FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y clang clang-tools cmake libc++-dev libfindbin-libs-perl links \
                        libleptonica-dev libfreetype6-dev \
                        zlib1g-dev libjpeg-dev libtiff-dev libpng-dev libgif-dev libwebp-dev libjbig-dev liblzma-dev liblz-dev && \
    rm -rf /var/lib/apt/lists/*

ENV CLANGVER=6.0 \
    CHECKERS="-disable-checker deadcode.DeadStores -enable-checker alpha.core.CastSize -enable-checker alpha.core.CastToStruct -enable-checker alpha.core.IdenticalExpr -enable-checker alpha.core.SizeofPtr -enable-checker alpha.security.ArrayBoundV2 -enable-checker alpha.security.MallocOverflow -enable-checker alpha.security.ReturnPtrRange -enable-checker alpha.unix.SimpleStream -enable-checker alpha.unix.cstring.BufferOverlap -enable-checker alpha.unix.cstring.NotNullTerminated -enable-checker alpha.unix.cstring.OutOfBounds -enable-checker alpha.core.FixedAddr -enable-checker unix -enable-checker security.insecureAPI.strcpy"

ENV CC=/usr/bin/clang-$CLANGVER \
    CXX=/usr/bin/clang++-$CLANGVER \
    CCC_CC=/usr/bin/clang-$CLANGVER \
    CCC_CXX=/usr/bin/clang++-$CLANGVER \
    CMAKE_CXX_COMPILER=/usr/share/clang/scan-build-6.0/libexec/c++-analyzer \
    CMAKE_C_COMPILER=/usr/share/clang/scan-build-6.0/libexec/ccc-analyzer

ENV EXTCMD=scan-build\ -v\ --use-analyzer=/usr/bin/clang-$CLANGVER

WORKDIR /opt/src/
CMD [ "clang", "--version" ]
