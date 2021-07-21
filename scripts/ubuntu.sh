#!/usr/bin/env bash
#  Copyright (c) 2018-2020. Prasad Tengse
#

set -eo pipefail

CLOUD_IMAGE_DOWNLOAD_PATH="${HOME}/Virtual/installers"

echo -e "\033[38;5;122m‣ Ubuntu 20.04 Focal Fossa\033[0m"

echo -e "- Ensure directories "
mkdir -p "${CLOUD_IMAGE_DOWNLOAD_PATH}"
(
  cd "${CLOUD_IMAGE_DOWNLOAD_PATH}"
  echo -e "- Download checksums"
  curl -sSfLO https://cloud-images.ubuntu.com/minimal/releases/hirsute/release/SHA256SUMS
  echo -e "- Download image "
  curl -fLO --progress-bar https://cloud-images.ubuntu.com/minimal/releases/hirsute/release/ubuntu-21.04-minimal-cloudimg-amd64.img
  echo -e "- Verify integrity"
  sha256sum -c --ignore-missing --strict SHA256SUMS
)
