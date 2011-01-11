Content-Type: multipart/mixed; boundary="===============7137178052174030470=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 10/10] atmodem: packet switch bearer support
Date: Mon, 10 Jan 2011 16:45:53 -0800
Message-ID: <1294706753.3873.13.camel@aeonflux>
In-Reply-To: <1294665325-11937-10-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7137178052174030470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

>  drivers/atmodem/gprs.c |   55 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 55 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> index a38c6b4..4ae1b57 100644
> --- a/drivers/atmodem/gprs.c
> +++ b/drivers/atmodem/gprs.c
> @@ -200,6 +200,59 @@ static void xdatastat_notify(GAtResult *result, gpoi=
nter user_data)
>  	}
>  }
>  =

> +static void cpsb_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_gprs *gprs =3D user_data;
> +	GAtResultIter iter;
> +	gint cid, bearer;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CPSB:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &cid))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &bearer))
> +		return;
> +
> +	ofono_gprs_bearer_notify(gprs, cid, bearer);
> +}
> +
> +static void cpsb_cb(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_gprs *gprs =3D user_data;
> +	GAtResultIter iter;
> +	gint cid, bearer;
> +
> +	if (!ok)
> +		return;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CPSB:"))
> +		return;
> +
> +	g_at_result_iter_next_number(&iter, NULL);
> +
> +	while (g_at_result_iter_next_number(&iter, &cid) &&
> +			g_at_result_iter_next_number(&iter, &bearer))
> +		ofono_gprs_bearer_notify(gprs, cid, bearer);
> +}
> +
> +static void cpsb_set_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> +{
> +	struct ofono_gprs *gprs =3D user_data;
> +	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
> +
> +	if (!ok)
> +		return;
> +
> +	g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify, FALSE, gprs, NULL);
> +	g_at_chat_send(gd->chat, "AT+CPSB?", none_prefix, cpsb_cb, gprs, NULL);
> +}
> +
>  static void gprs_initialized(gboolean ok, GAtResult *result, gpointer us=
er_data)
>  {
>  	struct ofono_gprs *gprs =3D user_data;
> @@ -208,6 +261,8 @@ static void gprs_initialized(gboolean ok, GAtResult *=
result, gpointer user_data)
>  	g_at_chat_register(gd->chat, "+CGEV:", cgev_notify, FALSE, gprs, NULL);
>  	g_at_chat_register(gd->chat, "+CGREG:", cgreg_notify,
>  					FALSE, gprs, NULL);
> +	g_at_chat_send(gd->chat, "AT+CPSB=3D1", none_prefix,
> +		cpsb_set_cb, gprs, NULL);
>  =


I think Denis mentioned this already, but the call to this one is rather
pointless. Just register the notification and send the command.

The extra AT+CPSB? is useless since we are not registered at this point
anyway.

Regards

Marcel



--===============7137178052174030470==--

