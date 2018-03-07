#!/usr/bin/env bash

set -e

terraform -version

for dir in $(dirname $(find . -path ./.terraform -prune -o -type f -name "*.tf"|sort)|uniq); do
    echo "Running terraform get in \${dir}..."
    terraform get \${dir}
    echo "Running terraform validate in \${dir}..."
    terraform validate -check-variables=false \$dir
    echo "Running terraform fmt check in \${dir}..."
    terraform fmt -check=true -list=true -diff=true -write=false \$dir
done

echo "Running tflint..."
tflint -v
tflint
