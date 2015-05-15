Content-Type: multipart/mixed; boundary="===============7142285358124344166=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] gprs: Add DBus method to reset contexts
Date: Thu, 14 May 2015 21:28:14 -0500
Message-ID: <555559BE.8090805@gmail.com>
In-Reply-To: <1431621550-25131-2-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7142285358124344166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 05/14/2015 11:39 AM, Alfonso Sanchez-Beato wrote:
> Add DBus method that removes the current contexts and re-provisions
> using the APN database.
> ---
>   src/gprs.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++----=
-------
>   1 file changed, 120 insertions(+), 24 deletions(-)
>

Looks okay to me, just a couple of small nitpicks:

> diff --git a/src/gprs.c b/src/gprs.c
> index 05ab499..de57b14 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -149,6 +149,8 @@ struct pri_context {
>
>   static void gprs_netreg_update(struct ofono_gprs *gprs);
>   static void gprs_deactivate_next(struct ofono_gprs *gprs);
> +static void provision_contexts(struct ofono_gprs *gprs, const char *mcc,
> +				const char *mnc, const char *spn);

Our preference is not to have forward declarations of static functions =

unless absolutely necessary (e.g. circular dependencies).  Can we move =

provision_contexts up to avoid this?  Feel free to do this in a separate =

commit if this makes things clearer.

>
>   static GSList *g_drivers =3D NULL;
>   static GSList *g_context_drivers =3D NULL;
> @@ -1885,6 +1887,38 @@ static struct pri_context *add_context(struct ofon=
o_gprs *gprs,
>   	return context;
>   }
>
> +static void send_context_added_signal(struct ofono_gprs *gprs,
> +					struct pri_context *context,
> +					DBusConnection *conn)
> +{
> +	const char *path;
> +	DBusMessage *signal;
> +
> +	path =3D __ofono_atom_get_path(gprs->atom);
> +	signal =3D dbus_message_new_signal(path,
> +					OFONO_CONNECTION_MANAGER_INTERFACE,
> +					"ContextAdded");
> +
> +	if (signal) {

Please avoid unnecessary nesting.  It is much easier to read this code =

if it was changed to:

if (!signal)
	return;

> +		DBusMessageIter iter;
> +		DBusMessageIter dict;
> +
> +		dbus_message_iter_init_append(signal, &iter);
> +
> +		path =3D context->path;
> +		dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
> +						&path);
> +
> +		dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +					OFONO_PROPERTIES_ARRAY_SIGNATURE,
> +					&dict);
> +		append_context_properties(context, &dict);
> +		dbus_message_iter_close_container(&iter, &dict);
> +
> +		g_dbus_send_message(conn, signal);
> +	}
> +}
> +
>   static DBusMessage *gprs_add_context(DBusConnection *conn,
>   					DBusMessage *msg, void *data)
>   {
> @@ -1894,7 +1928,6 @@ static DBusMessage *gprs_add_context(DBusConnection=
 *conn,
>   	const char *name;
>   	const char *path;
>   	enum ofono_gprs_context_type type;
> -	DBusMessage *signal;
>
>   	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &typestr,
>   					DBUS_TYPE_INVALID))
> @@ -1916,29 +1949,7 @@ static DBusMessage *gprs_add_context(DBusConnectio=
n *conn,
>   	g_dbus_send_reply(conn, msg, DBUS_TYPE_OBJECT_PATH, &path,
>   					DBUS_TYPE_INVALID);
>
> -	path =3D __ofono_atom_get_path(gprs->atom);
> -	signal =3D dbus_message_new_signal(path,
> -					OFONO_CONNECTION_MANAGER_INTERFACE,
> -					"ContextAdded");
> -
> -	if (signal) {
> -		DBusMessageIter iter;
> -		DBusMessageIter dict;
> -
> -		dbus_message_iter_init_append(signal, &iter);
> -
> -		path =3D context->path;
> -		dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
> -						&path);
> -
> -		dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> -					OFONO_PROPERTIES_ARRAY_SIGNATURE,
> -					&dict);
> -		append_context_properties(context, &dict);
> -		dbus_message_iter_close_container(&iter, &dict);
> -
> -		g_dbus_send_message(conn, signal);
> -	}
> +	send_context_added_signal(gprs, context, conn);
>
>   	return NULL;
>   }
> @@ -2173,6 +2184,89 @@ static DBusMessage *gprs_get_contexts(DBusConnecti=
on *conn,
>   	return reply;
>   }
>
> +static void remove_non_active_context(struct ofono_gprs *gprs,
> +				struct pri_context *ctx, DBusConnection *conn)
> +{
> +	char *path;
> +	const char *atompath;
> +
> +	if (gprs->settings) {
> +		g_key_file_remove_group(gprs->settings, ctx->key, NULL);
> +		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
> +	}
> +
> +	/* Make a backup copy of path for signal emission below */
> +	path =3D g_strdup(ctx->path);
> +
> +	context_dbus_unregister(ctx);
> +	gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
> +
> +	atompath =3D __ofono_atom_get_path(gprs->atom);
> +	g_dbus_emit_signal(conn, atompath, OFONO_CONNECTION_MANAGER_INTERFACE,
> +				"ContextRemoved", DBUS_TYPE_OBJECT_PATH, &path,
> +				DBUS_TYPE_INVALID);
> +	g_free(path);
> +}
> +
> +static DBusMessage *gprs_reset_contexts(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	struct ofono_gprs *gprs =3D data;
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
> +	struct ofono_sim *sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
> +	DBusMessage *reply;
> +	GSList *l;
> +
> +	if (gprs->pending)
> +		return __ofono_error_busy(msg);
> +
> +	for (l =3D gprs->contexts; l; l =3D l->next) {
> +		struct pri_context *ctx =3D l->data;
> +
> +		if (ctx->pending)
> +			return __ofono_error_busy(msg);
> +	}
> +
> +	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID))
> +		return __ofono_error_invalid_args(msg);
> +
> +	if (gprs->powered)
> +		return __ofono_error_not_allowed(msg);
> +
> +	for (l =3D gprs->contexts; l; l =3D l->next) {
> +		struct pri_context *ctx =3D l->data;
> +
> +		if (ctx->active)
> +			return __ofono_error_not_allowed(msg);

Is there a particular reason you're running through the list of contexts =

again here?  Why not check for ctx->active at the same time as ctx->pending?

> +	}
> +
> +	reply =3D dbus_message_new_method_return(msg);
> +	if (reply =3D=3D NULL)
> +		return NULL;
> +
> +	/* Remove first the current contexts, re-provision after */
> +
> +	while (gprs->contexts !=3D NULL) {
> +		struct pri_context *ctx =3D gprs->contexts->data;
> +		remove_non_active_context(gprs, ctx, conn);
> +	}
> +
> +	gprs->last_context_id =3D 0;
> +
> +	provision_contexts(gprs, ofono_sim_get_mcc(sim),
> +				ofono_sim_get_mnc(sim), ofono_sim_get_spn(sim));
> +
> +	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
> +		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
> +
> +	for (l =3D gprs->contexts; l; l =3D l->next) {
> +		struct pri_context *ctx =3D l->data;
> +		send_context_added_signal(gprs, ctx, conn);
> +	}
> +
> +	return reply;
> +}
> +
>   static const GDBusMethodTable manager_methods[] =3D {
>   	{ GDBUS_METHOD("GetProperties",
>   			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
> @@ -2192,6 +2286,8 @@ static const GDBusMethodTable manager_methods[] =3D=
 {
>   	{ GDBUS_METHOD("GetContexts", NULL,
>   			GDBUS_ARGS({ "contexts_with_properties", "a(oa{sv})" }),
>   			gprs_get_contexts) },
> +	{ GDBUS_ASYNC_METHOD("ResetContexts", NULL, NULL,
> +			gprs_reset_contexts) },
>   	{ }
>   };
>
>

Regards,
-Denis

--===============7142285358124344166==--

