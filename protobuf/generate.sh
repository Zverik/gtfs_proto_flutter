#!/bin/sh
REPO="$(cd "$(dirname "$0")/..";pwd)"
protoc --dart_out="$REPO/lib/src/proto" -I="$REPO/protobuf" "$REPO/protobuf"/*.proto
