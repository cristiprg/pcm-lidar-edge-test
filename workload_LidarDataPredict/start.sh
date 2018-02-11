#!/bin/bash

DATA_DIR="./dataDirectory"
mkdir -p $DATA_DIR

# Start python server
python ./service-time.py
