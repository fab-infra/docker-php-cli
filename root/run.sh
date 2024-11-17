#!/bin/sh

# Generate configuration
confd -onetime -backend env

# Run PHP
exec /usr/bin/php "$@"
