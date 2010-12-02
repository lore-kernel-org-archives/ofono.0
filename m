Content-Type: multipart/mixed; boundary="===============8268446489566742414=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] Add Lockdown property to Modem interface
Date: Thu, 02 Dec 2010 14:08:45 -0600
Message-ID: <4CF7FCCD.2020101@gmail.com>
In-Reply-To: <1290711740-27886-4-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8268446489566742414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/25/2010 01:02 PM, Gustavo F. Padovan wrote:
> Setting Lockdown to TRUE means power down the modem and hold a lock that
> only permits the lock's owner power up the modem back. When released
> it restores the last state of the modem before holding the lock.
> ---
>  doc/modem-api.txt |   10 +++++
>  src/modem.c       |  105 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 115 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/modem-api.txt b/doc/modem-api.txt
> index b92e53c..7189245 100644
> --- a/doc/modem-api.txt
> +++ b/doc/modem-api.txt
> @@ -37,6 +37,16 @@ Properties	boolean Powered [readwrite]
>  			Boolean representing the rf state of the modem.
>  			Online is false in flight mode.
>  =

> +		boolean Lockdown [readwrite]
> +
> +			Boolean representing the lock state of the modem.
> +			Setting it to true, makes the calling application hold
> +			the modem lock and power it down. Setting to false
> +			makes the it restore the modem state before the
> +			lockdown and release the modem lock. Only the

Can you update the docs to mention that oFono does not re-power up the
modem.

> +			application that holds the lock can power up the modem.
> +			If the the application exits Lockdown is set to false.
> +
>  		boolean Emergency [readonly, optional, experimental]
>  =

>  			Boolean representing the emergency mode of the
> diff --git a/src/modem.c b/src/modem.c
> index 1828a3b..0ad488d 100644
> --- a/src/modem.c
> +++ b/src/modem.c
> @@ -71,6 +71,9 @@ struct ofono_modem {
>  	ofono_bool_t		powered;
>  	ofono_bool_t		powered_pending;
>  	ofono_bool_t		get_online;
> +	ofono_bool_t		lockdown;
> +	char			*lock_owner;
> +	guint			lock_watch;
>  	guint			timeout;
>  	ofono_bool_t		online;
>  	struct ofono_watchlist	*online_watches;
> @@ -579,6 +582,9 @@ void __ofono_modem_append_properties(struct ofono_mod=
em *modem,
>  	ofono_dbus_dict_append(dict, "Powered", DBUS_TYPE_BOOLEAN,
>  				&modem->powered);
>  =

> +	ofono_dbus_dict_append(dict, "Lockdown", DBUS_TYPE_BOOLEAN,
> +				&modem->lockdown);
> +
>  	devinfo_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_DEVINFO=
);
>  =

>  	/* We cheat a little here and don't check the registered status */
> @@ -713,6 +719,22 @@ static gboolean set_powered_timeout(gpointer user)
>  	return FALSE;
>  }
>  =

