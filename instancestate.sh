#!/bin/bash
# Unified EC2 instance management script
# Usage:
#   ./ec2-manage.sh start <instance-id>
#   ./ec2-manage.sh stop <instance-id>

ACTION=$1
INSTANCE_ID=$2

if [ -z "$ACTION" ] || [ -z "$INSTANCE_ID" ]; then
  echo "Usage: $0 <start|stop> <instance-id>"
  exit 1
fi

# Validate action
if [[ "$ACTION" != "start" && "$ACTION" != "stop" ]]; then
  echo "Invalid action: $ACTION"
  echo "Usage: $0 <start|stop> <instance-id>"
  exit 1
fi

# Get current instance state
STATE=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --query "Reservations[].Instances[].State.Name" \
  --output text 2>/dev/null)

if [ -z "$STATE" ]; then
  echo "❌ Instance not found: $INSTANCE_ID"
  exit 1
fi

echo "🔍 Current state of $INSTANCE_ID: $STATE"

if [ "$ACTION" == "stop" ]; then
  if [ "$STATE" == "stopped" ]; then
    echo "ℹ️ Instance is already stopped."
    exit 0
  fi

  echo "🛑 Stopping instance $INSTANCE_ID..."
  aws ec2 stop-instances --instance-ids "$INSTANCE_ID" > /dev/null
  echo "⏳ Waiting for instance to stop..."
  aws ec2 wait instance-stopped --instance-ids "$INSTANCE_ID"
  echo "✅ Instance $INSTANCE_ID has been stopped successfully."

elif [ "$ACTION" == "start" ]; then
  if [ "$STATE" == "running" ]; then
    echo "ℹ️ Instance is already running."
    exit 0
  fi

  echo "🚀 Starting instance $INSTANCE_ID..."
  aws ec2 start-instances --instance-ids "$INSTANCE_ID" > /dev/null
  echo "⏳ Waiting for instance to start..."
  aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"
  echo "✅ Instance $INSTANCE_ID has been started successfully."

  PUBLIC_IP=$(aws ec2 describe-instances \
    --instance-ids "$INSTANCE_ID" \
    --query "Reservations[].Instances[].PublicIpAddress" \
    --output text)

  echo "🌐 Public IP: $PUBLIC_IP"
fi
 