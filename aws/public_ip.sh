#!/bin/bash
source ../.env

CLUSTER_NAME="cluster_${ID}"

TASK_ARN=$(aws ecs list-tasks --cluster "${CLUSTER_NAME}" \
               --profile "${AWS_PROFILE}" --query 'taskArns[0]' --output text)
echo "TASK: ${TASK_ARN}"

ENI_ID=$(aws ecs describe-tasks --cluster "${CLUSTER_NAME}" \
             --tasks "${TASK_ARN}" \
             --profile "${AWS_PROFILE}" \
             --query 'tasks[0].attachments[0].details[1].value' --output text)
echo "ENI: ${ENI_ID}"

PUBLIC_IP=$(aws ec2 describe-network-interfaces --network-interface-ids "${ENI_ID}" --profile "${AWS_PROFILE}" \
                --query 'NetworkInterfaces[0].Association.PublicIp' --output text)
echo "Servicio: http://${PUBLIC_IP}:${CONTAINER_PORT}"
