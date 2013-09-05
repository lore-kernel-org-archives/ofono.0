Content-Type: multipart/mixed; boundary="===============1105432815992059155=="
MIME-Version: 1.0
From: Etienne Mabille <mabille.etienne@gmail.com>
Subject: Telit HE910 initialisation sequence freezes
Date: Thu, 05 Sep 2013 09:54:42 +0200
Message-ID: <CAMtf1D9cQMJpJ+CngRzWYH+xEqfe_5UBQudf3hMQibi2n13frw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1105432815992059155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I am using the Telit HE910 modem with the "telit: rework for HE910" patches
shared by Jonas Bonn on the 4th of april 2013.

After some endurence testing I realize that sometimes (around 25% of the
time) the initialisation process freezes after switching sim state satus to
2.
I assume that the driver then waits for a signal from the modem, but this
signal never comes.
When this happens, the only way I found is to hard-reset the modem...
Is there a way to stimulate the modem in order to continue the
initialisation sequence ?

Thanks in advance,

Etienne

--===============1105432815992059155==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgZXZlcnlvbmUsPGRpdj48YnI+PC9kaXY+PGRpdj5JIGFtIHVzaW5n
IHRoZSBUZWxpdCBIRTkxMCBtb2RlbSB3aXRoIHRoZSAmcXVvdDt0ZWxpdDogcmV3b3JrIGZvciBI
RTkxMCZxdW90OyBwYXRjaGVzIHNoYXJlZCBieSBKb25hcyBCb25uIG9uIHRoZSA0dGggb2YgYXBy
aWwgMjAxMy6gPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BZnRlciBzb21lIGVuZHVyZW5jZSB0
ZXN0aW5nIEkgcmVhbGl6ZSB0aGF0IHNvbWV0aW1lcyAoYXJvdW5kIDI1JSBvZiB0aGUgdGltZSkg
dGhlIGluaXRpYWxpc2F0aW9uIHByb2Nlc3MgZnJlZXplcyBhZnRlciBzd2l0Y2hpbmcgc2ltIHN0
YXRlIHNhdHVzIHRvIDIuPC9kaXY+CjxkaXY+SSBhc3N1bWUgdGhhdCB0aGUgZHJpdmVyIHRoZW4g
d2FpdHMgZm9yIGEgc2lnbmFsIGZyb20gdGhlIG1vZGVtLCBidXQgdGhpcyBzaWduYWwgbmV2ZXIg
Y29tZXMuPC9kaXY+PGRpdj5XaGVuIHRoaXMgaGFwcGVucywgdGhlIG9ubHkgd2F5IEkgZm91bmQg
aXMgdG8gaGFyZC1yZXNldCB0aGUgbW9kZW0uLi48L2Rpdj48ZGl2PklzIHRoZXJlIGEgd2F5IHRv
IHN0aW11bGF0ZSB0aGUgbW9kZW0gaW4gb3JkZXIgdG8gY29udGludWUgdGhlIGluaXRpYWxpc2F0
aW9uIHNlcXVlbmNlID+gPC9kaXY+CjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzIGluIGFkdmFu
Y2UsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5FdGllbm5lPC9kaXY+PC9kaXY+Cg==

--===============1105432815992059155==--

