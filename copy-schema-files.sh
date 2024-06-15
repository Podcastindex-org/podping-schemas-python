#!/bin/bash

submodule_path="podping-schemas"
package_path="podping_schemas"

mkdir -p "${package_path}"

rsync -ra "${submodule_path}/schema/" "${package_path}/"

# Make capnpy imports use to this module
find "${package_path}" -name '*.capnp' -type f -exec sed -i -E 's/\/schema\//\/podping_schemas\//g' {} \;

readarray -d '' module_directories < <(find "${package_path}" -type d -not \( -path "*/__pycache__" \) -print0)

for module in "${module_directories[@]}"
do
    echo "Found ${module}"
    echo "Touching ${module}/__init__.py"
    touch "${module}/__init__.py"
done


# Attempt at dynamically added generated python files to pyproject.toml
# Poetry doesn't seem to care
#readarray -d '' module_capnp_files < <(find "${package_path}" -type f -iname '*.capnp' -print0)

#for file_path in "${module_capnp_files[@]}"
#do
#    python_file_path="${file_path//capnp/py}"
#    sed -i "/include = \[/a \    { path = \"$python_file_path\", format = \"wheel\" }," pyproject.toml
#done