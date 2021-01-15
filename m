Content-Type: multipart/mixed; boundary="===============8581320494957828686=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH] sim: validate IMS private identity
Date: Fri, 15 Jan 2021 22:23:05 +0300
Message-ID: <YAHrmTm8g3uptY8j@curiosity>
In-Reply-To: <d70b4ed7-3fb9-1a33-1cf8-e2c28e6bc16a@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8581320494957828686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > Make sure that IMPI is a valid UTF8 string before attempting
> > to report it via DBus. Otherwise ofono may crash on dbus assert.
> > This field may not be defined for ISIM in use. In this case the
> > field still can be read from ISIM, though it will not contain
> > a valid UTF8 string. For instance, it may contain 255 0xFF bytes.
> =

> Ugh, seems like the SIM vendor can't follow RFC's either?  31.103 Section
> 4.2.2 says:
> =

> "For contents and syntax of NAI TLV data object values see IETF RFC 2486
> [24]. The NAI shall be encoded to an octet string according to UTF-8
> encoding rules as specified in IETF RFC 3629 [27]. The tag value of the N=
AI
> TLV data object shall be '80'. "

This crash occured during my experiments with eSIM. As I mentioned, the
content of that TLV data object was 0xff bytes. IIUC it looks like vendor
could just skip initialization of that particular TLV data object during
bootstrap. Though I am not yet familiar with eSIM init procedure...

> > ---
> >   src/sim.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > =

> > diff --git a/src/sim.c b/src/sim.c
> > index 33e1245f..f60f5d1b 100644
> > --- a/src/sim.c
> > +++ b/src/sim.c
> > @@ -423,7 +423,7 @@ static DBusMessage *sim_get_properties(DBusConnecti=
on *conn,
> >   		ofono_dbus_dict_append(&dict, "ServiceProviderName",
> >   					DBUS_TYPE_STRING, &sim->spn);
> > -	if (sim->impi)
> > +	if (sim->impi && g_utf8_validate(sim->impi, 255, NULL))
> =

> Hmm, this would imply that we're setting sim->impi incorrectly..  Also,
> since we have __ofono_sim_get_impi() API, the better fix would be to make
> sure sim->impi is set correctly in impi_read_cb()

Ok. I will set sim->impi in impi_read_cb only if it is a valid UTF8 string.

Regards,
Sergey
--===============8581320494957828686==--

