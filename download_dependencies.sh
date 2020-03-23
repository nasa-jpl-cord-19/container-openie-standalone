#!/usr/bin/env bash

set -xe

echo "I see you opted for FML, starting download..."

curl -L -O https://github.com/dair-iitd/OpenIE-standalone/releases/download/v5.0/BONIE.jar
curl -L -O https://github.com/dair-iitd/OpenIE-standalone/releases/download/v5.0/ListExtractor.jar
curl -L -O https://prod-general-infra-builddependencies-1u4kmaayfoppb.s3.amazonaws.com/OpenIE-standalone/data/languageModel.bz2

echo "Initiating FML phase 2, verifying downloads..."

sha256sum -c dependencies.sha256

bunzip2 languageModel.bz2