#!/bin/bash

# Scripts automate checking security checks for target domain

domain=$1
HTTPS=https://$domain
HTTP=http://$domain

function say_yes {
    printf -- '---> Yes\n'
    printf '=================\n'
}
function say_no {
    printf -- '---> No\n'
    printf '=================\n'
}

printf 'Is the website only served over https?\n'
if ( curl -s -I $HTTP | grep '^HTTP' | grep 30 ); then
    if ( curl -s -I $HTTPS | grep '^HTTP' | grep 200 ); then
        say_yes
    else
        say_no
    fi
else
    say_no
fi

printf 'Is the HSTS http-header set?\n'
if ( curl -s -I $HTTPS | grep '^Strict' ); then
    say_yes
else
    say_no
fi

printf 'Is TLS1.2 the only supported protocol?\n'
if ! ( curl --sslv3 $HTTPS || curl --tlsv1.0 -I $HTTPS || curl --tlsv1.1 -I $HTTPS ); then
    if ( curl --tlsv1.2 -s -I $HTTPS | grep HTTP | greo 20); then
        say_yes
    else
        say_no
    fi
else
    say_no
fi

printf 'Do all supported symmetric ciphers use at least 256 bit keys?\n'
if [ "$(nmap --script ssl-enum-ciphers -p 443 $domain | grep AES | grep -cv strong)" -eq 0 ]; then
    say_yes
else
    say_no
fi

printf 'Have you ensured that your content cannot be embedded in a frame on another website?\n'
if ( curl -s -I $HTTPS | grep '^X-Frame-Options' | grep -E 'SAMEORIGIN|DENY' ); then
    say_yes
else
    say_no
fi
# TODO: not work on OSX Is the Diffie-Hellman prime at least 4096 bits?

printf 'Have you ensured that the Internet Explorer content sniffer is disabled?\n'
if ( curl -s -I $HTTPS | grep '^X-Content' | grep nosniff -q ); then
    say_yes
else
    say_no
fi

# TODO so slow
printf 'Is the server certificate at least 4096 bits?\n'
bits="$(openssl s_client -showcerts -connect $domain:443 2>&1 | grep '^Server public key' | grep -Eo '\d+')"
if [ ! -z $bits ]; then
    if [ $bits -ge 4096 ]; then
        say_yes
    else
        say_no
    fi
else
    say_no
fi


# all the rest https://securitychecklist.org/
