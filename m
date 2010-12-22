Content-Type: multipart/mixed; boundary="===============9177364826006001976=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH 1/2] modem: add Lockdown property to Modem interface
Date: Wed, 22 Dec 2010 16:19:41 -0200
Message-ID: <20101222181941.GA16612@vigoh>
In-Reply-To: <4D0C0709.9050305@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9177364826006001976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

* Denis Kenzior <denkenz@gmail.com> [2010-12-17 18:57:45 -0600]:

> Hi Gustavo,
> =

> On 12/03/2010 03:59 PM, Gustavo F. Padovan wrote:
> > Setting Lockdown to TRUE means power down the modem and hold a lock that
> > only permits the lock's owner power up the modem back. When released
> > it restores the last state of the modem before holding the lock.
> > ---
> >  doc/modem-api.txt |    9 ++++
> >  src/modem.c       |  129 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 138 insertions(+), 0 deletions(-)
> =

> Can you break this up into two patches, one for doc and one for src?
> =

> > =

> > diff --git a/doc/modem-api.txt b/doc/modem-api.txt
> > index b92e53c..45043b0 100644
> > --- a/doc/modem-api.txt
> > +++ b/doc/modem-api.txt
> > @@ -37,6 +37,15 @@ Properties	boolean Powered [readwrite]
> >  			Boolean representing the rf state of the modem.
> >  			Online is false in flight mode.
> >  =

> > +		boolean Lockdown [readwrite]
> > +
> > +			Boolean representing the lock state of the modem.
> > +			Setting it to true, makes the calling application hold
> > +			the modem lock and power it down. Setting to false
> > +			makes the it release the modem lock. Only the
> > +			application that holds the lock can power up the modem.
> > +			If the the application exits Lockdown is set to false.
> > +
> >  		boolean Emergency [readonly, optional, experimental]
> >  =

> >  			Boolean representing the emergency mode of the
> > diff --git a/src/modem.c b/src/modem.c
> > index b334b58..a9a6e87 100644
> > --- a/src/modem.c
> > +++ b/src/modem.c
> > @@ -71,6 +71,9 @@ struct ofono_modem {
> >  	ofono_bool_t		powered;
> >  	ofono_bool_t		powered_pending;
> >  	ofono_bool_t		get_online;
> > +	ofono_bool_t		lockdown;
> > +	char			*lock_owner;
> > +	guint			lock_watch;
> >  	guint			timeout;
> >  	ofono_bool_t		online;
> >  	struct ofono_watchlist	*online_watches;
> > @@ -583,6 +586,9 @@ void __ofono_modem_append_properties(struct ofono_m=
odem *modem,
> >  	ofono_dbus_dict_append(dict, "Powered", DBUS_TYPE_BOOLEAN,
> >  				&modem->powered);
> >  =

> > +	ofono_dbus_dict_append(dict, "Lockdown", DBUS_TYPE_BOOLEAN,
> > +				&modem->lockdown);
> > +
> >  	devinfo_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_DEVIN=
FO);
> >  =

> >  	/* We cheat a little here and don't check the registered status */
> > @@ -686,6 +692,16 @@ static int set_powered(struct ofono_modem *modem, =
ofono_bool_t powered)
> >  	return err;
> >  }
> >  =

> > +static void lockdown_remove(struct ofono_modem *modem)
> > +{
> > +	DBusConnection *conn =3Dofono_dbus_get_connection();
> > +
> > +	g_free(modem->lock_owner);
> > +	g_dbus_remove_watch(conn, modem->lock_watch);
> > +	modem->lock_watch =3D 0;
> > +	modem->lockdown =3D FALSE;
> > +}
> > +
> >  static gboolean set_powered_timeout(gpointer user)
> >  {
> >  	struct ofono_modem *modem =3D user;
> > @@ -712,11 +728,107 @@ static gboolean set_powered_timeout(gpointer use=
r)
> >  =

> >  		reply =3D __ofono_error_timed_out(modem->pending);
> >  		__ofono_dbus_pending_reply(&modem->pending, reply);
> > +
> > +		if (modem->lockdown)
> > +			lockdown_remove(modem);
> >  	}
> >  =

> >  	return FALSE;
> >  }
> >  =

> > +static void lockdown_disconnect(DBusConnection *conn, void *user_data)
> > +{
> > +	struct ofono_modem *modem =3D user_data;
> > +
> > +	DBG("");
> > +
> > +	g_free(modem->lock_owner);
> > +
> > +	modem->lockdown =3D FALSE;
> > +
> > +	ofono_dbus_signal_property_changed(conn, modem->path,
> > +					OFONO_MODEM_INTERFACE,
> > +					"Lockdown", DBUS_TYPE_BOOLEAN,
> > +					&modem->lockdown);
> =

> Should you also be removing the lock_watch here?  Since the lock_watch
> is no longer relevant and you'll be leaking it otherwise.

gdbus remove the watch for us in this case. So no leak here.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============9177364826006001976==--

