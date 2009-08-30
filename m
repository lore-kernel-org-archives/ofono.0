Content-Type: multipart/mixed; boundary="===============0119970601483897664=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: driver callback naming
Date: Sun, 30 Aug 2009 13:45:45 -0500
Message-ID: <200908301345.45643.denkenz@gmail.com>
In-Reply-To: <20090829180115.4d5744e5@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0119970601483897664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andres,

> static struct ofono_modem_driver g1_driver =3D {
>         .name =3D "HTC G1",
>         .probe =3D g1_probe,
>         .enable =3D g1_enable,
>         .disable =3D g1_disable,
>         .remove =3D g1_remove,
>         .populate =3D g1_populate,
> };
>

So the current intention:
.probe - Detect whether device is really supported by the plugin, initializ=
e =

any data structures specific to the device
.remove - Destroy data structures
.enable - Perform power up
.disable - Perform power down
.populate - Populate the atoms supported by this device (e.g. netreg, =

voicecall, etc)  This is called by the core after every power cycle, when t=
he =

device is brought up.

>
> Of course, I'm also wondering why there needs to be two separate layers
> of calls in the first place.  Why not have drivers register everything
> from within probe, call ofono_set_powered(modem, TRUE) once the device
> is ready, and be done with it?

The reason for this is e.g. airplane mode, where you physically want to tur=
n =

off the device.  Another case is for battery / power reasons, e.g. a netboo=
k =

with a USB modem that is not being used.

> The only reason why this doesn't blow up in the generic_at plugin is
> because the driver_data is leaked.  If one were to free it from
> generic_at_exit in the wrong place (since it's allocated from
> generic_at_init, it would make sense to free it in generic_at_exit),
> one would see the same SEGV/SIGBUS/SIGILL errors upon ctrl-c.

So the leak has now been fixed.

I think you're being unnecessarily harsh here.  To be fair, the generic_at =

driver does something like this at init:

create generic_data
create modem
set modem data
register modem

If you were to reverse the steps, e.g.:
remove_modem
destroy generic_data

everything would work just fine.

Regards,
-Denis

--===============0119970601483897664==--

