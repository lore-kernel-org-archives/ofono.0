Content-Type: multipart/mixed; boundary="===============6546740078108116652=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC][PATCH] Add: online method to isimodem
Date: Thu, 22 Apr 2010 20:25:34 -0500
Message-ID: <201004222025.34820.denkenz@gmail.com>
In-Reply-To: <1271947798-16962-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6546740078108116652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> ---
>  drivers/isimodem/isimodem.c |   38 +++++++---
>  gatchat/gatppp.c            |   16 ++++
>  gatchat/ppp.h               |    2 +
>  gatchat/ppp_lcp.c           |    4 +
>  gatchat/ppp_net.c           |   13 +++-
>  include/modem.h             |    6 ++
>  src/modem.c                 |  183
>  +++++++++++++++++++++++++++++++++++++++++++ src/ofono.h                 =
| =

>   11 +++
>  8 files changed, 260 insertions(+), 13 deletions(-)

In general it is a good idea to break up your patches when you're touching =

multiple areas at once.  So in this case this needs to be a set of patches =
for =

PPP support, set of patches for core support and finally a set of patches f=
or =

ISI modem.  The core changes should come before driver changes.

And why exactly are you including ppp patches along with isimodem?  I'm =

confused.

> diff --git a/include/modem.h b/include/modem.h
> index d502640..34cac7b 100644
> --- a/include/modem.h
> +++ b/include/modem.h
> @@ -50,6 +50,9 @@ void ofono_modem_remove(struct ofono_modem *modem);
>  void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool_t
>  powered); ofono_bool_t ofono_modem_get_powered(struct ofono_modem *modem=
);
> =

> +void ofono_modem_set_online(struct ofono_modem *modem, ofono_bool_t

This is assuming the driver can set online states outside of oFono control.=
  =

Tell me a use case where this makes sense please.  If this is meant to be u=
sed =

only by ofono core, then this function should not be declared here.

>  online); +ofono_bool_t ofono_modem_get_online(struct ofono_modem *modem);
> +

>  void ofono_modem_set_name(struct ofono_modem *modem, const char *name);
> =

>  int ofono_modem_set_string(struct ofono_modem *modem,
> @@ -85,6 +88,9 @@ struct ofono_modem_driver {
> =

>  	/* Populate the atoms that are available with SIM / Unlocked SIM*/
>  	void (*post_sim)(struct ofono_modem *modem);
> +
> +	/* Enable or disable cellular radio */
> +	int (*online)(struct ofono_modem *modem, ofono_bool_t online);

Only the core should drive the online state, so I suggest a callback functi=
on =

/ user data here.

>  };
> =

>  int ofono_modem_driver_register(const struct ofono_modem_driver *);
> diff --git a/src/modem.c b/src/modem.c
> index 8319702..05b1fed 100644
> --- a/src/modem.c
> +++ b/src/modem.c
> @@ -61,6 +61,11 @@ struct ofono_modem {
>  	ofono_bool_t		powered;
>  	ofono_bool_t		powered_pending;
>  	guint			timeout;
> +	DBusMessage		*pending_online;

We allow only one outstanding call / interface, so there's really no need f=
or =

this member.

> +	ofono_bool_t            online;
> +	ofono_bool_t            requested_online;

Lets be consistent with how powered is done at least...

> +	ofono_bool_t            online_timeout;

Is this supposed to be a guint?

> +	struct ofono_watchlist	*online_watches;
>  	GHashTable		*properties;
>  	struct ofono_sim	*sim;
>  	unsigned int		sim_watch;
> @@ -361,6 +366,9 @@ static DBusMessage *modem_get_properties(DBusConnecti=
on
>  *conn, OFONO_PROPERTIES_ARRAY_SIGNATURE,
>  					&dict);
> =

> +	ofono_dbus_dict_append(&dict, "Online", DBUS_TYPE_BOOLEAN,
> +				&modem->online);
> +

I think FlightMode will be more recognizable for the UI guys.

>  	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN,
>  				&modem->powered);
> =

> @@ -478,6 +486,158 @@ static gboolean set_powered_timeout(gpointer user)
>  	return FALSE;
>  }
> =

