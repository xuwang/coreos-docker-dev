FROM haproxy:1.6.2
MAINTAINER Xu Wang <xuwang@gmail.com>

ENV CONFD_VERSION=v0.11.0

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && apt-get install -y procps supervisor curl iptables \
    && rm -rf /var/lib/apt/lists/*

ADD haproxy-supervisor.conf /etc/supervisor/conf.d/haproxy.conf
ADD haproxy.cfg /etc/haproxy/haproxy.cfg
ADD entrypoint.sh /usr/local/sbin/entrypoint.sh
RUN chmod 755 /usr/local/sbin/entrypoint.sh

# TODO: container needs to be able to access host etcd port.
#ADD confd-supervisor.conf /etc/supervisor/conf.d/confd.conf
#RUN cd /usr/local/sbin && curl -L https://github.com/kelseyhightower/confd/releases/download/${CONFD_VERSIN}/confd-linux-amd64 -o confd

ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]
CMD ["start"]

