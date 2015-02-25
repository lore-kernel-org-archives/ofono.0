Content-Type: multipart/mixed; boundary="===============6077753259565166689=="
MIME-Version: 1.0
From: Frederik Lotter <frederik.lotter@mixtelematics.com>
Subject: CMGS <CTRL-Z> appears with terminate IO stream in Ofono
Date: Wed, 25 Feb 2015 15:48:35 +0200
Message-ID: <CAEM=xjiOiVOeOD9biyuhfhpm260OJBMJ_LMO0baSRNbsJpBeEw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6077753259565166689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ofono experts,

I am using a UBLOX U200 modem and I wrote the driver for it some months
ago, and have since been using GPRS successfully.

I have now added the SMS feature and I am running into a problem:

It looks like once the SMS PDU byte block is sent (with CTRL-Z) the stream
disconnects.

Aux: > 0011000A8170033962660000A7044679990C<CtrlZ>

Any ideas? It looks like the g_io_channel_set_encoding() is called on both
my tty channels to RAW mode, so I am not sure why the CTRL-Z (I guess) is
causing this.

Instrumented output below:

------------------------------------

ofonod[1502]:
/home/flotter/mix6000-angstrom/build/tmp-angstrom_v2014_06-eglibc/work/armv=
7at2hf-vfp-angstrom-linux-gnueabi/ofono/1.14-r0/ofono-1.14/drivers/atmodem/=
sms.c:at_cmgl_done()
ofonod[1502]: Aux: > AT+CGSMS=3D3\r
FRED[Write watcher destroyed...]
ofonod[1502]: Aux: < \r\nOK\r\n
FRED>>[
OK
] - 6 - 6 <<
ofonod[1502]: Aux: > AT+CMGS=3D17\r
FRED[Write watcher destroyed...]
ofonod[1502]: RegisterProfile() replied an error:
org.freedesktop.DBus.Error.UnknownMethod, Method "RegisterProfile" with
signature "osa{sv}" on interface "org.bluez.ProfileManager1" doesn't exist
ofonod[1502]: Aux: < \r\n>
FRED>>[
> ] - 4 - 4 <<
ofonod[1502]: Aux: > 0011000A8170033962660000A7044679990C<CtrlZ>
FRED[Write watcher destroyed...]
FRED[Read watcher destroyed...]
FRED[IO Disconnect]

--===============6077753259565166689==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgT2Zvbm8gZXhwZXJ0cyw8ZGl2Pjxicj48L2Rpdj48ZGl2PkkgYW0g
dXNpbmcgYSBVQkxPWCBVMjAwIG1vZGVtIGFuZCBJIHdyb3RlIHRoZSBkcml2ZXIgZm9yIGl0IHNv
bWUgbW9udGhzIGFnbywgYW5kIGhhdmUgc2luY2UgYmVlbiB1c2luZyBHUFJTIHN1Y2Nlc3NmdWxs
eS7CoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBoYXZlIG5vdyBhZGRlZCB0aGUgU01TIGZl
YXR1cmUgYW5kIEkgYW0gcnVubmluZyBpbnRvIGEgcHJvYmxlbTo8L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2Pkl0IGxvb2tzIGxpa2Ugb25jZSB0aGUgU01TIFBEVSBieXRlIGJsb2NrIGlzIHNlbnQg
KHdpdGggQ1RSTC1aKSB0aGUgc3RyZWFtIGRpc2Nvbm5lY3RzLjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+QXV4OiAmZ3Q7IDAwMTEwMDBBODE3MDAzMzk2MjY2MDAwMEE3MDQ0Njc5OTkwQyZsdDtD
dHJsWiZndDs8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbnkgaWRlYXM/IEl0IGxvb2tz
IGxpa2UgdGhlwqBnX2lvX2NoYW5uZWxfc2V0X2VuY29kaW5nKCkgaXMgY2FsbGVkIG9uIGJvdGgg
bXkgdHR5IGNoYW5uZWxzIHRvIFJBVyBtb2RlLCBzbyBJIGFtIG5vdCBzdXJlIHdoeSB0aGUgQ1RS
TC1aIChJIGd1ZXNzKSBpcyBjYXVzaW5nIHRoaXMuwqA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
Pkluc3RydW1lbnRlZCBvdXRwdXQgYmVsb3c6PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PjxkaXY+b2Zvbm9kWzE1MDJdOiAvaG9tZS9mbG90dGVyL21peDYwMDAtYW5nc3Ryb20vYnVpbGQv
dG1wLWFuZ3N0cm9tX3YyMDE0XzA2LWVnbGliYy93b3JrL2FybXY3YXQyaGYtdmZwLWFuZ3N0cm9t
LWxpbnV4LWdudWVhYmkvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9z
bXMuYzphdF9jbWdsX2RvbmUoKcKgPC9kaXY+PGRpdj5vZm9ub2RbMTUwMl06IEF1eDogJmd0OyBB
VCtDR1NNUz0zXHI8L2Rpdj48ZGl2PkZSRURbV3JpdGUgd2F0Y2hlciBkZXN0cm95ZWQuLi5dPC9k
aXY+PGRpdj5vZm9ub2RbMTUwMl06IEF1eDogJmx0OyBcclxuT0tcclxuPC9kaXY+PGRpdj5GUkVE
Jmd0OyZndDtbPC9kaXY+PGRpdj5PSzwvZGl2PjxkaXY+XSAtIDYgLSA2ICZsdDsmbHQ7PC9kaXY+
PGRpdj5vZm9ub2RbMTUwMl06IEF1eDogJmd0OyBBVCtDTUdTPTE3XHI8L2Rpdj48ZGl2PkZSRURb
V3JpdGUgd2F0Y2hlciBkZXN0cm95ZWQuLi5dPC9kaXY+PGRpdj5vZm9ub2RbMTUwMl06IFJlZ2lz
dGVyUHJvZmlsZSgpIHJlcGxpZWQgYW4gZXJyb3I6IG9yZy5mcmVlZGVza3RvcC5EQnVzLkVycm9y
LlVua25vd25NZXRob2QsIE1ldGhvZCAmcXVvdDtSZWdpc3RlclByb2ZpbGUmcXVvdDsgd2l0aCBz
aWduYXR1cmUgJnF1b3Q7b3Nhe3N2fSZxdW90OyBvbiBpbnRlcmZhY2UgJnF1b3Q7b3JnLmJsdWV6
LlByb2ZpbGVNYW5hZ2VyMSZxdW90OyBkb2VzbiYjMzk7dCBleGlzdDwvZGl2PjxkaXY+b2Zvbm9k
WzE1MDJdOiBBdXg6ICZsdDsgXHJcbiZndDvCoDwvZGl2PjxkaXY+RlJFRCZndDsmZ3Q7WzwvZGl2
PjxkaXY+Jmd0OyBdIC0gNCAtIDQgJmx0OyZsdDs8L2Rpdj48ZGl2Pm9mb25vZFsxNTAyXTogQXV4
OiAmZ3Q7IDAwMTEwMDBBODE3MDAzMzk2MjY2MDAwMEE3MDQ0Njc5OTkwQyZsdDtDdHJsWiZndDs8
L2Rpdj48ZGl2PkZSRURbV3JpdGUgd2F0Y2hlciBkZXN0cm95ZWQuLi5dPC9kaXY+PGRpdj5GUkVE
W1JlYWQgd2F0Y2hlciBkZXN0cm95ZWQuLi5dPC9kaXY+PGRpdj5GUkVEW0lPIERpc2Nvbm5lY3Rd
PC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============6077753259565166689==--

