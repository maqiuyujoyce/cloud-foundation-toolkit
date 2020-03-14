#!/bin/bash

echo "============Testing IAM KCC+kpt solutions...============"

ROOT_DIR=../../../solutions/iam/kpt

echo "======Cleaning up the old resources...======"
for DIR in $ROOT_DIR/*; do
	if [[ -d "$DIR" && ! -L "$DIR" ]]; then
	 	kubectl delete -f $DIR
	fi
done

for DIR in $ROOT_DIR/*; do
	if [[ -d "$DIR" && ! -L "$DIR" ]]; then
		echo "======Testing ${DIR##*/} solution...======"
		./"${DIR##*/}"/test.sh --source-directory $DIR
	fi
done