> +static int set_online(struct ofono_modem *modem, ofono_bool_t online)
> +{
> +	const struct ofono_modem_driver *driver =3D modem->driver;
> +	int err =3D -EINVAL;
> +
> +	if (modem->requested_online =3D=3D online)
> +		return -EALREADY;
> +
> +	modem->requested_online =3D online;
> +
> +	if (driver && driver->online)
> +		err =3D driver->online(modem, online);
> +	else if (powering_down && !online)
> +		err =3D 0;
> +
> +	if (err =3D=3D 0)
> +		ofono_modem_set_online(modem, online);
> +	else if (err !=3D -EINPROGRESS)
> +		modem->requested_online =3D modem->online;
> +
> +	return err;
> +}
> +
> +static gboolean set_online_timeout(gpointer user)
> +{
> +	struct ofono_modem *modem =3D user;
> +
> +	DBG("modem: %p", modem);
> +
> +	modem->online_timeout =3D 0;
> +	modem->requested_online =3D modem->online;
> +
> +	if (modem->pending)
> +		__ofono_dbus_pending_reply(&modem->pending,
> +				__ofono_error_timed_out(modem->pending));
> +
> +	return FALSE;
> +}
> +
> +static DBusMessage *set_property_online(struct ofono_modem *modem,
> +					DBusMessage *msg,
> +					DBusMessageIter *var)
> +{
> +	ofono_bool_t online;
> +	int err;
> +
> +	if (dbus_message_iter_get_arg_type(var) !=3D DBUS_TYPE_BOOLEAN)
> +		return __ofono_error_invalid_args(msg);
> +
> +	dbus_message_iter_get_basic(var, &online);
> +
> +	if (modem->pending_online !=3D NULL)
> +		return __ofono_error_busy(msg);
> +
> +	if (modem->online =3D=3D online)
> +		return dbus_message_new_method_return(msg);
> +
> +	modem->pending_online =3D dbus_message_ref(msg);
> +
> +	err =3D set_online(modem, online);
> +	if (err < 0) {
> +		if (err !=3D -EINPROGRESS && err !=3D -EALREADY)

Why are you checking for EALREADY again, you just checked this case 3 =

statements above...

> +			return __ofono_error_failed(msg);
> +
> +		modem->online_timeout =3D g_timeout_add_seconds(20,
> +						set_online_timeout, modem);
> +	}
> +
> +	return NULL;
> +}
> +
> +void ofono_modem_set_online(struct ofono_modem *modem, ofono_bool_t
>  online) +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	GSList *l;
> +	struct ofono_watchlist_item *watch;
> +	ofono_online_watch_func notify;
> +
> +	if (modem->online_timeout) {
> +		g_source_remove(modem->online_timeout);
> +		modem->online_timeout =3D 0;
> +	}
> +
> +	if (modem->pending_online) {
> +		DBusMessage *reply;
> +
> +		if (online =3D=3D modem->requested_online)
> +			reply =3D dbus_message_new_method_return(modem->pending_online);
> +		else
> +			reply =3D __ofono_error_failed(modem->pending_online);
> +
> +		__ofono_dbus_pending_reply(&modem->pending_online, reply);
> +	}
> +
> +	modem->requested_online =3D online;
> +
> +	if (modem->online =3D=3D online)
> +		return;
> +
> +	modem->online =3D online;
> +
> +	if (!modem->driver) {
> +		ofono_error("Calling ofono_modem_set_online on a"
> +				"modem with no driver is not valid, "
> +				"please fix the modem driver.");
> +		return;
> +	}
> +
> +	ofono_dbus_signal_property_changed(conn, modem->path,
> +					OFONO_MODEM_INTERFACE, "Online",
> +					DBUS_TYPE_BOOLEAN, &online);
> +
> +	for (l =3D modem->online_watches->items; l; l =3D l->next) {
> +		watch =3D l->data;
> +		notify =3D watch->notify;
> +		notify(modem, online, watch->notify_data);
> +	}
> +}
> +

<snip>

> +	if (modem->online =3D=3D TRUE)
> +		set_online(modem, FALSE);
> +

My overall feeling here is that there's no need to make FlightMode state so =

complicated.  Can we assume that powering down the modem from 'online' stat=
e =

will take care of bringing the hardware down cleanly and avoid explicitly =

calling the driver to bring it 'offline' first?

There's also the question of who stores the FlightMode user setting, and =

whether we store it by device ID or IMSI.

Regards,
-Denis

--===============6546740078108116652==--

