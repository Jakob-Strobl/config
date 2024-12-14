#!/bin/bash

if [[ "$OSTYPE" == "linux"* ]]; then
  echo "linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "macos"
else
  echo "unknown os"
fi
