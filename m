Content-Type: multipart/mixed; boundary="===============2388626708182375706=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4 2/2] stemodem: Update gprs-context to use rtnl to
 create/remove interfaces.
Date: Thu, 11 Nov 2010 14:37:05 +0900
Message-ID: <1289453825.3266.38.camel@aeonflux>
In-Reply-To: <1288967075-17434-2-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2388626708182375706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

>  drivers/stemodem/gprs-context.c |  207 +++++++++++++++++++++++++--------=
------
>  1 files changed, 135 insertions(+), 72 deletions(-)
> =

> diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-cont=
ext.c
> index 9f59579..4260d31 100644
> --- a/drivers/stemodem/gprs-context.c
> +++ b/drivers/stemodem/gprs-context.c
> @@ -28,6 +28,7 @@
>  #include <string.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> +#include <errno.h>
>  =

>  #include <glib.h>
>  =

> @@ -46,10 +47,11 @@
>  #include "stemodem.h"
>  #include "caif_socket.h"
>  #include "if_caif.h"
> +#include "caif_rtnl.h"
>  =

> -#define MAX_CAIF_DEVICES 7
> +#define MAX_CAIF_DEVICES 4

Can you please not try to squeeze such change in the same patch. Just
have a separate one that does this change.

>  #define MAX_DNS 2
> -#define MAX_ELEM 20
> +#define IP_ADDR_LEN 20
>  =

>  #define AUTH_BUF_LENGTH (OFONO_GPRS_MAX_USERNAME_LENGTH + \
>  			OFONO_GPRS_MAX_PASSWORD_LENGTH + 128)
> @@ -65,21 +67,29 @@ struct gprs_context_data {
>  };
>  =

>  struct conn_info {
> +	/*
> +	 * cid is allocated in oFono Core and is identifying
> +	 * the Account. cid =3D 0 indicates that it is currently unused.
> +	 */
>  	unsigned int cid;
> -	unsigned int device;
> +	/* Id used by CAIF and EPPSD to identify the CAIF channel*/
>  	unsigned int channel_id;
> -	char interface[10];
> +	/* Linux Interface Id */
> +	unsigned int ifindex;

So I realized now that you are using ifindex as input for
caif_rtnl_delete_interface, now I am questioning why there is a result
parameter in the callback for caif_rtnl_create_interface.

> +	/* Linux Interface name */
> +	char interface[IF_NAMESIZE];
> +	gboolean created;
>  };
>  =

>  struct eppsd_response {
>  	char *current;
> -	char ip_address[MAX_ELEM];
> -	char subnet_mask[MAX_ELEM];
> -	char mtu[MAX_ELEM];
> -	char default_gateway[MAX_ELEM];
> -	char dns_server1[MAX_ELEM];
> -	char dns_server2[MAX_ELEM];
> -	char p_cscf_server[MAX_ELEM];
> +	char ip_address[IP_ADDR_LEN];
> +	char subnet_mask[IP_ADDR_LEN];
> +	char mtu[IP_ADDR_LEN];
> +	char default_gateway[IP_ADDR_LEN];

Why are we having this in the first place. CAIF network interfaces are
point-to-point, right? In that case you should just leave this NULL.

> +	char dns_server1[IP_ADDR_LEN];
> +	char dns_server2[IP_ADDR_LEN];
> +	char p_cscf_server[IP_ADDR_LEN];
>  };
>  =

>  static void start_element_handler(GMarkupParseContext *context,
> @@ -122,8 +132,8 @@ static void text_handler(GMarkupParseContext *context,
>  	struct eppsd_response *rsp =3D user_data;
>  =

>  	if (rsp->current) {
> -		strncpy(rsp->current, text, MAX_ELEM);
> -		rsp->current[MAX_ELEM] =3D 0;
> +		strncpy(rsp->current, text, IP_ADDR_LEN);
> +		rsp->current[IP_ADDR_LEN] =3D 0;

Please use '\0' instead of just 0. You might need to fix this at other
places as well.

>  	}
>  }
>  =

> @@ -153,8 +163,7 @@ static gint conn_compare_by_cid(gconstpointer a, gcon=
stpointer b)
>  	return 0;
>  }
>  =

