Content-Type: multipart/mixed; boundary="===============0286826404188555650=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: ICCID not requested when PIN is locked
Date: Tue, 28 Oct 2014 12:50:22 +0100
Message-ID: <CAH4ZQwsXibijyOySYBo2M8SvdN2CTKUSveFNffZmmHK1jcc90Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0286826404188555650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,
I have a problem with SimManager interface.
When I start ofono with pin locked it starts to read the sim file manager
but the first message fails:

ofonod[29427]: Aux: > AT+CRSM=3D192,12258\r
ofonod[29427]: Aux: < \r\n+CME ERROR: 4\r\n

The callback of this message contains the following call which would
success but it is never called because of the error.

This results in the problem that ICCID is never retried even if I enter the
pin.

How can I solve this problem?

=E2=80=8BThank you!

Enrico

--===============0286826404188555650==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SGkgYWxsLDwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2Rl
ZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPkkgaGF2ZSBhIHBy
b2JsZW0gd2l0aCBTaW1NYW5hZ2VyIGludGVyZmFjZS48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9k
ZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5XaGVuIEkgc3Rh
cnQgb2Zvbm8gd2l0aCBwaW4gbG9ja2VkIGl0IHN0YXJ0cyB0byByZWFkIHRoZSBzaW0gZmlsZSBt
YW5hZ2VyIGJ1dCB0aGUgZmlyc3QgbWVzc2FnZSBmYWlsczo8L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj48YnI+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEs
c2Fucy1zZXJpZiI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCI+b2Zvbm9kWzI5NDI3XTogQXV4
OiAmZ3Q7IEFUK0NSU009MTkyLDEyMjU4XHI8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0
Ij5vZm9ub2RbMjk0MjddOiBBdXg6ICZsdDsgXHJcbitDTUUgRVJST1I6IDRcclxuPC9kaXY+PGRp
diBjbGFzcz0iZ21haWxfZGVmYXVsdCI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1
bHQiPlRoZSBjYWxsYmFjayBvZiB0aGlzIG1lc3NhZ2UgY29udGFpbnMgdGhlIGZvbGxvd2luZyBj
YWxsIHdoaWNoIHdvdWxkIHN1Y2Nlc3MgYnV0IGl0IGlzIG5ldmVyIGNhbGxlZCBiZWNhdXNlIG9m
IHRoZSBlcnJvci48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij48YnI+PC9kaXY+PGRp
diBjbGFzcz0iZ21haWxfZGVmYXVsdCI+VGhpcyByZXN1bHRzIGluIHRoZSBwcm9ibGVtIHRoYXQg
SUNDSUQgaXMgbmV2ZXIgcmV0cmllZCBldmVuIGlmIEkgZW50ZXIgdGhlIHBpbi48L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVs
dCI+SG93IGNhbiBJIHNvbHZlIHRoaXMgcHJvYmxlbT88L2Rpdj48L2Rpdj48ZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5
OnZlcmRhbmEsc2Fucy1zZXJpZiI+4oCLVGhhbmsgeW91ITwvZGl2PjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+RW5yaWNvPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+CjwvZGl2Pgo=

--===============0286826404188555650==--

