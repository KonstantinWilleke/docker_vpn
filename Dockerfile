FROM ubuntu:20.04

RUN apt update && apt --yes install openconnect curl

COPY . /src/vpn

RUN chmod 777 /src/vpn
RUN chmod 777 /src/vpn/connect_vpn.sh
RUN chmod 777 /src/vpn/vpn_is_connected.sh

CMD /src/vpn/connect_vpn.sh

HEALTHCHECK --start-period=10s \
    CMD /src/vpn/vpn_is_connected.sh
