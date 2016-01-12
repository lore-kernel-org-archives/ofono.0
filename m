Content-Type: multipart/mixed; boundary="===============3879272091038855794=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Tue, 12 Jan 2016 11:40:18 +0200
Message-ID: <CADnUhn0-4OM6PFyxPMBLxSpsVbq+gbBDJr=qYsV4MHyJfc58qQ@mail.gmail.com>
In-Reply-To: <CADnUhn1W9XNrLTZb+7MV1MaDY-U9Ye=4RCN9wBwCZ=JmDCKm2w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3879272091038855794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I tried without option drivers. Ofono logs looked very similar to those of
the old Huawei 3131. Main exception was that old uses interface eth1 and
new wwan0. The main difference, however,  is that there is no traffic with
the new modem.

Modem management commands do not work if option driver is not loaded (for
example online-modem). On the other hand this seems the case with the old
modem, too. Connmanctl services command lists old modem as Wired service
and new is not listed at all if these option drivers are not present.

-Matti

2016-01-12 10:47 GMT+02:00 matti kaasinen <matti.kaasinen@gmail.com>:

>
> 2016-01-12 10:38 GMT+02:00 matti kaasinen <matti.kaasinen@gmail.com>:
>
>> Note that driver listed is not kernel drive, like with new 3131 but most
>> likely ofono driver - at least it is not listed with lsmod.
>
>
>
> Now I was not careful enough. Modem was created exactly as before -
> check_usb_device() reported kernel module and create_modem() reported
> huawei.
>

--===============3879272091038855794==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PkkgdHJpZWQgd2l0aG91dCBvcHRpb24gZHJpdmVycy4g
T2Zvbm8gbG9ncyBsb29rZWQgdmVyeSBzaW1pbGFyIHRvIHRob3NlIG9mIHRoZSBvbGQgSHVhd2Vp
IDMxMzEuIE1haW4gZXhjZXB0aW9uIHdhcyB0aGF0IG9sZCB1c2VzIGludGVyZmFjZSBldGgxIGFu
ZCBuZXcgd3dhbjAuIFRoZSBtYWluIGRpZmZlcmVuY2UsIGhvd2V2ZXIswqAgaXMgdGhhdCB0aGVy
ZSBpcyBubyB0cmFmZmljIHdpdGggdGhlIG5ldyBtb2RlbS4gPGJyPjxicj48L2Rpdj5Nb2RlbSBt
YW5hZ2VtZW50IGNvbW1hbmRzIGRvIG5vdCB3b3JrIGlmIG9wdGlvbiBkcml2ZXIgaXMgbm90IGxv
YWRlZCAoZm9yIGV4YW1wbGUgb25saW5lLW1vZGVtKS4gT24gdGhlIG90aGVyIGhhbmQgdGhpcyBz
ZWVtcyB0aGUgY2FzZSB3aXRoIHRoZSBvbGQgbW9kZW0sIHRvby4gQ29ubm1hbmN0bCBzZXJ2aWNl
cyBjb21tYW5kIGxpc3RzIG9sZCBtb2RlbSBhcyBXaXJlZCBzZXJ2aWNlIGFuZCBuZXcgaXMgbm90
IGxpc3RlZCBhdCBhbGwgaWYgdGhlc2Ugb3B0aW9uIGRyaXZlcnMgYXJlIG5vdCBwcmVzZW50Ljxi
cj48YnI+PC9kaXY+LU1hdHRpPGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+
PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjIwMTYtMDEtMTIgMTA6NDcgR01UKzAyOjAwIG1hdHRp
IGthYXNpbmVuIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOm1hdHRpLmthYXNp
bmVuQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1hdHRpLmthYXNpbmVuQGdtYWlsLmNvbTwv
YT4mZ3Q7PC9zcGFuPjo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0
OjFleCI+PGRpdiBkaXI9Imx0ciI+PHNwYW4gY2xhc3M9IiI+PGRpdiBjbGFzcz0iZ21haWxfZXh0
cmEiPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxNi0wMS0xMiAxMDozOCBHTVQrMDI6
MDAgbWF0dGkga2Fhc2luZW4gPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bWF0
dGkua2Fhc2luZW5AZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bWF0dGkua2Fhc2luZW5AZ21h
aWwuY29tPC9hPiZndDs8L3NwYW4+Ojxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRk
aW5nLWxlZnQ6MWV4Ij5Ob3RlIHRoYXQgZHJpdmVyIGxpc3RlZCBpcyBub3Qga2VybmVsIGRyaXZl
LCBsaWtlIHdpdGggbmV3IDMxMzEgYnV0IG1vc3QgbGlrZWx5IG9mb25vIGRyaXZlciAtIGF0IGxl
YXN0IGl0IGlzIG5vdCBsaXN0ZWQgd2l0aCBsc21vZC4gPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48
YnI+PC9kaXY+PC9zcGFuPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj5Ob3cgSSB3YXMgbm90IGNh
cmVmdWwgZW5vdWdoLiBNb2RlbSB3YXMgY3JlYXRlZCBleGFjdGx5IGFzIGJlZm9yZSAtIGNoZWNr
X3VzYl9kZXZpY2UoKSByZXBvcnRlZCBrZXJuZWwgbW9kdWxlIGFuZCBjcmVhdGVfbW9kZW0oKSBy
ZXBvcnRlZCBodWF3ZWkuPGJyPjwvZGl2PjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwv
ZGl2Pgo=

--===============3879272091038855794==--

