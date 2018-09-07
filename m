Content-Type: multipart/mixed; boundary="===============5642005333601718428=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: vendor models and options
Date: Fri, 07 Sep 2018 10:09:08 +0200
Message-ID: <CAKSBH7GEje3Gc71h1qDDnKineXL8MHtNBwZmyK+VbeJNh+JZaQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5642005333601718428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear Denis, all,

while preparing the Gemalto driver, I see that there is a potential
shortcoming with the vendor structure in the atmodem. I can set
OFONO_VENDOR_GEMALTO_model, but this could be a very long list for all
options to maintain. I see the tendency also for other manufacturers.
Would it be ok if I convert the vendor integer in a structure with model
and flags?
This would make the current code more compact and clearer.

The alternative of cloning the atmodem is less tempting, because then it
needs constant monitoring of the atmodem to porting the features in it, or
conversely missing features in this general driver. One example is for the
indicators +CGREG/+CEREG/+C5GREG that we are adding in atmodem (gprs.c),
instead of the unique +CGREG that doesn't work anymore for LTE (in the
27.007). If I add it in Gemalto driver, it will be missing in the atmodem.

thank you for any commments.

Regards,
Giacinto

--===============5642005333601718428==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+RGVhciBEZW5pcywgYWxsLDxkaXY+PGJyPjwvZGl2PjxkaXY+d2hpbGUg
cHJlcGFyaW5nIHRoZSBHZW1hbHRvIGRyaXZlciwgSSBzZWUgdGhhdCB0aGVyZSBpcyBhIHBvdGVu
dGlhbCBzaG9ydGNvbWluZyB3aXRoIHRoZSB2ZW5kb3Igc3RydWN0dXJlIGluIHRoZSBhdG1vZGVt
LiBJIGNhbiBzZXQgT0ZPTk9fVkVORE9SX0dFTUFMVE9fbW9kZWwsIGJ1dCB0aGlzIGNvdWxkIGJl
IGEgdmVyeSBsb25nIGxpc3QgZm9yIGFsbCBvcHRpb25zIHRvIG1haW50YWluLiBJIHNlZSB0aGUg
dGVuZGVuY3kgYWxzbyBmb3Igb3RoZXIgbWFudWZhY3R1cmVycy48L2Rpdj48ZGl2PldvdWxkIGl0
IGJlIG9rIGlmIEkgY29udmVydCB0aGUgdmVuZG9yIGludGVnZXIgaW4gYSBzdHJ1Y3R1cmUgd2l0
aCBtb2RlbCBhbmQgZmxhZ3M/PC9kaXY+PGRpdj5UaGlzIHdvdWxkIG1ha2UgdGhlIGN1cnJlbnQg
Y29kZSBtb3JlIGNvbXBhY3QgYW5kIGNsZWFyZXIuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5U
aGUgYWx0ZXJuYXRpdmUgb2YgY2xvbmluZyB0aGUgYXRtb2RlbSBpcyBsZXNzIHRlbXB0aW5nLCBi
ZWNhdXNlIHRoZW4gaXQgbmVlZHMgY29uc3RhbnQgbW9uaXRvcmluZyBvZiB0aGUgYXRtb2RlbSB0
byBwb3J0aW5nIHRoZSBmZWF0dXJlcyBpbiBpdCwgb3IgY29udmVyc2VseSBtaXNzaW5nIGZlYXR1
cmVzIGluIHRoaXMgZ2VuZXJhbCBkcml2ZXIuIE9uZSBleGFtcGxlIGlzIGZvciB0aGUgaW5kaWNh
dG9yc8KgK0NHUkVHLytDRVJFRy8rQzVHUkVHIHRoYXQgd2UgYXJlIGFkZGluZyBpbiBhdG1vZGVt
IChncHJzLmMpLCBpbnN0ZWFkIG9mIHRoZSB1bmlxdWXCoCtDR1JFRyB0aGF0IGRvZXNuJiMzOTt0
IHdvcmsgYW55bW9yZSBmb3IgTFRFIChpbiB0aGUgMjcuMDA3KS4gSWYgSSBhZGQgaXQgaW4gR2Vt
YWx0byBkcml2ZXIsIGl0IHdpbGwgYmUgbWlzc2luZyBpbiB0aGUgYXRtb2RlbS48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PnRoYW5rIHlvdSBmb3IgYW55IGNvbW1tZW50cy48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj5HaWFjaW50bzwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjwvZGl2Pgo=

--===============5642005333601718428==--

