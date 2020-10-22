#!/usr/bin/env bash
#  Copyright (c) 2018-2020. Prasad Tengse
#

set -eo pipefail

CLOUD_IMAGE_DOWNLOAD_PATH="${HOME}/Virtual/installers/cloudimages"

echo -e "\033[38;5;122m‣ CentOS 8.x \033[0m"

echo -e "- Ensure directories"
mkdir -p "${CLOUD_IMAGE_DOWNLOAD_PATH}/centos-8"

(
  cd "${CLOUD_IMAGE_DOWNLOAD_PATH}/centos-8"
  echo -e "- Download checksums"
  curl -sSfLO https://cloud.centos.org/centos/8/x86_64/images/CHECKSUM
  echo -e "- Download image"
  curl -fLO --progress-bar https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.2.2004-20200611.2.x86_64.qcow2
  echo -e "- Verify integrity"
  sha256sum -c --ignore-missing --strict SHA256SUMS
)
