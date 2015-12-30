Content-Type: multipart/mixed; boundary="===============2288338373884305979=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Wed, 30 Dec 2015 12:31:04 +0200
Message-ID: <CADnUhn1iurv551=GeaJpP23Jscpu9GDtcybPSZ4tTePrvS-NNA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2288338373884305979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

Have anyone managed using newer version of Huawei 3131 (idVendor=3D12d1,
idProduct=3D14fe pair) together with connman/ofono?

Older version of Huawei 3131 registered nicely with cdc_ether and was shown
as wired service and connected automatically with eth1 interface.

------------------
Modeswitch:
------------------
seems noticing modem as idVendor=3D12d1, idProduct=3D1506 device.

-------------------------------------------------------------
Connman seems creating wwan0 interface
-------------------------------------------------------------
connmand[349]: wwan0 {create} index 3 type 1 <ETHER>
connmand[349]: wwan0 {update} flags 4098 <DOWN>
connmand[349]: wwan0 {newlink} index 3 address 58:2C:80:13:92:63 mtu 1500
connmand[349]: wwan0 {newlink} index 3 operstate 2 <DOWN>
connmand[349]: Adding interface wwan0 [ cellular ]

-----------
usbcore:
-----------
usbcore: registered new interface driver usbserial
usb-storage 2-1:1.5: USB Mass Storage device detected
usbcore: registered new interface driver cdc_ncm
usbcore: registered new interface driver cdc_wdm
usbcore: registered new interface driver option

-------------------------
huawei_cdc_ncm:
--------------------------
huawei_cdc_ncm 2-1:1.1 wwan0: register 'huawei_cdc_ncm' at
usb-musb-hdrc.1.auto-1, Huawei CDC NCM device, 58:2c:80:13:92:63

-------------------------
usbserial:
--------------------------
usbserial: USB Serial support registered for GSM modem (1-port)
usb 2-1: GSM modem (1-port) converter now attached to ttyUSB0
usb 2-1: GSM modem (1-port) converter now attached to ttyUSB1
usb 2-1: GSM modem (1-port) converter now attached to ttyUSB2

-------------------------
ofono:
--------------------------
Modem and NDIS support (CDC support: NDIS port)

Besides /dev/ttyUSBx ports there also exists /dev/cdc-wdm0

Modem shows up with connmanctl technologies
/net/connman/technology/cellular
  Name =3D Cellular
  Type =3D cellular
  Powered =3D False
  Connected =3D False
  Tethering =3D False

But it does not show as service

It is required to make manual online-modem ofono test command to get
cellular technology powered. Then it is also shown as service. Also fast
blinking green sign switches to slow blinking blue sign.

However, no interfaces are shown with ifconfig command nor any connection
is made when etherenet is unplugged.

Also no proggress is shown when
connmanctl session connect --type cellular
is made.

Do anyone know what I miss?

Thanks,
Matti

If so, what kernel modules should I have present?

