Content-Type: multipart/mixed; boundary="===============2629775419217757098=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Unable to get network interface working
Date: Thu, 25 Sep 2014 16:25:12 +0200
Message-ID: <CAH4ZQwuQegM1GDOKRW=awg6WK1X64R3SjcEi9GZ0en3-Oq1VCA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2629775419217757098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear all,
I'm using oFono 1.15 on Ubuntu 14.4 with telit UE910 modem.
OFono is able to detect the modem but for some reason The network interface
never gets an IP resulting in an immediate detach from the network.
Here is the syslog:

ofonod[2841]:
drivers/atmodem/gprs-context.c[247]:at_gprs_activate_primary() cid 1
ofonod[2841]: drivers/atmodem/gprs-context.c[200]:at_cgdcont_cb() ok 1
ofonod[2841]: drivers/atmodem/gprs-context.c[176]:at_cgdata_cb() ok 1
ofonod[2841]: drivers/atmodem/gprs-context.c[141]:setup_ppp()
ofonod[2841]: drivers/atmodem/gprs-context.c[86]:ppp_connect()
ofonod[2841]: IP: 37.182.26.98
ofonod[2841]: DNS: 83.224.70.54, 83.224.70.77
ofonod[2841]: src/gprs.c[889]:pri_activate_callback() 0x8609670
NetworkManager[937]: <info> (/he910_0): IPv4 static configuration:
NetworkManager[937]: <info> (/he910_0): device state change: prepare ->
failed (reason 'ip-config-unavailable') [40 120 5]
NetworkManager[937]: <warn> Activation (/he910_0) failed for connection
'/222016503456238/context1'
NetworkManager[937]:    SCPlugin-Ifupdown: devices added (path:
/sys/devices/virtual/net/ppp0, iface: ppp0)
NetworkManager[937]:    SCPlugin-Ifupdown: device added (path:
/sys/devices/virtual/net/ppp0, iface: ppp0): no ifupdown configuration
found.
NetworkManager[937]: <warn> /sys/devices/virtual/net/ppp0: couldn't
determine device driver; ignoring...
NetworkManager[937]: <info> (/he910_0): device state change: failed ->
disconnected (reason 'none') [120 30 0]
NetworkManager[937]: <info> (/he910_0): deactivating device (reason 'none')
[0]
ofonod[2841]: src/gprs.c[1286]:pri_set_property() deactivate_primary
ofonod[2841]:
drivers/atmodem/gprs-context.c[339]:at_gprs_deactivate_primary() cid 1
NetworkManager[937]:    SCPlugin-Ifupdown: devices removed (path:
/sys/devices/virtual/net/ppp0, iface: ppp0)
ofonod[2841]: plugins/udevng.c[976]:remove_device()
/sys/devices/virtual/net/ppp0
ofonod[2841]: drivers/atmodem/gprs-context.c[109]:ppp_disconnect() Reason: 6

Does anyone know what I'm missing?
Thank you!

Enrico

