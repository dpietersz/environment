#!/bin/bash

# Enable debug mode
set -x

# Check if the application path was provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/Application.app"
  exit 1
fi

# Get the application path from the argument
APP_PATH="$1"
echo "Provided application path: $APP_PATH"

# Attempt to resolve the symbolic link using stat
REAL_APP_PATH=$(stat -f "%Y" "$APP_PATH" 2>/dev/null)
echo "Resolved real application path: $REAL_APP_PATH"

# If stat doesn't resolve a path, assume the original path
if [ -z "$REAL_APP_PATH" ]; then
  REAL_APP_PATH="$APP_PATH"
  echo "Using original path as real path: $REAL_APP_PATH"
fi

# Check if the resolved application path exists
if [ ! -d "$REAL_APP_PATH" ]; then
  echo "Application not found at $REAL_APP_PATH"
  exit 1
else
  echo "Application found at $REAL_APP_PATH"
fi

# Use the mdls command to get the bundle identifier
BUNDLE_ID=$(mdls -name kMDItemCFBundleIdentifier "$REAL_APP_PATH" | awk -F '"' '{print $2}')
echo "Bundle identifier found: $BUNDLE_ID"

# Check if the bundle identifier was found
if [ -z "$BUNDLE_ID" ]; then
  echo "Bundle identifier not found."
  exit 1
fi

# Output the bundle identifier
echo "The bundle identifier for the application is: $BUNDLE_ID"

# Disable debug mode
set +x

