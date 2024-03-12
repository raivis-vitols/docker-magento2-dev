vcl 4.0;

backend default {
    .host = "nginx_http";
    .port = "8080";
}

sub vcl_recv {
    return (pass);
}
