Content-Type: multipart/mixed; boundary="===============4222109678414616660=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 2/4] gprs: add automatic context settings provisioning
Date: Wed, 12 Jan 2011 08:37:56 -0800
Message-ID: <1294850276.3873.95.camel@aeonflux>
In-Reply-To: <1294817213.24900.10.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4222109678414616660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> > > -void ofono_gprs_register(struct ofono_gprs *gprs)
> > > +static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
> > >  {
> > >  	DBusConnection *conn =3D ofono_dbus_get_connection();
> > >  	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
> > >  	const char *path =3D __ofono_atom_get_path(gprs->atom);
> > >  	struct ofono_atom *netreg_atom;
> > > -	struct ofono_atom *sim_atom;
> > > +
> > > +	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
> > > +		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
> > =

> > so I see a potential race here between the UI trying to provision and us
> > trying to provision.
> > =

> > We don't wanna end up with duplicated contexts here. Any ideas on how we
> > could prevent that nicely? Or should we just fail any attempts to create
> > new contexts if provisioning is still ongoing?
> =

> Code continues there with:
> 	if (!g_dbus_register_interface(conn, path,
> 					OFONO_CONNECTION_MANAGER_INTERFACE,
> 					manager_methods, manager_signals, NULL,
> 					gprs, NULL)) {
> 		ofono_error("Could not create %s interface",
> 				OFONO_CONNECTION_MANAGER_INTERFACE);
> =

> 		return;
> 	}
> =

> 	ofono_modem_add_interface(modem,
> 				OFONO_CONNECTION_MANAGER_INTERFACE);
> =

> Patch rearranges the initial context creation and interface
> registration, so there is no DBUS interface for UI to use until
> provisioning is ready. Or have misunderstood something?

it could we well that I got lost in the re-arranged code ;)

If we wait with the Connection Manager interface registration until we
ran through all provision drivers, that seems fine. So no concerns from
my part then on the potential race conditions with the UI.

Regards

Marcel



--===============4222109678414616660==--

