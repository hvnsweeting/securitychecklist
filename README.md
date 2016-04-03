# securitychecklist

WIP

Sample output with ``www.facebook.com``

```
Is the website only served over https?
HTTP/1.1 301 Moved Permanently
HTTP/1.1 200 OK
---> Yes
=================
Is the HSTS http-header set?
Strict-Transport-Security: max-age=15552000; preload
---> Yes
=================
Is TLS1.2 the only supported protocol?
HTTP/1.1 200 OK
Cache-Control: private, no-cache, no-store, must-revalidate
Expires: Sat, 01 Jan 2000 00:00:00 GMT
Pragma: no-cache
Public-Key-Pins-Report-Only: max-age=500; pin-sha256="WoiWRyIOVNa9ihaBciRSC7XHjliYS9VwUGOIud4PB18="; pin-sha256="r/mIkG3eEpVdm+u/ko/cwxzOMo1bk4TyHIlByibiA5E="; pin-sha256="q4PO2G2cbkZhZ82+JgmRUyGMoAeozA+BSXVXQWB8XWQ="; report-uri="http://reports.fb.com/hpkp/"
P3P: CP="Facebook does not have a P3P policy. Learn why here: http://fb.me/p3p"
Strict-Transport-Security: max-age=15552000; preload
X-XSS-Protection: 0
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
Set-Cookie: reg_ext_ref=deleted; expires=Thu, 01-Jan-1970 00:00:01 GMT; Max-Age=0; path=/; domain=.facebook.com; httponly
Vary: Accept-Encoding
Content-Type: text/html
X-FB-Debug: LAvqwFfUx6DucWAFOIdgKLk+jc1OySsUmYS5W8iwinac/HanZnNgyP8mqos+l5+RwI5opeKEETvKbSuClYC82A==
Date: Sun, 03 Apr 2016 17:31:00 GMT
Connection: keep-alive

---> No
=================
Do all supported symmetric ciphers use at least 256 bit keys?
---> Yes
=================
Have you ensured that your content cannot be embedded in a frame on another website?
X-Frame-Options: DENY
---> Yes
=================
Have you ensured that the Internet Explorer content sniffer is disabled?
---> Yes
=================
Is the server certificate at least 4096 bits?
---> No
=================
```
