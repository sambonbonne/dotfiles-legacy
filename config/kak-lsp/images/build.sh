#!/usr/bin/env sh
set -e

LSP_IMAGE_NAMESPACE="lsp"

build_image() {
  IMAGE_NAME="${LSP_IMAGE_NAMESPACE}/${1}"
  CONTAINER_FILE="${2}"

  podman build \
    -f "${CONTAINER_FILE}" \
    -t "${IMAGE_NAME}" \
    .
}

build_image "typescript" "$(pwd)/typescript.Containerfile"
