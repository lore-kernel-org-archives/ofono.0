Content-Type: multipart/mixed; boundary="===============4807133298204456142=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4 1/2] atmodem: remove CGACT command
Date: Wed, 26 May 2010 18:12:31 +0200
Message-ID: <1274890351.27220.168.camel@localhost.localdomain>
In-Reply-To: <20100526153615.2563.15365.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4807133298204456142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> It's enough that we shutdown PPP, no need to send CGACT after that.
> Recommended by Denis.
> ---
> =

>  drivers/atmodem/gprs-context.c |   51 +++++++++++++---------------------=
------
>  1 files changed, 16 insertions(+), 35 deletions(-)
> =

> diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-contex=
t.c
> index ba5f0c0..9b32d59 100644
> --- a/drivers/atmodem/gprs-context.c
> +++ b/drivers/atmodem/gprs-context.c
> @@ -65,22 +65,6 @@ struct gprs_context_data {
>  	void *cb_data;                                  /* Callback data */
>  };
>  =

> -static void at_cgact_down_cb(gboolean ok, GAtResult *result, gpointer us=
er_data)
> -{
> -	struct cb_data *cbd =3D user_data;
> -	ofono_gprs_context_cb_t cb =3D cbd->cb;
> -	struct ofono_gprs_context *gc =3D cbd->user;
> -	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> -	struct ofono_error error;
> -
> -	if (ok)
> -		gcd->active_context =3D 0;
> -
> -	decode_at_error(&error, g_at_result_final_response(result));
> -
> -	cb(&error, cbd->data);
> -}
> -
>  static void ppp_connect(const char *interface, const char *ip,
>  			const char *dns1, const char *dns2,
>  			gpointer user_data)
> @@ -104,13 +88,21 @@ static void ppp_disconnect(GAtPPPDisconnectReason re=
ason, gpointer user_data)
>  	struct ofono_gprs_context *gc =3D user_data;
>  	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
>  =

> -	if (gcd->state =3D=3D STATE_ENABLING) {
> +	DBG("");
> +
> +	switch (gcd->state) {
> +	case STATE_ENABLING:
>  		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, FALSE, NULL,
>  					NULL, NULL, NULL, gcd->cb_data);
> -		return;
> +		break;

just double-checking that you really wanna have break; and not return;
here. So that gcd->state gets reset to STATE_IDLE.

> +	case STATE_DISABLING:
> +		CALLBACK_WITH_SUCCESS(gcd->down_cb, gcd->cb_data);
> +		break;
> +	default:
> +		ofono_gprs_context_deactivated(gc, gcd->active_context);
> +		break;
>  	}
>  =

> -	ofono_gprs_context_deactivated(gc, gcd->active_context);
>  	gcd->active_context =3D 0;
>  	gcd->state =3D STATE_IDLE;
>  }

Regards

Marcel



--===============4807133298204456142==--

