Content-Type: multipart/mixed; boundary="===============0163176106259198553=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 2/4] modem: add EmergencyMode property
Date: Fri, 03 Dec 2010 13:19:58 -0600
Message-ID: <4CF942DE.4010004@gmail.com>
In-Reply-To: <72f9600236cce58ec920ec3ad84b8cc34597c0ca.1290610393.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0163176106259198553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

<snip>

> +static void modem_change_online(struct ofono_modem *modem,
> +				enum modem_state new_state)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	enum modem_state old_state =3D modem->modem_state;
> +	ofono_bool_t new_online =3D new_state =3D=3D MODEM_STATE_ONLINE;
> +
> +	DBG("old state: %d, new state: %d", old_state, new_state);
> +
> +	if (new_online =3D=3D modem->online)
> +		return;

You check for online not being equal here

> +
> +	modem->modem_state =3D new_state;
> +	modem->online =3D new_online;
> +
> +	ofono_dbus_signal_property_changed(conn, modem->path,
> +					OFONO_MODEM_INTERFACE, "Online",
> +					DBUS_TYPE_BOOLEAN, &modem->online);
> +
> +	notify_online_watches(modem);
> +}
> +
> +static void emergency_online_cb(const struct ofono_error *error, void *d=
ata)
> +{
> +	struct ofono_modem *modem =3D data;
> +
> +	DBG("modem: %p", modem);
> +
> +	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
> +			modem->modem_state !=3D MODEM_STATE_ONLINE)

And perform essentially the same check here...  Seems wasteful

> +		modem_change_online(modem, MODEM_STATE_ONLINE);
> +}
> +
> +static void emergency_offline_cb(const struct ofono_error *error, void *=
data)
> +{
> +	struct ofono_modem *modem =3D data;
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D ofono_modem_get_path(modem);
> +	gboolean state =3D FALSE;
> +
> +	DBG("modem: %p", modem);
> +
> +	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
> +			modem->modem_state =3D=3D MODEM_STATE_ONLINE)
> +		modem_change_online(modem, modem->modem_state_pre_emergency);

Same comment as above

> +
> +	modem->emergency--;
> +
> +	ofono_dbus_signal_property_changed(conn, path,
> +					OFONO_MODEM_INTERFACE,
> +					"Emergency",
> +					DBUS_TYPE_BOOLEAN,
> +					&state);
> +}
> +
> +void ofono_modem_inc_emergency(struct ofono_modem *modem)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D ofono_modem_get_path(modem);
> +	gboolean state =3D TRUE;
> +
> +	DBG("modem: %p", modem);
> +
> +	modem->emergency++;
> +	if (modem->emergency > 1)
> +		return;
> +
> +	ofono_dbus_signal_property_changed(conn, path,
> +						OFONO_MODEM_INTERFACE,
> +						"Emergency",
> +						DBUS_TYPE_BOOLEAN,
> +						&state);
> +
> +	modem->modem_state_pre_emergency =3D modem->modem_state;
> +
> +	if (modem->modem_state =3D=3D MODEM_STATE_ONLINE)
> +		return;

So my only major concern left is here actually.  If we activate an
emergency call and a set_property(Online, blah) is active, we get into
some funny race conditions.  I mentioned these to Pekka on IRC.  But
basically the worst one is if we have an Online=3DFalse operation pending.
 In this case your call proceeds, but then gets terminated shortly
thereafter by the offline procedure ;)

> +
> +	modem->driver->set_online(modem, TRUE, emergency_online_cb, modem);
> +}
> +

<snip>

> diff --git a/src/ofono.h b/src/ofono.h
> index d1a4bdc..11d939d 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -58,6 +58,7 @@ DBusMessage *__ofono_error_not_attached(DBusMessage *ms=
g);
>  DBusMessage *__ofono_error_attach_in_progress(DBusMessage *msg);
>  DBusMessage *__ofono_error_canceled(DBusMessage *msg);
>  DBusMessage *__ofono_error_access_denied(DBusMessage *msg);
> +DBusMessage *__ofono_error_emergency_active(DBusMessage *msg);

Can you put this into a separate patch?

>  =

>  void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply);
>  =

> @@ -185,6 +186,10 @@ unsigned int __ofono_modem_add_online_watch(struct o=
fono_modem *modem,
>  void __ofono_modem_remove_online_watch(struct ofono_modem *modem,
>  					unsigned int id);
>  =

> +ofono_bool_t ofono_modem_get_emergency(struct ofono_modem *modem);
> +void ofono_modem_inc_emergency(struct ofono_modem *modem);
> +void ofono_modem_dec_emergency(struct ofono_modem *modem);
> +
>  #include <ofono/call-barring.h>
>  =

>  gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb);

And please resubmit the entire series, seeing only patch 2/4 and patch
4/4 is quite confusing.

Regards,
-Denis

--===============0163176106259198553==--

