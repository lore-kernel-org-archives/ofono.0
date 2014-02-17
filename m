Content-Type: multipart/mixed; boundary="===============8477371137592253486=="
MIME-Version: 1.0
From: Freedreamer <freedreamer@email.it>
Subject: PPP ofono and Connman
Date: Mon, 17 Feb 2014 20:02:42 +0100
Message-ID: <CAAs3wMijG-h7X2FA=w6XrJ_WpnzK+i=x0mLckQ8usyOmQ_fe+w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8477371137592253486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

on my embedded system I got 3 interfaces : wifi , ethernet and gprs and I
decided to handle 'em with connman.
When I start a ppp connection with ofono everything seems to work properly
, I got the DNS and with the test script I can process ppp parameter.
ifconfig command shows the ppp0 set and when I ping
ping -I ppp0 8.8.8.8 it works well.

However when I try 2 ping any site I always got error

ping -I ppp0 www.google.it

It seems a DNS problem but i can't fix it. How should I tell to ofono to
use the ppp0 as default interface? I think the ppp  has some issues to
coexist with others interfaces , is that possibile?


I appreciate any help.

Regards

Marco

--===============8477371137592253486==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgYWxsLDxkaXY+PGJyPjwvZGl2PjxkaXY+b24gbXkgZW1iZWRkZWQg
c3lzdGVtIEkgZ290IDMgaW50ZXJmYWNlcyA6IHdpZmkgLCBldGhlcm5ldCBhbmQgZ3BycyBhbmQg
SSBkZWNpZGVkIHRvIGhhbmRsZSAmIzM5O2VtIHdpdGggY29ubm1hbi48L2Rpdj48ZGl2PldoZW4g
SSBzdGFydCBhIHBwcCBjb25uZWN0aW9uIHdpdGggb2Zvbm8gZXZlcnl0aGluZyBzZWVtcyB0byB3
b3JrIHByb3Blcmx5ICwgSSBnb3QgdGhlIEROUyBhbmQgd2l0aCB0aGUgdGVzdCBzY3JpcHQgSSBj
YW4gcHJvY2VzcyBwcHAgcGFyYW1ldGVyLjwvZGl2Pgo8ZGl2PmlmY29uZmlnIGNvbW1hbmQgc2hv
d3MgdGhlIHBwcDAgc2V0IGFuZCB3aGVuIEkgcGluZzxicj48L2Rpdj48ZGl2PnBpbmcgLUkgcHBw
MCA4LjguOC44IGl0IHdvcmtzIHdlbGwuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Ib3dldmVy
IHdoZW4gSSB0cnkgMiBwaW5nIGFueSBzaXRlIEkgYWx3YXlzIGdvdCBlcnJvcjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+cGluZyAtSSBwcHAwIDxhIGhyZWY9Imh0dHA6Ly93d3cuZ29vZ2xlLml0
Ij53d3cuZ29vZ2xlLml0PC9hPqA8L2Rpdj4KPGRpdj48YnI+PC9kaXY+PGRpdj5JdCBzZWVtcyBh
IEROUyBwcm9ibGVtIGJ1dCBpIGNhbiYjMzk7dCBmaXggaXQuIEhvdyBzaG91bGQgSSB0ZWxsIHRv
IG9mb25vIHRvIHVzZSB0aGUgcHBwMCBhcyBkZWZhdWx0IGludGVyZmFjZT8gSSB0aGluayB0aGUg
cHBwIKBoYXMgc29tZSBpc3N1ZXMgdG8gY29leGlzdCB3aXRoIG90aGVycyBpbnRlcmZhY2VzICwg
aXMgdGhhdCBwb3NzaWJpbGU/oDwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PkkgYXBwcmVjaWF0ZSBhbnkgaGVscC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlJlZ2Fy
ZHM8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk1hcmNvoDwvZGl2PjwvZGl2Pgo=

--===============8477371137592253486==--

