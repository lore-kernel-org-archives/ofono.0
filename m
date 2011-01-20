Content-Type: multipart/mixed; boundary="===============6193397304742346264=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 6/6] atmodem: packet switch bearer support
Date: Thu, 20 Jan 2011 12:17:16 +0100
Message-ID: <1295522236.3873.283.camel@aeonflux>
In-Reply-To: <1295512672-4891-6-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6193397304742346264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

>  drivers/atmodem/gprs.c |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)

I did apply this patch, but I fixed it up later ...

> diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> index defb154..daa3933 100644
> --- a/drivers/atmodem/gprs.c
> +++ b/drivers/atmodem/gprs.c
> @@ -200,6 +200,37 @@ static void xdatastat_notify(GAtResult *result, gpoi=
nter user_data)
>  	}
>  }
>  =

> +static void cpsb_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_gprs *gprs =3D user_data;
> +	GAtResultIter iter;
> +	gint bearer;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CPSB:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, NULL))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &bearer))
> +		return;
> +
> +	ofono_gprs_bearer_notify(gprs, bearer);
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
> +}

... since we normally don't bother with this kind of conditional
registration for notifications. We just register them.

Regards

Marcel



--===============6193397304742346264==--

