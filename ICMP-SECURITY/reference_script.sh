#!/bin/bash

echo "========================================"
echo " ICMP Security Reference Script"
echo "========================================"

check_setting() {
    key="$1"
    expected="$2"

    path="/proc/sys/$(echo "$key" | tr '.' '/')"

    if [ -f "$path" ]; then
        actual=$(cat "$path")

        if [ "$actual" = "$expected" ]; then
            echo "[ PASS ] $key = $actual"
        else
            echo "[ WARNING ] $key = $actual (expected $expected)"
        fi
    else
        echo "[ INFO ] $key is unavailable"
    fi
}

check_setting "net.ipv4.icmp_echo_ignore_broadcasts" "1"
check_setting "net.ipv4.icmp_ignore_bogus_error_responses" "1"
check_setting "net.ipv4.conf.all.accept_redirects" "0"
check_setting "net.ipv4.conf.default.accept_redirects" "0"
check_setting "net.ipv4.conf.all.send_redirects" "0"
check_setting "net.ipv4.conf.default.send_redirects" "0"
check_setting "net.ipv4.conf.all.rp_filter" "1"
check_setting "net.ipv4.conf.default.rp_filter" "1"

echo "========================================"
echo " ICMP reference check completed"
echo "========================================"
