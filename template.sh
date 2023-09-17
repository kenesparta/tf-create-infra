#!/bin/bash

# Este archivo esta hecho para ejecutarse linea por linea y facilitar el proceso de escritura de comandos.

# vars
source .env

# Build
docker build \
  -t "${DOCKER_IMAGE_LOCAL}":"${VERSION}" \
  -f DockerfileFrontend .


# Crear registry en GCP
gcloud auth activate-service-account --key-file=sa.json

gcloud auth configure-docker us-central1-docker.pkg.dev

docker tag "${DOCKER_IMAGE_LOCAL}":"${VERSION}" us-central1-docker.pkg.dev/dockerayacucho/fibo-wasm-"${ID}"/fibonacci-wasm-front:"${VERSION}"

docker push us-central1-docker.pkg.dev/dockerayacucho/fibo-wasm-"${ID}"/fibonacci-wasm-front:"${VERSION}"


# Deploy to cloud run
gcloud run deploy fibonacci-wasm-front-"${ID}" \
  --image us-central1-docker.pkg.dev/dockerayacucho/fibo-wasm-"${ID}"/fibonacci-wasm-front:"${VERSION}" \
  --region us-central1 \
  --project dockerayacucho \
  --allow-unauthenticated \
  --platform managed

gcloud run services add-iam-policy-binding fibonacci-wasm-front-"${ID}" \
  --region=us-central1 \
  --member=allUsers \
  --role=roles/run.invoker \
  --project dockerayacucho


# destroy
gcloud run services delete fibonacci-wasm-front-"${ID}" \
  --region=us-central1 \
  --project dockerayacucho
