#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

usage="Usage: $0 [-u -o <output_path>] <project-name>"
user="terraform"
output_path="secrets/credentials.json"
overwrite=0

function command_exists {
    type "$1" &> /dev/null ;
}

if ! $(command_exists terraform)
then
    echo "You need to install terraform"
    exit 1
fi

if ! $(command_exists gcloud)
then
    echo "You need to install gcloud"
    exit 1
fi

if ! $(command_exists jq)
then
    echo "You need to install jq"
    exit 1
fi

while getopts "hfu:o:" flag; do
  case ${flag} in
    h)
      echo ${usage}
      ;;
    f)
      overwrite=1
      ;;
    u)
      user=$OPTARG
      ;;
    o)
      output_path=$OPTARG
      ;;
  esac
done

project=${@:$OPTIND:1}

if [[ -f ${output_path} && (${overwrite} -eq "0") ]]; then
    echo "Output file [${output_path}] already exists"
    echo "Either use -f to force overwrite, or pick a different path"
    exit 1
fi

email=$(gcloud --format=json iam service-accounts create ${user} --display-name "Terraform" | jq -r ".email")

gcloud projects add-iam-policy-binding "${project}" \
        --member "serviceAccount:${email}" --role "roles/editor"

gcloud iam service-accounts keys create ${output_path} \
    --iam-account=${email}

