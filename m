Content-Type: multipart/mixed; boundary="===============3393030582803453017=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Re: Unable to get network interface working
Date: Thu, 25 Sep 2014 16:58:31 +0200
Message-ID: <CAH4ZQwuJGbSsHY2d_XxCQODGroH=Uq-bPOxT0inuz4LwfuMwAA@mail.gmail.com>
In-Reply-To: <54242569.5020509@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3393030582803453017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
thanx for the quick answer.
This is the log including AT commands:

ofonod[14630]: Modem: < AT+CGDATA=3D"PPP",1\r
ofonod[14630]: Modem: < \r\nCONNECT\r\n
ofonod[14630]: drivers/atmodem/gprs-context.c[176]:at_cgdata_cb() ok 1
ofonod[14630]: drivers/atmodem/gprs-context.c[141]:setup_ppp()
ofonod[14630]: Aux: < \r\n
ofonod[14630]: Aux: < +CRSM: 106,130\r\n\r\nOK\r\n
ofonod[14630]: Aux: > AT+CRSM=3D192,28613\r
ofonod[14630]: Aux: < \r\n
ofonod[14630]: Aux: < +CRSM: 106,130\r\n\r\nOK\r\n
ofonod[14630]: src/simfs.c[446]:sim_fs_op_read_block() bufoff: 0, seekoff:
39, toread: 17
ofonod[14630]: Aux: > AT+CRSM=3D192,28437\r
ofonod[14630]: Aux: < \r\n
ofonod[14630]: Aux: < +CRSM: 106,130\r\n\r\nOK\r\n
ofonod[14630]: Aux: < \r\n
ofonod[14630]: Aux: < +CIEV: rssi,1\r\n
ofonod[14630]: src/network.c[1536]:ofono_netreg_strength_notify() strength
20
ofonod[14630]: drivers/atmodem/gprs-context.c[86]:ppp_connect()
ofonod[14630]: IP: 109.113.70.48
ofonod[14630]: DNS: 83.224.70.77, 83.224.70.54
ofonod[14630]: src/gprs.c[889]:pri_activate_callback() 0x859e348
NetworkManager[876]: <info> (/he910_0): IPv4 static configuration:
NetworkManager[876]: <info> (/he910_0): device state change: prepare ->
failed (reason 'ip-config-unavailable') [40 120 5]
NetworkManager[876]: <info> NetworkManager state is now DISCONNECTED
NetworkManager[876]: <warn> Activation (/he910_0) failed for connection
'/222016503456238/context1'
NetworkManager[876]:    SCPlugin-Ifupdown: devices added (path:
/sys/devices/virtual/net/ppp0, iface: ppp0)
NetworkManager[876]:    SCPlugin-Ifupdown: device added (path:
/sys/devices/virtual/net/ppp0, iface: ppp0): no ifupdown configuration
found.
NetworkManager[876]: <warn> /sys/devices/virtual/net/ppp0: couldn't
determine device driver; ignoring...
NetworkManager[876]: <info> (/he910_0): device state change: failed ->
disconnected (reason 'none') [120 30 0]
NetworkManager[876]: <info> (/he910_0): deactivating device (reason 'none')
[0]
ofonod[14630]:
drivers/atmodem/gprs-context.c[328]:at_gprs_deactivate_primary() cid 1
NetworkManager[876]:    SCPlugin-Ifupdown: devices removed (path:
/sys/devices/virtual/net/ppp0, iface: ppp0)
ofonod[14630]: plugins/udevng.c[976]:remove_device()
/sys/devices/virtual/net/ppp0
ofonod[14630]: Aux: < \r\n
ofonod[14630]: drivers/atmodem/gprs-context.c[109]:ppp_disconnect() Reason:
6
ofonod[14630]: Aux: < +CIEV: rssi,2\r\n
ofonod[14630]: src/network.c[1536]:ofono_netreg_strength_notify() strength
40
NetworkManager[876]: <info> (/he910_0): IPv4 static configuration:
NetworkManager[876]: modem_prepare_result: assertion 'state =3D=3D
NM_DEVICE_STATE_PREPARE' failed
ofonod[14630]: plugins/udevng.c[1292]:check_modem_list()
ofonod[14630]: Aux: < \r\n+CGEV: ME DEACT IP, "109.113.70.48",
1\r\n\r\n+CGREG: 0\r\n\r\n+CGEV: NW DETACH\r\n
ofonod[14630]: src/gprs.c[2223]:ofono_gprs_status_notify() /he910_0 status 0
ofonod[14630]: src/gprs.c[2209]:ofono_gprs_detached_notify() /he910_0
NetworkManager[876]: <info> WWAN now disabled by management service

