Content-Type: multipart/mixed; boundary="===============8362515537225500363=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Option to not power off radio during start ofono
Date: Tue, 18 Feb 2020 10:19:20 +0100
Message-ID: <CAHB-PjkycO5zfS7KHpi+m0TK0DztQ0Dvnaa91zzKNnGD+hkUYw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8362515537225500363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Ofono (at least for ublox) is always powering off the radio during start.
This can of course be handy of programmatic reasons to bring the modem to a
known state.
Some configuration requires the radio to be turned off;  for instance the
LTE auto connect APN. But on the other hand these are stored in
non-volatile memory and could be configured before hand.

The big drawback with turning it off is that it might take time to register
again when the radio is on. I have seen it taking more than 10 minutes in
extreme cases.

In embedded systems this can be a big issue.

I'm thinking of adding a configuration option to keep the radio on during
start.

Whats the general thought about this?

BR
--Richard

--===============8362515537225500363==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+SGksPGRpdj48YnI+PC9kaXY+PGRpdj5PZm9ubyAoYXQgbGVhc3QgZm9y
IHVibG94KSBpcyBhbHdheXMgcG93ZXJpbmcgb2ZmIHRoZSByYWRpbyBkdXJpbmcgc3RhcnQuPC9k
aXY+PGRpdj5UaGlzIGNhbiBvZiBjb3Vyc2UgYmUgaGFuZHkgb2YgcHJvZ3JhbW1hdGljwqByZWFz
b25zIHRvIGJyaW5nIHRoZSBtb2RlbSB0byBhIGtub3duIHN0YXRlLjwvZGl2PjxkaXY+U29tZSBj
b25maWd1cmF0aW9uIHJlcXVpcmVzIHRoZSByYWRpbyB0byBiZSB0dXJuZWQgb2ZmO8KgIGZvciBp
bnN0YW5jZSB0aGUgTFRFIGF1dG8gY29ubmVjdCBBUE4uIEJ1dCBvbiB0aGUgb3RoZXLCoGhhbmQg
dGhlc2UgYXJlIHN0b3JlZCBpbiBub24tdm9sYXRpbGUgbWVtb3J5IGFuZCBjb3VsZCBiZSBjb25m
aWd1cmVkIGJlZm9yZSBoYW5kLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhlIGJpZyBkcmF3
YmFjayB3aXRoIHR1cm5pbmcgaXQgb2ZmIGlzIHRoYXQgaXQgbWlnaHQgdGFrZSB0aW1lIHRvIHJl
Z2lzdGVyIGFnYWluIHdoZW4gdGhlIHJhZGlvIGlzIG9uLiBJIGhhdmUgc2VlbiBpdCB0YWtpbmcg
bW9yZSB0aGFuIDEwIG1pbnV0ZXMgaW4gZXh0cmVtZSBjYXNlcy48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PkluIGVtYmVkZGVkIHN5c3RlbXMgdGhpcyBjYW4gYmUgYSBiaWcgaXNzdWUuPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5JJiMzOTttIHRoaW5raW5nIG9mIGFkZGluZyBhIGNvbmZpZ3Vy
YXRpb24gb3B0aW9uIHRvIGtlZXAgdGhlIHJhZGlvIG9uIGR1cmluZyBzdGFydC48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PldoYXRzIHRoZSBnZW5lcmFsIHRob3VnaHQgYWJvdXQgdGhpcz88L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PkJSPC9kaXY+PGRpdj4tLVJpY2hhcmQ8L2Rpdj48L2Rpdj4K

--===============8362515537225500363==--

