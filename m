Content-Type: multipart/mixed; boundary="===============1195721117199645421=="
MIME-Version: 1.0
From: Andrius =?unknown-8bit?q?Au=C4=8Dinas?= <andrius.aucinas@gmail.com>
Subject: telit uc864 sap clarification
Date: Mon, 26 Aug 2013 22:50:13 +0300
Message-ID: <CADTD6dfGTOceahxL2fZydGknC1nJ8fkATuBLV0bEhDJuZJ=Z3g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1195721117199645421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I am struggling to get SAP to work on my UC864 module.

A few bits to check in case I am doing something wrong in my setup:
1. The serial port specified in telit_sap_open method is not one of the 4
serial ports exposed through the USB, is it?
2. CMUX is not implemented for telit modules
3. I use a separate serial port (pins 25-32 to USB) for this and set it to
match the one in the code - everything that is written on it by the module
is forwarded onto bluetooth and vice versa

The problem is that I get the connection setup to work correctly and the
exchange of APDU request/response messages happens up to a point when the
module writes "0x02 0x00 0x00 0x00" on the port (all other messages that
receive some response from the SAP server start with "0x05 0x01 0x00
0x00"). By that time, the SAP server sees the bluetooth link as working
fine and SIM access as remote, but it does not understand this message and
sends an empty response, after which ofono initialisation just times out.
It does not get to a point when QSS changes.

I have tried filtering for this message specifically and not forwarding it
onto bluetooth, but then Ofono just times out as well.

Andrius

--===============1195721117199645421==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgYWxsLDxkaXY+PGJyPjwvZGl2PjxkaXY+SSBhbSBzdHJ1Z2dsaW5n
IHRvIGdldCBTQVAgdG8gd29yayBvbiBteSBVQzg2NCBtb2R1bGUuPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5BIGZldyBiaXRzIHRvIGNoZWNrIGluIGNhc2UgSSBhbSBkb2luZyBzb21ldGhpbmcg
d3JvbmcgaW4gbXkgc2V0dXA6PC9kaXY+PGRpdj4xLiBUaGUgc2VyaWFsIHBvcnQgc3BlY2lmaWVk
IGluIHRlbGl0X3NhcF9vcGVuIG1ldGhvZCBpcyBub3Qgb25lIG9mIHRoZSA0IHNlcmlhbCBwb3J0
cyBleHBvc2VkIHRocm91Z2ggdGhlIFVTQiwgaXMgaXQ/PC9kaXY+Cgo8ZGl2PjIuIENNVVggaXMg
bm90IGltcGxlbWVudGVkIGZvciB0ZWxpdCBtb2R1bGVzPC9kaXY+PGRpdj4zLiBJIHVzZSBhIHNl
cGFyYXRlIHNlcmlhbCBwb3J0IChwaW5zIDI1LTMyIHRvIFVTQikgZm9yIHRoaXMgYW5kIHNldCBp
dCB0byBtYXRjaCB0aGUgb25lIGluIHRoZSBjb2RlIC0gZXZlcnl0aGluZyB0aGF0IGlzIHdyaXR0
ZW4gb24gaXQgYnkgdGhlIG1vZHVsZSBpcyBmb3J3YXJkZWQgb250byBibHVldG9vdGggYW5kIHZp
Y2UgdmVyc2E8L2Rpdj4KCjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhlIHByb2JsZW0gaXMgdGhhdCBJ
IGdldCB0aGUgY29ubmVjdGlvbiBzZXR1cCB0byB3b3JrIGNvcnJlY3RseSBhbmQgdGhlIGV4Y2hh
bmdlIG9mIEFQRFUgcmVxdWVzdC9yZXNwb25zZSBtZXNzYWdlcyBoYXBwZW5zIHVwIHRvIGEgcG9p
bnQgd2hlbiB0aGUgbW9kdWxlIHdyaXRlcyAmcXVvdDsweDAyIDB4MDAgMHgwMCAweDAwJnF1b3Q7
IG9uIHRoZSBwb3J0IChhbGwgb3RoZXIgbWVzc2FnZXMgdGhhdCByZWNlaXZlIHNvbWUgcmVzcG9u
c2UgZnJvbSB0aGUgU0FQIHNlcnZlciBzdGFydCB3aXRoICZxdW90OzB4MDUgMHgwMSAweDAwIDB4
MDAmcXVvdDspLiBCeSB0aGF0IHRpbWUsIHRoZSBTQVAgc2VydmVyIHNlZXMgdGhlIGJsdWV0b290
aCBsaW5rIGFzIHdvcmtpbmcgZmluZSBhbmQgU0lNIGFjY2VzcyBhcyByZW1vdGUsIGJ1dCBpdCBk
b2VzIG5vdCB1bmRlcnN0YW5kIHRoaXMgbWVzc2FnZSBhbmQgc2VuZHMgYW4gZW1wdHkgcmVzcG9u
c2UsIGFmdGVyIHdoaWNoIG9mb25vIGluaXRpYWxpc2F0aW9uIGp1c3QgdGltZXMgb3V0LiBJdCBk
b2VzIG5vdCBnZXQgdG8gYSBwb2ludCB3aGVuIFFTUyBjaGFuZ2VzLjwvZGl2PgoKPGRpdj48YnI+
PC9kaXY+PGRpdj5JIGhhdmUgdHJpZWQgZmlsdGVyaW5nIGZvciB0aGlzIG1lc3NhZ2Ugc3BlY2lm
aWNhbGx5IGFuZCBub3QgZm9yd2FyZGluZyBpdCBvbnRvIGJsdWV0b290aCwgYnV0IHRoZW4gT2Zv
bm8ganVzdCB0aW1lcyBvdXQgYXMgd2VsbC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFuZHJp
dXM8L2Rpdj48L2Rpdj4K

--===============1195721117199645421==--