Hope you see someting.

Regards,
Enrico

--===============3393030582803453017==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SGkgRGVuaXMswqA8L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj50aGFueCBm
b3IgdGhlIHF1aWNrIGFuc3dlci48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHls
ZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5UaGlzIGlzIHRoZSBsb2cgaW5jbHVk
aW5nIEFUIGNvbW1hbmRzOjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJm
b250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj48ZGl2IGNs
YXNzPSJnbWFpbF9kZWZhdWx0Ij5vZm9ub2RbMTQ2MzBdOiBNb2RlbTogJmx0OyBBVCtDR0RBVEE9
JnF1b3Q7UFBQJnF1b3Q7LDFccjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiPm9mb25v
ZFsxNDYzMF06IE1vZGVtOiAmbHQ7IFxyXG5DT05ORUNUXHJcbjwvZGl2PjxkaXYgY2xhc3M9Imdt
YWlsX2RlZmF1bHQiPm9mb25vZFsxNDYzMF06IGRyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQu
Y1sxNzZdOmF0X2NnZGF0YV9jYigpIG9rIDE8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0
Ij5vZm9ub2RbMTQ2MzBdOiBkcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmNbMTQxXTpzZXR1
cF9wcHAoKcKgPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+b2Zvbm9kWzE0NjMwXTog
QXV4OiAmbHQ7IFxyXG48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5vZm9ub2RbMTQ2
MzBdOiBBdXg6ICZsdDsgK0NSU006IDEwNiwxMzBcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXYgY2xh
c3M9ImdtYWlsX2RlZmF1bHQiPm9mb25vZFsxNDYzMF06IEF1eDogJmd0OyBBVCtDUlNNPTE5Miwy
ODYxM1xyPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+b2Zvbm9kWzE0NjMwXTogQXV4
OiAmbHQ7IFxyXG48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5vZm9ub2RbMTQ2MzBd
OiBBdXg6ICZsdDsgK0NSU006IDEwNiwxMzBcclxuXHJcbk9LXHJcbjwvZGl2PjxkaXYgY2xhc3M9
ImdtYWlsX2RlZmF1bHQiPm9mb25vZFsxNDYzMF06IHNyYy9zaW1mcy5jWzQ0Nl06c2ltX2ZzX29w
X3JlYWRfYmxvY2soKSBidWZvZmY6IDAsIHNlZWtvZmY6IDM5LCB0b3JlYWQ6IDE3PC9kaXY+PGRp
diBjbGFzcz0iZ21haWxfZGVmYXVsdCI+b2Zvbm9kWzE0NjMwXTogQXV4OiAmZ3Q7IEFUK0NSU009
MTkyLDI4NDM3XHI8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5vZm9ub2RbMTQ2MzBd
OiBBdXg6ICZsdDsgXHJcbjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiPm9mb25vZFsx
NDYzMF06IEF1eDogJmx0OyArQ1JTTTogMTA2LDEzMFxyXG5cclxuT0tcclxuPC9kaXY+PGRpdiBj
bGFzcz0iZ21haWxfZGVmYXVsdCI+b2Zvbm9kWzE0NjMwXTogQXV4OiAmbHQ7IFxyXG48L2Rpdj48
ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5vZm9ub2RbMTQ2MzBdOiBBdXg6ICZsdDsgK0NJRVY6
IHJzc2ksMVxyXG48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5vZm9ub2RbMTQ2MzBd
OiBzcmMvbmV0d29yay5jWzE1MzZdOm9mb25vX25ldHJlZ19zdHJlbmd0aF9ub3RpZnkoKSBzdHJl
bmd0aCAyMDwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiPm9mb25vZFsxNDYzMF06IGRy
aXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuY1s4Nl06cHBwX2Nvbm5lY3QoKcKgPC9kaXY+PGRp
diBjbGFzcz0iZ21haWxfZGVmYXVsdCI+b2Zvbm9kWzE0NjMwXTogSVA6IDEwOS4xMTMuNzAuNDg8
L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5vZm9ub2RbMTQ2MzBdOiBETlM6IDgzLjIy
NC43MC43NywgODMuMjI0LjcwLjU0PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+b2Zv
bm9kWzE0NjMwXTogc3JjL2dwcnMuY1s4ODldOnByaV9hY3RpdmF0ZV9jYWxsYmFjaygpIDB4ODU5
ZTM0ODwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiPk5ldHdvcmtNYW5hZ2VyWzg3Nl06
ICZsdDtpbmZvJmd0OyAoL2hlOTEwXzApOiBJUHY0IHN0YXRpYyBjb25maWd1cmF0aW9uOjwvZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiPk5ldHdvcmtNYW5hZ2VyWzg3Nl06ICZsdDtpbmZv
Jmd0OyAoL2hlOTEwXzApOiBkZXZpY2Ugc3RhdGUgY2hhbmdlOiBwcmVwYXJlIC0mZ3Q7IGZhaWxl
ZCAocmVhc29uICYjMzk7aXAtY29uZmlnLXVuYXZhaWxhYmxlJiMzOTspIFs0MCAxMjAgNV08L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5OZXR3b3JrTWFuYWdlcls4NzZdOiAmbHQ7aW5m
byZndDsgTmV0d29ya01hbmFnZXIgc3RhdGUgaXMgbm93IERJU0NPTk5FQ1RFRDwvZGl2PjxkaXYg
Y2xhc3M9ImdtYWlsX2RlZmF1bHQiPk5ldHdvcmtNYW5hZ2VyWzg3Nl06ICZsdDt3YXJuJmd0OyBB
Y3RpdmF0aW9uICgvaGU5MTBfMCkgZmFpbGVkIGZvciBjb25uZWN0aW9uICYjMzk7LzIyMjAxNjUw
MzQ1NjIzOC9jb250ZXh0MSYjMzk7PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+TmV0
d29ya01hbmFnZXJbODc2XTogwqAgwqBTQ1BsdWdpbi1JZnVwZG93bjogZGV2aWNlcyBhZGRlZCAo
cGF0aDogL3N5cy9kZXZpY2VzL3ZpcnR1YWwvbmV0L3BwcDAsIGlmYWNlOiBwcHAwKTwvZGl2Pjxk
aXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiPk5ldHdvcmtNYW5hZ2VyWzg3Nl06IMKgIMKgU0NQbHVn
aW4tSWZ1cGRvd246IGRldmljZSBhZGRlZCAocGF0aDogL3N5cy9kZXZpY2VzL3ZpcnR1YWwvbmV0
L3BwcDAsIGlmYWNlOiBwcHAwKTogbm8gaWZ1cGRvd24gY29uZmlndXJhdGlvbiBmb3VuZC48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5OZXR3b3JrTWFuYWdlcls4NzZdOiAmbHQ7d2Fy
biZndDsgL3N5cy9kZXZpY2VzL3ZpcnR1YWwvbmV0L3BwcDA6IGNvdWxkbiYjMzk7dCBkZXRlcm1p
bmUgZGV2aWNlIGRyaXZlcjsgaWdub3JpbmcuLi48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZh
dWx0Ij5OZXR3b3JrTWFuYWdlcls4NzZdOiAmbHQ7aW5mbyZndDsgKC9oZTkxMF8wKTogZGV2aWNl
IHN0YXRlIGNoYW5nZTogZmFpbGVkIC0mZ3Q7IGRpc2Nvbm5lY3RlZCAocmVhc29uICYjMzk7bm9u
ZSYjMzk7KSBbMTIwIDMwIDBdPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+TmV0d29y
a01hbmFnZXJbODc2XTogJmx0O2luZm8mZ3Q7ICgvaGU5MTBfMCk6IGRlYWN0aXZhdGluZyBkZXZp
Y2UgKHJlYXNvbiAmIzM5O25vbmUmIzM5OykgWzBdPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVm
YXVsdCI+b2Zvbm9kWzE0NjMwXTogZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jWzMyOF06
YXRfZ3Byc19kZWFjdGl2YXRlX3ByaW1hcnkoKSBjaWQgMTwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiPk5ldHdvcmtNYW5hZ2VyWzg3Nl06IMKgIMKgU0NQbHVnaW4tSWZ1cGRvd246IGRl
dmljZXMgcmVtb3ZlZCAocGF0aDogL3N5cy9kZXZpY2VzL3ZpcnR1YWwvbmV0L3BwcDAsIGlmYWNl
OiBwcHAwKTwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiPm9mb25vZFsxNDYzMF06IHBs
dWdpbnMvdWRldm5nLmNbOTc2XTpyZW1vdmVfZGV2aWNlKCkgL3N5cy9kZXZpY2VzL3ZpcnR1YWwv
bmV0L3BwcDA8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5vZm9ub2RbMTQ2MzBdOiBB
dXg6ICZsdDsgXHJcbjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiPm9mb25vZFsxNDYz
MF06IGRyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuY1sxMDldOnBwcF9kaXNjb25uZWN0KCkg
UmVhc29uOiA2PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+b2Zvbm9kWzE0NjMwXTog
QXV4OiAmbHQ7ICtDSUVWOiByc3NpLDJcclxuPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVs
dCI+b2Zvbm9kWzE0NjMwXTogc3JjL25ldHdvcmsuY1sxNTM2XTpvZm9ub19uZXRyZWdfc3RyZW5n
dGhfbm90aWZ5KCkgc3RyZW5ndGggNDA8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5O
ZXR3b3JrTWFuYWdlcls4NzZdOiAmbHQ7aW5mbyZndDsgKC9oZTkxMF8wKTogSVB2NCBzdGF0aWMg
Y29uZmlndXJhdGlvbjo8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5OZXR3b3JrTWFu
YWdlcls4NzZdOiBtb2RlbV9wcmVwYXJlX3Jlc3VsdDogYXNzZXJ0aW9uICYjMzk7c3RhdGUgPT0g
Tk1fREVWSUNFX1NUQVRFX1BSRVBBUkUmIzM5OyBmYWlsZWQ8L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9kZWZhdWx0Ij5vZm9ub2RbMTQ2MzBdOiBwbHVnaW5zL3VkZXZuZy5jWzEyOTJdOmNoZWNrX21v
ZGVtX2xpc3QoKcKgPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+b2Zvbm9kWzE0NjMw
XTogQXV4OiAmbHQ7IFxyXG4rQ0dFVjogTUUgREVBQ1QgSVAsICZxdW90OzEwOS4xMTMuNzAuNDgm
cXVvdDssIDFcclxuXHJcbitDR1JFRzogMFxyXG5cclxuK0NHRVY6IE5XIERFVEFDSFxyXG48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5vZm9ub2RbMTQ2MzBdOiBzcmMvZ3Bycy5jWzIy
MjNdOm9mb25vX2dwcnNfc3RhdHVzX25vdGlmeSgpIC9oZTkxMF8wIHN0YXR1cyAwPC9kaXY+PGRp
diBjbGFzcz0iZ21haWxfZGVmYXVsdCI+b2Zvbm9kWzE0NjMwXTogc3JjL2dwcnMuY1syMjA5XTpv
Zm9ub19ncHJzX2RldGFjaGVkX25vdGlmeSgpIC9oZTkxMF8wPC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZGVmYXVsdCI+TmV0d29ya01hbmFnZXJbODc2XTogJmx0O2luZm8mZ3Q7IFdXQU4gbm93IGRp
c2FibGVkIGJ5IG1hbmFnZW1lbnQgc2VydmljZTwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1
bHQiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5Ib3BlIHlvdSBzZWUgc29t
ZXRpbmcuPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+PGJyPjwvZGl2PjxkaXYgY2xh
c3M9ImdtYWlsX2RlZmF1bHQiPlJlZ2FyZHMsPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVs
dCI+RW5yaWNvPC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============3393030582803453017==--

