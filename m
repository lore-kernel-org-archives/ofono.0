Content-Type: multipart/mixed; boundary="===============5076285887144755365=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Thu, 31 Dec 2015 10:39:26 +0200
Message-ID: <CADnUhn1_HD+ZJ+X4F=pfY5RS=FHX7Eui3dY71-iPZOJiQcdrCQ@mail.gmail.com>
In-Reply-To: <CADnUhn1iurv551=GeaJpP23Jscpu9GDtcybPSZ4tTePrvS-NNA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5076285887144755365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Versions,
ofono 1.16
connman 1.28
I updated connman to 1.31, but din not make any difference.

Logs do not show any problems, but it seems that there is something wrong -
for instance:
These are now connman commands, but really I don't now find difference,
ofono seems now more or less integrated to connman. But it is fine to
forward me to connman mailing list as any feedback at all is fine..

> connmanctl connect cellular_244052161781216_context1
Error /net/connman/service/cellular_244052161781216_context1: Input/output
error

> connmanctl config cellular_244052161781216_context1 --autoconnect yes
Error cellular_244052161781216_context1: Invalid service

Thanks,
Matti

2015-12-30 12:31 GMT+02:00 matti kaasinen <matti.kaasinen@gmail.com>:

> Hi!
>
> Have anyone managed using newer version of Huawei 3131 (idVendor=3D12d1,
> idProduct=3D14fe pair) together with connman/ofono?
>
> Older version of Huawei 3131 registered nicely with cdc_ether and was
> shown as wired service and connected automatically with eth1 interface.
>
> ------------------
> Modeswitch:
> ------------------
> seems noticing modem as idVendor=3D12d1, idProduct=3D1506 device.
>
> -------------------------------------------------------------
> Connman seems creating wwan0 interface
> -------------------------------------------------------------
> connmand[349]: wwan0 {create} index 3 type 1 <ETHER>
> connmand[349]: wwan0 {update} flags 4098 <DOWN>
> connmand[349]: wwan0 {newlink} index 3 address 58:2C:80:13:92:63 mtu 1500
> connmand[349]: wwan0 {newlink} index 3 operstate 2 <DOWN>
> connmand[349]: Adding interface wwan0 [ cellular ]
>
> -----------
> usbcore:
> -----------
> usbcore: registered new interface driver usbserial
> usb-storage 2-1:1.5: USB Mass Storage device detected
> usbcore: registered new interface driver cdc_ncm
> usbcore: registered new interface driver cdc_wdm
> usbcore: registered new interface driver option
>
> -------------------------
> huawei_cdc_ncm:
> --------------------------
> huawei_cdc_ncm 2-1:1.1 wwan0: register 'huawei_cdc_ncm' at
> usb-musb-hdrc.1.auto-1, Huawei CDC NCM device, 58:2c:80:13:92:63
>
> -------------------------
> usbserial:
> --------------------------
> usbserial: USB Serial support registered for GSM modem (1-port)
> usb 2-1: GSM modem (1-port) converter now attached to ttyUSB0
> usb 2-1: GSM modem (1-port) converter now attached to ttyUSB1
> usb 2-1: GSM modem (1-port) converter now attached to ttyUSB2
>
> -------------------------
> ofono:
> --------------------------
> Modem and NDIS support (CDC support: NDIS port)
>
> Besides /dev/ttyUSBx ports there also exists /dev/cdc-wdm0
>
> Modem shows up with connmanctl technologies
> /net/connman/technology/cellular
>   Name =3D Cellular
>   Type =3D cellular
>   Powered =3D False
>   Connected =3D False
>   Tethering =3D False
>
> But it does not show as service
>
> It is required to make manual online-modem ofono test command to get
> cellular technology powered. Then it is also shown as service. Also fast
> blinking green sign switches to slow blinking blue sign.
>
> However, no interfaces are shown with ifconfig command nor any connection
> is made when etherenet is unplugged.
>
> Also no proggress is shown when
> connmanctl session connect --type cellular
> is made.
>
> Do anyone know what I miss?
>
> Thanks,
> Matti
>
> If so, what kernel modules should I have present?
>
>

