Content-Type: multipart/mixed; boundary="===============2007752562776235237=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: MBIM IP configuration
Date: Mon, 24 Sep 2018 07:45:48 +0200
Message-ID: <CAKSBH7EYgTj-r2WLSZikV2Ez4uzkQn-Ew9N4Bvab2fuB1YzrzA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2007752562776235237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear all,

I have stepped into a very slow networks, that takes almost 1 minute to
assign an IP address once the MBIM CONNECT DONE is returned.
Under these conditions, the call to IP_CONFIGURATION returns all empty
values, and the driver sets the connection method to 'dhcp'.
But this modem does not support DHCP, so is there a way out of this?
Can the driver set the method to kind of 'waiting', and query periodically,
let's say every 500ms or every second?

Best regards,
Giacinto

--===============2007752562776235237==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+RGVhciBhbGwsPGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhdmUgc3RlcHBl
ZCBpbnRvIGEgdmVyeSBzbG93IG5ldHdvcmtzLCB0aGF0IHRha2VzIGFsbW9zdCAxIG1pbnV0ZSB0
byBhc3NpZ24gYW4gSVAgYWRkcmVzcyBvbmNlIHRoZSBNQklNIENPTk5FQ1QgRE9ORSBpcyByZXR1
cm5lZC48L2Rpdj48ZGl2PlVuZGVyIHRoZXNlIGNvbmRpdGlvbnMsIHRoZSBjYWxsIHRvIElQX0NP
TkZJR1VSQVRJT04gcmV0dXJucyBhbGwgZW1wdHkgdmFsdWVzLCBhbmQgdGhlIGRyaXZlciBzZXRz
IHRoZSBjb25uZWN0aW9uIG1ldGhvZCB0byAmIzM5O2RoY3AmIzM5Oy48L2Rpdj48ZGl2PkJ1dCB0
aGlzIG1vZGVtIGRvZXMgbm90IHN1cHBvcnQgREhDUCwgc28gaXMgdGhlcmUgYSB3YXkgb3V0IG9m
IHRoaXM/PC9kaXY+PGRpdj5DYW4gdGhlIGRyaXZlciBzZXQgdGhlIG1ldGhvZCB0byBraW5kIG9m
ICYjMzk7d2FpdGluZyYjMzk7LCBhbmQgcXVlcnkgcGVyaW9kaWNhbGx5LCBsZXQmIzM5O3Mgc2F5
IGV2ZXJ5IDUwMG1zIG9yIGV2ZXJ5IHNlY29uZD88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkJl
c3QgcmVnYXJkcyw8L2Rpdj48ZGl2PkdpYWNpbnRvPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48
YnI+PC9kaXY+PC9kaXY+Cg==

--===============2007752562776235237==--

