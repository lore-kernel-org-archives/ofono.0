Content-Type: multipart/mixed; boundary="===============7102604712246807918=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] xmm7modem: fix to activate context with cid zero
Date: Tue, 11 Jun 2019 10:52:21 -0500
Message-ID: <b70437d8-a0c9-d212-c5fb-3b7c81ac2b29@gmail.com>
In-Reply-To: <1560245485-18836-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7102604712246807918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 06/11/2019 04:31 AM, Antara Borwankar wrote:
> xmm7modem returns 0 as cid for default pdp context. Thus removing
> check for last_auto_context_id so that context actvation can be
> successful.

An AT trace of what is happening and how it is broken would be helpful.

> ---
>   drivers/atmodem/gprs.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> =

> diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> index dd73458..d9192b3 100644
> --- a/drivers/atmodem/gprs.c
> +++ b/drivers/atmodem/gprs.c
> @@ -161,9 +161,11 @@ static void at_cgdcont_read_cb(gboolean ok, GAtResul=
t *result,
>   		return;
>   	}
>   =

> -	if (gd->last_auto_context_id =3D=3D 0) {
> -		DBG("Context got deactivated while calling CGDCONT");
> -		return;
> +	if (gd->vendor !=3D OFONO_VENDOR_XMM) {

Why is this behind an XMM vendor?  The whole ME PDN ACT / DEACT should =

be more or less universal across all LTE modems.  The only question is =

what these modems use for the default bearer context id (cid).  From =

what I recall this code was written with uBlox in mind which uses a =

non-zero cid for this.

> +		if (gd->last_auto_context_id =3D=3D 0) {
> +			DBG("Context got deactivated while calling CGDCONT");
> +			return;
> +		}
>   	}
>   =

>   	g_at_result_iter_init(&iter, result);
> @@ -259,9 +261,12 @@ static void cgev_notify(GAtResult *result, gpointer =
user_data)
>   	} else if (g_str_has_prefix(event, "ME PDN DEACT")) {
>   		unsigned int context_id;
>   		sscanf(event, "%*s %*s %*s %u", &context_id);
> -		/* Indicate that this cid is not activated anymore */
> -		if (gd->last_auto_context_id =3D=3D context_id)
> -			gd->last_auto_context_id =3D 0;
> +
> +		if(gd->vendor !=3D OFONO_VENDOR_XMM) {
> +			/* Indicate that this cid is not activated anymore */
> +			if (gd->last_auto_context_id =3D=3D context_id)
> +				gd->last_auto_context_id =3D 0;
> +		}
>   	}
>   }
>   =

> @@ -487,6 +492,7 @@ static void gprs_initialized(gboolean ok, GAtResult *=
result, gpointer user_data)
>   =

>   	switch (gd->vendor) {
>   	case OFONO_VENDOR_IFX:
> +	case OFONO_VENDOR_XMM:
>   		/* Register for GPRS suspend notifications */
>   		g_at_chat_register(gd->chat, "+XDATASTAT:", xdatastat_notify,
>   						FALSE, gprs, NULL);
> =


Regards,
-Denis

--===============7102604712246807918==--

