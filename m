Content-Type: multipart/mixed; boundary="===============1619218472305797877=="
MIME-Version: 1.0
From: Etienne Mabille <mabille.etienne@gmail.com>
Subject: Setting up the Telit HE910 and Option GTM382
Date: Fri, 05 Apr 2013 11:47:19 +0200
Message-ID: <CAMtf1D-Ryk3EcxT9UfcnFHBje-5WM3gdR4C6jtAOgDxN_vpxiw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1619218472305797877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I am trying to have two modems working at the same time with ofono : one is
the Telit HE910, and the other one is the Option GTM382.
Both of them work fine when plugged alone, but if I use them both at the
same time,the initialization seems to stop during the telit_enable phase.
I am using ofono-1.3, I applied the several patches released in the
meantime to support the Telit modems including the latest
series patches "Telit plugin rework for HE910".
Here is the debug log from ofono :

ofonod[1789]: src/modem.c:ofono_modem_create() name: (null), type: telit
ofonod[1789]: plugins/udevng.c:setup_telit()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-6
ofonod[1789]: plugins/udevng.c:setup_telit() /dev/ttyACM1 2/2/1 00 (null)
Telit Wireless Module Modem
ofonod[1789]: plugins/udevng.c:setup_telit() /dev/ttyACM2 2/2/1 02 (null)
(null)
ofonod[1789]: plugins/udevng.c:setup_telit() /dev/ttyACM3 2/2/1 04 (null)
(null)
ofonod[1789]: plugins/udevng.c:setup_telit() /dev/ttyACM4 2/2/1 06 (null)
(null)
ofonod[1789]: plugins/udevng.c:setup_telit() /dev/ttyACM5 2/2/1 08 (null)
(null)
ofonod[1789]: plugins/udevng.c:setup_telit() /dev/ttyACM6 2/2/1 0a (null)
(null)
ofonod[1789]: plugins/udevng.c:setup_telit() /dev/ttyACM7 2/2/1 0c (null)
(null)
ofonod[1789]: plugins/udevng.c:setup_telit() modem=3D/dev/ttyACM1
aux=3D/dev/ttyACM4 gps=3D(null) diag=3D/dev/ttyACM2
ofonod[1789]: src/modem.c:set_modem_property() modem 0x8d27150 property
Modem
ofonod[1789]: src/modem.c:set_modem_property() modem 0x8d27150 property Aux
ofonod[1789]: src/modem.c:set_modem_property() modem 0x8d27150 property GPS
ofonod[1789]: src/modem.c:ofono_modem_register() 0x8d27150
ofonod[1789]: plugins/telit.c:telit_probe() 0x8d27150
ofonod[1789]: src/modem.c:emit_modem_added() 0x8d27150
ofonod[1789]: src/modem.c:get_modem_property() modem 0x8d27150 property
NetworkInterface
ofonod[1789]: src/modem.c:get_modem_property() modem 0x8d27150 property
SysPath
ofonod[1789]: src/modem.c:__ofono_modem_append_properties() Ifname (null)
ofonod[1789]: src/modem.c:call_modemwatches() 0x8d27150 added:1
ofonod[1789]: plugins/smart-messaging.c:modem_watch() modem: 0x8d27150,
added: 1
ofonod[1789]: plugins/push-notification.c:modem_watch() modem: 0x8d27150,
added: 1
ofonod[1789]: plugins/udevng.c:create_modem()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-1
ofonod[1789]: plugins/udevng.c:create_modem() driver=3Dhso
ofonod[1789]: src/modem.c:ofono_modem_create() name: (null), type: hso
ofonod[1789]: plugins/udevng.c:setup_hso()
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-1
ofonod[1789]: plugins/udevng.c:setup_hso() /dev/ttyHS0 255/255/255 00
(null) Diagnostic
ofonod[1789]: plugins/udevng.c:setup_hso() /dev/ttyHS1 255/255/255 01
(null) GPS
ofonod[1789]: plugins/udevng.c:setup_hso() /dev/ttyHS2 255/255/255 02
(null) GPS Control
ofonod[1789]: plugins/udevng.c:setup_hso() /dev/ttyHS3 255/255/255 03
(null) Application
ofonod[1789]: plugins/udevng.c:setup_hso() /dev/ttyHS4 255/255/255 06
(null) Control
ofonod[1789]: plugins/udevng.c:setup_hso() /dev/ttyHS5 255/255/255 09
(null) Modem
ofonod[1789]: plugins/udevng.c:setup_hso() control=3D/dev/ttyHS4
application=3D/dev/ttyHS3 modem=3D/dev/ttyHS5 network=3D(null)
ofonod[1789]: src/modem.c:set_modem_property() modem 0x8d27718 property
Control
ofonod[1789]: src/modem.c:set_modem_property() modem 0x8d27718 property
Application
ofonod[1789]: src/modem.c:set_modem_property() modem 0x8d27718 property
Modem
ofonod[1789]: src/modem.c:set_modem_property() modem 0x8d27718 property
NetworkInterface
ofonod[1789]: src/modem.c:ofono_modem_register() 0x8d27718
ofonod[1789]: plugins/hso.c:hso_probe() 0x8d27718
ofonod[1789]: src/modem.c:emit_modem_added() 0x8d27718
ofonod[1789]: src/modem.c:get_modem_property() modem 0x8d27718 property
NetworkInterface
ofonod[1789]: src/modem.c:get_modem_property() modem 0x8d27718 property
SysPath
ofonod[1789]: src/modem.c:__ofono_modem_append_properties() Ifname (null)
ofonod[1789]: src/modem.c:call_modemwatches() 0x8d27718 added:1
ofonod[1789]: plugins/smart-messaging.c:modem_watch() modem: 0x8d27718,
added: 1
ofonod[1789]: plugins/push-notification.c:modem_watch() modem: 0x8d27718,
added: 1
ofonod[1789]: src/modem.c:get_modem_property() modem 0x8d27718 property
NetworkInterface
ofonod[1789]: src/modem.c:get_modem_property() modem 0x8d27718 property
SysPath
ofonod[1789]: src/modem.c:__ofono_modem_append_properties() Ifname (null)
ofonod[1789]: src/modem.c:get_modem_property() modem 0x8d27150 property
NetworkInterface
ofonod[1789]: src/modem.c:get_modem_property() modem 0x8d27150 property
SysPath
ofonod[1789]: src/modem.c:__ofono_modem_append_properties() Ifname (null)
ofonod[1789]: src/modem.c:get_modem_property() modem 0x8d27718 property
NetworkInterface
ofonod[1789]: src/modem.c:get_modem_property() modem 0x8d27718 property
SysPath
ofonod[1789]: src/modem.c:__ofono_modem_append_properties() Ifname (null)
ofonod[1789]: src/modem.c:get_modem_property() modem 0x8d27150 property
NetworkInterface
ofonod[1789]: src/modem.c:get_modem_property() modem 0x8d27150 property
SysPath
ofonod[1789]: src/modem.c:__ofono_modem_append_properties() Ifname (null)
ofonod[1789]: plugins/telit.c:telit_enable() 0x8d27150
ofonod[1789]: src/modem.c:get_modem_property() modem 0x8d27150 property
Modem
ofonod[1789]: plugins/telit.c:open_device() Modem /dev/ttyACM1


