FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y python-pip iputils-ping iproute2 dnsutils curl telnet
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
