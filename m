Content-Type: multipart/mixed; boundary="===============7646127707169315575=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: driver callback naming
Date: Sat, 29 Aug 2009 18:01:15 -0400
Message-ID: <20090829180115.4d5744e5@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7646127707169315575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Slightly bikesheddy, but.. The ofono_modem_driver callback naming is
pretty confusing.  Currently, it's:


static struct ofono_modem_driver g1_driver =3D {
        .name =3D "HTC G1",
        .probe =3D g1_probe,
        .enable =3D g1_enable,
        .disable =3D g1_disable,
        .remove =3D g1_remove,
        .populate =3D g1_populate,
};


I'm used to probe/remove in the kernel being used for device detection
and allocating related resources (as well as powering up or down pci
devices and such), but the enable/disable names tell me nothing.
What's being enabled?  Is 'probe' just a thin layer that detects
whether a device is present and then defers to 'enable' to set it
up (and if so, should we it called 'detect' or something that
doesn't imply a kernel-like 'probe' function)?  Denkenz informs me that
it's for setting power to devices; if that's the case, a better name
might be powerup/powerdown.

Of course, I'm also wondering why there needs to be two separate layers
of calls in the first place.  Why not have drivers register everything
from within probe, call ofono_set_powered(modem, TRUE) once the device
is ready, and be done with it?

This question comes up because sending SIGTERM to the
daemon ends up calling g1_exit, which (in my case) was freeing the
ofono_modem->private_data first, and then calling ofono_modem_remove.
This in turn was calling the 'disable' callback, which expected
ofono_modem->private_data to exist.

The only reason why this doesn't blow up in the generic_at plugin is
because the driver_data is leaked.  If one were to free it from
generic_at_exit in the wrong place (since it's allocated from
generic_at_init, it would make sense to free it in generic_at_exit),
one would see the same SEGV/SIGBUS/SIGILL errors upon ctrl-c.



--===============7646127707169315575==--

