Content-Type: multipart/mixed; boundary="===============5649545270907609561=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/4] nettime: Network time plugin implementation
Date: Mon, 07 Feb 2011 10:58:40 -0800
Message-ID: <1297105120.1520.427.camel@aeonflux>
In-Reply-To: <1296571771-26513-2-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5649545270907609561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

>  plugins/nettime.c |  326 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 326 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/nettime.c

I would prefer if we call this nokia-timed.c or in case this actually
becomes default part of MeeGo, them maybe meego-timed.c. I would be also
fine with {nokia,meego}-nettime.c.

Just calling it nettime.c is too generic. It needs to be clear what this
is for.

> +#define TIMED_PATH "/com/meego/time"
> +#define TIMED_SERVICE "com.meego.time"

So the intention is to convert the Nokia timed into a MeeGo specific
daemon? I would have expected to see com.nokia.timed here.

> +struct nt_data {
> +	gboolean time_available;
> +	gboolean time_pending;
> +	time_t nw_time_utc;
> +	time_t received;
> +	int dst;
> +	int time_zone;
> +	const char *mcc;
> +	const char *mnc;

Why do you bother with these here. You might better just reference the
netreg atom. The memory is only valid if netreg atom is present.

> +	unsigned int timed_watch;
> +	gboolean timed_present;
> +	struct ofono_netreg *netreg;
> +	unsigned int netreg_st_watch;
> +
> +};
> +
> +static void nettime_register(struct ofono_nettime_context *);
> +
> +static gboolean encode_time_format(struct ofono_network_time *time,
> +				 struct tm *tm)
> +{
> +
> +	tm->tm_gmtoff =3D time->utcoff;
> +	tm->tm_isdst =3D time->dst;
> +
> +	if (time->year < 0)
> +		return FALSE;
> +
> +	tm->tm_year =3D time->year - 1900;
> +	tm->tm_mon =3D time->mon - 1;
> +	tm->tm_mday =3D time->mday;
> +	tm->tm_hour =3D time->hour;
> +	tm->tm_min =3D time->min;
> +	tm->tm_sec =3D time->sec;
> +
> +	return TRUE;
> +}
> +
> +static time_t get_monotonic_time()
> +{
> +	struct timespec ts;
> +	clock_gettime(CLOCK_MONOTONIC, &ts);
> +	return ts.tv_sec;
> +}
> +
> +static int fill_time_notification(DBusMessage *msg,
> +		struct nt_data *ntd)
> +{
> +	DBusMessageIter iter, iter_array;
> +	int64_t utc;
> +
> +	dbus_message_iter_init_append(msg, &iter);
> +	dbus_message_iter_open_container(&iter,
> +					DBUS_TYPE_ARRAY,
> +					"{sv}",
> +					&iter_array);
> +
> +	if (ntd->time_pending) {
> +		if (ntd->time_available) {
> +			utc =3D ntd->nw_time_utc - ntd->received;
> +			ofono_dbus_dict_append(&iter_array,
> +						"UTC",
> +						DBUS_TYPE_INT64,
> +						&utc);
> +		}
> +
> +		ofono_dbus_dict_append(&iter_array,
> +					"DST",
> +					DBUS_TYPE_INT32,
> +					&ntd->dst);
> +		ofono_dbus_dict_append(&iter_array,
> +					"Timezone",
> +					DBUS_TYPE_INT32,
> +					&ntd->time_zone);
> +	}
> +
> +	ofono_dbus_dict_append(&iter_array,
> +			"MobileCountryCode",
> +			DBUS_TYPE_STRING,
> +			&ntd->mcc);
> +	ofono_dbus_dict_append(&iter_array,
> +			"MobileNetworkCode",
> +			DBUS_TYPE_STRING,
> +			&ntd->mnc);
> +
> +	dbus_message_iter_close_container(&iter, &iter_array);
> +	return 0;
> +}
> +
> +static DBusMessage *create_time_notification(
> +			struct ofono_nettime_context *context)
> +{
> +	DBusMessage *message;
> +	struct nt_data *ntd =3D context->data;
> +	const char *path =3D ofono_modem_get_path(context->modem);
> +
> +	if (path =3D=3D NULL) {
> +		ofono_error("Fetching path for modem failed");
> +		return NULL;
> +	}
> +
> +	message =3D dbus_message_new_method_call(TIMED_SERVICE, TIMED_PATH,
> +					"com.meego.NetworkTime", "Notify");
> +	if (message =3D=3D NULL)
> +		return NULL;
> +
> +	dbus_message_set_no_reply(message, TRUE);
> +	fill_time_notification(message, ntd);
> +
> +	return message;
> +}
> +
> +static void init_time(struct ofono_nettime_context *context)
> +{
> +	struct nt_data *nt_data =3D g_new0(struct nt_data, 1);
> +
> +	nt_data->time_available =3D FALSE;
> +	nt_data->time_pending =3D FALSE;
> +	nt_data->dst =3D 0;
> +	nt_data->time_zone =3D 0;
> +
> +	context->data =3D nt_data;
> +}
> +
> +static int nettime_probe(struct ofono_nettime_context *context)
> +{
> +	DBG("Network Time Probe for modem: %p", context->modem);
> +
> +	init_time(context);

Please just don't bother with putting this in separate function. It only
has one caller and I prefer the context->data allocation being in the
probe() callback directly.

> +	nettime_register(context);

Same for this one. Also I don't see the point of the forward
declaration.

> +static void nettime_remove(struct ofono_nettime_context *context)
> +{
> +	struct nt_data *ntd =3D context->data;
> +
> +	DBG("Network Time Remove for modem: %p", context->modem);
> +	g_dbus_remove_watch(ofono_dbus_get_connection(),
> +				ntd->timed_watch);
> +	g_free(ntd);
> +}

You can avoid certain checks here, but then you need to have clear error
handling in probe() callback.

> +static void notify(int status, int lac, int ci, int tech, const char *mc=
c,
> +			const char *mnc, void *data)
> +{
> +	struct ofono_nettime_context *context =3D data;
> +	struct nt_data *ntd =3D context->data;
> +	DBusMessage *message;
> +
> +	if (mcc =3D=3D NULL || mnc =3D=3D NULL)
> +		return;
> +
> +	ntd->mcc =3D mcc;
> +	ntd->mnc =3D mnc;
> +
> +	if (ntd->timed_present =3D=3D FALSE) {
> +		DBG("Timed not present. Caching time info");
> +		return;
> +	}
> +
> +	message =3D create_time_notification(context);
> +	if (message =3D=3D NULL) {
> +		ofono_error("Failed to create Notification message");
> +		return;
> +	}
> +
> +	g_dbus_send_message(ofono_dbus_get_connection(), message);
> +	ntd->time_pending =3D FALSE;
> +}
> +
> +static void nr_st_watch_destroy(void *data)
> +{
> +	struct ofono_nettime_context *context =3D data;
> +	struct nt_data *ntd =3D context->data;
> +	DBG("");
> +
> +	ntd->netreg_st_watch =3D 0;
> +}
> +
> +static void nettime_info_received(struct ofono_nettime_context *context,
> +				struct ofono_network_time *info)
> +{
> +	struct tm t;
> +	struct nt_data *ntd =3D context->data;
> +	const char *mcc, *mnc;
> +
> +	DBG("Network time notification received, modem: %p",
> +			context->modem);
> +
> +	if (info =3D=3D NULL)
> +		return;
> +
> +	ntd->received =3D get_monotonic_time();
> +	ntd->time_pending =3D TRUE;
> +
> +	ntd->time_available =3D encode_time_format(info, &t);
> +	if (ntd->time_available =3D=3D TRUE)
> +		ntd->nw_time_utc =3D timegm(&t);
> +
> +	ntd->dst =3D info->dst;
> +	ntd->time_zone =3D info->utcoff;
> +
> +	ntd->netreg =3D __ofono_atom_get_data(__ofono_modem_find_atom(
> +				context->modem, OFONO_ATOM_TYPE_NETREG));
> +
> +	mcc =3D ofono_netreg_get_mcc(ntd->netreg);
> +	mnc =3D ofono_netreg_get_mnc(ntd->netreg);
> +	if ((mcc =3D=3D NULL) || (mnc =3D=3D NULL)) {
> +		DBG("Mobile country/network code missing");
> +
> +		if (ntd->netreg_st_watch !=3D 0)
> +			return;
> +
> +		ntd->netreg_st_watch =3D __ofono_netreg_add_status_watch(
> +					ntd->netreg, notify,
> +					context, nr_st_watch_destroy);
> +	} else {
> +		notify(0, 0, 0, 0, mcc, mnc, context);
> +	}
> +
> +}
> +
> +static struct ofono_nettime_driver nettime_driver =3D {
> +	.name		=3D "Network Time",
> +	.probe		=3D nettime_probe,
> +	.remove		=3D nettime_remove,
> +	.info_received	=3D nettime_info_received,
> +};
> +
> +static int nettime_init(void)
> +{
> +	return ofono_nettime_driver_register(&nettime_driver);
> +}
> +
> +static void nettime_exit(void)
> +{
> +	ofono_nettime_driver_unregister(&nettime_driver);
> +}

So in general the plugin init/exit functions should be last in the
source code. Just above the OFONO_PLUGIN_DEFINE. That way it is
consistent and a lot easier to read.

Also the generic nettime_* namespacing might be better done as
nokia_timed_* or just short timed_*.

> +static void timed_connect(DBusConnection *connection, void *user_data)
> +{
> +	struct ofono_nettime_context *context =3D user_data;
> +	struct nt_data *ntd =3D context->data;
> +	const char *mcc, *mnc;
> +
> +	DBG("");
> +
> +	ntd->timed_present =3D TRUE;
> +	mcc =3D ofono_netreg_get_mcc(ntd->netreg);
> +	mnc =3D ofono_netreg_get_mnc(ntd->netreg);
> +
> +	notify(0, 0, 0, 0, mcc, mnc, context);
> +}
> +
> +static void timed_disconnect(DBusConnection *connection, void *user_data)
> +{
> +	struct ofono_nettime_context *context =3D user_data;
> +	struct nt_data *ntd =3D context->data;
> +
> +	DBG("");
> +
> +	ntd->timed_present =3D FALSE;
> +}
> +
> +static void nettime_register(struct ofono_nettime_context *context)
> +{
> +	DBusConnection *conn;
> +	struct nt_data *ntd =3D context->data;
> +
> +	DBG("Registering Network time for modem %s" ,
> +		ofono_modem_get_path(context->modem));
> +
> +	conn =3D ofono_dbus_get_connection();
> +
> +	ntd->timed_watch =3D g_dbus_add_service_watch(conn, TIMED_SERVICE,
> +					timed_connect, timed_disconnect,
> +					context, NULL);
> +}

Please reorder the functions a bit better. That makes the whole code
more readable and gives us a lot more benefit in the long term.

I only wanna see forward declaration if they are 100% unavoidable.

> +
> +OFONO_PLUGIN_DEFINE(nettime, "Network Time Plugin",
> +		VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
> +		nettime_init, nettime_exit)
> +

Regards

Marcel



--===============5649545270907609561==--

