Content-Type: multipart/mixed; boundary="===============6684930751519919808=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Duplicated contexts...
Date: Wed, 07 Aug 2019 21:44:24 +0000
Message-ID: <CAHB-PjmsKndU1317ZGxPDsR7asT-R3EY5rvOAD_Ou=VgYNVQ2A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6684930751519919808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Just want to hear your thoughts of how to fix an issue I saw.

The modem was told to activate with COPS=3D0, that took time.
And a context was activated ME PDN ACT, almost immediately when registered
(LTE).

So gprs got notified that the CID was activated. But at that stage SIM had
not finished, it was queued after the COPS=3D0 and there is a long
sequence... So gprs had not read its provision contexts.
So a new context was created.....

Later on provision contexts were read and a second context was added for
the same APN...

Ideas of how to fix this:
1. Delay creation of context until the GPRS atom is registered, but that is
racy in case the context gets activated (we have no check for deactivation
without a created context).
2. Merge provision context into the created context when provisioning
happens and send proprtychanged.

I think only the second idea would work... any better idea?

Thanks in advance
Richard

--===============6684930751519919808==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGksPGRpdj48YnI+PC9kaXY+PGRpdj5KdXN0IHdhbnQgdG8gaGVhciB5
b3VywqB0aG91Z2h0cyBvZiBob3cgdG8gZml4IGFuIGlzc3VlIEkgc2F3LjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+VGhlIG1vZGVtIHdhcyB0b2xkIHRvIGFjdGl2YXRlIHdpdGggQ09QUz0wLCB0
aGF0IHRvb2sgdGltZS48L2Rpdj48ZGl2PkFuZCBhIGNvbnRleHQgd2FzIGFjdGl2YXRlZCBNRSBQ
RE4gQUNULCBhbG1vc3QgaW1tZWRpYXRlbHkgd2hlbiByZWdpc3RlcmVkIChMVEUpLjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+U28gZ3BycyBnb3Qgbm90aWZpZWQgdGhhdCB0aGUgQ0lEIHdhcyBh
Y3RpdmF0ZWQuIEJ1dCBhdCB0aGF0IHN0YWdlIFNJTSBoYWQgbm90IGZpbmlzaGVkLCBpdCB3YXMg
cXVldWVkIGFmdGVyIHRoZSBDT1BTPTAgYW5kIHRoZXJlIGlzIGEgbG9uZyBzZXF1ZW5jZS4uLiBT
byBncHJzIGhhZCBub3QgcmVhZCBpdHMgcHJvdmlzaW9uIGNvbnRleHRzLjwvZGl2PjxkaXY+U28g
YSBuZXcgY29udGV4dCB3YXMgY3JlYXRlZC4uLi4uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5M
YXRlciBvbiBwcm92aXNpb24gY29udGV4dHMgd2VyZSByZWFkIGFuZCBhIHNlY29uZCBjb250ZXh0
IHdhcyBhZGRlZCBmb3IgdGhlIHNhbWUgQVBOLi4uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5J
ZGVhcyBvZiBob3cgdG8gZml4IHRoaXM6PC9kaXY+PGRpdj4xLiBEZWxheSBjcmVhdGlvbiBvZiBj
b250ZXh0IHVudGlsIHRoZSBHUFJTIGF0b20gaXMgcmVnaXN0ZXJlZCwgYnV0IHRoYXQgaXMgcmFj
eSBpbiBjYXNlIHRoZSBjb250ZXh0IGdldHMgYWN0aXZhdGVkICh3ZSBoYXZlIG5vIGNoZWNrIGZv
ciBkZWFjdGl2YXRpb24gd2l0aG91dCBhIGNyZWF0ZWQgY29udGV4dCkuPC9kaXY+PGRpdj4yLiBN
ZXJnZSBwcm92aXNpb24gY29udGV4dCBpbnRvIHRoZSBjcmVhdGVkIGNvbnRleHQgd2hlbiBwcm92
aXNpb25pbmcgaGFwcGVucyBhbmQgc2VuZCBwcm9wcnR5Y2hhbmdlZC48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PkkgdGhpbmsgb25seSB0aGUgc2Vjb25kIGlkZWEgd291bGQgd29yay4uLiBhbnkg
YmV0dGVyIGlkZWE/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MgaW4gYWR2YW5jZTwv
ZGl2PjxkaXY+UmljaGFyZDwvZGl2PjwvZGl2Pgo=

--===============6684930751519919808==--

