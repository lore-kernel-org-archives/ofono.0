Content-Type: multipart/mixed; boundary="===============3326386798818386030=="
MIME-Version: 1.0
From: WuYongbo <wilbur.unail@gmail.com>
Subject: How can I get the log of ofonod on N900 with meego trunk image?
Date: Wed, 22 Dec 2010 00:35:06 +0800
Message-ID: <AANLkTimXAghFYnhmTB10T0boMXghPCH0CVbCcN0+WiRa@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3326386798818386030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sorry for the wrong tile in my previous mail.


How can I get the log of ofonod on N900 with meego trunk image?
I tried modifying the /etc/rc.sysinit as following:

*if [ -x "/usr/sbin/bluetoothd" ] ; then*
*             /usr/sbin/ofonod -nd  >> /var/log/ofonod.log 2>&1*
*fi*

it does not work, even /var/log/ofonod.log is not created.

--===============3326386798818386030==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHNwYW4gY2xhc3M9IkFwcGxlLXN0eWxlLXNwYW4iIHN0eWxlPSJmb250LWZhbWlseTogYXJpYWws
IHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogOS4wMjc3OHB4OyBib3JkZXItY29sbGFwc2U6IGNvbGxh
cHNlOyBjb2xvcjogcmdiKDUxLCA1MSwgNTEpOyAiPjxkaXY+U29ycnkgZm9yIHRoZSB3cm9uZyB0
aWxlIGluIG15IHByZXZpb3VzIG1haWwuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+Cjwv
ZGl2PjxkaXY+SG93IGNhbiBJIGdldCB0aGUgbG9nIG9mIG9mb25vZCBvbiBOOTAwIHdpdGggbWVl
Z28gdHJ1bmsgaW1hZ2U/PC9kaXY+PGRpdj5JIHRyaWVkIG1vZGlmeWluZyB0aGUgL2V0Yy9yYy5z
eXNpbml0IGFzIGZvbGxvd2luZzo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxpPjxmb250IGNv
bG9yPSIjRkYwMDAwIj5pZiBbIC14ICZxdW90Oy91c3Ivc2Jpbi9ibHVldG9vdGhkJnF1b3Q7IF0g
OyB0aGVuPC9mb250PjwvaT48L2Rpdj4KPGRpdj48aT48Zm9udCBjb2xvcj0iI0ZGMDAwMCI+oKAg
oCCgIKAgoCCgIC91c3Ivc2Jpbi9vZm9ub2QgLW5kIKAmZ3Q7Jmd0OyAvdmFyL2xvZy9vZm9ub2Qu
bG9nIDImZ3Q7JmFtcDsxPC9mb250PjwvaT48L2Rpdj48ZGl2PjxpPjxmb250IGNvbG9yPSIjRkYw
MDAwIj5maTwvZm9udD48L2k+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5pdCBkb2VzIG5vdCB3
b3JrLCBldmVuIC92YXIvbG9nL29mb25vZC5sb2cgaXMgbm90IGNyZWF0ZWQuPC9kaXY+Cjwvc3Bh
bj4K

--===============3326386798818386030==--

