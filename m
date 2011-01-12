Content-Type: multipart/mixed; boundary="===============4174542287846733638=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [RFC PATCH 2/4] gprs: add automatic context settings provisioning
Date: Wed, 12 Jan 2011 09:26:53 +0200
Message-ID: <1294817213.24900.10.camel@jsaunama-desktop>
In-Reply-To: <1294815077.3873.75.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4174542287846733638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Marcel,

On Tue, 2011-01-11 at 22:51 -0800, ext Marcel Holtmann wrote:
> >  =

> > -void ofono_gprs_register(struct ofono_gprs *gprs)
> > +static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
> >  {
> >  	DBusConnection *conn =3D ofono_dbus_get_connection();
> >  	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
> >  	const char *path =3D __ofono_atom_get_path(gprs->atom);
> >  	struct ofono_atom *netreg_atom;
> > -	struct ofono_atom *sim_atom;
> > +
> > +	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
> > +		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
> =

> so I see a potential race here between the UI trying to provision and us
> trying to provision.
> =

> We don't wanna end up with duplicated contexts here. Any ideas on how we
> could prevent that nicely? Or should we just fail any attempts to create
> new contexts if provisioning is still ongoing?

Code continues there with:
	if (!g_dbus_register_interface(conn, path,
					OFONO_CONNECTION_MANAGER_INTERFACE,
					manager_methods, manager_signals, NULL,
					gprs, NULL)) {
		ofono_error("Could not create %s interface",
				OFONO_CONNECTION_MANAGER_INTERFACE);

		return;
	}

	ofono_modem_add_interface(modem,
				OFONO_CONNECTION_MANAGER_INTERFACE);

Patch rearranges the initial context creation and interface
registration, so there is no DBUS interface for UI to use until
provisioning is ready. Or have misunderstood something?

--Jukka



--===============4174542287846733638==--

