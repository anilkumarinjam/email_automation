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




































# #!/bin/bash

# # Start Flask app with PM2
# pm2 start email_smtp_api.py --name "email-auto" --interpreter python

# # Start ngrok with PM2
# pm2 start "ngrok http --url=firefly-winning-dragon.ngrok-free.app 7000" --name ngrok-email-auto

# # Save PM2 configuration
# pm2 save

# echo "Services started with PM2. Use 'pm2 status' to check running processes"
# echo "Use 'pm2 logs' to view logs"


# # to stop use -pm2 stop flask-app ngrok 