> +static void lockdown_disconnect(DBusConnection *conn, void *user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +
> +	DBG("");
> +
> +	g_free(modem->lock_owner);
> +
> +	modem->lockdown =3D FALSE;
> +
> +	ofono_dbus_signal_property_changed(conn, modem->path,
> +					OFONO_MODEM_INTERFACE,
> +					"Lockdown", DBUS_TYPE_BOOLEAN,
> +					&modem->lockdown);
> +}
> +
>  static DBusMessage *modem_set_property(DBusConnection *conn,
>  					DBusMessage *msg, void *data)
>  {
> @@ -755,6 +777,9 @@ static DBusMessage *modem_set_property(DBusConnection=
 *conn,
>  		if (modem->powered =3D=3D powered)
>  			return dbus_message_new_method_return(msg);
>  =

> +		if (modem->lockdown)
> +			return __ofono_error_access_denied(msg);
> +
>  		err =3D set_powered(modem, powered);
>  		if (err < 0) {
>  			if (err !=3D -EINPROGRESS)
> @@ -786,6 +811,81 @@ static DBusMessage *modem_set_property(DBusConnectio=
n *conn,
>  		return NULL;
>  	}
>  =

> +	if (g_str_equal(name, "Lockdown")) {

Can you break this out into a separate function, similar to how we
handle Online?  Otherwise this function becomes way too long.

> +		ofono_bool_t lockdown, powered;
> +		const char *caller;
> +		int err;
> +
> +		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
> +			return __ofono_error_invalid_args(msg);
> +
> +		dbus_message_iter_get_basic(&var, &lockdown);
> +
> +		if (modem->pending !=3D NULL)
> +			return __ofono_error_busy(msg);
> +
> +		if (modem->lockdown =3D=3D lockdown)
> +			return dbus_message_new_method_return(msg);
> +
> +		if (modem->powered !=3D modem->powered_pending)
> +			return __ofono_error_not_available(msg);
> +
> +		caller =3D dbus_message_get_sender(msg);
> +
> +		if (lockdown) {
> +			modem->lock_owner =3D g_strdup(caller);
> +
> +			modem->lock_watch =3D g_dbus_add_service_watch(conn,
> +					modem->lock_owner, NULL,
> +					lockdown_disconnect, modem, NULL);
> +
> +			if (modem->lock_watch =3D=3D 0) {
> +				g_free(modem->lock_owner);
> +				return __ofono_error_failed(msg);
> +			}
> +
> +			powered =3D FALSE;
> +
> +		} else {
> +			if (g_strcmp0(caller, modem->lock_owner))
> +				return __ofono_error_access_denied(msg);
> +
> +			g_free(modem->lock_owner);
> +			g_dbus_remove_watch(conn, modem->lock_watch);
> +			modem->lock_watch =3D 0;
> +		}
> +
> +		modem->lockdown =3D lockdown;
> +
> +		g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
> +
> +		ofono_dbus_signal_property_changed(conn, modem->path,
> +						OFONO_MODEM_INTERFACE,
> +						"Lockdown", DBUS_TYPE_BOOLEAN,
> +						&lockdown);
> +
> +		if (!modem->lockdown)
> +			return NULL;
> +
> +		err =3D set_powered(modem, powered);
> +		if (err < 0) {
> +			if (err !=3D -EINPROGRESS)
> +				return __ofono_error_failed(msg);
> +
> +			modem->pending =3D dbus_message_ref(msg);
> +			modem->timeout =3D g_timeout_add_seconds(20,
> +						set_powered_timeout, modem);
> +			return NULL;
> +		}
> +
> +		ofono_dbus_signal_property_changed(conn, modem->path,
> +						OFONO_MODEM_INTERFACE,
> +						"Powered", DBUS_TYPE_BOOLEAN,
> +						&powered);
> +
> +		return NULL;
> +	}
> +

One thing that might make this a little bit safer is to set pending and
return from setting lockdown only when the modem has been powered off.
Otherwise you might do nastiness like this:
Lockdown =3D True,
Lockdown =3D False
Powered =3D True

Since we're in the middle of the old powered down operation as a result
of Lockdown, we might get truly confused.

>  	return __ofono_error_invalid_args(msg);
>  }
>  =

> @@ -1588,6 +1688,11 @@ static void modem_unregister(struct ofono_modem *m=
odem)
>  		modem->interface_update =3D 0;
>  	}
>  =

> +	if (modem->lock_watch) {
> +		g_dbus_remove_watch(conn, modem->lock_watch);
> +		modem->lock_watch =3D 0;
> +	}
> +
>  	g_dbus_unregister_interface(conn, modem->path, OFONO_MODEM_INTERFACE);
>  =

>  	if (modem->driver && modem->driver->remove)

Regards,
-Denis

--===============8268446489566742414==--

