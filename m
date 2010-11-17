Content-Type: multipart/mixed; boundary="===============5283339549542545461=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] plugin/ste: Use D-Bus API from Modem Init Daemon for
 autoconfig.
Date: Wed, 17 Nov 2010 14:00:49 +0100
Message-ID: <1289998849.29148.10.camel@aeonflux>
In-Reply-To: <AANLkTimHbn4ZRBA-3xvem6TFiKS4EinWywovh4=h4Vud@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5283339549542545461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> >> We definitely need a synchronization mechanism between Modem Init Daem=
on
> >> and the other services, so we decided to use a D-Bus API for the
> >> Modem Init Daemon to expose the modem state and an API for initiating
> >> power-off, upgrade and reboot.
> >
> > do you have a link to the D-Bus of this daemon? I would prefer if you
> > publish it first or at least the part of it used here.
> =

> This is an extract of the Modem Init Daemon D-Bus API.
> Should I could put this the git for reference e.g. in drivers/stemodem/?
> =

> Modem Init Deamon
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Service	com.stericsson.modeminit
> Interface	com.stericsson.modeminit.Modem
> Object path	/

so how to you handle the case if you have two or more CAIF based modems
in the system? oFono does not impose a limit here.

Regards

Marcel



--===============5283339549542545461==--

