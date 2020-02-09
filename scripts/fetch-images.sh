#!/usr/bin/env bash
#  Copyright (c) 2018-2020. Prasad Tengse
#

set -eo pipefail
readonly SCRIPT=$(basename "$0")
readonly YELLOW=$'\e[1;33m'
readonly GREEN=$'\e[1;32m'
readonly BLUE=$'\e[1;34m'
readonly RED=$'\e[1;31m'
readonly NC=$'\e[0m'
readonly CHECKSUMS_FILE="SHA512SUMS"

function display_usage()
{
#Prints out help menu
cat <<EOF
Bash script to checksum and sign

Usage: ${YELLOW}${SCRIPT}   [options]${NC}
[-q --quick-mode]      [Handy shortcut to pre populate
                        Image, checksum and GPG URLs. supports,
                          - "ubuntu-bionic",
                          - "debian-buster",
                          - "centos8"
[-u --url]             [URL to fetch cloudimage]
[-c --checksum-url]    [SHA512 checksum URL]
[-k --key-url]         [GPG Key URL(This key will not be imported!)]
[-s --sig-url]         [Signature file URL]
[-f --file]            [File to save]
[-d --distro]          [Distro Name]
[-G --skip-gpg-verify] [Skip verifying GPG signature]
[-h --help]            [Display this help message]
EOF
}


function print_info()
{
  printf "‣ %s \n" "$@"
}

function print_success()
{
  printf "%s✔ %s %s\n" "${GREEN}" "$@" "${NC}"
}

function print_warning()
{
  printf "%s⚠ %s %s\n" "${YELLOW}" "$@" "${NC}"
}

function print_error()
{
   printf "%s✖ %s %s\n" "${RED}" "$@" "${NC}"
}

function verify_checksums()
{
  print_info "Verifying CHECKSUMS"
  if [[ -f ${CHECKSUMS_FILE} ]]; then
    if sha512sum -c "${CHECKSUMS_FILE}" --strict --status --ignore-missing; then
      print_success "Hooray! checksums verified"
      return 0
    else
      print_warning "Failed! Some files failed checksum verification!"
      return 1
    fi
  else
    print_error "File ${CHECKSUMS_FILE} not found!"
    exit 1
  fi
}

function verify_gpg_signature()
{
  # Verifies the file with its detached GPG signature.
  # Assumes that you already have public key in your keyring.
  # Assumes signature file is present at same localtion,
  # with same name but with .sig(n) or .gpg or .asc extension.
  # Lets declare variables
  local checksum_sig_file
  # Checks if file is present
  if [ -f "${CHECKSUMS_FILE}.asc" ]; then
    checksum_sig_file="${CHECKSUMS_FILE}.asc"
  elif [ -f "${CHECKSUMS_FILE}.gpg" ]; then
    checksum_sig_file="${CHECKSUMS_FILE}.gpg"
  elif [ -f "${CHECKSUMS_FILE}.sig" ]; then
    checksum_sig_file="${CHECKSUMS_FILE}.sig"
  elif [ -f "${CHECKSUMS_FILE}.sign" ]; then
    checksum_sig_file="${CHECKSUMS_FILE}.sign"
  else
    print_error "Error! signature file not found!"
    exit 1;
  fi

  # Check for signature files
  print_info "Verifying digital signature of checksums"
  print_info "Signature File : ${checksum_sig_file}"
  print_info "Data File      : ${CHECKSUMS_FILE}"
  # Checks for commands
  if command -v gpg > /dev/null; then
    if gpg --verify "${checksum_sig_file}" "${CHECKSUMS_FILE}" 2>/dev/null; then
      print_success "Hooray! digintal signature verified"
    else
      print_error "Oh No! Signature checks failed!"
      exit 50;
    fi
  else
    print_error "Cannot perform verification. gpg is not installed."
    print_error "This action requires gnugpg/gnupg2 package."
    exit 1;
  fi
}

function main()
{
  # No args just run the setup function
  if [[ $# -eq 0 ]]; then
    print_error "No Action specified!"
    display_usage;
    exit 1
  fi

  while [[ ${1} != "" ]]; do
    case ${1} in
      -h | --help )           display_usage;exit 0;;
      -c | --checksum)        bool_gen_checksum="true";;
      -s | --sign)            bool_sign_checksum="true";;
      -v | --verify)          bool_verify_checksum="true";;
      -G | --skip-gpg-verify) bool_skip_gpg_verify="true";;
      * )                     echo -e "\e[91mInvalid argument(s). See usage below. \e[39m";display_usage;;
    esac
    shift
  done

  # Actions

  if [[ $bool_gen_checksum == "true" ]]; then
    print_info "Generating Checksums..."
    generate_checksums

    if [[ $bool_sign_checksum == "true" ]]; then
      sign_checksum
    else
      print_warning "Not Signing checksums file!"
    fi
  fi

  if [[ $bool_verify_checksum == "true" ]]; then
    verify_checksums
    if [[ $bool_skip_gpg_verify == "true" ]]; then
      print_warning "Skipping signature verification of checksums"
    else
      verify_gpg_signature
    fi
  fi

}

main "$@"

echo -e "‣ Downloading Ubuntu 18.04 SHA512SUM \033[0m"
mkdir -p $(CLOUD_IMAGE_DOWNLOAD_PATH)/Ubuntu-1804
curl -sSfL http://cdimage.debian.org/cdimage/openstack/current-10/SHA512SUMS \
		-o $(CLOUD_IMAGE_DOWNLOAD_PATH)/Ubuntu-1804/SHA512SUMS
echo -e "‣ Downloading Debian 10 QCOW2 Image \033[0m"
# curl -sSfL http://cdimage.debian.org/cdimage/openstack/current-10/debian-10-openstack-amd64.qcow2 \
		-o $(CLOUD_IMAGE_DOWNLOAD_PATH)/Ubuntu-1804/debian-10-openstack-amd64.qcow2
echo -e "‣ Verifying Checksum\033[0m"
(cd $(CLOUD_IMAGE_DOWNLOAD_PATH)/Ubuntu-1804 && sha512sum -c --ignore-missing SHA512SUMS)
