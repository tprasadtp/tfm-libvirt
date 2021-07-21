#!/usr/bin/env bash
#  Copyright (c) 2018-2020. Prasad Tengse
#

set -eo pipefail

CLOUD_IMAGE_DOWNLOAD_PATH="${HOME}/Virtual/installers/cloudimages"

echo -e "\033[38;5;122m‣ Debian 10.x Buster\033[0m"

echo -e "- Ensure directories"
mkdir -p "${CLOUD_IMAGE_DOWNLOAD_PATH}/debian-10"

(
  cd "${CLOUD_IMAGE_DOWNLOAD_PATH}/debian-10"
  echo -e "- Download checksums"
  curl -sSfLO https://cloud.debian.org/images/cloud/OpenStack/current-10/SHA256SUMS
  echo -e "- Download image"
  curl -fLO --progress-bar https://cloud.debian.org/images/cloud/OpenStack/current-10/debian-10-openstack-amd64.qcow2
  echo -e "- Verify integrity"
  sha256sum -c --ignore-missing --strict SHA256SUMS
)
