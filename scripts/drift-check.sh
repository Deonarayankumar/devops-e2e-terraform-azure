#!/usr/bin/env bash
set -euo pipefail

ENV_DIR="${1:?usage: drift-check.sh <environment-dir>}"
REPORT="${REPORT:-drift-report.txt}"

cd "${ENV_DIR}"
terraform init -input=false >/dev/null
terraform plan -detailed-exitcode -input=false -no-color > "${REPORT}" 2>&1 || EXIT=$?
EXIT=${EXIT:-0}

case "${EXIT}" in
  0) echo "No drift detected in ${ENV_DIR}" ;;
  2) echo "DRIFT detected — see ${REPORT}"; exit 2 ;;
  *) echo "terraform plan failed"; cat "${REPORT}"; exit 1 ;;
esac
