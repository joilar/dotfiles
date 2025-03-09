#!/bin/bash

set -e

log_dir="$HOME/logs"
log_timestamp="$(date +%F.%T)"
log_path="$log_dir/update.$log_timestamp.log"

bin_atoms="sys-devel/gcc net-libs/nodejs"

echo "Log: $log_path"
mkdir -p $log_dir

emerge --verbose --sync |& tee -a $log_path
emerge --verbose --update --ask --getbinpkgonly --nodeps $bin_atoms |& tee -a $log_path
emerge --verbose --update --ask --deep --newuse --exclude "$bin_atoms" @world |& tee -a $log_path
