#!/bin/bash

# Start Flask app with PM2
pm2 start email_smtp_api.py --name "flask-app" --interpreter python

# Start ngrok with PM2
pm2 start --name "ngrok" -- ngrok http --url=firefly-winning-dragon.ngrok-free.app 7000

# Save PM2 configuration
pm2 save

echo "Services started with PM2. Use 'pm2 status' to check running processes"
echo "Use 'pm2 logs' to view logs"


# to stop use -pm2 stop flask-app ngrok 