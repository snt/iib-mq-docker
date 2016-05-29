#!/bin/sh

. /opt/mqm/bin/setmqenv -s

echo ". /opt/mqm/bin/setmqenv -s" >> ~/.bashrc

cat <<EOF > /etc/security/limits.d/mqm.conf
mqm		soft	nofiles		10240
mqm		hard	nofiles		10240
EOF

crtmqm iib1
strmqm iib1
cat <<EOF | runmqsc iib1
def listener(lst1) trptype(tcp) port(1414) control(qmgr)
start listener(lst1)
alter qmgr chlauth(disabled)
def chl(svrconn1) chltype(svrconn) trptype(tcp)
EOF

$(dirname $0)/iib/iib make registry global accept license silently
$(dirname $0)/iib/iib mqsicreatebroker iib1 -q iib1
#$(dirname $0)/iib/iib mqsistart iib1
endmqm -w iib1


