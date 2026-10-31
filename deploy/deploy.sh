#!/usr/bin/env bash

set -euo pipefail

REGION="${AWS_REGION:-us-east-1}"
BUCKET="${S3_BACKUP_BUCKET:-rce-portal-backups}"
VERSION=$(node -p "require('./package.json').version")
COMMIT=$(git rev-parse --short HEAD)

echo "Deploying version ${VERSION} (commit ${COMMIT}) to ${BUCKET}"

npm ci --production
npm run build

echo "Uploading artifacts to s3://${BUCKET}/prod/"
aws s3 cp dist/ "s3://${BUCKET}/prod/" --recursive --region "${REGION}"

echo "Syncing to web-prod instances via SSM"
aws ssm send-command \
    --region "${REGION}" \
    --document-name AWS-RunShellScript \
    --targets "Key=tag:Role,Values=web-prod" \
    --parameters 'commands=["sudo rsync -av /opt/deploy/dist/ /var/www/html/"]'

echo "Deploy finished"
