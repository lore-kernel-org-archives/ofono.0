Content-Type: multipart/mixed; boundary="===============2966320103147087961=="
MIME-Version: 1.0
From: Fabio <fabio.tosetti@gmail.com>
Subject: U-Blox modem sends unprintable chars before "AT+CGMS=<seq>" reply:
 ofono (1.16) close the serial port ?
Date: Tue, 24 Nov 2015 10:45:21 +0100
Message-ID: <CAJvjxsz6pieOW_eqy+B+vHdgSxmPxnkBpF1dyM1M8Fi7VoA48g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2966320103147087961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,
I'm using ofono 1.16 with some patch to add sms manager to the Ublox driver.

Someone could confirm that ofono close the serial port when it receives
some unexpected/unprintable character before the "AT+CGMS=3D<seq>" reply fr=
om
the modem?

If yes, is possible to discard these characters instead of hanging-up the
serial port? Could I have some info about the source I have to patch ?

Thanks in advance,
FabioT


-- =

***************************************************************************=
*************************************************

"Solo due cose sono infinite: l'universo e la stupidit=C3=A0 umana. Ma della
prima non sono sicuro". [Albert Einstein]
***************************************************************************=
*************************************************

--===============2966320103147087961==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGVsbG8sPGRpdj5JJiMzOTttIHVzaW5nIG9mb25vIDEuMTYgd2l0aCBz
b21lIHBhdGNoIHRvIGFkZCBzbXMgbWFuYWdlciB0byB0aGUgVWJsb3ggZHJpdmVyLjwvZGl2Pjxk
aXY+PGJyPjxkaXY+U29tZW9uZSBjb3VsZCBjb25maXJtIHRoYXQgb2Zvbm8gY2xvc2UgdGhlIHNl
cmlhbCBwb3J0IHdoZW4gaXQgcmVjZWl2ZXMgc29tZSB1bmV4cGVjdGVkL3VucHJpbnRhYmxlIGNo
YXJhY3RlciBiZWZvcmUgdGhlwqAmcXVvdDtBVCtDR01TPSZsdDtzZXEmZ3Q7JnF1b3Q7IHJlcGx5
IGZyb20gdGhlIG1vZGVtPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SWYgeWVzLCBpcyBwb3Nz
aWJsZSB0byBkaXNjYXJkIHRoZXNlIGNoYXJhY3RlcnMgaW5zdGVhZCBvZiBoYW5naW5nLXVwIHRo
ZSBzZXJpYWwgcG9ydD8gQ291bGQgSSBoYXZlIHNvbWUgaW5mbyBhYm91dCB0aGUgc291cmNlIEkg
aGF2ZSB0byBwYXRjaCA/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MgaW4gYWR2YW5j
ZSw8L2Rpdj48ZGl2PkZhYmlvVDwvZGl2PjxkaXY+PGJyIGNsZWFyPSJhbGwiPjxkaXY+PGJyPjwv
ZGl2Pi0tIDxicj48ZGl2IGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiPioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiogPGJyPiZx
dW90O1NvbG8gZHVlIGNvc2Ugc29ubyBpbmZpbml0ZTogbCYjMzk7dW5pdmVyc28gZSBsYSBzdHVw
aWRpdMOgIHVtYW5hLiBNYSBkZWxsYSBwcmltYSBub24gc29ubyBzaWN1cm8mcXVvdDsuIFtBbGJl
cnQgRWluc3RlaW5dPGJyPioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKio8L2Rpdj4KPC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============2966320103147087961==--

