#!/bin/bash

# Check if the user provided a command as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <server_start_command>"
  exit 1
fi

# Start the server in the background
$1 &
SERVER_PID=$!
SERVER_PGID=$(ps -o pgid= $SERVER_PID | grep -o '[0-9]*')

sleep 1

if ps -p $SERVER_PID > /dev/null; then
  echo "Server started with PID $SERVER_PID and PGID $SERVER_PGID"
else
  echo "Server failed to start."
  exit 1
fi

# Run the wrk benchmarking tool
wrk -t10 -c400 -d10s http://127.0.0.1:8080

# Stop the server
if ps -p $SERVER_PID > /dev/null; then
  echo "Stopping the server and its process group..."
  kill -TERM -- -$SERVER_PGID
  echo "Server stopped."
else
  echo "Server is no longer running."
fi