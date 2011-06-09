Content-Type: multipart/mixed; boundary="===============0266685875362375470=="
MIME-Version: 1.0
From: Deng, Ying An <ying.an.deng@intel.com>
Subject: Problem with Huawei E5832
Date: Thu, 09 Jun 2011 10:07:56 +0800
Message-ID: <CE59C043D0EC3349B2BF41C0EC72229B4D80D079@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0266685875362375470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

When using Huawei E5832 with ofono 0.48, the 3G modem cannot be initialized=
 by ofono.

Here's the ofono log:

ofonod[2763]: src/modem.c:ofono_modem_create() name: 1234567890ABCDEF, type=
: huawei
ofonod[2763]: src/modem.c:set_modem_property() modem 0x86791e0 property Path
ofonod[2763]: src/modem.c:set_modem_property() modem 0x86791e0 property Reg=
istered
ofonod[2763]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.7/u=
sb1/1-5/1-5:1.2/ttyUSB1/tty/ttyUSB1 (huawei)
ofonod[2763]: plugins/udev.c:add_huawei() modem 0x86791e0
ofonod[2763]: src/modem.c:get_modem_property() modem 0x86791e0 property Mod=
emRegistered
ofonod[2763]: src/modem.c:get_modem_property() modem 0x86791e0 property Pcu=
iRegistered
ofonod[2763]: src/modem.c:get_modem_property() modem 0x86791e0 property Path
ofonod[2763]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.7/u=
sb1/1-5/1-5:1.0/ttyUSB0/tty/ttyUSB0 (huawei)
ofonod[2763]: plugins/udev.c:add_huawei() modem 0x86791e0
ofonod[2763]: src/modem.c:get_modem_property() modem 0x86791e0 property Mod=
emRegistered
ofonod[2763]: src/modem.c:get_modem_property() modem 0x86791e0 property Pcu=
iRegistered


Here's the dmesg log:

[ 5916.054519] usb 1-5: new high speed USB device using ehci_hcd and addres=
s 21
[ 5916.182355] usb 1-5: New USB device found, idVendor=3D12d1, idProduct=3D=
142d
[ 5916.182374] usb 1-5: New USB device strings: Mfr=3D3, Product=3D2, Seria=
lNumber=3D1
[ 5916.182390] usb 1-5: Product: HUAWEI Mobile Connect
[ 5916.182403] usb 1-5: Manufacturer: Huawei Incorporated
[ 5916.182415] usb 1-5: SerialNumber: 1234567890ABCDEF
[ 5916.195359] option 1-5:1.0: GSM modem (1-port) converter detected
[ 5916.197114] usb 1-5: GSM modem (1-port) converter now attached to ttyUSB0
[ 5916.199431] scsi32 : usb-storage 1-5:1.1
[ 5916.202722] option 1-5:1.2: GSM modem (1-port) converter detected
[ 5916.204631] usb 1-5: GSM modem (1-port) converter now attached to ttyUSB1
[ 5917.205700] scsi 32:0:0:0: CD-ROM            HUAWEI   Mass storage     f=
fff PQ: 0 ANSI: 2
[ 5917.207737] scsi 32:0:0:1: Direct-Access     HUAWEI   Mass storage     f=
fff PQ: 0 ANSI: 2
[ 5917.221393] sr0: scsi-1 drive
[ 5917.226228] sr 32:0:0:0: Attached scsi CD-ROM sr0
[ 5917.227684] sr 32:0:0:0: Attached scsi generic sg1 type 5
[ 5917.231320] sd 32:0:0:1: Attached scsi generic sg2 type 0
[ 5917.241071] sd 32:0:0:1: [sdb] Attached SCSI removable disk


Can anybody give some advice?

Thanks
Best regards,

Ying.An


--===============0266685875362375470==--

