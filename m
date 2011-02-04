Content-Type: multipart/mixed; boundary="===============0867567378978147752=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/12] gprs: core support for IPv6
Date: Fri, 04 Feb 2011 11:50:01 -0600
Message-ID: <4D4C3C49.2000807@gmail.com>
In-Reply-To: <1296723809-32676-4-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0867567378978147752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 02/03/2011 03:03 AM, Mika Liljeberg wrote:
> ---
>  include/gprs-context.h |    2 +-
>  src/gprs.c             |  296 +++++++++++++++++++++++++++++++-----------=
------
>  2 files changed, 192 insertions(+), 106 deletions(-)
> =

> diff --git a/include/gprs-context.h b/include/gprs-context.h
> index 88530f6..d03dd47 100644
> --- a/include/gprs-context.h
> +++ b/include/gprs-context.h
> @@ -77,7 +77,7 @@ struct ofono_gprs_context_driver {
>  	void (*remove)(struct ofono_gprs_context *gc);
>  	void (*activate_primary)(struct ofono_gprs_context *gc,
>  				const struct ofono_gprs_primary_context *ctx,
> -				ofono_gprs_context_up_cb_t cb, void *data);
> +				ofono_gprs_context_cb_t cb, void *data);
>  	void (*deactivate_primary)(struct ofono_gprs_context *gc,
>  					unsigned int id,
>  					ofono_gprs_context_cb_t cb, void *data);
> diff --git a/src/gprs.c b/src/gprs.c
> index 7d36633..b5dd5f2 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -99,10 +99,12 @@ struct ofono_gprs {
>  	struct ofono_atom *atom;
>  };
>  =

