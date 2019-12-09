#!/bin/bash
set -xe
aws-vault exec perso -- aws s3 cp "$PWD/$1" "s3://ebusnelli-photos/Erika/$1" --acl bucket-owner-full-control --storage-class DEEP_ARCHIVE
