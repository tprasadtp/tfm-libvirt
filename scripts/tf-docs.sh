#!/usr/bin/env bash
#  Copyright (c) $CURRENT_YEAR. Prasad Tengse
#
#
set -eo pipefail
readonly SCRIPT=$(basename "$0")
readonly YELLOW=$'\e[33m'
readonly GREEN=$'\e[32m'
readonly RED=$'\e[31m'
readonly NC=$'\e[0m'


function display_usage()
{
#Prints out help menu
cat <<EOT
Bash script to Generate Terraform Docs

Usage: ${YELLOW}${SCRIPT} ${GREEN} module-path ${NC}
[-h --help]            [Display this help message]
EOT
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

function check_help()
{
  #Check if -h or --help is present if so display help and exit
  while [[ ${1} != "" ]]; do
    case ${1} in
      -h | --help )           display_usage;exit 0;;
    esac
    shift
  done
}

function main()
{
  # No args just run
  if [[ $# -eq 0 ]]; then
    print_error "No Arguments specified!"
    display_usage;
    exit 1
  fi

  check_help "$@"

  if [[ -z $REPO_ROOT ]]; then
    print_warning "REPO_ROOT is undefined! falling back to $(pwd)"
    export REPO_ROOT="$(pwd)"
  fi

  ERRORS=()

  for module in "$@"; do
    print_info "Terraform Module - $module"
    if [[ -e "${REPO_ROOT}/modules/$module/providers.tf" ]] \
        && [[ -e "${REPO_ROOT}/modules/$module/README.md"  ]] \
        && [[ -e "${REPO_ROOT}/modules/$module/.terraform-docs.yml"  ]]; then
      if docker run  \
        --network=none \
        --workdir /tfm/src \
        -v "${REPO_ROOT}/modules/$module:/tfm/src:rw" \
        quay.io/terraform-docs/terraform-docs:latest \
        . ; then
        print_success "Generated"
      else
        print_error "Failed to generate table"
        ERRORS+=("${module}")
        continue
      fi

    else
      ERRORS+=("${module}")
      print_error "Module not found!"
    fi
  done

  if [ ${#ERRORS[@]} -eq 0 ]; then
    print_success "Generated documentation for all modules!!"
  else
    print_error "Failed to generate documentaion for these modules: ${ERRORS[*]}"
    exit 1
  fi

}

main "$@"
