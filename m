Content-Type: multipart/mixed; boundary="===============3031711912066712514=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: use ATD99 to enter data state when needed
Date: Wed, 15 Feb 2017 14:39:09 -0600
Message-ID: <c13527c5-8e6c-a88c-75d6-9adc8c3bbc7b@gmail.com>
In-Reply-To: <20170215163837.28766-2-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3031711912066712514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 02/15/2017 10:38 AM, Christophe Ronco wrote:
> Some modems do not support AT+CGDATA=3D"PPP",X to enter data state.
> Use AT+CGDATA=3D? to detect these modems and for them use ATD*99***X#
> to enter data state.
> ---
>  drivers/atmodem/gprs-context.c | 44 ++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-contex=
t.c
> index f6e6c2ef..bfe0d4b5 100644
> --- a/drivers/atmodem/gprs-context.c
> +++ b/drivers/atmodem/gprs-context.c
> @@ -47,6 +47,7 @@
>
>  #define STATIC_IP_NETMASK "255.255.255.255"
>
> +static const char *cgdata_prefix[] =3D { "+CGDATA:", NULL };
>  static const char *none_prefix[] =3D { NULL };
>
>  enum state {
> @@ -67,6 +68,7 @@ struct gprs_context_data {
>  	ofono_gprs_context_cb_t cb;
>  	void *cb_data;                                  /* Callback data */
>  	unsigned int vendor;
> +	gboolean use_atd99;
>  };
>
>  static void ppp_debug(const char *str, void *data)
> @@ -210,7 +212,7 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>  		return;
>  	}
>
> -	if (gcd->vendor =3D=3D OFONO_VENDOR_SIMCOM_SIM900)
> +	if (gcd->use_atd99)
>  		sprintf(buf, "ATD*99***%u#", gcd->active_context);
>  	else
>  		sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
> @@ -378,6 +380,43 @@ static void cgev_notify(GAtResult *result, gpointer =
user_data)
>  		g_at_ppp_shutdown(gcd->ppp);
>  }
>
> +static void at_cgdata_test_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data)
> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	GAtResultIter iter;
> +	const char *data_type;
> +	gboolean found =3D FALSE;
> +
> +	gcd->use_atd99 =3D TRUE;
> +
> +	if (!ok) {
> +		DBG("not ok");
> +		goto error;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +	if (!g_at_result_iter_next(&iter, "+CGDATA:")) {
> +		DBG("no +CGDATA line");
> +		goto error;
> +	}
> +
> +	if (!g_at_result_iter_open_list(&iter)) {
> +		DBG("no list found");
> +		goto error;
> +	}
> +
> +	while (!found && g_at_result_iter_next_string(&iter, &data_type)) {
> +		if (g_str_equal(data_type, "PPP")) {
> +			found =3D TRUE;
> +			gcd->use_atd99 =3D FALSE;
> +		}
> +	}
> +error:
> +	DBG("use_atd99:%d", gcd->use_atd99);
> +}
> +
>  static int at_gprs_context_probe(struct ofono_gprs_context *gc,
>  					unsigned int vendor, void *data)
>  {
> @@ -405,6 +444,9 @@ static int at_gprs_context_probe(struct ofono_gprs_co=
ntext *gc,
>  	if (chat =3D=3D NULL)
>  		return 0;
>
> +	g_at_chat_send(chat, "AT+CGDATA=3D?", cgdata_prefix, at_cgdata_test_cb,
> +								gc, NULL);
> +

Looks fine to me.  My only comment would be to skip the CGDATA query if =

the vendor quirk explicitly tells us to use ATD*99.  So e.g.

switch (vendor) {
case OFONO_VENDOR_SIMCOM_SIM900:
	use_atd99 =3D FALSE;
	break;
default:
	g_at_chat_send(chat, "AT+CGDATA=3D?", ...);
}

>  	g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
>
>  	return 0;
>

Regards,
-Denis

--===============3031711912066712514==--

