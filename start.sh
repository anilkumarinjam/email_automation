#!/bin/bash

# Start the Python Flask server in the background
python email_smtp_api.py &

# Store the Flask server PID
FLASK_PID=$!

# Start ngrok for port 6000 in the background
ngrok http --url=firefly-winning-dragon.ngrok-free.app 6000 &

# Store the ngrok PID
NGROK_PID=$!

echo "Services started. Press Ctrl+C to stop both services."

# Wait for Ctrl+C
trap "kill $FLASK_PID $NGROK_PID; exit" INT

# Keep script running
wait