--===============5076285887144755365==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj5WZXJzaW9ucyw8YnI+PC9kaXY+b2Zv
bm8gMS4xNjxicj48L2Rpdj5jb25ubWFuIDEuMjg8YnI+PC9kaXY+SSB1cGRhdGVkIGNvbm5tYW4g
dG8gMS4zMSwgYnV0IGRpbiBub3QgbWFrZSBhbnkgZGlmZmVyZW5jZS48YnI+PGJyPjwvZGl2Pkxv
Z3MgZG8gbm90IHNob3cgYW55IHByb2JsZW1zLCBidXQgaXQgc2VlbXMgdGhhdCB0aGVyZSBpcyBz
b21ldGhpbmcgd3JvbmcgLSBmb3IgaW5zdGFuY2U6PGJyPjxkaXY+VGhlc2UgYXJlIG5vdyBjb25u
bWFuIGNvbW1hbmRzLCBidXQgcmVhbGx5IEkgZG9uJiMzOTt0IG5vdyBmaW5kIGRpZmZlcmVuY2Us
IG9mb25vIHNlZW1zIG5vdyBtb3JlIG9yIGxlc3MgaW50ZWdyYXRlZCB0byBjb25ubWFuLiBCdXQg
aXQgaXMgZmluZSB0byBmb3J3YXJkIG1lIHRvIGNvbm5tYW4gbWFpbGluZyBsaXN0IGFzIGFueSBm
ZWVkYmFjayBhdCBhbGwgaXMgZmluZS4uPGJyPjwvZGl2PjxkaXY+PGJyPiZndDsgY29ubm1hbmN0
bCBjb25uZWN0IGNlbGx1bGFyXzI0NDA1MjE2MTc4MTIxNl9jb250ZXh0MTxicj5FcnJvciAvbmV0
L2Nvbm5tYW4vc2VydmljZS9jZWxsdWxhcl8yNDQwNTIxNjE3ODEyMTZfY29udGV4dDE6IElucHV0
L291dHB1dCBlcnJvcjxicj48YnI+Jmd0OyBjb25ubWFuY3RsIGNvbmZpZyBjZWxsdWxhcl8yNDQw
NTIxNjE3ODEyMTZfY29udGV4dDEgLS1hdXRvY29ubmVjdCB5ZXM8YnI+RXJyb3IgY2VsbHVsYXJf
MjQ0MDUyMTYxNzgxMjE2X2NvbnRleHQxOiBJbnZhbGlkIHNlcnZpY2U8YnI+PGJyPjwvZGl2Pjxk
aXY+VGhhbmtzLDxicj48L2Rpdj48ZGl2Pk1hdHRpPGJyPjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9
ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjIwMTUtMTItMzAgMTI6
MzEgR01UKzAyOjAwIG1hdHRpIGthYXNpbmVuIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0i
bWFpbHRvOm1hdHRpLmthYXNpbmVuQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1hdHRpLmth
YXNpbmVuQGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9Imdt
YWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mg
c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PkhpITxicj48
YnI+PC9kaXY+SGF2ZSBhbnlvbmUgbWFuYWdlZCB1c2luZyBuZXdlciB2ZXJzaW9uIG9mIEh1YXdl
aSAzMTMxIChpZFZlbmRvcj0xMmQxLCBpZFByb2R1Y3Q9MTRmZSBwYWlyKSB0b2dldGhlciB3aXRo
IGNvbm5tYW4vb2Zvbm8/PGJyPjxicj48L2Rpdj48ZGl2Pk9sZGVyIHZlcnNpb24gb2YgSHVhd2Vp
IDMxMzEgcmVnaXN0ZXJlZCBuaWNlbHkgd2l0aCBjZGNfZXRoZXIgYW5kIHdhcyBzaG93biBhcyB3
aXJlZCBzZXJ2aWNlIGFuZCBjb25uZWN0ZWQgYXV0b21hdGljYWxseSB3aXRoIGV0aDEgaW50ZXJm
YWNlLjxicj48YnI+PC9kaXY+PGRpdj4tLS0tLS0tLS0tLS0tLS0tLS08YnI+PGRpdj5Nb2Rlc3dp
dGNoOjxicj4tLS0tLS0tLS0tLS0tLS0tLS08YnI+c2VlbXMgbm90aWNpbmcgbW9kZW0gYXMgaWRW
ZW5kb3I9MTJkMSwgaWRQcm9kdWN0PTE1MDYgZGV2aWNlLiA8YnI+PC9kaXY+PC9kaXY+PGRpdj48
YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxicj48ZGl2PkNvbm5tYW4gc2VlbXMgY3JlYXRpbmcgd3dhbjAgaW50ZXJmYWNlPGJy
PjwvZGl2Pi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS08YnI+Y29ubm1hbmRbMzQ5XTogd3dhbjAge2NyZWF0ZX0gaW5kZXggMyB0eXBl
IDEgJmx0O0VUSEVSJmd0Ozxicj5jb25ubWFuZFszNDldOiB3d2FuMCB7dXBkYXRlfSBmbGFncyA0
MDk4ICZsdDtET1dOJmd0Ozxicj5jb25ubWFuZFszNDldOiB3d2FuMCB7bmV3bGlua30gaW5kZXgg
MyBhZGRyZXNzIDU4OjJDOjgwOjEzOjkyOjYzIG10dSAxNTAwPGJyPmNvbm5tYW5kWzM0OV06IHd3
YW4wIHtuZXdsaW5rfSBpbmRleCAzIG9wZXJzdGF0ZSAyICZsdDtET1dOJmd0Ozxicj5jb25ubWFu
ZFszNDldOiBBZGRpbmcgaW50ZXJmYWNlIHd3YW4wIFsgY2VsbHVsYXIgXTxicj48YnI+LS0tLS0t
LS0tLS08YnI+PC9kaXY+PGRpdj51c2Jjb3JlOiA8YnI+LS0tLS0tLS0tLS08YnI+dXNiY29yZTog
cmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1c2JzZXJpYWw8YnI+dXNiLXN0b3JhZ2Ug
Mi0xOjEuNTogVVNCIE1hc3MgU3RvcmFnZSBkZXZpY2UgZGV0ZWN0ZWQ8YnI+dXNiY29yZTogcmVn
aXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBjZGNfbmNtPGJyPnVzYmNvcmU6IHJlZ2lzdGVy
ZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgY2RjX3dkbTxicj51c2Jjb3JlOiByZWdpc3RlcmVkIG5l
dyBpbnRlcmZhY2UgZHJpdmVyIG9wdGlvbjxicj48YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LTxicj5odWF3ZWlfY2RjX25jbTogPGJyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPmh1
YXdlaV9jZGNfbmNtIDItMToxLjEgd3dhbjA6IHJlZ2lzdGVyICYjMzk7aHVhd2VpX2NkY19uY20m
IzM5OyBhdCB1c2ItbXVzYi1oZHJjLjEuYXV0by0xLCBIdWF3ZWkgQ0RDIE5DTSBkZXZpY2UsIDU4
OjJjOjgwOjEzOjkyOjYzPGJyPjxicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPnVzYnNl
cmlhbDogPGJyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPnVzYnNlcmlhbDogVVNCIFNl
cmlhbCBzdXBwb3J0IHJlZ2lzdGVyZWQgZm9yIEdTTSBtb2RlbSAoMS1wb3J0KTxicj51c2IgMi0x
OiBHU00gbW9kZW0gKDEtcG9ydCkgY29udmVydGVyIG5vdyBhdHRhY2hlZCB0byB0dHlVU0IwPGJy
PnVzYiAyLTE6IEdTTSBtb2RlbSAoMS1wb3J0KSBjb252ZXJ0ZXIgbm93IGF0dGFjaGVkIHRvIHR0
eVVTQjE8YnI+dXNiIDItMTogR1NNIG1vZGVtICgxLXBvcnQpIGNvbnZlcnRlciBub3cgYXR0YWNo
ZWQgdG8gdHR5VVNCMjxicj48YnI+PC9kaXY+PGRpdj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
PGJyPm9mb25vOjxicj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj5Nb2RlbSBhbmQgTkRJ
UyBzdXBwb3J0IChDREMgc3VwcG9ydDogTkRJUyBwb3J0KTxicj48YnI+PC9kaXY+PGRpdj5CZXNp
ZGVzIC9kZXYvdHR5VVNCeCBwb3J0cyB0aGVyZSBhbHNvIGV4aXN0cyAvZGV2L2NkYy13ZG0wPGJy
Pjxicj48L2Rpdj48ZGl2Pk1vZGVtIHNob3dzIHVwIHdpdGggY29ubm1hbmN0bCB0ZWNobm9sb2dp
ZXPCoCA8YnI+L25ldC9jb25ubWFuL3RlY2hub2xvZ3kvY2VsbHVsYXI8YnI+wqAgTmFtZSA9IENl
bGx1bGFyPGJyPsKgIFR5cGUgPSBjZWxsdWxhcjxicj7CoCBQb3dlcmVkID0gRmFsc2U8YnI+wqAg
Q29ubmVjdGVkID0gRmFsc2U8YnI+wqAgVGV0aGVyaW5nID0gRmFsc2U8YnI+PGJyPjwvZGl2Pjxk
aXY+QnV0IGl0IGRvZXMgbm90IHNob3cgYXMgc2VydmljZTxicj48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2Pkl0IGlzIHJlcXVpcmVkIHRvIG1ha2UgbWFudWFsIG9ubGluZS1tb2RlbSBvZm9ubyB0
ZXN0IGNvbW1hbmQgdG8gZ2V0IGNlbGx1bGFyIHRlY2hub2xvZ3kgcG93ZXJlZC4gVGhlbiBpdCBp
cyBhbHNvIHNob3duIGFzIHNlcnZpY2UuIEFsc28gZmFzdCBibGlua2luZyBncmVlbiBzaWduIHN3
aXRjaGVzIHRvIHNsb3cgYmxpbmtpbmcgYmx1ZSBzaWduLjxicj48YnI+PC9kaXY+PGRpdj5Ib3dl
dmVyLCBubyBpbnRlcmZhY2VzIGFyZSBzaG93biB3aXRoIGlmY29uZmlnIGNvbW1hbmQgbm9yIGFu
eSBjb25uZWN0aW9uIGlzIG1hZGUgd2hlbiBldGhlcmVuZXQgaXMgdW5wbHVnZ2VkLjxicj48YnI+
PC9kaXY+PGRpdj5BbHNvIG5vIHByb2dncmVzcyBpcyBzaG93biB3aGVuIDxicj48L2Rpdj48ZGl2
PmNvbm5tYW5jdGwgc2Vzc2lvbiBjb25uZWN0IC0tdHlwZSBjZWxsdWxhcjxicj48L2Rpdj48ZGl2
PmlzIG1hZGUuPGJyPjxicj48L2Rpdj48ZGl2PkRvIGFueW9uZSBrbm93IHdoYXQgSSBtaXNzPzxi
cj48YnI+PC9kaXY+PGRpdj5UaGFua3MsPGJyPjwvZGl2PjxkaXY+TWF0dGk8YnI+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5JZiBzbywgd2hhdCBrZXJuZWwgbW9kdWxlcyBzaG91bGQgSSBoYXZl
IHByZXNlbnQ/PGJyPjxicj48L2Rpdj48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rp
dj4K

--===============5076285887144755365==--

