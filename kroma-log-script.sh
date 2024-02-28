#!/bin/bash

# Define the directory where you want to store your log files
LOG_DIR="/home/ubuntu/kroma-logs"
mkdir -p "$LOG_DIR" || true

# Define a fixed log file name
LOG_FILE="${LOG_DIR}/kroma-validator-logs.log"

echo "Collecting logs into $LOG_FILE..."

# Find all running containers starting with "kroma-validator-"
CONTAINERS=$(docker ps --filter "name=kroma-validator-" --format "{{.Names}}")

# Loop through each found container and append the logs to the log file
for CONTAINER in $CONTAINERS; do
  # Write the timestamp and container name as a header for each log section
  echo "========================================" >> "$LOG_FILE"
  echo "$CONTAINER : $(date +%Y%m%d%H%M%S)" >> "$LOG_FILE"
  echo "========================================" >> "$LOG_FILE"
  # Append the docker logs output
  docker logs --tail 30 "$CONTAINER" >> "$LOG_FILE"
  echo "" >> "$LOG_FILE"  # Ensure a blank line for readability between container logs
done

echo "Log collection complete."