Content-Type: multipart/mixed; boundary="===============0411249922007538533=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH v2] sim: validate IMS private identity
Date: Sat, 16 Jan 2021 00:14:02 +0300
Message-ID: <YAIFmpdNlC4dwsXH@curiosity>
In-Reply-To: <4387f20f-f716-13a1-3459-2fb6945665ac@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0411249922007538533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > > > Make sure that IMS private identity is a valid UTF8 string before
> > > > setting sim->impi field. Otherwise ofono may crash on dbus assert
> > > > when SIM properties are reported via org.ofono.SimManager interface.
> > > > ---
> > > >    src/sim.c | 3 ++-
> > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > =

> > > > diff --git a/src/sim.c b/src/sim.c
> > > > index 33e1245f..2a663e2d 100644
> > > > --- a/src/sim.c
> > > > +++ b/src/sim.c
> > > > @@ -1664,7 +1664,8 @@ static void impi_read_cb(int ok, int total_le=
ngth, int record,
> > > >    		return;
> > > >    	}
> > > > -	sim->impi =3D g_strndup((const char *)data + 2, data[1]);
> > > > +	if (g_utf8_validate((const char *)data + 2, data[1], NULL))
> > > > +		sim->impi =3D g_strndup((const char *)data + 2, data[1]);
> > > =

> > > I assume this code path was tested with a file containing embedded NU=
Ls as
> > > that is the only way it would have worked.
> =

> Ignore the last part of the above sentence.  What I'm trying to say is th=
at:
> =

> We in theory have two possibilities:
> =

> 1. file with a string 'foo', no null:
> 0x80 0x03 'f' 'o' 'o'
> =

> 2. file with  a string 'foo' and null:
> 0x80 0x04 'f' 'o' 'o'
> =

> I suspect the spec really wants 1, but maybe it can be interpreted that 2=
 is
> also a possibility?
> =

> The present logic should work for either of the above, but not what you h=
ave, i.e.:
> =

> 0x80 0x03 0xff 0xff 0xff
> =

> > > =

> > > glib docs [1] say:
> > > "Note that g_utf8_validate() returns FALSE if max_len is positive and=
 any of
> > > the max_len bytes are nul."
> > > =

> > > So I think the above logic would flag such a file as invalid, no?
> > =

> =

> ...but g_utf8_validate as invoked in this patch would flag possibility 2 =
as
> invalid...

True. Thanks for detailed clarification. Indeed, both cases needs to be
supported. Let me double-check and come back with v3.

Regards,
Sergey
--===============0411249922007538533==--