--===============2629775419217757098==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+RGVhciBhbGwsPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SSYjMzk7bSB1
c2luZyBvRm9ubyAxLjE1IG9uIFVidW50dSAxNC40IHdpdGggdGVsaXQgVUU5MTAgbW9kZW0uPC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEs
c2Fucy1zZXJpZiI+T0Zvbm8gaXMgYWJsZSB0byBkZXRlY3QgdGhlIG1vZGVtIGJ1dCBmb3Igc29t
ZSByZWFzb24gVGhlIG5ldHdvcmsgaW50ZXJmYWNlIG5ldmVyIGdldHMgYW4gSVAgcmVzdWx0aW5n
IGluIGFuIGltbWVkaWF0ZSBkZXRhY2ggZnJvbSB0aGUgbmV0d29yay48L2Rpdj48ZGl2IGNsYXNz
PSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5I
ZXJlIGlzIHRoZSBzeXNsb2c6PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9
ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9Imdt
YWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPjxkaXYg
Y2xhc3M9ImdtYWlsX2RlZmF1bHQiPm9mb25vZFsyODQxXTogZHJpdmVycy9hdG1vZGVtL2dwcnMt
Y29udGV4dC5jWzI0N106YXRfZ3Byc19hY3RpdmF0ZV9wcmltYXJ5KCkgY2lkIDE8L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5vZm9ub2RbMjg0MV06IGRyaXZlcnMvYXRtb2RlbS9ncHJz
LWNvbnRleHQuY1syMDBdOmF0X2NnZGNvbnRfY2IoKSBvayAxPC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZGVmYXVsdCI+b2Zvbm9kWzI4NDFdOiBkcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmNb
MTc2XTphdF9jZ2RhdGFfY2IoKSBvayAxPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+
b2Zvbm9kWzI4NDFdOiBkcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmNbMTQxXTpzZXR1cF9w
cHAoKcKgPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+b2Zvbm9kWzI4NDFdOiBkcml2
ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmNbODZdOnBwcF9jb25uZWN0KCnCoDwvZGl2PjxkaXYg
Y2xhc3M9ImdtYWlsX2RlZmF1bHQiPm9mb25vZFsyODQxXTogSVA6IDM3LjE4Mi4yNi45ODwvZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiPm9mb25vZFsyODQxXTogRE5TOiA4My4yMjQuNzAu
NTQsIDgzLjIyNC43MC43NzwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiPm9mb25vZFsy
ODQxXTogc3JjL2dwcnMuY1s4ODldOnByaV9hY3RpdmF0ZV9jYWxsYmFjaygpIDB4ODYwOTY3MDwv
ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiPk5ldHdvcmtNYW5hZ2VyWzkzN106ICZsdDtp
bmZvJmd0OyAoL2hlOTEwXzApOiBJUHY0IHN0YXRpYyBjb25maWd1cmF0aW9uOjwvZGl2PjxkaXYg
Y2xhc3M9ImdtYWlsX2RlZmF1bHQiPk5ldHdvcmtNYW5hZ2VyWzkzN106ICZsdDtpbmZvJmd0OyAo
L2hlOTEwXzApOiBkZXZpY2Ugc3RhdGUgY2hhbmdlOiBwcmVwYXJlIC0mZ3Q7IGZhaWxlZCAocmVh
c29uICYjMzk7aXAtY29uZmlnLXVuYXZhaWxhYmxlJiMzOTspIFs0MCAxMjAgNV08L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5OZXR3b3JrTWFuYWdlcls5MzddOiAmbHQ7d2FybiZndDsg
QWN0aXZhdGlvbiAoL2hlOTEwXzApIGZhaWxlZCBmb3IgY29ubmVjdGlvbiAmIzM5Oy8yMjIwMTY1
MDM0NTYyMzgvY29udGV4dDEmIzM5OzwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiPk5l
dHdvcmtNYW5hZ2VyWzkzN106IMKgIMKgU0NQbHVnaW4tSWZ1cGRvd246IGRldmljZXMgYWRkZWQg
KHBhdGg6IC9zeXMvZGV2aWNlcy92aXJ0dWFsL25ldC9wcHAwLCBpZmFjZTogcHBwMCk8L2Rpdj48
ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5OZXR3b3JrTWFuYWdlcls5MzddOiDCoCDCoFNDUGx1
Z2luLUlmdXBkb3duOiBkZXZpY2UgYWRkZWQgKHBhdGg6IC9zeXMvZGV2aWNlcy92aXJ0dWFsL25l
dC9wcHAwLCBpZmFjZTogcHBwMCk6IG5vIGlmdXBkb3duIGNvbmZpZ3VyYXRpb24gZm91bmQuPC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+TmV0d29ya01hbmFnZXJbOTM3XTogJmx0O3dh
cm4mZ3Q7IC9zeXMvZGV2aWNlcy92aXJ0dWFsL25ldC9wcHAwOiBjb3VsZG4mIzM5O3QgZGV0ZXJt
aW5lIGRldmljZSBkcml2ZXI7IGlnbm9yaW5nLi4uPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVm
YXVsdCI+TmV0d29ya01hbmFnZXJbOTM3XTogJmx0O2luZm8mZ3Q7ICgvaGU5MTBfMCk6IGRldmlj
ZSBzdGF0ZSBjaGFuZ2U6IGZhaWxlZCAtJmd0OyBkaXNjb25uZWN0ZWQgKHJlYXNvbiAmIzM5O25v
bmUmIzM5OykgWzEyMCAzMCAwXTwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiPk5ldHdv
cmtNYW5hZ2VyWzkzN106ICZsdDtpbmZvJmd0OyAoL2hlOTEwXzApOiBkZWFjdGl2YXRpbmcgZGV2
aWNlIChyZWFzb24gJiMzOTtub25lJiMzOTspIFswXTwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2Rl
ZmF1bHQiPm9mb25vZFsyODQxXTogc3JjL2dwcnMuY1sxMjg2XTpwcmlfc2V0X3Byb3BlcnR5KCkg
ZGVhY3RpdmF0ZV9wcmltYXJ5PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+b2Zvbm9k
WzI4NDFdOiBkcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmNbMzM5XTphdF9ncHJzX2RlYWN0
aXZhdGVfcHJpbWFyeSgpIGNpZCAxPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+TmV0
d29ya01hbmFnZXJbOTM3XTogwqAgwqBTQ1BsdWdpbi1JZnVwZG93bjogZGV2aWNlcyByZW1vdmVk
IChwYXRoOiAvc3lzL2RldmljZXMvdmlydHVhbC9uZXQvcHBwMCwgaWZhY2U6IHBwcDApPC9kaXY+
PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+b2Zvbm9kWzI4NDFdOiBwbHVnaW5zL3VkZXZuZy5j
Wzk3Nl06cmVtb3ZlX2RldmljZSgpIC9zeXMvZGV2aWNlcy92aXJ0dWFsL25ldC9wcHAwPC9kaXY+
PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+b2Zvbm9kWzI4NDFdOiBkcml2ZXJzL2F0bW9kZW0v
Z3Bycy1jb250ZXh0LmNbMTA5XTpwcHBfZGlzY29ubmVjdCgpIFJlYXNvbjogNjwvZGl2PjxkaXYg
Y2xhc3M9ImdtYWlsX2RlZmF1bHQiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0
Ij5Eb2VzIGFueW9uZSBrbm93IHdoYXQgSSYjMzk7bSBtaXNzaW5nPzwvZGl2PjxkaXYgY2xhc3M9
ImdtYWlsX2RlZmF1bHQiPlRoYW5rIHlvdSE8L2Rpdj48L2Rpdj48ZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+RW5yaWNvPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+CjwvZGl2Pgo=

--===============2629775419217757098==--

