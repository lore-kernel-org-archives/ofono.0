Content-Type: multipart/mixed; boundary="===============8623854775215090402=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] atmodem: Implement the list_activated_contexts
 callback
Date: Mon, 12 Aug 2019 15:44:03 -0500
Message-ID: <12e357e3-4018-5ca5-2860-5f2445727423@gmail.com>
In-Reply-To: <20190812201826.28535-3-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8623854775215090402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 8/12/19 3:18 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> The callback calls cgact and cgdcont to get information
> regarding any activate context.
> ---
>   drivers/atmodem/gprs.c | 149 ++++++++++++++++++++++++++++++++---------
>   1 file changed, 116 insertions(+), 33 deletions(-)
> =

> diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> index 10108281..ab8f20f1 100644
> --- a/drivers/atmodem/gprs.c
> +++ b/drivers/atmodem/gprs.c
> @@ -29,6 +29,7 @@
>   #include <stdio.h>
>   #include <errno.h>
>   =

> +#include <ell/ell.h>
>   #include <glib.h>
>   =

>   #include <ofono/log.h>
> @@ -41,6 +42,8 @@
>   #include "atmodem.h"
>   #include "vendor.h"
>   =

> +#define MAX_CONTEXTS 255
> +
>   static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
>   static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
>   static const char *cgact_prefix[] =3D { "+CGACT:", NULL };
> @@ -54,6 +57,14 @@ struct gprs_data {
>   	int attached;
>   };
>   =

> +struct list_contexts_data
> +{
> +	struct ofono_gprs *gprs;
> +	void *cb;
> +	void *data;
> +	struct l_uintset *active_cids;

You may want to use a reference count here, see below

> +};
> +
>   static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
>   {
>   	struct cb_data *cbd =3D user_data;

<snip>

> @@ -162,47 +207,57 @@ static void at_cgdcont_read_cb(gboolean ok, GAtResu=
lt *result,
>   		return;
>   	}
>   =

> -	if (gd->last_auto_context_id =3D=3D -1) {
> +	if (activated_cid =3D=3D -1) {
>   		DBG("Context got deactivated while calling CGDCONT");
>   		return;
>   	}
>   =

> -	g_at_result_iter_init(&iter, result);
> +	cids =3D l_uintset_new(activated_cid);
>   =

> -	while (g_at_result_iter_next(&iter, "+CGDCONT:")) {
> -		int read_cid;
> +	l_uintset_put(cids, activated_cid);
>   =

> -		if (!g_at_result_iter_next_number(&iter, &read_cid))
> -			break;
> +	at_cgdcont_parse(gprs, result, cids);
>   =

> -		if (read_cid !=3D activated_cid)
> -			continue;
> -
> -		/* ignore protocol */
> -		g_at_result_iter_skip_next(&iter);
> +	l_uintset_free(cids);
> +}
>   =

> -		g_at_result_iter_next_string(&iter, &apn);
> +static void at_cgdcont_act_read_cb(gboolean ok, GAtResult *result,
> +					gpointer user_data)
> +{
> +	struct list_contexts_data *ld =3D user_data;
> +	ofono_gprs_status_cb_t cb =3D ld->cb;
> +	struct ofono_error error;
> +	int count =3D 0;
>   =

> -		break;
> -	}
> +	decode_at_error(&error, g_at_result_final_response(result));
>   =

> -	if (apn)
> -		ofono_gprs_cid_activated(gprs, activated_cid, apn);
> +	if (!ok)
> +		ofono_warn("Can't read CGDCONT context.");
>   	else
> -		ofono_warn("cid %u: Received activated but no apn present",
> -				activated_cid);
> +		count =3D at_cgdcont_parse(ld->gprs, result, ld->active_cids);
> +
> +	cb(&error, count, ld->data);
> +
> +	l_uintset_free(ld->active_cids);
>   }
>   =

>   static void at_cgact_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
>   {
> -	struct ofono_gprs *gprs =3D user_data;
> -	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
> +	struct list_contexts_data *ld =3D user_data;
> +	struct gprs_data *gd =3D ofono_gprs_get_data(ld->gprs);
> +	ofono_gprs_status_cb_t cb =3D ld->cb;
> +	struct ofono_error error;
>   	GAtResultIter iter;
>   =

> -	DBG("ok %d", ok);
> +	decode_at_error(&error, g_at_result_final_response(result));
>   =

>   	if (!ok) {
>   		ofono_warn("Can't read CGACT contexts.");
> +
> +		cb(&error, 0, ld->data);
> +
> +		g_free(ld);
> +
>   		return;
>   	}
>   =

> @@ -222,17 +277,48 @@ static void at_cgact_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>   			continue;
>   =

>   		/* Flag this as auto context as it was obviously active */
> -		if (gd->last_auto_context_id =3D=3D 0)
> +		if (gd->last_auto_context_id =3D=3D -1)
>   			gd->last_auto_context_id =3D read_cid;
>   =

> -		if (read_cid !=3D gd->last_auto_context_id)
> -			continue;
> +		if (!ld->active_cids)
> +			ld->active_cids =3D l_uintset_new(MAX_CONTEXTS);
>   =

> -		g_at_chat_send(gd->chat, "AT+CGDCONT?", cgdcont_prefix,
> -				at_cgdcont_read_cb, gprs, NULL);
> +		l_uintset_put(ld->active_cids, read_cid);
> +	}
>   =

> -		break;
> +	if (ld->active_cids !=3D NULL) {
> +		if (g_at_chat_send(gd->chat, "AT+CGDCONT?", cgdcont_prefix,
> +					at_cgdcont_act_read_cb, ld, g_free))
> +			return;
> +

You still need to free ld here.  Note that it is much easier to use =

reference counting when you're performing a transaction, and simply take =

a reference when you've successfully queued the next command in the =

transaction.  See cb_data_ref for an example.

> +		CALLBACK_WITH_FAILURE(cb, 0, ld->data);
> +	} else {
> +		/* No active contexts found */
> +		cb(&error, 0, ld->data);
>   	}
> +
> +	l_uintset_free(ld->active_cids);
> +	g_free(ld);
> +}
> +
> +static void at_gprs_list_active_contexts(struct ofono_gprs *gprs,
> +						ofono_gprs_status_cb_t cb,
> +						void *data)
> +{
> +	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
> +	struct list_contexts_data *ld =3D g_new0(struct list_contexts_data, 1);
> +
> +	ld->gprs =3D gprs;
> +	ld->data =3D data;
> +	ld->cb =3D cb;
> +
> +	if (g_at_chat_send(gd->chat, "AT+CGACT?", cgact_prefix,
> +				at_cgact_cb, ld, NULL))

This would actually cause a memory leak if the modem was forcefully =

removed for example.  Always provide a destroy callback to =

g_at_chat_send if you're sending allocated memory as user data.

> +		return;
> +
> +	g_free(ld);
> +
> +	CALLBACK_WITH_FAILURE(cb, 0, data);
>   }
>   =

>   static void cgreg_notify(GAtResult *result, gpointer user_data)

Regards,
-Denis

--===============8623854775215090402==--

