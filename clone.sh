#!/bin/bash
set -xeuo pipefail

OUTDIR="./data/cloney/"

mkdir -p $OUTDIR

cd "$OUTDIR"

 # No command line arguments.
 # Just pass stdin on.
cat|
while read -r REPO_URL REPO_SUBDIR; do
  REPO_NAME=$(basename "$REPO_URL")
  IFS="@" read REPO_NAME REPO_REF <<<"$REPO_NAME"
  REPO_NAME=${REPO_URL%".git"}
  REPO_NAME=${REPO_NAME#"https://"}

  if [[ -z "$REPO_REF" ]]; then
    REPO_REF=master
  fi

  echo "$REPO_NAME $REPO_REF"


  if [[ -d $REPO_NAME ]]; then
      cd "$REPO_NAME"
      git reset --hard HEAD
      git fetch origin
      git checkout origin/$REPO_REF
      DIRS_ARRAY=($(echo "$REPO_SUBDIR" | tr "," "\n"))
      for DIR in "${DIRS_ARRAY[@]}"; do
        git sparse-checkout add "$(echo "$DIR" | sed -e "s/^\.\///g")"
      done
      cd -
  else
    git clone \
      --depth 1 \
      --filter=tree:0 \
      --sparse \
      "$REPO_URL" "$REPO_NAME"

      cd "$REPO_NAME"
      git checkout origin/$REPO_REF
      DIRS_ARRAY=($(echo "$REPO_SUBDIR" | tr "," "\n"))
      for DIR in "${DIRS_ARRAY[@]}"; do
        git sparse-checkout add "$(echo "$DIR" | sed -e "s/^\.\///g")"
      done
      cd -
  fi
done

exit 0