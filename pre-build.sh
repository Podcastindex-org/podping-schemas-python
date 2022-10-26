#!/bin/sh

# Since we have to install epel-release under yum first, install capnproto here
# Need this if the version of manylinux used doesn't included epel-release
# Like the almalinux 8 base
#if command -v apt-get >/dev/null; then
#    apt-get update
#    apt-get install -y capnproto  || { echo "Installing custom apt package(s) failed."; exit 1; }
#elif command -v yum >/dev/null; then
#    yum install -y capnproto  || { echo "Installing custom yum package(s) failed."; exit 1; }
#else
#    echo "Package managers apt or yum not found."; exit 1;
#fi

# Remove build artifacts from previous version
# Otherwise we get multiple version .so files, creating large wheels
find ./ -type f \( -iname '*.so' -o -iname '*.pyx' -o -iname '*.c' \) -delete
