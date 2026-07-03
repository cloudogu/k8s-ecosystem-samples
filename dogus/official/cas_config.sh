#!/bin/bash
envDefault="remote"
env="${1:-$envDefault}"
./create_dogu_config.sh "ecosystem" "cas" $env