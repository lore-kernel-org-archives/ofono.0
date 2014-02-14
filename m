Content-Type: multipart/mixed; boundary="===============3587853351546975425=="
MIME-Version: 1.0
From: Homam Dabis <hdabis@digisoft.tv>
Subject: How does ofono work
Date: Fri, 14 Feb 2014 17:16:24 +0000
Message-ID: <CAK+sfov2mrkyta6aSn2nzu+p=EFMJWK4gC3ZmuR1JNgCmVOmKA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3587853351546975425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I have a problem in that my Huawei E303 is not being properly detected by
ofono i.e GetModems returns an empty array.

It is working well on Ubuntu (linux 3.2.0-58-generic) but not on my
embedded SIgma platform (linux 2.6.35)

The option driver/usbserial driver seem to be correctly loaded. mode switch
is also ok as the USB serial devices seem to be created ok.

I am using ofono 1.14.

Ofono detects that ttyUSB0,1,2 are available and calls add_modem.

As my setup is not normal, I am now trying to debug the system myself.

On the Sigma platform, it seems like the huawei plugin functions in
huawei.c are not being called as on the ubuntu platform.

So the question is how are those functions in huawei.c being called?

Any explanation would be greatly appreciated.

Homam

--===============3587853351546975425==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgaGF2ZSBh
IHByb2JsZW0gaW4gdGhhdCBteSBIdWF3ZWkgRTMwMyBpcyBub3QgYmVpbmcgcHJvcGVybHkgZGV0
ZWN0ZWQgYnkgb2Zvbm8gaS5lIEdldE1vZGVtcyByZXR1cm5zIGFuIGVtcHR5IGFycmF5LjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+SXQgaXMgd29ya2luZyB3ZWxsIG9uIFVidW50dSAobGludXgg
My4yLjAtNTgtZ2VuZXJpYykgYnV0IG5vdCBvbiBteSBlbWJlZGRlZCBTSWdtYSBwbGF0Zm9ybSAo
bGludXggMi42LjM1KTxicj4KPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGUgb3B0aW9uIGRy
aXZlci91c2JzZXJpYWwgZHJpdmVyIHNlZW0gdG8gYmUgY29ycmVjdGx5IGxvYWRlZC4gbW9kZSBz
d2l0Y2ggaXMgYWxzbyBvayBhcyB0aGUgVVNCIHNlcmlhbCBkZXZpY2VzIHNlZW0gdG8gYmUgY3Jl
YXRlZCBvay48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgYW0gdXNpbmcgb2Zvbm8gMS4xNC48
L2Rpdj48ZGl2Pjxicj4KPC9kaXY+PGRpdj5PZm9ubyBkZXRlY3RzIHRoYXQgdHR5VVNCMCwxLDIg
YXJlIGF2YWlsYWJsZSBhbmQgY2FsbHMgYWRkX21vZGVtLjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+QXMgbXkgc2V0dXAgaXMgbm90IG5vcm1hbCwgSSBhbSBub3cgdHJ5aW5nIHRvIGRlYnVnIHRo
ZSBzeXN0ZW0gbXlzZWxmLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+T24gdGhlIFNpZ21hIHBs
YXRmb3JtLCBpdCBzZWVtcyBsaWtlIHRoZSBodWF3ZWkgcGx1Z2luIGZ1bmN0aW9uc6BpbiBodWF3
ZWkuYyBhcmUgbm90IGJlaW5nIGNhbGxlZCBhcyBvbiB0aGUgdWJ1bnR1IHBsYXRmb3JtLjwvZGl2
Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2PlNvIHRoZSBxdWVzdGlvbiBpcyBob3cgYXJlIHRob3NlIGZ1
bmN0aW9ucyBpbiBodWF3ZWkuYyBiZWluZyBjYWxsZWQ/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5BbnkgZXhwbGFuYXRpb24gd291bGQgYmUgZ3JlYXRseSBhcHByZWNpYXRlZC48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PkhvbWFtIKA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PqA8L2Rpdj4K
PGRpdiBkaXI9Imx0ciI+PHNwYW4+PC9zcGFuPjxzcGFuPjwvc3Bhbj48YnI+PGRpdj48YnI+PC9k
aXY+PC9kaXY+CjwvZGl2Pgo=

--===============3587853351546975425==--

