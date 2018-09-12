Content-Type: multipart/mixed; boundary="===============8257666179322041946=="
MIME-Version: 1.0
From: Frank Vasquez <frankv@helium.com>
Subject: ublox TOBY-R200
Date: Wed, 12 Sep 2018 15:41:16 -0700
Message-ID: <CAFJydPUsTRmFcP+34bCe_YufRh-atSmmeY5TOPDts+XDbGKf_A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8257666179322041946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Greetings,

I have an embedded device with a ublox TOBY-R200 on it.  I want to use
connman to manage any cellular connection on that modem since connman is
already managing ethernet and wifi connectivity.  oFono seems like the best
option.  I see that there is already a ublox plugin for oFono but I don't
think the TOBY-R200 is supported.  The cell module is soldered onto the
board and appears as a USB device.

[    6.519190] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[    6.519197] usb 1-1: Product: u-blox Cellular Module
[    6.519204] usb 1-1: Manufacturer: u-blox
[    6.519211] usb 1-1: SerialNumber: 352848080392646

I can send AT commands to the modem over /dev/ttyACM0.

Cheers,
Frank

--===============8257666179322041946==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+R3JlZXRpbmdzLDxkaXY+PGJyPjwvZGl2Pjxk
aXY+SSBoYXZlIGFuIGVtYmVkZGVkIGRldmljZSB3aXRoIGEgdWJsb3ggVE9CWS1SMjAwIG9uIGl0
LsKgIEkgd2FudCB0byB1c2UgY29ubm1hbiB0byBtYW5hZ2UgYW55IGNlbGx1bGFyIGNvbm5lY3Rp
b24gb24gdGhhdCBtb2RlbSBzaW5jZSBjb25ubWFuIGlzIGFscmVhZHkgbWFuYWdpbmcgZXRoZXJu
ZXQgYW5kIHdpZmkgY29ubmVjdGl2aXR5LsKgIG9Gb25vIHNlZW1zIGxpa2UgdGhlIGJlc3Qgb3B0
aW9uLsKgIEkgc2VlIHRoYXQgdGhlcmUgaXMgYWxyZWFkeSBhIHVibG94IHBsdWdpbiBmb3Igb0Zv
bm8gYnV0IEkgZG9uJiMzOTt0IHRoaW5rIHRoZSBUT0JZLVIyMDAgaXMgc3VwcG9ydGVkLsKgIFRo
ZSBjZWxsIG1vZHVsZSBpcyBzb2xkZXJlZCBvbnRvIHRoZSBib2FyZCBhbmQgYXBwZWFycyBhcyBh
IFVTQiBkZXZpY2UuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PlvCoCDCoCA2LjUxOTE5
MF0gdXNiIDEtMTogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTEsIFByb2R1Y3Q9MiwgU2Vy
aWFsTnVtYmVyPTM8L2Rpdj48ZGl2PlvCoCDCoCA2LjUxOTE5N10gdXNiIDEtMTogUHJvZHVjdDog
dS1ibG94IENlbGx1bGFyIE1vZHVsZTwvZGl2PjxkaXY+W8KgIMKgIDYuNTE5MjA0XSB1c2IgMS0x
OiBNYW51ZmFjdHVyZXI6IHUtYmxveDwvZGl2PjxkaXY+W8KgIMKgIDYuNTE5MjExXSB1c2IgMS0x
OiBTZXJpYWxOdW1iZXI6IDM1Mjg0ODA4MDM5MjY0NjwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+SSBjYW4gc2VuZCBBVCBjb21tYW5kcyB0byB0aGUgbW9kZW0gb3ZlciAvZGV2L3R0eUFD
TTAuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9kaXY+PGRpdj5GcmFuazwvZGl2
PjwvZGl2PjwvZGl2Pgo=

--===============8257666179322041946==--

