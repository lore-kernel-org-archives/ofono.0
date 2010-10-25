Content-Type: multipart/mixed; boundary="===============8191911628661535858=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 1/6] radio settings: add FastDormancy property
Date: Mon, 25 Oct 2010 17:05:28 +0200
Message-ID: <C358A26273CF2948B8BCDBA661A581782A7D885430@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <1288017001.3613.7.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8191911628661535858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> > @@ -103,14 +103,60 @@ static DBusMessage =

> *radio_get_properties_reply(DBusMessage *msg,
> >  					=

> OFONO_PROPERTIES_ARRAY_SIGNATURE,
> >  					&dict);
> >  =

> > -	ofono_dbus_dict_append(&dict, "TechnologyPreference",
> > +	if ((int)rs->mode !=3D -1) {
> > +		const char *mode =3D =

> radio_access_mode_to_string(rs->mode);
> > +		ofono_dbus_dict_append(&dict, "TechnologyPreference",
> >  					DBUS_TYPE_STRING, &mode);
> =

> what is up with this (int) rs->mode cast here. That looks highly wrong
> to me. The mode is an enum so please don't hack around it like this.
>
> If mode can be invalid or not present then we need to extend this enum
> with an initial value of OFONO_RADIO_ACCESS_MODE_UNKNOWN, but not hack
> some cast magic into it.

Yes, it's fishy. Denis introduced the enum in commit 81bc8884b414e6c2d51178=
9d2e183cdad55182f0 but left mode initialized as -1. I'm not sure what's up =
with that but I did not want to start fixing it. I suppose the initializer =
could be added to the enum, as you say, or the whole patch could be reverte=
d. Not my call, though.

> Or you use some flags like for the cached value.
>
> And I would propose the same for fast dormancy value. Lets =

> store it as a
> boolean and have a flag if it is present or not.

That's what I did in the previous patch but Denis wanted a single CACHED fl=
ag. Guys, please try to agree on this.

	MikaL

--===============8191911628661535858==--

