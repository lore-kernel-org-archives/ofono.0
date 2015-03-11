Content-Type: multipart/mixed; boundary="===============4591028988510533741=="
MIME-Version: 1.0
From: Rajashekharaiah, Kiran KumarX <kiran.kumarx.rajashekharaiah@intel.com>
Subject: RE: Using ofono for location service
Date: Wed, 11 Mar 2015 13:06:34 +0000
Message-ID: <50BCD3CCE3CFC54ABCADC6EDD7405570C5549E@BGSMSX104.gar.corp.intel.com>
In-Reply-To: <54F9E7BE.4080409@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4591028988510533741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

-----Original Message-----
From: ofono [mailto:ofono-bounces(a)ofono.org] On Behalf Of Denis Kenzior
Sent: Friday, March 06, 2015 11:16 PM
To: ofono(a)ofono.org
Subject: Re: Using ofono for location service

Hi Kiran,

On 03/06/2015 05:55 AM, Rajashekharaiah, Kiran KumarX wrote:
> Hi,
>
> I am trying to use ofono on a linux box with TELIT HE910. How can I =

> enable stand-alone gps using ofono, so that I can get GPS data without =

> cellular connection?
>

The location-reporting atom is enabled in pre-sim, so in theory you should =
be able to use the modem as a GPS device without a SIM.

 From what I remember, oFono HE910 GPS support requires fairly new firmware=
 and a special setting to work correctly.  See doc/telit-modem.txt for more=
 information.

Kiran: I followed the doc/telit-modem.txt(I set AT#PORTCFG=3D8 and rebooted=
 the modem)and the firmware version is 12.00.004. =

After running the ofonod and test/enable-modem, I ran a script to get locat=
ion info. It gets disabled immediately. =

One more observation is, I get  "modem=3D/dev/ttyACM0 aux=3D/dev/ttyACM3 gp=
s=3D/dev/ttyACM5" from ofonod logs, but /dev/ttyACM5 is
not accepting AT commands when I try from minicom.

Following are the logs:
./test/gn3
Connecting modem /he910_0...
ofonod[2389]: drivers/telitmodem/location-reporting.c:telit_location_report=
ing_enable() lr=3D0x82e09e0
ofonod[2389]: drivers/telitmodem/location-reporting.c:telit_portcfg_check_c=
b() lr=3D0x82e09e0 ok=3D1
ofonod[2389]: drivers/telitmodem/location-reporting.c:telit_gps_enable_cb()=
 lr=3D0x82e09e0 ok=3D1
ofonod[2389]: drivers/telitmodem/location-reporting.c:telit_gps_ctl_cb() lr=
=3D0x82e09e0 ok=3D1
ofonod[2389]: src/modem.c:get_modem_property() modem 0x82e2ba0 property GPS
ofonod[2389]: drivers/telitmodem/location-reporting.c:telit_location_report=
ing_disable() lr=3D0x82e09e0
ofonod[2389]: drivers/telitmodem/location-reporting.c:telit_gps_disable_cb(=
) lr=3D0x82e09e0, ok=3D1

The test script I am using is:

import dbus
import sys
import glib

bus =3D dbus.SystemBus()

if len(sys.argv) =3D=3D 2:
        path =3D sys.argv[1]
else:
        manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
                        'org.ofono.Manager')
        modems =3D manager.GetModems()
        path =3D modems[0][0]

print("Connecting modem %s..." % path)
modem =3D dbus.Interface(bus.get_object('org.ofono', path),
                                                'org.ofono.LocationReportin=
g')

fd =3D modem.Request()

Regards,
Kiran


> Also when I tried running "test-gnss" for testing AGPS, I get the =

> following error(with ofonod daemon running in background):
>
> *NameError: name 'gnss' is not defined*
>

Yes, sounds like no modems with the
org.ofono.AssistedSatelliteNavigation interface were found.

> **
>
> Does this mean AGPS is not enabled? If so how can I enable it?
>
> **

Have you powered up your telit HE 910 via enable-modem?

Regards,
-Denis
_______________________________________________
ofono mailing list
ofono(a)ofono.org
https://lists.ofono.org/mailman/listinfo/ofono

--===============4591028988510533741==--

