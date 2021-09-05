#!/usr/bin/env bash
set -o nounset
set -o errexit
set -o pipefail

temp="/tmp/uisptools-install"

args="$*"
version=""
branch="main"

branchRegex=" --branch ([^ ]+)"
if [[ " ${args}" =~ ${branchRegex} ]]; then
  branch="${BASH_REMATCH[1]}"
fi
echo "branch=${branch}"

repo="https://raw.githubusercontent.com/Andrewiski/UISP-Tools"
repoapi="https://api.github.com/repos/Andrewiski/UISP-Tools"

versionRegex=" --version ([^ ]+)"
if [[ " ${args}" =~ ${versionRegex} ]]; then
  version="${BASH_REMATCH[1]}"
fi


if [ -z "${version}" ]; then
  latestVersionUrl="${repoapi}/releases/latest"
  if ! version=$(curl --silent "${latestVersionUrl}" | grep -Po '"tag_name": "\K.*?(?=")'); then
    echo >&2 "Failed to obtain latest version info from ${latestVersionUrl}"
    exit 1
  fi
fi
echo version="${version}"
echo "Warning Version is Not used only downloads current commit of installUispTools.sh for branch"

rm -rf "${temp}"
if ! mkdir "${temp}"; then
  echo >&2 "Failed to create temporary directory"
  exit 1
fi

cd "${temp}"

installScriptUrl="${repo}/${branch}/dockerCompose/installUispTools.sh"

echo "Downloading installation script from ${installScriptUrl}."
if ! curl -sS "${installScriptUrl}"; then
  echo >&2 "Failed to download install script ${installScriptUrl}"
  exit 1
fi

#if ! curl -sS "${packageUrl}" | tar xzf -; then
#  echo >&2 "Failed to download installation package ${packageUrl}"
#  exit 1
#fi

chmod +x installUispTools.sh
./installUispTools ${args} --version "${version}"

cd ~
if ! rm -rf "${temp}"; then
  echo >&2 "Warning: Failed to remove temporary directory ${temp}"
fi
