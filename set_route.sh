#!/bin/bash

# Delete existing default routes
ip route del default || true

# Add new default route
ip route add default via 192.168.0.1 || true

# # Execute the container's main command
# exec "$@"
