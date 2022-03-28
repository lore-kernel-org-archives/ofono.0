Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CED7C
	for <ofono@lists.linux.dev>; Mon, 28 Mar 2022 10:01:08 +0000 (UTC)
Date: Mon, 28 Mar 2022 10:00:54 +0000
Authentication-Results: mail-4317.proton.ch; dkim=none
To: "ofono@lists.linux.dev" <ofono@lists.linux.dev>
From: =?utf-8?Q?St=C3=A9phane_David?= <sd@alpwan.fr>
Reply-To: =?utf-8?Q?St=C3=A9phane_David?= <sd@alpwan.fr>
Subject: ALPWAN / Connman Ofono Huawei MS2372h-153 not working
Message-ID: <z00B-jI8FNZ1xtpBjb98YqdYCSR3PBIdho_WTNhlqlPM3dQJdRdi33a-Rr-xiRpnfYjwsQ8TT2MPRkqsqygEzuEWjwg-nIY3uK7rQGsWvOo=@alpwan.fr>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I try to use a Huawei Modem MS2372h-153 (SIM Card 1NCE) with connman and of=
ono but I have some problems to do that.

Computer : Raspberry Pi 4 Model B rev 1.4

OS : Debian GNU/Linux 11 (bullseye) / Raspberry Pi OS Lite (64-bit)

Kernel : Linux 5.10.92-v8+

Arch : ARM64

Connman : 1.36-2.2

Ofono : 1.31-3

Ofono-scripts : 1.31-3

APN : iot.1nce.net

nsa@alpwan-e0d9c90c:~ $ lsusb

Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub

Bus 001 Device 003: ID 0483:5740 STMicroelectronics Virtual COM Port

Bus 001 Device 005: ID 12d1:1506 Huawei Technologies Co., Ltd. Modem/Networ=
kcard

Bus 001 Device 002: ID 2109:3431 VIA Labs, Inc. Hub

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

dmesg

[ 9.507015] usb 1-1.1: new high-speed USB device number 5 using xhci_hcd

[ 9.616313] usb 1-1.1: New USB device found, idVendor=3D12d1, idProduct=3D1=
506, bcdDevice=3D 1.02

[ 9.616329] usb 1-1.1: New USB device strings: Mfr=3D1, Product=3D2, Serial=
Number=3D0

[ 9.616336] usb 1-1.1: Product: HUAWEI_MOBILE

[ 9.616342] usb 1-1.1: Manufacturer: HUAWEI_MOBILE

[ 9.673161] usbcore: registered new interface driver usbserial_generic

[ 9.673217] usbserial: USB Serial support registered for generic

[ 9.676205] usbcore: registered new interface driver cdc_ether

[ 9.688574] usbcore: registered new interface driver cdc_ncm

[ 9.708900] usbcore: registered new interface driver option

[ 9.708973] usbserial: USB Serial support registered for GSM modem (1-port)

[ 9.709202] option 1-1.1:1.0: GSM modem (1-port) converter detected

[ 9.710442] usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB0

[ 9.711402] option 1-1.1:1.1: GSM modem (1-port) converter detected

[ 9.711760] usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB1

[ 9.712056] option 1-1.1:1.2: GSM modem (1-port) converter detected

[ 9.712325] usb 1-1.1: GSM modem (1-port) converter now attached to ttyUSB2

[ 9.715371] usbcore: registered new interface driver cdc_wdm

[ 9.746562] huawei_cdc_ncm 1-1.1:1.3: MAC-Address: 00:1e:10:1f:00:00

[ 9.746580] huawei_cdc_ncm 1-1.1:1.3: setting rx_max =3D 16384

[ 9.747286] huawei_cdc_ncm 1-1.1:1.3: NDP will be placed at end of frame fo=
r this device.

[ 9.747523] huawei_cdc_ncm 1-1.1:1.3: cdc-wdm0: USB WDM device

[ 9.749312] huawei_cdc_ncm 1-1.1:1.3 wwan0: register 'huawei_cdc_ncm' at us=
b-0000:01:00.0-1.1, Huawei CDC NCM device, 00:1e:10:1f:00:00

[ 9.749494] usbcore: registered new interface driver huawei_cdc_ncm

nsa@alpwan-e0d9c90c:~ $ ifconfig

eth0: flags=3D4163 mtu 1500

inet 192.168.0.169 netmask 255.255.255.0 broadcast 192.168.0.255

inet6 fe80::fccb:2fa5:b61b:1236 prefixlen 64 scopeid 0x20

inet6 2a01:e34:ee9f:eaa0:5470:b84c:3a21:bccc prefixlen 64 scopeid 0x0

