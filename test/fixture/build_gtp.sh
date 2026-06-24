#!/bin/sh
GTFS_PROTO=../../../../gtfs-proto/.venv/bin/gtfs_proto

cd v1
zip feed.zip *.txt
$GTFS_PROTO pack feed.zip -o ../feed.gtp
rm feed.zip

cd ../v2
zip feed.zip *.txt
$GTFS_PROTO pack feed.zip -o feed.gtp
$GTFS_PROTO delta ../feed.gtp feed.gtp -o ../delta.gtp
rm feed.zip feed.gtp
