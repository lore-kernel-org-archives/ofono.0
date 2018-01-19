Content-Type: multipart/mixed; boundary="===============0343970862262711827=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: Huawei MS2131
Date: Fri, 19 Jan 2018 11:17:09 +0100
Message-ID: <66b7b190-00e5-3044-805a-96cebf66e545@kerlink.fr>
In-Reply-To: <B5CD1B0BA251DD468958CC22781DD5372B3B88@DEFTHW99EJ0MSX.ww902.siemens.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0343970862262711827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Xingxing,


On 01/19/2018 10:52 AM, He, Xingxing wrote:
> Hi Christophe,
>
> May I get the patch in usb-modeswitch for switch device to PPP mode? I wo=
uld like to have a try, thank you in advance.
>
> Best regards,
> Xingxing
I use usb-modeswitch 2.5.0 =

(http://www.draisberghof.de/usb_modeswitch/usb-modeswitch-2.5.0.tar.bz2).
I had to patch usb-modeswitch to support huawei E3372 with firmware =

22.X. I have done that before trying MS2131 so I can't tell if it is =

necessary for this device (or device firmware).
Here is the comment I wrote when I have implemented the modification:

After some research I found this interesting message on a forum =

(http://www.draisberghof.de/usb_modeswitch/bb/viewtopic.php?f=3D4&t=3D1734):

What has been labelled "fall back" message in this thread is not a =

Huawei official switch message, it just happens to work in some firmwares.

55534243123456780000000000000011062000000101000100000000000000

is the standard switch message

while

55534243123456780000000000000011063000000100010000000000000000

is a Huawei official fall back switch msg switching any modern Huawei =

dongle into 12d1:1001.


The first binary message is the message sent by usb-modeswitch to many =

Huawei devices.
I modified usb-modeswitch to send the second binary message instead. =

Here is what happens when inserting USB key with this modification:

[ 174.120901] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[ 174.273073] usb 1-1: New USB device found, idVendor=3D12d1, idProduct=3D1=
f01
[ 174.279807] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, =

SerialNumber=3D3
[ 174.287016] usb 1-1: Product: HUAWEI_MOBILE
[ 174.291237] usb 1-1: Manufacturer: HUAWEI_MOBILE
[ 174.295876] usb 1-1: SerialNumber: 0123456789ABCDEF
[ 174.340649] usb-storage 1-1:1.0: USB Mass Storage device detected
[ 174.348241] scsi host0: usb-storage 1-1:1.0
[ 175.322850] usb 1-1: USB disconnect, device number 2
[ 175.890898] usb 1-1: new high-speed USB device number 3 using ci_hdrc
[ 176.049944] usb 1-1: New USB device found, idVendor=3D12d1, idProduct=3D1=
55e
[ 176.056720] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, =

SerialNumber=3D0
[ 176.063911] usb 1-1: Product: HUAWEI_MOBILE
[ 176.068104] usb 1-1: Manufacturer: HUAWEI_MOBILE
[ 176.119262] option 1-1:1.0: GSM modem (1-port) converter detected
[ 176.140098] usb 1-1: GSM modem (1-port) converter now attached to ttyUSB0
[ 176.163530] option 1-1:1.1: GSM modem (1-port) converter detected
[ 176.188362] usb 1-1: GSM modem (1-port) converter now attached to ttyUSB1
[ 176.221032] option 1-1:1.2: GSM modem (1-port) converter detected
[ 176.250351] usb 1-1: GSM modem (1-port) converter now attached to ttyUSB2
[ 176.322577] cdc_ncm 1-1:1.3: MAC-Address: 00:1e:10:1f:00:00
[ 176.328169] cdc_ncm 1-1:1.3: setting rx_max =3D 16384
[ 176.354358] cdc_ncm 1-1:1.3 wwan0: register 'cdc_ncm' at =

usb-ci_hdrc.0-1, Mobile Broadband Network Device, 00:1e:10:1f:00:00
A USB device 12d1:155e appears, creates 3 USB serial channels and a =

cdc_ncm interface.


End of comment

When I insert an MS2131, here is what I see on my system:
[=C2=A0 178.452861] usb 1-1: new high-speed USB device number 2 using ci_hd=
rc
[=C2=A0 178.604840] usb 1-1: New USB device found, idVendor=3D12d1, idProdu=
ct=3D14fe
[=C2=A0 178.611574] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, =

SerialNumber=3D3
[=C2=A0 178.618782] usb 1-1: Product: HUAWEI Mobile
[=C2=A0 178.622991] usb 1-1: Manufacturer: HUAWEI
[=C2=A0 178.627009] usb 1-1: SerialNumber: FFFFFFFFFFFFFFFF
[=C2=A0 178.652141] usb-storage 1-1:1.0: USB Mass Storage device detected
[=C2=A0 178.659862] scsi host0: usb-storage 1-1:1.0
[=C2=A0 179.648202] usb 1-1: USB disconnect, device number 2
[=C2=A0 179.952752] usb 1-1: new high-speed USB device number 3 using ci_hd=
rc
[=C2=A0 180.104463] usb 1-1: New USB device found, idVendor=3D12d1, idProdu=
ct=3D155e
[=C2=A0 180.111194] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, =

SerialNumber=3D0
[=C2=A0 180.118390] usb 1-1: Product: HUAWEI Mobile
[=C2=A0 180.122581] usb 1-1: Manufacturer: HUAWEI
[=C2=A0 180.184692] option 1-1:1.0: GSM modem (1-port) converter detected
[=C2=A0 180.205743] usb 1-1: GSM modem (1-port) converter now attached to t=
tyUSB0
[=C2=A0 180.225687] option 1-1:1.1: GSM modem (1-port) converter detected
[=C2=A0 180.251829] usb 1-1: GSM modem (1-port) converter now attached to t=
tyUSB1
[=C2=A0 180.275843] option 1-1:1.2: GSM modem (1-port) converter detected
[=C2=A0 180.307996] usb 1-1: GSM modem (1-port) converter now attached to t=
tyUSB2
[=C2=A0 180.351223] cdc_ncm 1-1:1.3: MAC-Address: 00:1e:10:1f:00:00
[=C2=A0 180.388163] cdc_ncm 1-1:1.3 wwan0: register 'cdc_ncm' at =

usb-ci_hdrc.0-1, Mobile Broadband Network Device, 00:1e:10:1f:00:00

and a lsusb after that:
root(a)klk-wifc-030122:~ # lsusb
Bus 001 Device 003: ID 12d1:155e

My usbmodeswitch patch is attached to this mail.

Hoping this helps,

Christophe

--===============0343970862262711827==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="huawei.patch"

ZGlmZiAtTmF1ciBhL3VzYl9tb2Rlc3dpdGNoLmMgYi91c2JfbW9kZXN3aXRjaC5jCi0tLSBhL3Vz
Yl9tb2Rlc3dpdGNoLmMKKysrIGIvdXNiX21vZGVzd2l0Y2guYwpAQCAtNzQwLDcgKzc0MCw5IEBA
IGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAl9IGVsc2UgaWYgKE1vZGVNYXAgJiBI
VUFXRUlORVdfTU9ERSkgewogCQlTSE9XX1BST0dSRVNTKG91dHB1dCwiVXNpbmcgc3RhbmRhcmQg
SHVhd2VpIHN3aXRjaGluZyBtZXNzYWdlXG4iKTsKIAkJZGV0YWNoRHJpdmVyKCk7Ci0JCXN0cmNw
eShNZXNzYWdlc1swXSwiNTU1MzQyNDMxMjM0NTY3ODAwMDAwMDAwMDAwMDAwMTEwNjIwMDAwMDAx
MDEwMDAxMDAwMDAwMDAwMDAwMDAiKTsKKwkJLypzdHJjcHkoTWVzc2FnZXNbMF0sIjU1NTM0MjQz
MTIzNDU2NzgwMDAwMDAwMDAwMDAwMDExMDYyMDAwMDAwMTAxMDAwMTAwMDAwMDAwMDAwMDAwIik7
Ki8KKwkJLyogc3dpdGNoIGh1YXdlaSBkZXZpY2VzIHRvIFBQUCBtb2RlICovCisJCXN0cmNweShN
ZXNzYWdlc1swXSwiNTU1MzQyNDMxMjM0NTY3ODAwMDAwMDAwMDAwMDAwMTEwNjMwMDAwMDAxMDAw
MTAwMDAwMDAwMDAwMDAwMDAiKTsKIAkJc3dpdGNoU2VuZE1lc3NhZ2UoKTsKIAl9IGVsc2UgaWYg
KE1vZGVNYXAgJiBPUFRJT05fTU9ERSkgewogCQlTSE9XX1BST0dSRVNTKG91dHB1dCwiVXNpbmcg
c3RhbmRhcmQgT3B0aW9uIHN3aXRjaGluZyBtZXNzYWdlXG4iKTsK

--===============0343970862262711827==--

