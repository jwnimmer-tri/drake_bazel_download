#!/bin/bash
# SPDX-License-Identifier: MIT-0
#
# Executes the install_prereqs script contained within @drake_artifacts.
#
# Run this program as:
#  bazel run //:install_prereqs

set -euo pipefail

# Fail-fast when not run via Bazel.
if [[ -z "${BUILD_WORKSPACE_DIRECTORY+x}" ]]; then
  echo 'ERROR: You must run this program as:'
  echo '  bazel run //:install_prereqs'
  exit 1
fi

# Run the script using a viable path. If we are running on Ubuntu, then we also
# need root access.
cd $(dirname $(readlink -f external/drake_artifacts/share/drake/setup/install_prereqs))
if [[ $(uname) == "Darwin" ]]; then
  ./install_prereqs -y
elif [[ "${EUID}" -eq 0 ]]; then
  ./install_prereqs -y
else
  sudo ./install_prereqs -y
fi