I also used gdbserver to find out where the problem is. Here is the
backtrace from where i think the failure is :

   =E2=94=82230                     }
   =E2=94=82231             }
   =E2=94=82232
 >=E2=94=82233             fd =3D open(tty, O_RDWR | O_NOCTTY |
O_NONBLOCK);               /* the open function fails and returns -1 */
   =E2=94=82234             if (fd < 0)
   =E2=94=82235                     return -1;
   =E2=94=82236
   =E2=94=82237             tcflush(fd, TCIOFLUSH);

#0  open_device (tty=3D0x8d27e08 "/dev/ttyACM1", options=3D0x8d1dbb0) at
gatchat/gattty.c:233
#1  g_at_tty_open (tty=3D0x8d27e08 "/dev/ttyACM1", options=3D0x8d1dbb0) at
gatchat/gattty.c:248
#2  0x080bd823 in open_device (modem=3D<value optimized out>, key=3D<value
optimized out>, debug=3D0x81227a8 "Modem: ")
    at plugins/telit.c:210
#3  0x080bd8f3 in telit_enable (modem=3D0x8d27150) at plugins/telit.c:386
#4  0x080c0982 in set_powered (modem=3D0x8d27150, powered=3D1) at
src/modem.c:885
#5  0x080c19fc in modem_set_property (conn=3D0x8d1f178, msg=3D0x8d2bca0,
data=3D0x8d27150) at src/modem.c:1097
#6  0x08054e14 in process_message (connection=3D0x8d1f178,
message=3D0xbf834460, method=3D0x8d2b614,
    iface_user_data=3D0x8d27150) at gdbus/object.c:224
