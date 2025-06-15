#!/bin/bash
# tools/tor/rotate_tor.sh

(echo 'AUTHENTICATE ""'; echo 'signal NEWNYM'; echo 'QUIT') | nc 127.0.0.1 9051 > /dev/null
