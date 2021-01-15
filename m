Content-Type: multipart/mixed; boundary="===============2503926598250789930=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH v2] sim: validate IMS private identity
Date: Fri, 15 Jan 2021 23:34:14 +0300
Message-ID: <YAH8Rjcdxpkk1jTo@curiosity>
In-Reply-To: <091b23a6-70aa-64c0-d968-8c0de2ab7846@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2503926598250789930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > Make sure that IMS private identity is a valid UTF8 string before
> > setting sim->impi field. Otherwise ofono may crash on dbus assert
> > when SIM properties are reported via org.ofono.SimManager interface.
> > ---
> >   src/sim.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > =

> > diff --git a/src/sim.c b/src/sim.c
> > index 33e1245f..2a663e2d 100644
> > --- a/src/sim.c
> > +++ b/src/sim.c
> > @@ -1664,7 +1664,8 @@ static void impi_read_cb(int ok, int total_length=
, int record,
> >   		return;
> >   	}
> > -	sim->impi =3D g_strndup((const char *)data + 2, data[1]);
> > +	if (g_utf8_validate((const char *)data + 2, data[1], NULL))
> > +		sim->impi =3D g_strndup((const char *)data + 2, data[1]);
> =

> I assume this code path was tested with a file containing embedded NULs as
> that is the only way it would have worked.
> =

> glib docs [1] say:
> "Note that g_utf8_validate() returns FALSE if max_len is positive and any=
 of
> the max_len bytes are nul."
> =

> So I think the above logic would flag such a file as invalid, no?

No, I tested using modem with attached SIM/eSIM. TLV data object appears
to be well-formed, but the contents is all padding 0xff bytes. Could you
please clarify your concern ? I assume we can not rely on the content
being properly null terminated string.

Regards,
Sergey
--===============2503926598250789930==--

