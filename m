Content-Type: multipart/mixed; boundary="===============8915889933944176498=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] atmodem: packet switch bearer support
Date: Fri, 07 Jan 2011 10:27:38 -0600
Message-ID: <4D273EFA.3020202@gmail.com>
In-Reply-To: <1294416127-22432-4-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8915889933944176498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On 01/07/2011 10:02 AM, R=C3=A9mi Denis-Courmont wrote:
> ---
>  drivers/atmodem/gprs.c |   50 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 50 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> index a38c6b4..1d4a8bf 100644
> --- a/drivers/atmodem/gprs.c
> +++ b/drivers/atmodem/gprs.c
> @@ -200,6 +200,54 @@ static void xdatastat_notify(GAtResult *result, gpoi=
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
> +	if (!g_at_result_iter_next(&iter, "+CPSB:"))
> +		return;

doc/coding-style.txt Rule M1

> +	if (!g_at_result_iter_next_number(&iter, &cid))
> +		return;

doc/coding-style.txt Rule M1

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
> +	if (!g_at_result_iter_next(&iter, "+CPSB:"))
> +		return;

doc/coding-style.txt Rule M1

> +
> +	g_at_result_iter_next_number(&iter, NULL);
> +	while (g_at_result_iter_next_number(&iter, &cid) &&
> +			g_at_result_iter_next_number(&iter, &bearer))
> +		ofono_gprs_bearer_notify(gprs, cid, bearer);

doc/coding-style.txt Rule M1

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

Why do you bother running CPSB query?  No context is active at this point.

> +}
> +
>  static void gprs_initialized(gboolean ok, GAtResult *result, gpointer us=
er_data)
>  {
>  	struct ofono_gprs *gprs =3D user_data;
> @@ -208,6 +256,8 @@ static void gprs_initialized(gboolean ok, GAtResult *=
result, gpointer user_data)
>  	g_at_chat_register(gd->chat, "+CGEV:", cgev_notify, FALSE, gprs, NULL);
>  	g_at_chat_register(gd->chat, "+CGREG:", cgreg_notify,
>  					FALSE, gprs, NULL);
> +	g_at_chat_send(gd->chat, "AT+CPSB=3D1", none_prefix,
> +		cpsb_set_cb, gprs, NULL);
>  =

>  	switch (gd->vendor) {
>  	case OFONO_VENDOR_IFX:

Regards,
-Denis

--===============8915889933944176498==--