--===============2288338373884305979==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PkhpITxicj48YnI+PC9kaXY+SGF2ZSBhbnlvbmUgbWFu
YWdlZCB1c2luZyBuZXdlciB2ZXJzaW9uIG9mIEh1YXdlaSAzMTMxIChpZFZlbmRvcj0xMmQxLCBp
ZFByb2R1Y3Q9MTRmZSBwYWlyKSB0b2dldGhlciB3aXRoIGNvbm5tYW4vb2Zvbm8/PGJyPjxicj48
L2Rpdj48ZGl2Pk9sZGVyIHZlcnNpb24gb2YgSHVhd2VpIDMxMzEgcmVnaXN0ZXJlZCBuaWNlbHkg
d2l0aCBjZGNfZXRoZXIgYW5kIHdhcyBzaG93biBhcyB3aXJlZCBzZXJ2aWNlIGFuZCBjb25uZWN0
ZWQgYXV0b21hdGljYWxseSB3aXRoIGV0aDEgaW50ZXJmYWNlLjxicj48YnI+PC9kaXY+PGRpdj4t
LS0tLS0tLS0tLS0tLS0tLS08YnI+PGRpdj5Nb2Rlc3dpdGNoOjxicj4tLS0tLS0tLS0tLS0tLS0t
LS08YnI+c2VlbXMgbm90aWNpbmcgbW9kZW0gYXMgaWRWZW5kb3I9MTJkMSwgaWRQcm9kdWN0PTE1
MDYgZGV2aWNlLiA8YnI+PC9kaXY+PC9kaXY+PGRpdj48YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj48ZGl2PkNvbm5tYW4g
c2VlbXMgY3JlYXRpbmcgd3dhbjAgaW50ZXJmYWNlPGJyPjwvZGl2Pi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+Y29ubm1hbmRb
MzQ5XTogd3dhbjAge2NyZWF0ZX0gaW5kZXggMyB0eXBlIDEgJmx0O0VUSEVSJmd0Ozxicj5jb25u
bWFuZFszNDldOiB3d2FuMCB7dXBkYXRlfSBmbGFncyA0MDk4ICZsdDtET1dOJmd0Ozxicj5jb25u
bWFuZFszNDldOiB3d2FuMCB7bmV3bGlua30gaW5kZXggMyBhZGRyZXNzIDU4OjJDOjgwOjEzOjky
OjYzIG10dSAxNTAwPGJyPmNvbm5tYW5kWzM0OV06IHd3YW4wIHtuZXdsaW5rfSBpbmRleCAzIG9w
ZXJzdGF0ZSAyICZsdDtET1dOJmd0Ozxicj5jb25ubWFuZFszNDldOiBBZGRpbmcgaW50ZXJmYWNl
IHd3YW4wIFsgY2VsbHVsYXIgXTxicj48YnI+LS0tLS0tLS0tLS08YnI+PC9kaXY+PGRpdj51c2Jj
b3JlOiA8YnI+LS0tLS0tLS0tLS08YnI+dXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNl
IGRyaXZlciB1c2JzZXJpYWw8YnI+dXNiLXN0b3JhZ2UgMi0xOjEuNTogVVNCIE1hc3MgU3RvcmFn
ZSBkZXZpY2UgZGV0ZWN0ZWQ8YnI+dXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRy
aXZlciBjZGNfbmNtPGJyPnVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIg
Y2RjX3dkbTxicj51c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIG9wdGlv
bjxicj48YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj5odWF3ZWlfY2RjX25jbTogPGJy
Pi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPmh1YXdlaV9jZGNfbmNtIDItMToxLjEgd3dh
bjA6IHJlZ2lzdGVyICYjMzk7aHVhd2VpX2NkY19uY20mIzM5OyBhdCB1c2ItbXVzYi1oZHJjLjEu
YXV0by0xLCBIdWF3ZWkgQ0RDIE5DTSBkZXZpY2UsIDU4OjJjOjgwOjEzOjkyOjYzPGJyPjxicj4t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPnVzYnNlcmlhbDogPGJyPi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tPGJyPnVzYnNlcmlhbDogVVNCIFNlcmlhbCBzdXBwb3J0IHJlZ2lzdGVyZWQg
Zm9yIEdTTSBtb2RlbSAoMS1wb3J0KTxicj51c2IgMi0xOiBHU00gbW9kZW0gKDEtcG9ydCkgY29u
dmVydGVyIG5vdyBhdHRhY2hlZCB0byB0dHlVU0IwPGJyPnVzYiAyLTE6IEdTTSBtb2RlbSAoMS1w
b3J0KSBjb252ZXJ0ZXIgbm93IGF0dGFjaGVkIHRvIHR0eVVTQjE8YnI+dXNiIDItMTogR1NNIG1v
ZGVtICgxLXBvcnQpIGNvbnZlcnRlciBub3cgYXR0YWNoZWQgdG8gdHR5VVNCMjxicj48YnI+PC9k
aXY+PGRpdj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPm9mb25vOjxicj4tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLTxicj5Nb2RlbSBhbmQgTkRJUyBzdXBwb3J0IChDREMgc3VwcG9ydDog
TkRJUyBwb3J0KTxicj48YnI+PC9kaXY+PGRpdj5CZXNpZGVzIC9kZXYvdHR5VVNCeCBwb3J0cyB0
aGVyZSBhbHNvIGV4aXN0cyAvZGV2L2NkYy13ZG0wPGJyPjxicj48L2Rpdj48ZGl2Pk1vZGVtIHNo
b3dzIHVwIHdpdGggY29ubm1hbmN0bCB0ZWNobm9sb2dpZXPCoCA8YnI+L25ldC9jb25ubWFuL3Rl
Y2hub2xvZ3kvY2VsbHVsYXI8YnI+wqAgTmFtZSA9IENlbGx1bGFyPGJyPsKgIFR5cGUgPSBjZWxs
dWxhcjxicj7CoCBQb3dlcmVkID0gRmFsc2U8YnI+wqAgQ29ubmVjdGVkID0gRmFsc2U8YnI+wqAg
VGV0aGVyaW5nID0gRmFsc2U8YnI+PGJyPjwvZGl2PjxkaXY+QnV0IGl0IGRvZXMgbm90IHNob3cg
YXMgc2VydmljZTxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkl0IGlzIHJlcXVpcmVkIHRv
IG1ha2UgbWFudWFsIG9ubGluZS1tb2RlbSBvZm9ubyB0ZXN0IGNvbW1hbmQgdG8gZ2V0IGNlbGx1
bGFyIHRlY2hub2xvZ3kgcG93ZXJlZC4gVGhlbiBpdCBpcyBhbHNvIHNob3duIGFzIHNlcnZpY2Uu
IEFsc28gZmFzdCBibGlua2luZyBncmVlbiBzaWduIHN3aXRjaGVzIHRvIHNsb3cgYmxpbmtpbmcg
Ymx1ZSBzaWduLjxicj48YnI+PC9kaXY+PGRpdj5Ib3dldmVyLCBubyBpbnRlcmZhY2VzIGFyZSBz
aG93biB3aXRoIGlmY29uZmlnIGNvbW1hbmQgbm9yIGFueSBjb25uZWN0aW9uIGlzIG1hZGUgd2hl
biBldGhlcmVuZXQgaXMgdW5wbHVnZ2VkLjxicj48YnI+PC9kaXY+PGRpdj5BbHNvIG5vIHByb2dn
cmVzcyBpcyBzaG93biB3aGVuIDxicj48L2Rpdj48ZGl2PmNvbm5tYW5jdGwgc2Vzc2lvbiBjb25u
ZWN0IC0tdHlwZSBjZWxsdWxhcjxicj48L2Rpdj48ZGl2PmlzIG1hZGUuPGJyPjxicj48L2Rpdj48
ZGl2PkRvIGFueW9uZSBrbm93IHdoYXQgSSBtaXNzPzxicj48YnI+PC9kaXY+PGRpdj5UaGFua3Ms
PGJyPjwvZGl2PjxkaXY+TWF0dGk8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JZiBzbywg
d2hhdCBrZXJuZWwgbW9kdWxlcyBzaG91bGQgSSBoYXZlIHByZXNlbnQ/PGJyPjxicj48L2Rpdj48
L2Rpdj4K

--===============2288338373884305979==--

