Content-Type: multipart/mixed; boundary="===============4898459758204434655=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 2/4] Core support for packet switched bearer reporting
Date: Mon, 10 Jan 2011 13:19:53 +0200
Message-ID: <201101101319.53668.remi.denis-courmont@nokia.com>
In-Reply-To: <4D273E7C.7080605@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4898459758204434655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 07 January 2011 18:25:32 ext Denis Kenzior, you wrote:
> > @@ -2001,6 +2010,29 @@ void ofono_gprs_add_context(struct ofono_gprs
> > *gprs,
> > =

> >  	__ofono_atom_register(gc->atom, gprs_context_unregister);
> >  =

> >  }
> > =

> > +void ofono_gprs_bearer_notify(struct ofono_gprs *gprs,
> > +				unsigned int cid, int bearer)
> > +{
> > +	DBusConnection *conn =3D ofono_dbus_get_connection();
> > +	GSList *l;
> > +	const char *value =3D packet_bearer_to_string(bearer);
> =

> Why bother running this operation before you're sure you're going to
> emit the signal?

Now that we're talking about network-initiated LTE bearers, I would rather =
be =

safe than sorry. I wouldn't assume that the modem will signal the CPSB =

(unchanged) value later in this case.

> Please move this down.

To avoid any race, we have to query the existing CPSB values after we enabl=
e =

the CPSB subscription, right? We could surely move that to a later stage, b=
ut =

I don't see the benefit.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============4898459758204434655==--

