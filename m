Content-Type: multipart/mixed; boundary="===============5351836713745654319=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] atmodem: fix crash during context deactivation
Date: Tue, 25 May 2010 14:44:24 +0200
Message-ID: <1274791464.27220.140.camel@localhost.localdomain>
In-Reply-To: <20100525113901.6786.73777.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5351836713745654319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> Ofono either crashed or busy looped with my Huawei E1552 3G modem when I
> tried to deactivate GPRS context. The reason was that gcd->chat was
> unreferenced already in setup_ppp() but the chat was still accessed
> later in at_gprs_deactivate_primary().
> =

> To fix the problem, change the logic instead to suspend chat session
> for PPP and resume when PPP has disconnected. Now it doesn't crash
> anymore.
> =

> Deactivation still doesn't work properly with Huawei E1552, and most
> probably with other Huawei modems, because the modem hangs up the chat
> line after PPP deactivation. This needs to be fixed separately.

didn't we fix this issue already. Or was it just in gsmdial?

>  	struct ofono_gprs_context *gc =3D user_data;
>  	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	struct cb_data *cbd;
> +	char buf[64];
> +	guint ret;
> +
> +	DBG("");
> +
> +	g_at_chat_resume(gcd->chat);
>  =

>  	if (gcd->state =3D=3D STATE_ENABLING) {
>  		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, FALSE, NULL,
>  					NULL, NULL, NULL, gcd->cb_data);
> -		return;
> +	} else if (gcd->state =3D=3D STATE_DISABLING) {

This else if is rather pointless since the previous one already returned
from the function.

	if (aaa...)
		return;

	if (bbb...) {
		...
	} else {
	}

That is way easier to follow than multiple else if. Also in this case a
switch statement might be a lot better.

> +		cbd =3D cb_data_new(gcd->down_cb, gcd->cb_data);
> +
> +		if (cbd =3D=3D NULL) {
> +			CALLBACK_WITH_FAILURE(gcd->down_cb, gcd->cb_data);
> +			goto out;
> +		}
> +
> +		cbd->user =3D gc;
> +
> +		snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u",
> +				gcd->active_context);
> +
> +		ret =3D g_at_chat_send(gcd->chat, buf, none_prefix,
> +					at_cgact_down_cb, cbd, g_free);
> +
> +		if (ret =3D=3D 0) {
> +			ofono_info("Unable to send AT+CGACT=3D0");
> +			CALLBACK_WITH_FAILURE(gcd->down_cb, gcd->cb_data);
> +			g_free(cbd);
> +			goto out;
> +		}

What is this goto out; really buying you?

> +	} else {
> +		ofono_gprs_context_deactivated(gc, gcd->active_context);
>  	}
>  =

> -	ofono_gprs_context_deactivated(gc, gcd->active_context);
> +out:
>  	gcd->active_context =3D 0;
>  	gcd->state =3D STATE_IDLE;
>  }

Just from a simple look at it. Using a switch statement for states and
utilizing break; correctly makes this a lot more easier to read.

> @@ -118,13 +148,14 @@ static void ppp_disconnect(GAtPPPDisconnectReason r=
eason, gpointer user_data)
>  static gboolean setup_ppp(struct ofono_gprs_context *gc)
>  {
>  	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> -	GIOChannel *channel;
> +	GAtIO *io;
> +
> +	io =3D g_at_chat_get_io(gcd->chat);
>  =

> -	channel =3D g_at_chat_get_channel(gcd->chat);
> -	g_at_chat_unref(gcd->chat);
> +	g_at_chat_suspend(gcd->chat);
>  =

>  	/* open ppp */
> -	gcd->ppp =3D g_at_ppp_new(channel);
> +	gcd->ppp =3D g_at_ppp_new_from_io(io);
>  =

>  	if (gcd->ppp =3D=3D NULL)
>  		return FALSE;
> @@ -227,25 +258,14 @@ static void at_gprs_deactivate_primary(struct ofono=
_gprs_context *gc,
>  					ofono_gprs_context_cb_t cb, void *data)
>  {
>  	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> -	struct cb_data *cbd =3D cb_data_new(cb, data);
> -	char buf[64];
>  =

> -	if (!cbd)
> -		goto error;
> +	DBG("");
>  =

> -	cbd->user =3D gc;
> -
> -	snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", id);
> -
> -	if (g_at_chat_send(gcd->chat, buf, none_prefix,
> -				at_cgact_down_cb, cbd, g_free) > 0)
> -		return;
> -
> -error:
> -	if (cbd)
> -		g_free(cbd);
> +	gcd->state =3D STATE_DISABLING;
> +	gcd->down_cb =3D cb;
> +	gcd->cb_data =3D data;
>  =

> -	CALLBACK_WITH_FAILURE(cb, data);
> +	g_at_ppp_shutdown(gcd->ppp);
>  }

Do we handle g_at_chat_resume correctly and not resume and already
active GAtChat?

Regards

Marcel



--===============5351836713745654319==--

