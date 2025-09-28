#!/bin/bash
UPTIME_PRETTY=$(uptime -p)
UPTIME_FORMATTED=$(echo "$UPTIME_PRETTY" | sed -E 's/^up *//; s/([0-9]+) days?/\1d/; s/([0-9]+) hours?/\1h/; s/([0-9]+) minutes?/\1m/; s/,//g; s/ 0[d,h,m]//g; s/ +/ /g; s/^ *//; s/ *$//')

echo " $UPTIME_FORMATTED"
