#!/bin/bash
set -e

echo "🏗️ Building Number Game..."

# Build variables
IMAGE_NAME="dockerakilesh/number-game"
TAG=$(git rev-parse --short HEAD 2>/dev/null || echo "local")

echo "Building ${IMAGE_NAME}:${TAG}"

# Build image
docker build -t "${IMAGE_NAME}:${TAG}" game-service/
docker tag "${IMAGE_NAME}:${TAG}" "${IMAGE_NAME}:dev"
docker tag "${IMAGE_NAME}:${TAG}" "${IMAGE_NAME}:latest"

echo "✅ Build complete!"
echo "Images: ${IMAGE_NAME}:${TAG}, ${IMAGE_NAME}:dev, ${IMAGE_NAME}:latest"