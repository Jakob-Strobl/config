#!/bin/bash

if [[ "$OSTYPE" == "linux"* ]]; then
  echo "linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "macos"
elif [[ "$OSTYPE" == "msys"* ]]; then
  echo "windows"
else
  echo "unknown os $OSTYPE"
fi