> -static struct conn_info *conn_info_create(unsigned int device,
> -						unsigned int channel_id)
> +static struct conn_info *conn_info_create(unsigned int channel_id)
>  {
>  	struct conn_info *connection =3D g_try_new0(struct conn_info, 1);
>  =

> @@ -162,26 +171,61 @@ static struct conn_info *conn_info_create(unsigned =
int device,
>  		return NULL;
>  =

>  	connection->cid =3D 0;
> -	connection->device =3D device;
>  	connection->channel_id =3D channel_id;
>  =

>  	return connection;
>  }
>  =

> +static void rtnl_callback(int result, gpointer user_data,
> +		char *ifname, int ifindex)
> +{
> +	struct conn_info *conn =3D user_data;
> +
> +	strncpy(conn->interface, ifname, sizeof(conn->interface));
> +	conn->ifindex =3D ifindex;
> +
> +	if (result =3D=3D 0)
> +		conn->created =3D TRUE;
> +	else {
> +		conn->created =3D FALSE;
> +		DBG("Could not create CAIF Interface");
> +	}
> +}

So here is the think. This makes no sense. Either you get an error and
ifname and index are not valid or you succeed.

So this should be something like

	if (ifname < 0) {
		connman_error(...)
		return;
	}

	....

> +
>  /*
>   * Creates a new IP interface for CAIF.
>   */
> -static gboolean caif_if_create(const char *interface, unsigned int conni=
d)
> +static gboolean caif_if_create(struct conn_info *conn)
>  {
> -	return FALSE;
> +	int err;
> +
> +	err =3D caif_rtnl_create_interface(conn, IFLA_CAIF_IPV4_CONNID,
> +					conn->channel_id, FALSE, rtnl_callback);
> +	if (err < 0) {
> +		DBG("Failed to create IP interface for CAIF");
> +		return FALSE;
> +	}
> +
> +	return TRUE;
>  }
>  =

>  /*
>   * Removes IP interface for CAIF.
>   */
> -static gboolean caif_if_remove(const char *interface, unsigned int conni=
d)
> +static void caif_if_remove(struct conn_info *conn)
>  {
> -	return FALSE;
> +	if (!conn->created)
> +		return;
> +
> +	if (caif_rtnl_delete_interface(conn->ifindex) < 0) {
> +		ofono_error("Failed to delete caif interface %s",
> +			conn->interface);
> +		return;
> +	}
> +
> +	DBG("removed CAIF interface ch:%d ifname:%s ifindex:%d\n",
> +		conn->channel_id, conn->interface, conn->ifindex);
> +	return;
>  }
>  =

>  static void ste_eppsd_down_cb(gboolean ok, GAtResult *result,
> @@ -192,11 +236,14 @@ static void ste_eppsd_down_cb(gboolean ok, GAtResul=
t *result,
>  	struct ofono_gprs_context *gc =3D cbd->user;
>  	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
>  	struct ofono_error error;
> -	struct conn_info *conn;
> +	struct conn_info *conn =3D NULL;
>  	GSList *l;
>  =

> -	if (!ok)
> -		goto error;
> +	if (!ok) {
> +		decode_at_error(&error, g_at_result_final_response(result));
> +		cb(&error, cbd->data);
> +		return;
> +	}
>  =

>  	l =3D g_slist_find_custom(g_caif_devices,
>  				GUINT_TO_POINTER(gcd->active_context),
> @@ -210,16 +257,8 @@ static void ste_eppsd_down_cb(gboolean ok, GAtResult=
 *result,
>  	}
>  =

>  	conn =3D l->data;
> -
> -	if (!caif_if_remove(conn->interface, conn->channel_id)) {
> -		DBG("Failed to remove caif interface %s.",
> -				conn->interface);
> -	}
> -
>  	conn->cid =3D 0;
> -
> -	decode_at_error(&error, g_at_result_final_response(result));
> -	cb(&error, cbd->data);
> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
>  	return;
>  =

>  error:
> @@ -237,26 +276,30 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult =
*result, gpointer user_data)
>  	GSList *l;
>  	int i;
>  	gsize length;
> -	char *res_string;
> +	const char *res_string;
>  	const char *dns[MAX_DNS + 1];
>  	struct eppsd_response rsp;
>  	GMarkupParseContext *context =3D NULL;
> +	struct ofono_error error;
>  =

>  	l =3D g_slist_find_custom(g_caif_devices,
>  				GUINT_TO_POINTER(gcd->active_context),
>  				conn_compare_by_cid);
>  =

>  	if (!l) {
> -		DBG("Did not find data (device and channel id)"
> -					"for connection with cid; %d",
> -					gcd->active_context);
> +		DBG("CAIF Device gone missing (cid:%d)", gcd->active_context);
>  		goto error;
>  	}
>  =

>  	conn =3D l->data;
>  =

> -	if (!ok)
> -		goto error;
> +	if (!ok) {
> +		conn->cid =3D 0;
> +		gcd->active_context =3D 0;
> +		decode_at_error(&error, g_at_result_final_response(result));
> +		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
> +		return;
> +	}
>  =

>  	rsp.current =3D NULL;
>  	context =3D g_markup_parse_context_new(&parser, 0, &rsp, NULL);
> @@ -266,7 +309,7 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
>  =

>  	for (i =3D 0; i < g_at_result_num_response_lines(result); i++) {
>  		g_at_result_iter_next(&iter, NULL);
> -		res_string =3D strdup(g_at_result_iter_raw_line(&iter));
> +		res_string =3D g_at_result_iter_raw_line(&iter);
>  		length =3D strlen(res_string);
>  =

>  		if (!g_markup_parse_context_parse(context, res_string,
> @@ -283,20 +326,9 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *=
result, gpointer user_data)
>  	dns[1] =3D rsp.dns_server2;
>  	dns[2] =3D NULL;
>  =

> -	sprintf(conn->interface, "caif%u", conn->device);
> -
> -	if (!caif_if_create(conn->interface, conn->channel_id)) {
> -		ofono_error("Failed to create caif interface %s.",
> -				conn->interface);
> -		CALLBACK_WITH_SUCCESS(cb, NULL, FALSE, rsp.ip_address,
> +	CALLBACK_WITH_SUCCESS(cb, conn->interface, TRUE, rsp.ip_address,
>  				rsp.subnet_mask, rsp.default_gateway,
>  				dns, cbd->data);
> -	} else {
> -		CALLBACK_WITH_SUCCESS(cb, conn->interface,
> -				FALSE, rsp.ip_address, rsp.subnet_mask,
> -				rsp.default_gateway, dns, cbd->data);
> -	}
> -
>  	return;
>  =

>  error:
> @@ -308,6 +340,7 @@ error:
>  	if (conn)
>  		conn->cid =3D 0;
>  =

> +	gcd->active_context =3D 0;
>  	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
>  }
>  =

> @@ -319,12 +352,23 @@ static void ste_cgdcont_cb(gboolean ok, GAtResult *=
result, gpointer user_data)
>  	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
>  	struct cb_data *ncbd =3D NULL;
>  	char buf[128];
> -	struct conn_info *conn;
> +	struct conn_info *conn =3D NULL;
>  	GSList *l;
>  =

> +	l =3D g_slist_find_custom(g_caif_devices,
> +				GUINT_TO_POINTER(gcd->active_context),
> +				conn_compare_by_cid);
> +
> +	if (!l) {
> +		DBG("CAIF Device gone missing (cid:%d)", gcd->active_context);
> +		goto error;
> +	}
> +
> +	conn =3D l->data;
> +
>  	if (!ok) {
>  		struct ofono_error error;
> -
> +		conn->cid =3D 0;
>  		gcd->active_context =3D 0;
>  =

>  		decode_at_error(&error, g_at_result_final_response(result));
> @@ -332,26 +376,18 @@ static void ste_cgdcont_cb(gboolean ok, GAtResult *=
result, gpointer user_data)
>  		return;
>  	}
>  =

> -	ncbd =3D g_memdup(cbd, sizeof(struct cb_data));
> -
> -	l =3D g_slist_find_custom(g_caif_devices, GUINT_TO_POINTER(0),
> -				conn_compare_by_cid);
> -
> -	if (!l) {
> -		DBG("at_cgdcont_cb, no more available devices");
> -		goto error;
> -	}
> -
> -	conn =3D l->data;
> -	conn->cid =3D gcd->active_context;
>  	snprintf(buf, sizeof(buf), "AT*EPPSD=3D1,%u,%u",
>  			conn->channel_id, conn->cid);
> +	ncbd =3D g_memdup(cbd, sizeof(struct cb_data));
>  =

>  	if (g_at_chat_send(gcd->chat, buf, NULL,
>  				ste_eppsd_up_cb, ncbd, g_free) > 0)
>  		return;
>  =

>  error:
> +	if (conn)
> +		conn->cid =3D 0;
> +
>  	g_free(ncbd);
>  =

>  	gcd->active_context =3D 0;
> @@ -368,6 +404,8 @@ static void ste_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
>  	struct cb_data *cbd =3D cb_data_new(cb, data);
>  	char buf[AUTH_BUF_LENGTH];
>  	int len;
> +	GSList *l;
> +	struct conn_info *conn =3D NULL;
>  =

>  	if (!cbd)
>  		goto error;
> @@ -375,6 +413,23 @@ static void ste_gprs_activate_primary(struct ofono_g=
prs_context *gc,
>  	gcd->active_context =3D ctx->cid;
>  	cbd->user =3D gc;
>  =

> +	/* Find free connection with cid zero */
> +	l =3D g_slist_find_custom(g_caif_devices, GUINT_TO_POINTER(0),
> +				conn_compare_by_cid);
> +
> +	if (!l) {
> +		DBG("No more available CAIF devices");
> +		goto error;
> +	}
> +
> +	conn =3D l->data;
> +	if (!conn->created) {
> +		DBG("CAIF interface not created (rtnl error?)");
> +		goto error;
> +	}
> +
> +	conn->cid =3D ctx->cid;
> +
>  	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
>  =

>  	if (ctx->apn)
> @@ -389,7 +444,7 @@ static void ste_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
>  	 * Set username and password, this should be done after CGDCONT
>  	 * or an error can occur.  We don't bother with error checking
>  	 * here
> -	 * */
> +	 */
>  	snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"",
>  			ctx->cid, ctx->username, ctx->password);
>  =

> @@ -398,6 +453,10 @@ static void ste_gprs_activate_primary(struct ofono_g=
prs_context *gc,
>  	return;
>  =

>  error:
> +	if (conn)
> +		conn->cid =3D 0;
> +
> +	gcd->active_context =3D 0;
>  	g_free(cbd);
>  =

>  	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
> @@ -423,8 +482,8 @@ static void ste_gprs_deactivate_primary(struct ofono_=
gprs_context *gc,
>  				conn_compare_by_cid);
>  =

>  	if (!l) {
> -		DBG("at_gprs_deactivate_primary, did not find"
> -			"data (channel id) for connection with cid; %d", id);
> +		DBG("did not find data (channel id) "
> +				"for connection with cid; %d", id);
>  		goto error;
>  	}
>  =

> @@ -516,9 +575,11 @@ static int ste_gprs_context_probe(struct ofono_gprs_=
context *gc,
>  	ofono_gprs_context_set_data(gc, gcd);
>  =

>  	for (i =3D 0; i < MAX_CAIF_DEVICES; i++) {
> -		ci =3D conn_info_create(i, i+1);
> -		if (ci)
> -			g_caif_devices =3D g_slist_append(g_caif_devices, ci);
> +		ci =3D conn_info_create(i+1);
> +		if (!ci)
> +			return -ENOMEM;
> +		caif_if_create(ci);
> +		g_caif_devices =3D g_slist_append(g_caif_devices, ci);
>  	}
>  =

>  	return 0;
> @@ -527,7 +588,7 @@ static int ste_gprs_context_probe(struct ofono_gprs_c=
ontext *gc,
>  static void ste_gprs_context_remove(struct ofono_gprs_context *gc)
>  {
>  	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> -
> +	g_slist_foreach(g_caif_devices, (GFunc) caif_if_remove, NULL);
>  	g_slist_foreach(g_caif_devices, (GFunc) g_free, NULL);
>  	g_slist_free(g_caif_devices);
>  	g_caif_devices =3D NULL;
> @@ -548,10 +609,12 @@ static struct ofono_gprs_context_driver driver =3D {
>  =

>  void ste_gprs_context_init()
>  {
> +	caif_rtnl_init();
>  	ofono_gprs_context_driver_register(&driver);
>  }
>  =

>  void ste_gprs_context_exit()
>  {
> +	caif_rtnl_exit();
>  	ofono_gprs_context_driver_unregister(&driver);
>  }

The more I looked through the rest of this patch, the more I thought you
need to split this patch into a cleanup and caif_rtnl usage patch.

Regards

Marcel



--===============2388626708182375706==--

