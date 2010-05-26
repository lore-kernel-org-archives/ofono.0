Content-Type: multipart/mixed; boundary="===============2925693870704659939=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH v2] atmodem: fix crash during context deactivation
Date: Wed, 26 May 2010 23:04:06 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351E99720A@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <20100525145641.11296.52980.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2925693870704659939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Valo,

Kalle Valo wrote:
> ---
> =

> drivers/atmodem/gprs-context.c |   56
> +++++++++++++---------------------------
> 1 files changed, 18 insertions(+), 38 deletions(-)
> =

> diff --git a/drivers/atmodem/gprs-context.c
> b/drivers/atmodem/gprs-context.c
> index ba5f0c0..794db8a 100644
> --- a/drivers/atmodem/gprs-context.c
> +++ b/drivers/atmodem/gprs-context.c
> @@ -65,22 +65,6 @@ struct gprs_context_data {
> 	void *cb_data;                                  /*
> Callback data */
> };
> =

> -static void at_cgact_down_cb(gboolean ok, GAtResult *result,
> gpointer user_data) -{
> -	struct cb_data *cbd =3D user_data;
> -	ofono_gprs_context_cb_t cb =3D cbd->cb;
> -	struct ofono_gprs_context *gc =3D cbd->user;
> -	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> -	struct ofono_error error;
> -
> -	if (ok)
> -		gcd->active_context =3D 0;
> -
> -	decode_at_error(&error, g_at_result_final_response(result)); -
> -	cb(&error, cbd->data);
> -}
> -
> static void ppp_connect(const char *interface, const char *ip,
> 			const char *dns1, const char *dns2,
> 			gpointer user_data)
> @@ -104,13 +88,19 @@ static void
> ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_data)
> 	struct ofono_gprs_context *gc =3D user_data;
> 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> =

> +	DBG("");
> +
> +	g_at_chat_resume(gcd->chat);
> +
> 	if (gcd->state =3D=3D STATE_ENABLING) {
> 		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, FALSE, NULL,
> 					NULL, NULL, NULL, gcd->cb_data);
> -		return;
> +	} else if (gcd->state =3D=3D STATE_DISABLING) {
> +		CALLBACK_WITH_SUCCESS(gcd->down_cb, gcd->cb_data); +	} else {
> +		ofono_gprs_context_deactivated(gc, gcd->active_context); 	}
> =

> -	ofono_gprs_context_deactivated(gc, gcd->active_context);
> 	gcd->active_context =3D 0; gcd->state =3D STATE_IDLE;
> }
> @@ -118,13 +108,14 @@ static void
> ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_data)
> static gboolean setup_ppp(struct ofono_gprs_context *gc) {
> 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> -	GIOChannel *channel; +	GAtIO *io;
> +
> +	io =3D g_at_chat_get_io(gcd->chat);
> =

> -	channel =3D g_at_chat_get_channel(gcd->chat);
> -	g_at_chat_unref(gcd->chat);
> +	g_at_chat_suspend(gcd->chat);
> =

> 	/* open ppp */
> -	gcd->ppp =3D g_at_ppp_new(channel);
> +	gcd->ppp =3D g_at_ppp_new_from_io(io);
> =

> 	if (gcd->ppp =3D=3D NULL)
> 		return FALSE;

You should use g_at_chat_resume(gcd->chat) to resume the chat before you re=
turns FALSE here.

> @@ -227,25 +218,14 @@ static void
> at_gprs_deactivate_primary(struct ofono_gprs_context *gc,
> ofono_gprs_context_cb_t cb, void *data)
> {
> 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> -	struct cb_data *cbd =3D cb_data_new(cb, data);
> -	char buf[64];
> -
> -	if (!cbd)
> -		goto error;
> -
> -	cbd->user =3D gc;
> =

> -	snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", id);
> +	DBG("");
> =

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
> =

> -	CALLBACK_WITH_FAILURE(cb, data);
> +	g_at_ppp_shutdown(gcd->ppp);
> }
> =

> static int at_gprs_context_probe(struct ofono_gprs_context *gc,
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua


--===============2925693870704659939==--

