#!/bin/sh
zip feed.zip *.txt
../../../gtfs-proto/.venv/bin/gtfs_proto pack feed.zip -o feed.gtp
rm feed.zip
