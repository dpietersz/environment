#!/bin/bash

echo "Updating Gentoo System"

# Syncing the portage tree
echo "Syncing portage tree..."
sudo emerge --sync

# Update packages
echo "Updating All packages..."
sudo emerge --update --deep --with-bdeps=y @world

# Clean up
echo "Cleaning up unnecessary packages..."
sudo emerge --depclean

# Rebuild packages that have been installed in slots that have one or more packages updated
echo "Rebuilding necessary packages..."
sudo emerge @preserved-rebuild

# Final message
echo "Gentoo update completed!"
