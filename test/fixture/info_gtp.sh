#!/bin/sh
set -x
../../../gtfs-proto/.venv/bin/gtfs_proto info ${1:+-b $1} feed.gtp
