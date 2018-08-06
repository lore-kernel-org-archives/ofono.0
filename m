Content-Type: multipart/mixed; boundary="===============6836693261705090625=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: atmodem driver cnmi
Date: Mon, 06 Aug 2018 18:33:19 +0200
Message-ID: <CAKSBH7EtCB-pzx9pwYZRUqEf+CRTKKOSmA+eaTs8asoJDS+Qsw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6836693261705090625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear all,

I have a question for the function build_cnmi_string() in
plugins/atmodem/sms.c

The numeric values appear corrupted, like "2310" instead of "2".

example, from an excerpt:
` default:
/* Sounds like 2 is the sanest mode */
mode =3D "2310";
break;
`

Am I missing something, like a post-processing, or some specific
implementation not compliant with the 3GPP TS_27.005, or there is a problem
with this function?

thank you,
Giacinto Cifelli

--===============6836693261705090625==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+RGVhciBhbGwsPGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhdmUgYSBxdWVz
dGlvbiBmb3IgdGhlIGZ1bmN0aW9uIGJ1aWxkX2NubWlfc3RyaW5nKCkgaW4gcGx1Z2lucy9hdG1v
ZGVtL3Ntcy5jPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGUgbnVtZXJpYyB2YWx1ZXMgYXBw
ZWFyIGNvcnJ1cHRlZCwgbGlrZSAmcXVvdDsyMzEwJnF1b3Q7IGluc3RlYWQgb2YgJnF1b3Q7MiZx
dW90Oy48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5leGFtcGxlLCBmcm9tIGFuIGV4Y2Vy
cHQ6PC9kaXY+PGRpdj48ZGl2PmA8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PmRlZmF1bHQ6PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bh
bj4vKiBTb3VuZHMgbGlrZSAyIGlzIHRoZSBzYW5lc3QgbW9kZSAqLzwvZGl2PjxkaXY+PHNwYW4g
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+bW9kZSA9ICZxdW90OzIzMTAmcXVvdDs7
PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bhbj5icmVhazs8
L2Rpdj48L2Rpdj48ZGl2PmA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFtIEkgbWlzc2luZyBz
b21ldGhpbmcsIGxpa2UgYSBwb3N0LXByb2Nlc3NpbmcsIG9yIHNvbWUgc3BlY2lmaWMgaW1wbGVt
ZW50YXRpb24gbm90IGNvbXBsaWFudCB3aXRoIHRoZSAzR1BQIFRTXzI3LjAwNSwgb3IgdGhlcmUg
aXMgYSBwcm9ibGVtIHdpdGggdGhpcyBmdW5jdGlvbj88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PnRoYW5rIHlvdSw8YnI+R2lhY2ludG8gQ2lmZWxsaTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2Pgo=

--===============6836693261705090625==--

