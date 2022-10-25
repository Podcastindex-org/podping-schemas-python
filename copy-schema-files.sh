#!/bin/bash

submodule_path="podping-schemas"
package_path="src/podping_schemas"

readarray -d '' paths_to_copy < <(find "${submodule_path}/schema/" -mindepth 1 -maxdepth 1 -print0)

for path in "${paths_to_copy[@]}"
do
    cp -r "${path}" "${package_path}"
done

readarray -d '' module_directories < <(find "${package_path}" -type d -not \( -path "*/__pycache__" \) -print0)

for module in "${module_directories[@]}"
do
    echo "Touching ${module}/__init__.py"
    touch "${module}/__init__.py"
done

