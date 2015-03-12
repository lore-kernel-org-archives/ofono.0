Content-Type: multipart/mixed; boundary="===============5255154985698957610=="
MIME-Version: 1.0
From: Rajashekharaiah, Kiran KumarX <kiran.kumarx.rajashekharaiah@intel.com>
Subject: RE: Using ofono for location service
Date: Thu, 12 Mar 2015 11:56:30 +0000
Message-ID: <50BCD3CCE3CFC54ABCADC6EDD7405570C55553@BGSMSX104.gar.corp.intel.com>
In-Reply-To: <222E70FA67D72A4FB8EEDF5AF01724ACC99C73@BGSMSX102.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5255154985698957610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Following are the logs:
> ./test/gn3
> Connecting modem /he910_0...
> ofonod[2389]: =

> drivers/telitmodem/location-reporting.c:telit_location_reporting_enabl
> e() lr=3D0x82e09e0
> ofonod[2389]: =

> drivers/telitmodem/location-reporting.c:telit_portcfg_check_cb()
> lr=3D0x82e09e0 ok=3D1
> ofonod[2389]: =

> drivers/telitmodem/location-reporting.c:telit_gps_enable_cb()
> lr=3D0x82e09e0 ok=3D1
> ofonod[2389]: =

> drivers/telitmodem/location-reporting.c:telit_gps_ctl_cb()
> lr=3D0x82e09e0 ok=3D1
> ofonod[2389]: src/modem.c:get_modem_property() modem 0x82e2ba0 =

> property GPS
> ofonod[2389]: =

> drivers/telitmodem/location-reporting.c:telit_location_reporting_disab
> le() lr=3D0x82e09e0
> ofonod[2389]: =

> drivers/telitmodem/location-reporting.c:telit_gps_disable_cb()
> lr=3D0x82e09e0, ok=3D1

Everything looks as it should here.

>
> The test script I am using is:
>
> import dbus
> import sys
> import glib
>
> bus =3D dbus.SystemBus()
>
> if len(sys.argv) =3D=3D 2:
>          path =3D sys.argv[1]
> else:
>          manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
>                          'org.ofono.Manager')
>          modems =3D manager.GetModems()
>          path =3D modems[0][0]
>
> print("Connecting modem %s..." % path) modem =3D =

> dbus.Interface(bus.get_object('org.ofono', path),
>                                                  =

> 'org.ofono.LocationReporting')
>
> fd =3D modem.Request()
>

What do you expect the script to do actually?

Once you obtain the file descriptor, your client must be around to do somet=
hing with it (e.g. read NMEA strings).

As soon as the client(UNIX process) who performed the 'Request()' =

operation exits, oFono closes the fd and shuts down the NMEA port on the mo=
dem.

So everything is working as it should.

Kiran: I am facing problem while reading from the file descriptor I got fro=
m modem.request(). One observation is, I get  =

"modem=3D/dev/ttyACM0 aux=3D/dev/ttyACM3 gps=3D/dev/ttyACM5" from ofonod lo=
gs, but /dev/ttyACM5 is not accepting AT commands when I try from minicom.
Should I change gps port also to /dev/ttyACM3?

Regards,
Kiran

--===============5255154985698957610==--

