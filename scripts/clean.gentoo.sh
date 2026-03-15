#!/bin/bash -x

set -e

log_dir="$HOME/logs"
log_timestamp="$(date +%F.%T)"
log_path="$log_dir/clean.$log_timestamp.log"

echo "Log: $log_path"
mkdir -p $log_dir

emerge --verbose --ask --depclean |& tee -a $log_path
emerge --verbose --ask @preserved-rebuild |& tee -a $log_path
eclean --verbose --interactive --deep distfiles |& tee -a $log_path
eclean --verbose --interactive --deep packages |& tee -a $log_path
