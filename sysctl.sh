#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/env.sh

if [[ ! -e $SYSCTLCONFIG ]] || [[ ! -r $SYSCTLCONFIG ]] || [[ ! -w $SYSCTLCONFIG ]]; then
    echo "$SYSCTLCONFIG is not exist or not accessible (are you root?)"
    exit 1
fi

sed -i -e "/net.ipv4.ip_forward/d" $SYSCTLCONFIG
echo "net.ipv4.ip_forward=1" >> $SYSCTLCONFIG

sysctl -p

cat /etc/sysctl.d/*.conf /etc/sysctl.conf | sysctl -e -p -
