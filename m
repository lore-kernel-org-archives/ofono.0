Content-Type: multipart/mixed; boundary="===============2322421129340203698=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 4/4] udev: add Telit UC864-G and update udev rules
Date: Wed, 08 Jun 2011 03:32:15 -0500
Message-ID: <4DEF338F.1020701@gmail.com>
In-Reply-To: <alpine.DEB.2.00.1106100958000.30119@entw48>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2322421129340203698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bernhard,

>>
>> From what I remember of the Telit modems, all ports are fully
>> functional, so the GPS port can be on any tty.  If this is the case,
>> then the way this can be accomplished is by querying the model /
>> revision of the modem during the enable() stage in the modem driver and
>> adding the appropriate atom as needed.
>>
> =

> The GPS port is not fully functional as far is I know it is read only.
> According to the manual it is necessary to enable over the modem line
> with AT$GPSP=3D1 afterwards it starts reporting NMEA signals on the GPS l=
ine.
> =


In theory you can use $GPSNMUN to enable GPS reporting on Ports 1 and 4
which seem to be fully functional.  However, it does look like on my
UC864-G, port #3 is used for the GPS stream.  Port #1 doesn't seem to
respond to anything.

> I like the environment setting with udev more. The approach with
> querying the model during enable() requires a update to the telit plugin
> every time a new model with gps is released. The comment about hardcode
> the interface number was an answer to the suggestion to look at the
> novatel udev code. Sorry for mixing up things.
> =

> After I dug deeper into the add_modem code I don't know if I have a
> problem at all :)
> =

> My current "problem" with the patch I sent is that I get into the
> =

>     if (modem =3D=3D NULL) {
>         const char *serial =3D get_serial(parent);
> =

>         modem =3D ofono_modem_create(serial, driver);
> =

> case.
> =

> ofonod[16327]: src/modem.c:ofono_modem_create() name: 000000000002,
> type: telit
> =

> So my modem dbus modem path is /000000000002 which I thought it was wrong.
> Everything else works well. The GPS value is set and both paths are set
> right.
> =

> So I think my real question is - is it the intended behavior to have the
> path like this? I don't have any supported modem to test (I really
> should by one :D ) and the phonesim is using /phonesim1 as path
> =


Yes and no.  ofono_modem_create has two modes of operation, one where a
known unique id is given.  This can come for example from the serial
number of the USB device.  Some manufacturers provide this information
properly, others do not.  If you cannot trust the USB serial ID, then
giving a NULL parameter to ofono_modem_create will tell oFono to
generate a unique id itself.  Your path will then look like /telit2 or
something like that.

Regards,
-Denis

--===============2322421129340203698==--

