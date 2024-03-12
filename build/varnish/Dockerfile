FROM varnish:7.3

COPY ./default.vcl /etc/varnish/default.vcl
ENTRYPOINT varnishd -F -f /etc/varnish/default.vcl -a :8081 -p feature=+http2 -s malloc,512m
