Content-Type: multipart/mixed; boundary="===============2174093815589500908=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Using ofono for location service
Date: Wed, 11 Mar 2015 11:31:40 -0500
Message-ID: <55006DEC.8050709@gmail.com>
In-Reply-To: <50BCD3CCE3CFC54ABCADC6EDD7405570C5549E@BGSMSX104.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2174093815589500908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

 > Following are the logs:
> ./test/gn3
> Connecting modem /he910_0...
> ofonod[2389]: drivers/telitmodem/location-reporting.c:telit_location_repo=
rting_enable() lr=3D0x82e09e0
> ofonod[2389]: drivers/telitmodem/location-reporting.c:telit_portcfg_check=
_cb() lr=3D0x82e09e0 ok=3D1
> ofonod[2389]: drivers/telitmodem/location-reporting.c:telit_gps_enable_cb=
() lr=3D0x82e09e0 ok=3D1
> ofonod[2389]: drivers/telitmodem/location-reporting.c:telit_gps_ctl_cb() =
lr=3D0x82e09e0 ok=3D1
> ofonod[2389]: src/modem.c:get_modem_property() modem 0x82e2ba0 property G=
PS
> ofonod[2389]: drivers/telitmodem/location-reporting.c:telit_location_repo=
rting_disable() lr=3D0x82e09e0
> ofonod[2389]: drivers/telitmodem/location-reporting.c:telit_gps_disable_c=
b() lr=3D0x82e09e0, ok=3D1

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
> print("Connecting modem %s..." % path)
> modem =3D dbus.Interface(bus.get_object('org.ofono', path),
>                                                  'org.ofono.LocationRepor=
ting')
>
> fd =3D modem.Request()
>

What do you expect the script to do actually?

Once you obtain the file descriptor, your client must be around to do =

something with it (e.g. read NMEA strings).

As soon as the client(UNIX process) who performed the 'Request()' =

operation exits, oFono closes the fd and shuts down the NMEA port on the =

modem.

So everything is working as it should.

Regards,
-Denis

--===============2174093815589500908==--