ether e4:5f:01:15:de:4f txqueuelen 1000 (Ethernet)

RX packets 504 bytes 39108 (38.1 KiB)

RX errors 0 dropped 0 overruns 0 frame 0

TX packets 525 bytes 105816 (103.3 KiB)

TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0

lo: flags=3D73 mtu 65536

inet 127.0.0.1 netmask 255.0.0.0

inet6 ::1 prefixlen 128 scopeid 0x10

loop txqueuelen 1000 (Local Loopback)

RX packets 12978 bytes 2589961 (2.4 MiB)

RX errors 0 dropped 0 overruns 0 frame 0

TX packets 12978 bytes 2589961 (2.4 MiB)

TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0

tether: flags=3D-28605 mtu 1500

inet 192.168.1.1 netmask 255.255.255.0 broadcast 192.168.1.255

inet6 fe80::9052:8fff:fe1f:e97 prefixlen 64 scopeid 0x20

ether e4:5f:01:15:de:50 txqueuelen 1000 (Ethernet)

RX packets 0 bytes 0 (0.0 B)

RX errors 0 dropped 0 overruns 0 frame 0

TX packets 38 bytes 5116 (4.9 KiB)

TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0

wlan0: flags=3D4163 mtu 1500

inet 169.254.223.188 netmask 255.255.0.0 broadcast 169.254.255.255

inet6 fe80::396f:65ff:30c1:ba06 prefixlen 64 scopeid 0x20

ether e4:5f:01:15:de:50 txqueuelen 1000 (Ethernet)

RX packets 0 bytes 0 (0.0 B)

RX errors 0 dropped 0 overruns 0 frame 0

TX packets 90 bytes 16314 (15.9 KiB)

TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0

wwan0: flags=3D4163 mtu 1500

inet 169.254.62.145 netmask 255.255.0.0 broadcast 169.254.255.255

inet6 fe80::b252:632a:1186:e827 prefixlen 64 scopeid 0x20

ether 00:1e:10:1f:00:00 txqueuelen 1000 (Ethernet)

RX packets 0 bytes 0 (0.0 B)

RX errors 0 dropped 0 overruns 0 frame 0

TX packets 33 bytes 6126 (5.9 KiB)

TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0

connmanctl> technologies

/net/connman/technology/bluetooth

Name =3D Bluetooth

Type =3D bluetooth

Powered =3D False

Connected =3D False

Tethering =3D False

/net/connman/technology/p2p

Name =3D P2P

Type =3D p2p

Powered =3D False

Connected =3D False

Tethering =3D False

/net/connman/technology/cellular

Name =3D Cellular

Type =3D cellular

Powered =3D False

Connected =3D False

Tethering =3D False

/net/connman/technology/ethernet

Name =3D Wired

Type =3D ethernet

Powered =3D True

Connected =3D True

Tethering =3D False

/net/connman/technology/wifi

Name =3D WiFi

Type =3D wifi

Powered =3D True

Connected =3D False

Tethering =3D True

TetheringIdentifier =3D alpwan-e0d9c90c

TetheringPassphrase =3D e45f0115de50

connmanctl> enable cellular

Enabled cellular

connmanctl> technologies

/net/connman/technology/bluetooth

Name =3D Bluetooth

Type =3D bluetooth

Powered =3D False

Connected =3D False

Tethering =3D False

/net/connman/technology/p2p

Name =3D P2P

Type =3D p2p

Powered =3D False

Connected =3D False

Tethering =3D False

/net/connman/technology/cellular

Name =3D Cellular

Type =3D cellular

Powered =3D True

Connected =3D False

Tethering =3D False

/net/connman/technology/ethernet

Name =3D Wired

Type =3D ethernet

Powered =3D True

Connected =3D True

Tethering =3D False

/net/connman/technology/wifi

Name =3D WiFi

Type =3D wifi

Powered =3D True

Connected =3D False

Tethering =3D True

TetheringIdentifier =3D alpwan-e0d9c90c

TetheringPassphrase =3D e45f0115de50

!!! but no service create !!!

nsa@alpwan-e0d9c90c:~ $ ls /var/lib/connman

ethernet_e45f0115de4f_cable settings

!!! impossible to connect !!!

after a connmanctl disable cellular, I try do connect the modem directly fr=
om ofono

nsa@alpwan-e0d9c90c:/usr/share/ofono/scripts $ sudo ./list-modems

[ /huawei_0 ]

Online =3D 0

Powered =3D 1

Lockdown =3D 0

Emergency =3D 0

Manufacturer =3D huawei

Model =3D MS2372h-153

