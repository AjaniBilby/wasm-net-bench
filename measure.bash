#!/bin/bash

# Check if the user provided a command as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <server_start_command>"
  exit 1
fi

# Start the server in the background
$1 &
SERVER_PID=$!

sleep 1

if ps -p $SERVER_PID > /dev/null; then
  echo "Server started with PID $SERVER_PID and PGID $SERVER_PGID"
else
  echo "Server failed to start."
  exit 1
fi

# Run the wrk benchmarking tool
wrk -t1 -c100 -d10s http://127.0.0.1:8080
wrk -t2 -c100 -d10s http://127.0.0.1:8080
wrk -t2 -c200 -d10s http://127.0.0.1:8080
wrk -t2 -c300 -d10s http://127.0.0.1:8080
wrk -t2 -c400 -d10s http://127.0.0.1:8080
wrk -t2 -c500 -d10s http://127.0.0.1:8080
wrk -t2 -c600 -d10s http://127.0.0.1:8080

# Stop the server
if ps -p $SERVER_PID > /dev/null; then
  echo "Stopping the server and its process group..."
  kill -SIGKILL $SERVER_PID
  while kill -0 $SERVER_PID 2>/dev/null; do
    sleep 1
  done
  echo "Server stopped."
else
  echo "Server is no longer running."
fi