#7  0xb77e12b2 in ?? ()
#8  0xb77d6544 in ?? ()
#9  0x08053bd0 in message_dispatch (data=3D0xb77f8ff4) at gdbus/mainloop.c:=
80
#10 0xb782d829 in ?? ()
#11 0xb782cf7d in ?? ()
#12 0xb782efee in ?? ()
#13 0xb783003e in ?? ()
#14 0x080bf1ff in main (argc=3D1, argv=3D0xbf834a54) at src/main.c:260

Here is what I have got so far...
I don't understand why this open fails when the Option is plugged in since
they don't use the same device ports (ttyACM? for HE910, and ttyHS? for
GTM382)
Thanks in advance for your help,

Etienne Mabille

--===============1619218472305797877==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj5JIGFtIHRyeWluZyB0byBoYXZlIHR3
byBtb2RlbXMgd29ya2luZyBhdCB0aGUgc2FtZSB0aW1lIHdpdGggb2Zvbm8gOgogb25lIGlzIHRo
ZSBUZWxpdCBIRTkxMCwgYW5kIHRoZSBvdGhlciBvbmUgaXMgdGhlIE9wdGlvbiBHVE0zODIuPGJy
PjwvZGl2PjxkaXY+Qm90aCBvZiB0aGVtIHdvcmsgZmluZSB3aGVuIHBsdWdnZWQgYWxvbmUsIGJ1
dCBpZiBJIHVzZSB0aGVtIGJvdGggYXQgdGhlIHNhbWUgdGltZSx0aGUgaW5pdGlhbGl6YXRpb24g
c2VlbXMgdG8gc3RvcCBkdXJpbmcgdGhlIHRlbGl0X2VuYWJsZSBwaGFzZS48YnI+CkkgYW0gdXNp
bmcgb2Zvbm8tMS4zLCBJIGFwcGxpZWQgdGhlIHNldmVyYWwgcGF0Y2hlcyByZWxlYXNlZCBpbiB0
aGUgbWVhbnRpbWUgdG8gc3VwcG9ydCB0aGUgVGVsaXQgbW9kZW1zIGluY2x1ZGluZyB0aGUgbGF0
ZXN0IDxicj5zZXJpZXMgcGF0Y2hlcyAmcXVvdDtUZWxpdCBwbHVnaW4gcmV3b3JrIGZvciBIRTkx
MCZxdW90Oy48YnI+SGVyZSBpcyB0aGUgZGVidWcgbG9nIGZyb20gb2Zvbm8gOjxicj4KPGJyPm9m
b25vZFsxNzg5XTogc3JjL21vZGVtLmM6b2Zvbm9fbW9kZW1fY3JlYXRlKCkgbmFtZTogKG51bGwp
LCB0eXBlOiB0ZWxpdDxicj4KCm9mb25vZFsxNzg5XTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF90
ZWxpdCgpIC9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWQuNy91c2IxLzEtNjxicj5v
Zm9ub2RbMTc4OV06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfdGVsaXQoKSAvZGV2L3R0eUFDTTEg
Mi8yLzEgMDAgKG51bGwpIFRlbGl0IFdpcmVsZXNzIE1vZHVsZSBNb2RlbTxicj5vZm9ub2RbMTc4
OV06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfdGVsaXQoKSAvZGV2L3R0eUFDTTIgMi8yLzEgMDIg
KG51bGwpIChudWxsKTxicj4KCgpvZm9ub2RbMTc4OV06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBf
dGVsaXQoKSAvZGV2L3R0eUFDTTMgMi8yLzEgMDQgKG51bGwpIChudWxsKTxicj5vZm9ub2RbMTc4
OV06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfdGVsaXQoKSAvZGV2L3R0eUFDTTQgMi8yLzEgMDYg
KG51bGwpIChudWxsKTxicj5vZm9ub2RbMTc4OV06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfdGVs
aXQoKSAvZGV2L3R0eUFDTTUgMi8yLzEgMDggKG51bGwpIChudWxsKTxicj4KCgpvZm9ub2RbMTc4
OV06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfdGVsaXQoKSAvZGV2L3R0eUFDTTYgMi8yLzEgMGEg
KG51bGwpIChudWxsKTxicj5vZm9ub2RbMTc4OV06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfdGVs
aXQoKSAvZGV2L3R0eUFDTTcgMi8yLzEgMGMgKG51bGwpIChudWxsKTxicj5vZm9ub2RbMTc4OV06
IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfdGVsaXQoKSBtb2RlbT0vZGV2L3R0eUFDTTEgYXV4PS9k
ZXYvdHR5QUNNNCBncHM9KG51bGwpIGRpYWc9L2Rldi90dHlBQ00yPGJyPgoKCm9mb25vZFsxNzg5
XTogc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4ZDI3MTUwIHByb3Bl
cnR5IE1vZGVtPGJyPm9mb25vZFsxNzg5XTogc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5
KCkgbW9kZW0gMHg4ZDI3MTUwIHByb3BlcnR5IEF1eDxicj5vZm9ub2RbMTc4OV06IHNyYy9tb2Rl
bS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OGQyNzE1MCBwcm9wZXJ0eSBHUFM8YnI+
CgoKb2Zvbm9kWzE3ODldOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9yZWdpc3RlcigpIDB4OGQy
NzE1MDxicj5vZm9ub2RbMTc4OV06IHBsdWdpbnMvdGVsaXQuYzp0ZWxpdF9wcm9iZSgpIDB4OGQy
NzE1MDxicj5vZm9ub2RbMTc4OV06IHNyYy9tb2RlbS5jOmVtaXRfbW9kZW1fYWRkZWQoKSAweDhk
MjcxNTA8YnI+b2Zvbm9kWzE3ODldOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBt
b2RlbSAweDhkMjcxNTAgcHJvcGVydHkgTmV0d29ya0ludGVyZmFjZTxicj4KCgpvZm9ub2RbMTc4
OV06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OGQyNzE1MCBwcm9w
ZXJ0eSBTeXNQYXRoPGJyPm9mb25vZFsxNzg5XTogc3JjL21vZGVtLmM6X19vZm9ub19tb2RlbV9h
cHBlbmRfcHJvcGVydGllcygpIElmbmFtZSAobnVsbCk8YnI+b2Zvbm9kWzE3ODldOiBzcmMvbW9k
ZW0uYzpjYWxsX21vZGVtd2F0Y2hlcygpIDB4OGQyNzE1MCBhZGRlZDoxPGJyPgoKCm9mb25vZFsx
Nzg5XTogcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzptb2RlbV93YXRjaCgpIG1vZGVtOiAweDhk
MjcxNTAsIGFkZGVkOiAxPGJyPm9mb25vZFsxNzg5XTogcGx1Z2lucy9wdXNoLW5vdGlmaWNhdGlv
bi5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4OGQyNzE1MCwgYWRkZWQ6IDE8YnI+b2Zvbm9kWzE3
ODldOiBwbHVnaW5zL3VkZXZuZy5jOmNyZWF0ZV9tb2RlbSgpIC9zeXMvZGV2aWNlcy9wY2kwMDAw
OjAwLzAwMDA6MDA6MWQuNy91c2IxLzEtMTxicj4KCgpvZm9ub2RbMTc4OV06IHBsdWdpbnMvdWRl
dm5nLmM6Y3JlYXRlX21vZGVtKCkgZHJpdmVyPWhzbzxicj5vZm9ub2RbMTc4OV06IHNyYy9tb2Rl
bS5jOm9mb25vX21vZGVtX2NyZWF0ZSgpIG5hbWU6IChudWxsKSwgdHlwZTogaHNvPGJyPm9mb25v
ZFsxNzg5XTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9oc28oKSAvc3lzL2RldmljZXMvcGNpMDAw
MDowMC8wMDAwOjAwOjFkLjcvdXNiMS8xLTE8YnI+CgoKb2Zvbm9kWzE3ODldOiBwbHVnaW5zL3Vk
ZXZuZy5jOnNldHVwX2hzbygpIC9kZXYvdHR5SFMwIDI1NS8yNTUvMjU1IDAwIChudWxsKSBEaWFn
bm9zdGljPGJyPm9mb25vZFsxNzg5XTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9oc28oKSAvZGV2
L3R0eUhTMSAyNTUvMjU1LzI1NSAwMSAobnVsbCkgR1BTPGJyPm9mb25vZFsxNzg5XTogcGx1Z2lu
cy91ZGV2bmcuYzpzZXR1cF9oc28oKSAvZGV2L3R0eUhTMiAyNTUvMjU1LzI1NSAwMiAobnVsbCkg
R1BTIENvbnRyb2w8YnI+CgoKb2Zvbm9kWzE3ODldOiBwbHVnaW5zL3VkZXZuZy5jOnNldHVwX2hz
bygpIC9kZXYvdHR5SFMzIDI1NS8yNTUvMjU1IDAzIChudWxsKSBBcHBsaWNhdGlvbjxicj5vZm9u
b2RbMTc4OV06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHNvKCkgL2Rldi90dHlIUzQgMjU1LzI1
NS8yNTUgMDYgKG51bGwpIENvbnRyb2w8YnI+b2Zvbm9kWzE3ODldOiBwbHVnaW5zL3VkZXZuZy5j
OnNldHVwX2hzbygpIC9kZXYvdHR5SFM1IDI1NS8yNTUvMjU1IDA5IChudWxsKSBNb2RlbTxicj4K
CgpvZm9ub2RbMTc4OV06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHNvKCkgY29udHJvbD0vZGV2
L3R0eUhTNCBhcHBsaWNhdGlvbj0vZGV2L3R0eUhTMyBtb2RlbT0vZGV2L3R0eUhTNSBuZXR3b3Jr
PShudWxsKTxicj5vZm9ub2RbMTc4OV06IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgp
IG1vZGVtIDB4OGQyNzcxOCBwcm9wZXJ0eSBDb250cm9sPGJyPm9mb25vZFsxNzg5XTogc3JjL21v
ZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4ZDI3NzE4IHByb3BlcnR5IEFwcGxp
Y2F0aW9uPGJyPgoKCm9mb25vZFsxNzg5XTogc3JjL21vZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5
KCkgbW9kZW0gMHg4ZDI3NzE4IHByb3BlcnR5IE1vZGVtPGJyPm9mb25vZFsxNzg5XTogc3JjL21v
ZGVtLmM6c2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4ZDI3NzE4IHByb3BlcnR5IE5ldHdv
cmtJbnRlcmZhY2U8YnI+b2Zvbm9kWzE3ODldOiBzcmMvbW9kZW0uYzpvZm9ub19tb2RlbV9yZWdp
c3RlcigpIDB4OGQyNzcxODxicj4KCgpvZm9ub2RbMTc4OV06IHBsdWdpbnMvaHNvLmM6aHNvX3By
b2JlKCkgMHg4ZDI3NzE4PGJyPm9mb25vZFsxNzg5XTogc3JjL21vZGVtLmM6ZW1pdF9tb2RlbV9h
ZGRlZCgpIDB4OGQyNzcxODxicj5vZm9ub2RbMTc4OV06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9w
cm9wZXJ0eSgpIG1vZGVtIDB4OGQyNzcxOCBwcm9wZXJ0eSBOZXR3b3JrSW50ZXJmYWNlPGJyPm9m
b25vZFsxNzg5XTogc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4ZDI3
NzE4IHByb3BlcnR5IFN5c1BhdGg8YnI+CgoKb2Zvbm9kWzE3ODldOiBzcmMvbW9kZW0uYzpfX29m
b25vX21vZGVtX2FwcGVuZF9wcm9wZXJ0aWVzKCkgSWZuYW1lIChudWxsKTxicj5vZm9ub2RbMTc4
OV06IHNyYy9tb2RlbS5jOmNhbGxfbW9kZW13YXRjaGVzKCkgMHg4ZDI3NzE4IGFkZGVkOjE8YnI+
b2Zvbm9kWzE3ODldOiBwbHVnaW5zL3NtYXJ0LW1lc3NhZ2luZy5jOm1vZGVtX3dhdGNoKCkgbW9k
ZW06IDB4OGQyNzcxOCwgYWRkZWQ6IDE8YnI+CgoKb2Zvbm9kWzE3ODldOiBwbHVnaW5zL3B1c2gt
bm90aWZpY2F0aW9uLmM6bW9kZW1fd2F0Y2goKSBtb2RlbTogMHg4ZDI3NzE4LCBhZGRlZDogMTxi
cj5vZm9ub2RbMTc4OV06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4
OGQyNzcxOCBwcm9wZXJ0eSBOZXR3b3JrSW50ZXJmYWNlPGJyPm9mb25vZFsxNzg5XTogc3JjL21v
ZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4ZDI3NzE4IHByb3BlcnR5IFN5c1Bh
dGg8YnI+CgoKb2Zvbm9kWzE3ODldOiBzcmMvbW9kZW0uYzpfX29mb25vX21vZGVtX2FwcGVuZF9w
cm9wZXJ0aWVzKCkgSWZuYW1lIChudWxsKTxicj5vZm9ub2RbMTc4OV06IHNyYy9tb2RlbS5jOmdl
dF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OGQyNzE1MCBwcm9wZXJ0eSBOZXR3b3JrSW50ZXJm
YWNlPGJyPm9mb25vZFsxNzg5XTogc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9k
ZW0gMHg4ZDI3MTUwIHByb3BlcnR5IFN5c1BhdGg8YnI+CgoKb2Zvbm9kWzE3ODldOiBzcmMvbW9k
ZW0uYzpfX29mb25vX21vZGVtX2FwcGVuZF9wcm9wZXJ0aWVzKCkgSWZuYW1lIChudWxsKTxicj5v
Zm9ub2RbMTc4OV06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OGQy
NzcxOCBwcm9wZXJ0eSBOZXR3b3JrSW50ZXJmYWNlPGJyPm9mb25vZFsxNzg5XTogc3JjL21vZGVt
LmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4ZDI3NzE4IHByb3BlcnR5IFN5c1BhdGg8
YnI+CgoKb2Zvbm9kWzE3ODldOiBzcmMvbW9kZW0uYzpfX29mb25vX21vZGVtX2FwcGVuZF9wcm9w
ZXJ0aWVzKCkgSWZuYW1lIChudWxsKTxicj5vZm9ub2RbMTc4OV06IHNyYy9tb2RlbS5jOmdldF9t
b2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OGQyNzE1MCBwcm9wZXJ0eSBOZXR3b3JrSW50ZXJmYWNl
PGJyPm9mb25vZFsxNzg5XTogc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0g
MHg4ZDI3MTUwIHByb3BlcnR5IFN5c1BhdGg8YnI+CgoKb2Zvbm9kWzE3ODldOiBzcmMvbW9kZW0u
YzpfX29mb25vX21vZGVtX2FwcGVuZF9wcm9wZXJ0aWVzKCkgSWZuYW1lIChudWxsKTxicj5vZm9u
b2RbMTc4OV06IHBsdWdpbnMvdGVsaXQuYzp0ZWxpdF9lbmFibGUoKSAweDhkMjcxNTA8YnI+b2Zv
bm9kWzE3ODldOiBzcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDhkMjcx
NTAgcHJvcGVydHkgTW9kZW08YnI+b2Zvbm9kWzE3ODldOiBwbHVnaW5zL3RlbGl0LmM6b3Blbl9k
ZXZpY2UoKSBNb2RlbSAvZGV2L3R0eUFDTTE8YnI+CgoKPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+SSBhbHNvIHVzZWQgZ2Ric2VydmVyIHRvIGZpbmQgb3V0IHdoZXJlIHRoZSBwcm9ibGVt
IGlzLiBIZXJlIGlzIHRoZSBiYWNrdHJhY2UgZnJvbSB3aGVyZSBpIHRoaW5rIHRoZSBmYWlsdXJl
IGlzIDo8YnI+PGJyPsKgwqAg4pSCMjMwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9PGJyPsKgwqAg4pSCMjMxwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH08YnI+wqDC
oCDilIIyMzI8YnI+CgrCoCZndDvilIIyMzPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmQgPSBv
cGVuKHR0eSwgT19SRFdSIHwgT19OT0NUVFkgfCBPX05PTkJMT0NLKTvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC8qIHRoZSBvcGVuIGZ1bmN0aW9uIGZhaWxzIGFuZCByZXR1cm5zIC0xICov
PGJyPgrCoMKgIOKUgjIzNMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZmQgJmx0OyAwKTxi
cj7CoMKgIOKUgjIzNcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC0xOzxicj7CoMKgIOKUgjIzNjxicj7CoMKgIOKUgjIzN8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB0Y2ZsdXNoKGZkLCBUQ0lPRkxVU0gpOzxicj48YnI+IzDCoCBvcGVuX2RldmljZSAodHR5
PTB4OGQyN2UwOCAmcXVvdDsvZGV2L3R0eUFDTTEmcXVvdDssIG9wdGlvbnM9MHg4ZDFkYmIwKSBh
dCBnYXRjaGF0L2dhdHR0eS5jOjIzMzxicj4KCgojMcKgIGdfYXRfdHR5X29wZW4gKHR0eT0weDhk
MjdlMDggJnF1b3Q7L2Rldi90dHlBQ00xJnF1b3Q7LCBvcHRpb25zPTB4OGQxZGJiMCkgYXQgZ2F0
Y2hhdC9nYXR0dHkuYzoyNDg8YnI+IzLCoCAweDA4MGJkODIzIGluIG9wZW5fZGV2aWNlIChtb2Rl
bT0mbHQ7dmFsdWUgb3B0aW1pemVkIG91dCZndDssIGtleT0mbHQ7dmFsdWUgb3B0aW1pemVkIG91
dCZndDssIGRlYnVnPTB4ODEyMjdhOCAmcXVvdDtNb2RlbTogJnF1b3Q7KTxicj4KCgrCoMKgwqAg
YXQgcGx1Z2lucy90ZWxpdC5jOjIxMDxicj4jM8KgIDB4MDgwYmQ4ZjMgaW4gdGVsaXRfZW5hYmxl
IChtb2RlbT0weDhkMjcxNTApIGF0IHBsdWdpbnMvdGVsaXQuYzozODY8YnI+IzTCoCAweDA4MGMw
OTgyIGluIHNldF9wb3dlcmVkIChtb2RlbT0weDhkMjcxNTAsIHBvd2VyZWQ9MSkgYXQgc3JjL21v
ZGVtLmM6ODg1PGJyPiM1wqAgMHgwODBjMTlmYyBpbiBtb2RlbV9zZXRfcHJvcGVydHkgKGNvbm49
MHg4ZDFmMTc4LCBtc2c9MHg4ZDJiY2EwLCBkYXRhPTB4OGQyNzE1MCkgYXQgc3JjL21vZGVtLmM6
MTA5Nzxicj4KCgojNsKgIDB4MDgwNTRlMTQgaW4gcHJvY2Vzc19tZXNzYWdlIChjb25uZWN0aW9u
PTB4OGQxZjE3OCwgbWVzc2FnZT0weGJmODM0NDYwLCBtZXRob2Q9MHg4ZDJiNjE0LDxicj7CoMKg
wqAgaWZhY2VfdXNlcl9kYXRhPTB4OGQyNzE1MCkgYXQgZ2RidXMvb2JqZWN0LmM6MjI0PGJyPiM3
wqAgMHhiNzdlMTJiMiBpbiA/PyAoKTxicj4jOMKgIDB4Yjc3ZDY1NDQgaW4gPz8gKCk8YnI+IznC
oCAweDA4MDUzYmQwIGluIG1lc3NhZ2VfZGlzcGF0Y2ggKGRhdGE9MHhiNzdmOGZmNCkgYXQgZ2Ri
dXMvbWFpbmxvb3AuYzo4MDxicj4KCgojMTAgMHhiNzgyZDgyOSBpbiA/PyAoKTxicj4jMTEgMHhi
NzgyY2Y3ZCBpbiA/PyAoKTxicj4jMTIgMHhiNzgyZWZlZSBpbiA/PyAoKTxicj4jMTMgMHhiNzgz
MDAzZSBpbiA/PyAoKTxicj4jMTQgMHgwODBiZjFmZiBpbiBtYWluIChhcmdjPTEsIGFyZ3Y9MHhi
ZjgzNGE1NCkgYXQgc3JjL21haW4uYzoyNjA8YnI+PGJyPjwvZGl2PkhlcmUgaXMgd2hhdCBJIGhh
dmUgZ290IHNvIGZhci4uLjxicj4KPC9kaXY+SSBkb24mIzM5O3QgdW5kZXJzdGFuZCB3aHkgdGhp
cyBvcGVuIGZhaWxzIHdoZW4gdGhlIE9wdGlvbiBpcyBwbHVnZ2VkIGluIHNpbmNlIHRoZXkgZG9u
JiMzOTt0IHVzZSB0aGUgc2FtZSBkZXZpY2UgcG9ydHMgKHR0eUFDTT8gZm9yIEhFOTEwLCBhbmQg
dHR5SFM/IGZvciBHVE0zODIpPGJyPjwvZGl2PlRoYW5rcyBpbiBhZHZhbmNlIGZvciB5b3VyIGhl
bHAsPGJyPjxicj48L2Rpdj4KRXRpZW5uZSBNYWJpbGxlPGJyPjxkaXY+PGRpdj48YnI+PC9kaXY+
PC9kaXY+PC9kaXY+Cg==

--===============1619218472305797877==--

