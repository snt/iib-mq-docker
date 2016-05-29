#!/bin/sh

. ~/.bashrc
. /opt/mqm/bin/setmqenv -s

strmqm iib1
/iib/iib mqsistart iib1

