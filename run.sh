#!/bin/bash
trap "exit 0" SIGINT SIGTERM


DEBUG=${DEBUG:-false}
TERMINATION_ENDPOINT="http://169.254.169.254/latest/meta-data/spot/termination-time"


echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: Starting on node ${MY_NODE_NAME}"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: polling AWS meta-data every 5 seconds"

while true; do
  status_code=$(curl -s -o /dev/null -w "%{http_code}" "${TERMINATION_ENDPOINT}")
  if [[ ${status_code} == "200" ]]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: Initiating node drain. Received termination signal from AWS"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: Draining ${MY_NODE_NAME}"
    /app/kubectl drain "${MY_NODE_NAME}" --force --delete-local-data --grace-period=110 --ignore-daemonsets
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: Done"
    break
  else
    [[ ${DEBUG} == true ]] && echo "[$(date '+%Y-%m-%d %H:%M:%S')] DEBUG: Skipping node, no signal received. ${status_code}"
    sleep 5
  fi
done
