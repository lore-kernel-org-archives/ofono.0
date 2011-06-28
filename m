Content-Type: multipart/mixed; boundary="===============1603396919022057509=="
MIME-Version: 1.0
From: ofonoconn@encambio.com
Subject: Re: Problem detecting/using wwan0 modem
Date: Tue, 28 Jun 2011 19:05:07 +0200
Message-ID: <20110628170507.GA26666@debut.europalab.com>
In-Reply-To: <4E08BC04.3030105@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1603396919022057509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello Denis,

On Mon., June 27, 2011, Denis Kenzior wrote:
>>> The rules seem to be OK, so the udev detection code
>>> in plugins/udev.c:add_mbm is not finding your modem.
>>>
>>> Try starting oFono with
>>>
>>> ofonod -n -d 'plugins/udev*' (sorry, I messed this up earlier)
>>>
>>> and report the output
>>>
>>   meego$ /usr/sbin/ofonod -n -d 'plugins/udev*'
>>   ofonod[811]: oFono version 0.48
>>   ofonod[811]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d=
.7/usb1/1-5/1-5:1.1/tty/ttyACM0 (mbm)
>>   ofonod[811]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband=
 Module Data Modem
>>   ofonod[811]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d=
.7/usb1/1-5/1-5:1.3/tty/ttyACM1 (mbm)
>>   ofonod[811]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband=
 Module Modem
>>   ofonod[811]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d=
.7/usb1/1-5/1-5:1.6/net/wwan0 (mbm)
>>   ofonod[811]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband=
 Module Network Adapter
>>   ofonod[811]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d=
.7/usb1/1-5/1-5:1.9/tty/ttyACM2 (mbm)
>>   ofonod[811]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband=
 Module NMEA
>>   ofonod[811]: Exit
>> =

>Based on the output above, the udev plugin needed to be modified to
>detect the HP version of the MBM modems.  The change can be found in
>commit: 6a2847f7aba5d84b06940ee29300d4b6fd31d682.  I'm also attaching
>this patch for your reference.  Please report back if this solves your
>issue.
>
>[...]
>
>diff --git a/plugins/udev.c b/plugins/udev.c
>index 1580b02..8ea937c 100644
>--- a/plugins/udev.c
>+++ b/plugins/udev.c
>@@ -122,6 +122,7 @@ static void add_mbm(struct ofono_modem *modem,
> 			g_str_has_suffix(desc, "Minicard Modem 2") ||
> 			g_str_has_suffix(desc, "Mini-Card Modem") ||
> 			g_str_has_suffix(desc, "Broadband Modem") ||
>+			g_str_has_suffix(desc, "Module Modem") ||
> 			g_str_has_suffix(desc, "Broadband USB Modem"))) {
> 		devnode =3D udev_device_get_devnode(udev_device);
> =

>@@ -132,11 +133,13 @@ static void add_mbm(struct ofono_modem *modem,
> 	} else if (registered =3D=3D 0 &&
> 			(g_str_has_suffix(desc, "Minicard Data Modem") ||
> 			g_str_has_suffix(desc, "Mini-Card Data Modem") ||
>+			g_str_has_suffix(desc, "Module Data Modem") ||
> 			g_str_has_suffix(desc, "Broadband Data Modem"))) {
> 		devnode =3D udev_device_get_devnode(udev_device);
> 		ofono_modem_set_string(modem, DATA_DEVICE, devnode);
> 	} else if (g_str_has_suffix(desc, "Minicard GPS Port") ||
> 			g_str_has_suffix(desc, "Mini-Card GPS Port") ||
>+			g_str_has_suffix(desc, "Module NMEA") ||
> 			g_str_has_suffix(desc, "Broadband GPS Port")) {
> 		devnode =3D udev_device_get_devnode(udev_device);
> 		ofono_modem_set_string(modem, GPS_DEVICE, devnode);
>@@ -144,6 +147,7 @@ static void add_mbm(struct ofono_modem *modem,
> 			(g_str_has_suffix(desc, "Minicard Network Adapter") ||
> 			g_str_has_suffix(desc, "Mini-Card Network Adapter") ||
> 			g_str_has_suffix(desc, "Broadband Network Adapter") ||
>+			g_str_has_suffix(desc, "Module Network Adapter") ||
> 			g_str_has_suffix(desc, "Minicard NetworkAdapter"))) {
> 		devnode =3D get_property(udev_device, "INTERFACE");
> 		ofono_modem_set_string(modem, NETWORK_INTERFACE, devnode);
>
Okay bad news. I patched version 0.50 with the logic above and
nothing has changed. After installing version 0.50 with the patch
applied (checked to make sure) I get the same debug output and
/usr/lib/ofono/test/list-modems gives no output.

Is there some other test other than list-modems that I should use?

  meego# /usr/sbin/ofonod -n -d 'plugins/udev*'
  ofonod[851]: oFono version 0.50
  ofonod[851]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.7/=
usb1/1-5/1-5:1.1/tty/ttyACM0 (mbm)
  ofonod[851]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband Mo=
dule=C2=A0Data Modem
  ofonod[851]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.7/=
usb1/1-5/1-5:1.3/tty/ttyACM1 (mbm)
  ofonod[851]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband Mo=
dule Modem
  ofonod[851]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.7/=
usb1/1-5/1-5:1.6/net/wwan0 (mbm)
  ofonod[851]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband Mo=
dule Network Adapter
  ofonod[851]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.7/=
usb1/1-5/1-5:1.9/tty/ttyACM2 (mbm)
  ofonod[851]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband Mo=
dule NMEA

Any ideas?

Regards,
Michael

--===============1603396919022057509==--

