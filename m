Content-Type: multipart/mixed; boundary="===============3834517850630994737=="
MIME-Version: 1.0
From: Bruno Bruzzano <brunano21@gmail.com>
Subject: Unable to hang up a call.
Date: Mon, 03 Feb 2014 20:33:45 -0500
Message-ID: <CACA6DsXssq1gpa22v8G=VDQ6hwv4USM=hDnrzttqYzmngVtbew@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3834517850630994737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I'm writing you since denkenz (on IRC channel) suggested me.
I'm using oFono 1.14. My issue is that, basically, I'm not able to hang up
an active call.
Here I made a pastebin of oFono daemon. - http://pastebin.com/h8x6uk1d

When I call the Hangup() method, I get the following
org.freedesktop.DBus.Error.NoReply.
The problem is present also using d-feet. A timeout expires.

By the way, if I retry to call the method again I
get:  org.ofono.Error.InProgress.

Could I have missed something?

If you require more information, please let me know.
Thanks.

Best Regards.

--===============3834517850630994737==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgZXZlcnlvbmUsPGRpdj48YnI+PC9kaXY+PGRpdj5JJiMzOTttIHdy
aXRpbmcgeW91IHNpbmNlIGRlbmtlbnogKG9uIElSQyBjaGFubmVsKSBzdWdnZXN0ZWQgbWUuPC9k
aXY+PGRpdj5JJiMzOTttIHVzaW5nIG9Gb25vIDEuMTQuIE15IGlzc3VlIGlzIHRoYXQsIGJhc2lj
YWxseSwgSSYjMzk7bSBub3QgYWJsZSB0byBoYW5nIHVwIGFuIGFjdGl2ZSBjYWxsLqA8L2Rpdj4K
CjxkaXY+SGVyZSBJIG1hZGUgYSBwYXN0ZWJpbiBvZiBvRm9ubyBkYWVtb24uIC2gPGEgaHJlZj0i
aHR0cDovL3Bhc3RlYmluLmNvbS9oOHg2dWsxZCI+aHR0cDovL3Bhc3RlYmluLmNvbS9oOHg2dWsx
ZDwvYT48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PldoZW4gSSBjYWxsIHRoZSBIYW5ndXAoKSBt
ZXRob2QsIEkgZ2V0IHRoZSBmb2xsb3dpbmcgb3JnLmZyZWVkZXNrdG9wLkRCdXMuRXJyb3IuTm9S
ZXBseS48L2Rpdj4KCjxkaXY+VGhlIHByb2JsZW0gaXMgcHJlc2VudCBhbHNvIHVzaW5nIGQtZmVl
dC4gQSB0aW1lb3V0IGV4cGlyZXMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5CeSB0aGUgd2F5
LCBpZiBJIHJldHJ5IHRvIGNhbGwgdGhlIG1ldGhvZCBhZ2FpbiBJIGdldDqgoG9yZy5vZm9uby5F
cnJvci5JblByb2dyZXNzLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Q291bGQgSSBoYXZlIG1p
c3NlZCBzb21ldGhpbmc/PC9kaXY+Cgo8ZGl2Pjxicj48L2Rpdj48ZGl2PklmIHlvdSByZXF1aXJl
IG1vcmUgaW5mb3JtYXRpb24sIHBsZWFzZSBsZXQgbWUga25vdy48L2Rpdj48ZGl2PlRoYW5rcy48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkJlc3QgUmVnYXJkcy48L2Rpdj48L2Rpdj4K

--===============3834517850630994737==--

