Content-Type: multipart/mixed; boundary="===============5569786281723538551=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: Message waiting patches
Date: Thu, 16 Jul 2015 15:08:19 +0200
Message-ID: <CACM4vuCBb19LLqmJwKPcVePY2=KvYtHG_YxWmFG1=3ddXxDCfQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5569786281723538551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I have just sent to the list a couple of fixes for the message-waiting
atom. In some cases the EF_MWIS was populated with bad data due to using an
uninitialized variable: one patch solves this. The other one is for
properly updating the atom structures when reading EF_MWIS, and it is good
to have although it was not really affecting anything.

Br,
Alfonso

--===============5569786281723538551==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgYWxsLDxkaXY+PGJyPjwvZGl2PjxkaXY+SSBoYXZlIGp1c3Qgc2Vu
dCB0byB0aGUgbGlzdCBhIGNvdXBsZSBvZiBmaXhlcyBmb3IgdGhlIG1lc3NhZ2Utd2FpdGluZyBh
dG9tLiBJbiBzb21lIGNhc2VzIHRoZSBFRl9NV0lTIHdhcyBwb3B1bGF0ZWQgd2l0aCBiYWQgZGF0
YSBkdWUgdG8gdXNpbmcgYW4gdW5pbml0aWFsaXplZCB2YXJpYWJsZTogb25lIHBhdGNoIHNvbHZl
cyB0aGlzLiBUaGUgb3RoZXIgb25lIGlzIGZvciBwcm9wZXJseSB1cGRhdGluZyB0aGUgYXRvbSBz
dHJ1Y3R1cmVzIHdoZW4gcmVhZGluZyBFRl9NV0lTLCBhbmQgaXQgaXMgZ29vZCB0byBoYXZlIGFs
dGhvdWdoIGl0IHdhcyBub3QgcmVhbGx5IGFmZmVjdGluZyBhbnl0aGluZy48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PkJyLDwvZGl2PjxkaXY+QWxmb25zbzwvZGl2PjwvZGl2Pgo=

--===============5569786281723538551==--

