Content-Type: multipart/mixed; boundary="===============1808698127027812047=="
MIME-Version: 1.0
From: TengChou Yang <threefure@gmail.com>
Subject: CDMA voicecall driver
Date: Wed, 19 Jun 2013 17:24:50 -0700
Message-ID: <CAHtt_w=VW5tDZrcsSo8ceq_zsGLteLwQphdcV_k1ESUfNztDwg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1808698127027812047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,
I am currently working on Sierra modem (MC5728V). Looks like CDMA is not
fully supported for the voicecall yet.
What I see from ofono master branch there are only probe, remove, dial,
hangup had been implemented. I am working
on other's method step by step. I am wondering is it worth it to change the
dbus service path from org.ofono.cdma.voicecallmanager
to org.ofono.voicecallmanager? In this case, application doesn't need to
care about it's GSM modem or CDMA modem,
what they need to do is connecting to the same dbus path.
Sincerely,
TengChou Yang

--===============1808698127027812047==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgYWxsLDxkaXYgc3R5bGU+SSBhbSBjdXJyZW50bHkgd29ya2luZyBv
biBTaWVycmEgbW9kZW0gKE1DNTcyOFYpLiBMb29rcyBsaWtlIENETUEgaXMgbm90IGZ1bGx5IHN1
cHBvcnRlZCBmb3IgdGhlIHZvaWNlY2FsbCB5ZXQuPC9kaXY+PGRpdiBzdHlsZT5XaGF0IEkgc2Vl
IGZyb20gb2Zvbm8gbWFzdGVyIGJyYW5jaCB0aGVyZSBhcmUgb25seSBwcm9iZSwgcmVtb3ZlLCBk
aWFsLCBoYW5ndXAgaGFkIGJlZW4gaW1wbGVtZW50ZWQuIEkgYW0gd29ya2luZzwvZGl2Pgo8ZGl2
IHN0eWxlPm9uIG90aGVyJiMzOTtzIG1ldGhvZCBzdGVwIGJ5IHN0ZXAuIEkgYW0gd29uZGVyaW5n
IGlzIGl0IHdvcnRoIGl0IHRvIGNoYW5nZSB0aGUgZGJ1cyBzZXJ2aWNlIHBhdGggZnJvbSBvcmcu
b2Zvbm8uY2RtYS52b2ljZWNhbGxtYW5hZ2VyPC9kaXY+PGRpdiBzdHlsZT50byBvcmcub2Zvbm8u
dm9pY2VjYWxsbWFuYWdlcj8gSW4gdGhpcyBjYXNlLCBhcHBsaWNhdGlvbiBkb2VzbiYjMzk7dCBu
ZWVkIHRvIGNhcmUgYWJvdXQgaXQmIzM5O3MgR1NNIG1vZGVtIG9yIENETUEgbW9kZW0soDwvZGl2
Pgo8ZGl2IHN0eWxlPndoYXQgdGhleSBuZWVkIHRvIGRvIGlzIGNvbm5lY3RpbmcgdG8gdGhlIHNh
bWUgZGJ1cyBwYXRoLjwvZGl2PjxkaXYgc3R5bGU+U2luY2VyZWx5LDwvZGl2PjxkaXYgc3R5bGU+
VGVuZ0Nob3UgWWFuZzwvZGl2PjwvZGl2Pgo=

--===============1808698127027812047==--

