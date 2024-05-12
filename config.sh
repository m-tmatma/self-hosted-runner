#!/bin/bash

if [ -z "$OWNER" ]; then
  echo "please set enviornment variable 'OWNER' in advance"
  exit 1
fi
if [ -z "$GITHUB_ACCESS_TOKEN" ]; then
  echo "please set enviornment variable 'GITHUB_ACCESS_TOKEN' in advance"
  exit 1
fi
if [ -z "$LABELS" ]; then
  echo "please set enviornment variable 'LABELS' in advance"
  exit 1
fi
if [ -z "$NAME" ]; then
  echo "please set enviornment variable 'NAME' in advance"
  exit 1
fi

if [ -n "$REPO" ]; then
  URL=https://api.github.com/repos/$OWNER/$REPO/actions/runners/registration-token
  URL_TO_RUNNER=https://github.com/$OWNER/$REPO
else
  URL=https://api.github.com/orgs/$OWNER/actions/runners/registration-token
  URL_TO_RUNNER=https://github.com/$OWNER
fi

TOKEN=$(curl -L \
  -X POST \
  -s \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_ACCESS_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  $URL | jq -r '.token')

cd actions-runner
./config.sh --unattended --name $NAME-$(hostname) --url $URL_TO_RUNNER --token $TOKEN --labels $LABELS