> +struct pri_context;
> +
>  struct ofono_gprs_context {
>  	struct ofono_gprs *gprs;
> +	struct pri_context *pri;
>  	enum ofono_gprs_context_type type;
> -	ofono_bool_t inuse;

I don't see how getting rid of this is not a good idea.  As soon as the
context driver is assigned to a context being activated we set it as
'inuse'.  If you don't set this variable then it is possible to pick the
same driver, even if that driver is busy but has not started to set its
settings yet.

>  	const struct ofono_gprs_context_driver *driver;
>  	void *driver_data;
>  	struct ofono_atom *atom;
> @@ -111,12 +113,13 @@ struct ofono_gprs_context {
>  struct context_settings {
>  	enum ofono_gprs_context_type type;
>  	char *interface;
> -	gboolean static_ip;
> +	enum ofono_gprs_addrconf method;
>  	char *ip;
>  	char *netmask;
>  	char *gateway;
>  	char **dns;
>  	char *proxy;
> +	char *ipv6addr;

Nitpick but please name this ipv6 and put it right after ip

>  };
>  =

>  struct pri_context {
> @@ -226,6 +229,8 @@ static const char *gprs_proto_to_string(enum ofono_gp=
rs_proto proto)
>  		return "ip";
>  	case OFONO_GPRS_PROTO_IPV6:
>  		return "ipv6";
> +	case OFONO_GPRS_PROTO_IPV4V6:
> +		return "ipv4v6";
>  	};
>  =

>  	return NULL;
> @@ -240,11 +245,28 @@ static gboolean gprs_proto_from_string(const char *=
str,
>  	} else if (g_str_equal(str, "ipv6")) {
>  		*proto =3D OFONO_GPRS_PROTO_IPV6;
>  		return TRUE;
> +	} else if (g_str_equal(str, "ipv4v6")) {
> +		*proto =3D OFONO_GPRS_PROTO_IPV4V6;
> +		return TRUE;
>  	}
>  =

>  	return FALSE;
>  }
>  =

> +static const char *gprs_addrconf_to_string(enum ofono_gprs_addrconf meth=
od)
> +{
> +	switch (method) {
> +	case OFONO_GPRS_ADDRCONF_NONE:
> +		return NULL;
> +	case OFONO_GPRS_ADDRCONF_STATIC:
> +		return "static";
> +	case OFONO_GPRS_ADDRCONF_DHCP:
> +		return "dhcp";
> +	}
> +
> +	return NULL;
> +}
> +
>  static unsigned int gprs_cid_alloc(struct ofono_gprs *gprs)
>  {
>  	return idmap_alloc(gprs->cid_map);
> @@ -255,6 +277,49 @@ static void gprs_cid_release(struct ofono_gprs *gprs=
, unsigned int id)
>  	idmap_put(gprs->cid_map, id);
>  }
>  =

> +static gboolean assign_context(struct pri_context *ctx)
> +{
> +	struct idmap *cidmap =3D ctx->gprs->cid_map;
> +	unsigned int cid_min;
> +	GSList *l;
> +
> +	if (cidmap =3D=3D NULL)
> +		return FALSE;
> +
> +	cid_min =3D idmap_get_min(cidmap);
> +
> +	ctx->context.cid =3D gprs_cid_alloc(ctx->gprs);
> +	if (ctx->context.cid =3D=3D 0)
> +		return FALSE;
> +
> +	for (l =3D ctx->gprs->context_drivers; l; l =3D l->next) {
> +		struct ofono_gprs_context *gc =3D l->data;
> +
> +		if (gc->pri !=3D NULL)
> +			continue;
> +
> +		if (gc->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_ANY ||
> +						gc->type =3D=3D ctx->type) {
> +			gc->pri =3D ctx;
> +			ctx->context_driver =3D gc;
> +			return TRUE;
> +		}
> +	}
> +
> +	return FALSE;
> +}
> +
> +static void release_context(struct pri_context *ctx)
> +{
> +	if (ctx =3D=3D NULL || ctx->gprs =3D=3D NULL)
> +		return;
> +
> +	gprs_cid_release(ctx->gprs, ctx->context.cid);
> +	ctx->context.cid =3D 0;
> +	ctx->context_driver->pri =3D NULL;
> +	ctx->context_driver =3D NULL;
> +}
> +

For something like this I'd really like to see it in a separate patch.
You're moving the function and also modifying the implementation.  It is
much easier to review a patch set if you move a function in one patch
and then modify its behavior in another.  Same with release_context.  It
is probably a good idea to put the common code in here, but modify the
behavior as a part of a different patch.

Ideally this patch should be at least 2:
- For moving assign_context and factoring out common code into
release_context
- The rest of this patch + modifications to the two above.

>  static struct pri_context *gprs_context_by_path(struct ofono_gprs *gprs,
>  						const char *ctx_path)
>  {
> @@ -278,6 +343,7 @@ static void context_settings_free(struct context_sett=
ings *settings)
>  	g_free(settings->gateway);
>  	g_strfreev(settings->dns);
>  	g_free(settings->proxy);
> +	g_free(settings->ipv6addr);
>  =

>  	g_free(settings);
>  }
> @@ -316,12 +382,10 @@ static void context_settings_append_variant(struct =
context_settings *settings,
>  		goto done;
>  	}
>  =

> -	if (settings->static_ip =3D=3D TRUE)
> -		method =3D "static";
> -	else
> -		method =3D "dhcp";
> -
> -	ofono_dbus_dict_append(&array, "Method", DBUS_TYPE_STRING, &method);
> +	method =3D gprs_addrconf_to_string(settings->method);
> +	if (method !=3D NULL)
> +		ofono_dbus_dict_append(&array, "Method", DBUS_TYPE_STRING,
> +					&method);
>  =

>  	if (settings->ip)
>  		ofono_dbus_dict_append(&array, "Address", DBUS_TYPE_STRING,
> @@ -335,6 +399,19 @@ static void context_settings_append_variant(struct c=
ontext_settings *settings,
>  		ofono_dbus_dict_append(&array, "Gateway", DBUS_TYPE_STRING,
>  					&settings->gateway);
>  =

> +	if (settings->ipv6addr !=3D NULL) {
> +		uint8_t addr[16];
> +		char *strll =3D alloca(INET6_ADDRSTRLEN);
> +
> +		inet_pton(AF_INET6, settings->ipv6addr, addr);
> +		memset(addr, 0, 8);
> +		addr[0] =3D 0xfe;
> +		addr[1] =3D 0x80;
> +		inet_ntop(AF_INET6, addr, strll, INET6_ADDRSTRLEN);
> +		ofono_dbus_dict_append(&array, "IPv6Address", DBUS_TYPE_STRING,
> +					&strll);
> +	}
> +
>  	if (settings->dns)
>  		ofono_dbus_dict_append_array(&array, "DomainNameServers",
>  						DBUS_TYPE_STRING,
> @@ -578,42 +655,27 @@ static void pri_reset_context_settings(struct pri_c=
ontext *ctx)
>  	g_free(interface);
>  }
>  =

> -static void pri_update_context_settings(struct pri_context *ctx,
> -					const char *interface,
> -					ofono_bool_t static_ip,
> -					const char *ip, const char *netmask,
> -					const char *gateway, const char **dns)
> +static void pri_update_context_settings(struct pri_context *ctx)
>  {
> -	if (ctx->settings)
> -		context_settings_free(ctx->settings);
> -
> -	ctx->settings =3D g_try_new0(struct context_settings, 1);
> -	if (ctx->settings =3D=3D NULL)
> +	if (ctx->settings =3D=3D NULL || ctx->settings->interface =3D=3D NULL)
>  		return;
>  =

>  	ctx->settings->type =3D ctx->type;
>  =

> -	ctx->settings->interface =3D g_strdup(interface);
> -	ctx->settings->static_ip =3D static_ip;
> -	ctx->settings->ip =3D g_strdup(ip);
> -	ctx->settings->netmask =3D g_strdup(netmask);
> -	ctx->settings->gateway =3D g_strdup(gateway);
> -	ctx->settings->dns =3D g_strdupv((char **)dns);
> -
>  	if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS && ctx->message_proxy)
>  		ctx->settings->proxy =3D g_strdup(ctx->message_proxy);
>  =

> -	pri_ifupdown(interface, TRUE);
> +	pri_ifupdown(ctx->settings->interface, TRUE);
>  =

>  	if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS) {
>  		pri_parse_proxy(ctx, ctx->message_proxy);
>  =

>  		DBG("proxy %s port %u", ctx->proxy_host, ctx->proxy_port);
>  =

> -		pri_setaddr(interface, ip);
> +		pri_setaddr(ctx->settings->interface, ctx->settings->ip);
>  =

>  		if (ctx->proxy_host)
> -			pri_setproxy(interface, ctx->proxy_host);
> +			pri_setproxy(ctx->settings->interface, ctx->proxy_host);
>  	}
>  =

>  	pri_context_signal_settings(ctx);
> @@ -685,30 +747,18 @@ static DBusMessage *pri_get_properties(DBusConnecti=
on *conn,
>  	return reply;
>  }
>  =

> -static void pri_activate_callback(const struct ofono_error *error,
> -					const char *interface,
> -					ofono_bool_t static_ip,
> -					const char *ip, const char *netmask,
> -					const char *gateway, const char **dns,
> -					void *data)
> +static void pri_activate_callback(const struct ofono_error *error, void =
*data)
>  {
>  	struct pri_context *ctx =3D data;
>  	DBusConnection *conn =3D ofono_dbus_get_connection();
>  	dbus_bool_t value;
>  =

> -	DBG("%p %s", ctx, interface);
> -
>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>  		DBG("Activating context failed with error: %s",
>  				telephony_error_to_str(error));
>  		__ofono_dbus_pending_reply(&ctx->pending,
>  					__ofono_error_failed(ctx->pending));
> -
> -		gprs_cid_release(ctx->gprs, ctx->context.cid);
> -		ctx->context.cid =3D 0;
> -		ctx->context_driver->inuse =3D FALSE;
> -		ctx->context_driver =3D NULL;
> -
> +		release_context(ctx);
>  		return;
>  	}
>  =

> @@ -716,14 +766,7 @@ static void pri_activate_callback(const struct ofono=
_error *error,
>  	__ofono_dbus_pending_reply(&ctx->pending,
>  				dbus_message_new_method_return(ctx->pending));
>  =

> -	/*
> -	 * If we don't have the interface, don't bother emitting any settings,
> -	 * as nobody can make use of them
> -	 */
> -	if (interface !=3D NULL)
> -		pri_update_context_settings(ctx, interface, static_ip,
> -						ip, netmask, gateway, dns);
> -
> +	pri_update_context_settings(ctx);
>  	value =3D ctx->active;
>  	ofono_dbus_signal_property_changed(conn, ctx->path,
>  					OFONO_CONNECTION_CONTEXT_INTERFACE,
> @@ -744,11 +787,8 @@ static void pri_deactivate_callback(const struct ofo=
no_error *error, void *data)
>  		return;
>  	}
>  =

> -	gprs_cid_release(ctx->gprs, ctx->context.cid);
> -	ctx->context.cid =3D 0;
> +	release_context(ctx);
>  	ctx->active =3D FALSE;
> -	ctx->context_driver->inuse =3D FALSE;
> -	ctx->context_driver =3D NULL;
>  =

>  	__ofono_dbus_pending_reply(&ctx->pending,
>  				dbus_message_new_method_return(ctx->pending));
> @@ -995,38 +1035,6 @@ static DBusMessage *pri_set_message_center(struct p=
ri_context *ctx,
>  	return NULL;
>  }
>  =

> -static gboolean assign_context(struct pri_context *ctx)
> -{
> -	struct idmap *cidmap =3D ctx->gprs->cid_map;
> -	unsigned int cid_min;
> -	GSList *l;
> -
> -	if (cidmap =3D=3D NULL)
> -		return FALSE;
> -
> -	cid_min =3D idmap_get_min(cidmap);
> -
> -	ctx->context.cid =3D gprs_cid_alloc(ctx->gprs);
> -	if (ctx->context.cid =3D=3D 0)
> -		return FALSE;
> -
> -	for (l =3D ctx->gprs->context_drivers; l; l =3D l->next) {
> -		struct ofono_gprs_context *gc =3D l->data;
> -
> -		if (gc->inuse =3D=3D TRUE)
> -			continue;
> -
> -		if (gc->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_ANY ||
> -						gc->type =3D=3D ctx->type) {
> -			ctx->context_driver =3D gc;
> -			ctx->context_driver->inuse =3D TRUE;
> -			return TRUE;
> -		}
> -	}
> -
> -	return FALSE;
> -}
> -
>  static DBusMessage *pri_set_property(DBusConnection *conn,
>  					DBusMessage *msg, void *data)
>  {
> @@ -1179,6 +1187,8 @@ static GDBusSignalTable context_signals[] =3D {
>  	{ }
>  };
>  =

> +
> +
>  static struct pri_context *pri_context_create(struct ofono_gprs *gprs,
>  					const char *name,
>  					enum ofono_gprs_context_type type)
> @@ -1344,14 +1354,9 @@ static void gprs_attached_update(struct ofono_gprs=
 *gprs)
>  			if (ctx->active =3D=3D FALSE)
>  				continue;
>  =

> -			gprs_cid_release(gprs, ctx->context.cid);
> -			ctx->context.cid =3D 0;
> +			release_context(ctx);
>  			ctx->active =3D FALSE;
> -			ctx->context_driver->inuse =3D FALSE;
> -			ctx->context_driver =3D NULL;
> -
>  			pri_reset_context_settings(ctx);
> -
>  			value =3D FALSE;
>  			ofono_dbus_signal_property_changed(conn, ctx->path,
>  					OFONO_CONNECTION_CONTEXT_INTERFACE,
> @@ -1736,10 +1741,7 @@ static void gprs_deactivate_for_remove(const struc=
t ofono_error *error,
>  		return;
>  	}
>  =

> -	gprs_cid_release(gprs, ctx->context.cid);
> -	ctx->context.cid =3D 0;
> -	ctx->context_driver->inuse =3D FALSE;
> -	ctx->context_driver =3D NULL;
> +	release_context(ctx);
>  =

>  	if (gprs->settings) {
>  		g_key_file_remove_group(gprs->settings, ctx->key, NULL);
> @@ -1831,12 +1833,9 @@ static void gprs_deactivate_for_all(const struct o=
fono_error *error,
>  		return;
>  	}
>  =

> -	gprs_cid_release(gprs, ctx->context.cid);
> -	ctx->active =3D FALSE;
> -	ctx->context.cid =3D 0;
> -	ctx->context_driver->inuse =3D FALSE;
> -	ctx->context_driver =3D NULL;
> +	release_context(ctx);
>  =

> +	ctx->active =3D FALSE;
>  	pri_reset_context_settings(ctx);
>  =

>  	value =3D ctx->active;
> @@ -2087,11 +2086,8 @@ void ofono_gprs_context_deactivated(struct ofono_g=
prs_context *gc,
>  		if (ctx->active =3D=3D FALSE)
>  			break;
>  =

> -		gprs_cid_release(ctx->gprs, ctx->context.cid);
> -		ctx->context.cid =3D 0;
> +		release_context(ctx);
>  		ctx->active =3D FALSE;
> -		ctx->context_driver->inuse =3D FALSE;
> -		ctx->context_driver =3D NULL;
>  =

>  		pri_reset_context_settings(ctx);
>  =

> @@ -2130,6 +2126,8 @@ static void gprs_context_remove(struct ofono_atom *=
atom)
>  	if (gc =3D=3D NULL)
>  		return;
>  =

> +	release_context(gc->pri);
> +
>  	if (gc->driver && gc->driver->remove)
>  		gc->driver->remove(gc);
>  =

> @@ -2202,6 +2200,94 @@ void ofono_gprs_context_set_type(struct ofono_gprs=
_context *gc,
>  	gc->type =3D type;
>  }
>  =

> +static struct context_settings *get_settings(struct ofono_gprs_context *=
gc)
> +{
> +	if (gc =3D=3D NULL || gc->pri =3D=3D NULL)
> +		return NULL;
> +
> +	if (gc->pri->settings =3D=3D NULL)
> +		gc->pri->settings =3D g_try_new0(struct context_settings, 1);
> +

I appreciate the lazy allocation, however you get into trouble if the
driver calls one of the _set functions but still returns a failure in
the callback.  Overall this seems a more complicated approach than
returning values in the callback of activate_primary.

> +	return gc->pri->settings;
> +}
> +
> +void ofono_gprs_context_set_interface(struct ofono_gprs_context *gc,
> +					const char *interface)
> +{
> +	struct context_settings *settings =3D get_settings(gc);
> +
> +	if (settings =3D=3D NULL || settings->interface !=3D NULL)
> +		return;

I'd let the driver call these functions as often as they want and just
take the last value.

> +
> +	settings->interface =3D g_strdup(interface);
> +}
> +
> +void ofono_gprs_context_set_ip_addrconf(struct ofono_gprs_context *gc,
> +					enum ofono_gprs_addrconf method)
> +{
> +	struct context_settings *settings =3D get_settings(gc);
> +
> +	if (settings =3D=3D NULL)
> +		return;
> +
> +	settings->method =3D method;
> +}
> +
> +void ofono_gprs_context_set_ip_address(struct ofono_gprs_context *gc,
> +					const char *address)
> +{
> +	struct context_settings *settings =3D get_settings(gc);
> +
> +	if (settings =3D=3D NULL || settings->ip !=3D NULL)
> +		return;
> +
> +	settings->ip =3D g_strdup(address);
> +}
> +
> +void ofono_gprs_context_set_ip_netmask(struct ofono_gprs_context *gc,
> +					const char *netmask)
> +{
> +	struct context_settings *settings =3D get_settings(gc);
> +
> +	if (settings =3D=3D NULL || settings->netmask !=3D NULL)
> +		return;
> +
> +	settings->netmask =3D g_strdup(netmask);
> +}
> +
> +void ofono_gprs_context_set_ip_gateway(struct ofono_gprs_context *gc,
> +					const char *gateway)
> +{
> +	struct context_settings *settings =3D get_settings(gc);
> +
> +	if (settings =3D=3D NULL || settings->gateway !=3D NULL)
> +		return;
> +
> +	settings->gateway =3D g_strdup(gateway);
> +}
> +
> +void ofono_gprs_context_set_ipv6_address(struct ofono_gprs_context *gc,
> +						const char *address)
> +{
> +	struct context_settings *settings =3D get_settings(gc);
> +
> +	if (settings =3D=3D NULL || settings->ipv6addr !=3D NULL)
> +		return;
> +
> +	settings->ipv6addr =3D g_strdup(address);
> +}
> +
> +void ofono_gprs_context_set_dns_servers(struct ofono_gprs_context *gc,
> +						const char **dns)
> +{
> +	struct context_settings *settings =3D get_settings(gc);
> +
> +	if (settings =3D=3D NULL || settings->dns !=3D NULL)
> +		return;
> +
> +	settings->dns =3D g_strdupv((char **)dns);
> +}
> +
>  int ofono_gprs_driver_register(const struct ofono_gprs_driver *d)
>  {
>  	DBG("driver: %p, name: %s", d, d->name);

Regards,
-Denis

--===============0867567378978147752==--

