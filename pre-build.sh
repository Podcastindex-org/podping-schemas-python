#!/bin/sh

#version="$1"

# Since we have to install epel-release under yum first, install capnproto here
if command -v apt-get >/dev/null; then
    apt-get update
    apt-get install -y capnproto  || { echo "Installing custom apt package(s) failed."; exit 1; }
elif command -v yum >/dev/null; then
    yum install -y capnproto  || { echo "Installing custom yum package(s) failed."; exit 1; }
else
    echo "Package managers apt or yum not found."; exit 1;
fi

# Remove build artifacts from previous version
# Otherwise we get multiple version .so files, creating large wheels
find ./ -type f \( -iname '*.so' -o -iname '*.pyx' -o -iname '*.c' \) -delete

#sed -i -e 's/"capnpy"]/"https:\/\/github.com\/agates\/capnpy\/releases\/download\/0.9.1dev0\/capnpy-0.9.1.dev0-'"$version"'.whl"]/g' pyproject.toml