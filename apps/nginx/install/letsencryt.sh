#!/bin/bash

debian_letsencryt_install() {

    # Since Certbot is packaged for your system, all you'll need to do is apt-get the following packages.
    # First you'll have to follow the instructions here to enable the Jessie backports repo, if you have not already done so. Then run:
    apt-get install certbot -t jessie-backports

    # Certbot supports a number of different “plugins” that can be used to obtain and/or install certificates.
    # certbot certonly

    # 
    certbot certonly --webroot -w /var/www/example -d example.com -d www.example.com -w /var/www/thing -d thing.is -d m.thing.is

    # 
    # certbot certonly --standalone -d example.com -d www.example.com

    # Automating renewal
    certbot renew --dry-run
}

centos_letsencryt_install() {
    
}