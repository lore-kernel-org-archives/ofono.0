Content-Type: multipart/mixed; boundary="===============1950578965773338086=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: Telit driver implementation
Date: Tue, 16 Sep 2014 11:24:10 +0200
Message-ID: <541801BA.2080503@southpole.se>
In-Reply-To: <CAH4ZQwuiA7WpsGLBo_yvtumXR_8Phw6k5MWu-u2x0BXPWztrDQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1950578965773338086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/16/14 11:16, Enrico Sau wrote:
> Dear all,
> I need to use ofono on a Telit module (UE910). I tried to use he910
> plugin and atmodem driver and it seems to recognize the modem but,
> some of the interfaces does not work and I also need some more
> commands than the one exported by atmodem.
> This request is to ask what should I do? I'm currently starting to
> develop a new driver (telitmodem) with the interfaces I need.
> Is my behavior correct?

Since the UE910 is a member of the xE910 family and extremely similar to
the HE910 in functionality, it would be better to try to extend the
he910 driver to handle this device.

If you could provide a description of your problem and requirements,
then it might be easier to give you guidance:

i) what interfaces do not work?
ii) what commands do you require that are not exported?

The more info you can provide, the better.

/Jonas

--===============1950578965773338086==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDwvaGVhZD4KICA8
Ym9keSB0ZXh0PSIjMDAwMDAwIiBiZ2NvbG9yPSIjRkZGRkZGIj4KICAgIDxkaXYgY2xhc3M9Im1v
ei1jaXRlLXByZWZpeCI+T24gMDkvMTYvMTQgMTE6MTYsIEVucmljbyBTYXUgd3JvdGU6PGJyPgog
ICAgPC9kaXY+CiAgICA8YmxvY2txdW90ZQpjaXRlPSJtaWQ6Q0FINFpRd3VpQTdXcHNHTEJvX3l2
dHVtWFJfOFBodzZrNU1XdS11MngwQlhQV3p0ckRRQG1haWwuZ21haWwuY29tIgogICAgICB0eXBl
PSJjaXRlIj4KICAgICAgPGRpdiBkaXI9Imx0ciI+CiAgICAgICAgPGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIKICAgICAgICAgIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYi
PkRlYXIgYWxsLDwvZGl2PgogICAgICAgIDxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiCiAgICAg
ICAgICBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj5JIG5lZWQgdG8gdXNl
IG9mb25vIG9uCiAgICAgICAgICBhIFRlbGl0IG1vZHVsZSAoVUU5MTApLiBJIHRyaWVkIHRvIHVz
ZSBoZTkxMCBwbHVnaW4gYW5kCiAgICAgICAgICBhdG1vZGVtIGRyaXZlciBhbmQgaXQgc2VlbXMg
dG8gcmVjb2duaXplIHRoZSBtb2RlbSBidXQsIHNvbWUKICAgICAgICAgIG9mIHRoZSBpbnRlcmZh
Y2VzIGRvZXMgbm90IHdvcmsgYW5kIEkgYWxzbyBuZWVkIHNvbWUgbW9yZQogICAgICAgICAgY29t
bWFuZHMgdGhhbiB0aGUgb25lIGV4cG9ydGVkIGJ5IGF0bW9kZW0uPC9kaXY+CiAgICAgICAgPGRp
diBjbGFzcz0iZ21haWxfZGVmYXVsdCIKICAgICAgICAgIHN0eWxlPSJmb250LWZhbWlseTp2ZXJk
YW5hLHNhbnMtc2VyaWYiPlRoaXMgcmVxdWVzdCBpcyB0byBhc2sKICAgICAgICAgIHdoYXQgc2hv
dWxkIEkgZG8/IEknbSBjdXJyZW50bHkgc3RhcnRpbmcgdG8gZGV2ZWxvcCBhIG5ldwogICAgICAg
ICAgZHJpdmVyICh0ZWxpdG1vZGVtKSB3aXRoIHRoZSBpbnRlcmZhY2VzIEkgbmVlZC48L2Rpdj4K
ICAgICAgICA8ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IgogICAgICAgICAgc3R5bGU9ImZvbnQt
ZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SXMgbXkgYmVoYXZpb3IgY29ycmVjdD88L2Rpdj4K
ICAgICAgPC9kaXY+CiAgICA8L2Jsb2NrcXVvdGU+CiAgICA8YnI+CiAgICBTaW5jZSB0aGUgVUU5
MTAgaXMgYSBtZW1iZXIgb2YgdGhlIHhFOTEwIGZhbWlseSBhbmQgZXh0cmVtZWx5CiAgICBzaW1p
bGFyIHRvIHRoZSBIRTkxMCBpbiBmdW5jdGlvbmFsaXR5LCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8g
dHJ5IHRvCiAgICBleHRlbmQgdGhlIGhlOTEwIGRyaXZlciB0byBoYW5kbGUgdGhpcyBkZXZpY2Uu
PGJyPgogICAgPGJyPgogICAgSWYgeW91IGNvdWxkIHByb3ZpZGUgYSBkZXNjcmlwdGlvbiBvZiB5
b3VyIHByb2JsZW0gYW5kIHJlcXVpcmVtZW50cywKICAgIHRoZW4gaXQgbWlnaHQgYmUgZWFzaWVy
IHRvIGdpdmUgeW91IGd1aWRhbmNlOjxicj4KICAgIDxicj4KICAgIGkpIHdoYXQgaW50ZXJmYWNl
cyBkbyBub3Qgd29yaz88YnI+CiAgICBpaSkgd2hhdCBjb21tYW5kcyBkbyB5b3UgcmVxdWlyZSB0
aGF0IGFyZSBub3QgZXhwb3J0ZWQ/PGJyPgogICAgPGJyPgogICAgVGhlIG1vcmUgaW5mbyB5b3Ug
Y2FuIHByb3ZpZGUsIHRoZSBiZXR0ZXIuPGJyPgogICAgPGJyPgogICAgL0pvbmFzPGJyPgogIDwv
Ym9keT4KPC9odG1sPgo=

--===============1950578965773338086==--