Revision =3D 21.327.07.00.00

Serial =3D 866129030046221

SystemPath =3D /sys/devices/platform/scb/fd500000.pcie/pci0000:00/0000:00:0=
0.0/0000:01:00.0/usb1/1-1/1-1.1

Interfaces =3D org.ofono.SmartMessaging org.ofono.PushNotification org.ofon=
o.MessageManager org.ofono.ConnectionManager org.ofono.RadioSettings org.of=
ono.Phonebook org.ofono.AudioSettings org.ofono.VoiceCallManager org.ofono.=
AllowedAccessPoints org.ofono.SimManager

Features =3D sms gprs rat sim

Type =3D hardware

[ org.ofono.SmartMessaging ]

[ org.ofono.PushNotification ]

[ org.ofono.MessageManager ]

ServiceCenterAddress =3D +882285000016868

UseDeliveryReports =3D 0

Bearer =3D cs-preferred

Alphabet =3D default

[ org.ofono.ConnectionManager ]

Attached =3D 0

Bearer =3D none

RoamingAllowed =3D 0

Powered =3D 1

[ org.ofono.RadioSettings ]

TechnologyPreference =3D any

GsmBand =3D any

UmtsBand =3D any

[ org.ofono.Phonebook ]

[ org.ofono.AudioSettings ]

Active =3D 0

[ org.ofono.VoiceCallManager ]

EmergencyNumbers =3D 118 110 08 911 000 112 999 119

[ org.ofono.AllowedAccessPoints ]

[ org.ofono.SimManager ]

Present =3D 1

CardIdentifier =3D 89882280666023068871

SubscriberIdentity =3D 901405102306887

ServiceProviderName =3D 1nce.net

FixedDialing =3D 0

BarredDialing =3D 0

MobileCountryCode =3D 901

MobileNetworkCode =3D 40

SubscriberNumbers =3D

LockedPins =3D

PreferredLanguages =3D de en

PinRequired =3D none

Retries =3D [pin =3D 3] [pin2 =3D 3] [puk =3D 10] [puk2 =3D 10]

CardSlotCount =3D 1

ActiveCardSlot =3D 1

nsa@alpwan-e0d9c90c:/usr/share/ofono/scripts $ sudo ./enable-modem

Connecting modem /huawei_0...

nsa@alpwan-e0d9c90c:/usr/share/ofono/scripts $ sudo ./online-modem

Setting modem /huawei_0 online...

nsa@alpwan-e0d9c90c:/usr/share/ofono/scripts $ sudo ./register-auto

nsa@alpwan-e0d9c90c:/usr/share/ofono/scripts $

I think that these 3 commands do the same job as connmanctl enable cellular

nsa@alpwan-e0d9c90c:/usr/share/ofono/scripts $ connmanctl technologies

/net/connman/technology/bluetooth

Name =3D Bluetooth

Type =3D bluetooth

Powered =3D False

Connected =3D False

Tethering =3D False

/net/connman/technology/p2p

Name =3D P2P

Type =3D p2p

Powered =3D False

Connected =3D False

Tethering =3D False

/net/connman/technology/cellular

Name =3D Cellular

Type =3D cellular

Powered =3D True

Connected =3D False

Tethering =3D False

/net/connman/technology/ethernet

Name =3D Wired

Type =3D ethernet

Powered =3D True

Connected =3D True

Tethering =3D False

/net/connman/technology/wifi

Name =3D WiFi

Type =3D wifi

Powered =3D True

Connected =3D False

Tethering =3D True

TetheringIdentifier =3D alpwan-e0d9c90c

TetheringPassphrase =3D e45f0115de50

nsa@alpwan-e0d9c90c:/usr/share/ofono/scripts $ sudo ./create-internet-conte=
xt iot.1nce.net

Found context /huawei_0/context1

Setting APN to iot.1nce.net

nsa@alpwan-e0d9c90c:/usr/share/ofono/scripts $ sudo ./activate-context

Error activating /huawei_0/context1: org.ofono.Error.NotAttached: GPRS is n=
ot attached

I suppose that this is the reason why the service is not created with connm=
an

What i'm doing wrong ? or maybe the Huawei MS2372h-153 is not well supporte=
d by connman/ofono ?

thank you

regards

St=C3=A9phane David

Cordialement / Best regards

[image]

St=C3=A9phane David

Embedded Computers / ARM / RISC-V / Linux
Telecoms & Network / M2M / IoT
Mobile: +33 (0)6 87 00 73 19
www.alpwan.fr

Envoy=C3=A9 avec la messagerie s=C3=A9curis=C3=A9e ProtonMail.
