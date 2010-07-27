Content-Type: multipart/mixed; boundary="===============2284474287400965515=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] Fix busylooped in ppp_disconnect for huawei modem
Date: Tue, 27 Jul 2010 11:57:17 -0500
Message-ID: <4C4F0FED.10401@gmail.com>
In-Reply-To: <1280206726-2133-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2284474287400965515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

On 07/26/2010 11:58 PM, Zhenhua Zhang wrote:
> Huawei modem closes the modem port after PPP disconnect. So the channel
> of gatchat is NULL in ppp_disconnect. In such case, we resume the chat
> and it causes huawei_disconnect() get called and the gprs context is
> removed later.
> =

> Before removing this gprs context, we should reply the pending DBus
> message to the client.
> ---
>  drivers/atmodem/gprs-context.c |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-contex=
t.c
> index fea80b0..2f5be9b 100644
> --- a/drivers/atmodem/gprs-context.c
> +++ b/drivers/atmodem/gprs-context.c
> @@ -88,12 +88,18 @@ static void ppp_disconnect(GAtPPPDisconnectReason rea=
son, gpointer user_data)
>  {
>  	struct ofono_gprs_context *gc =3D user_data;
>  	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	GAtIO *io =3D g_at_chat_get_io(gcd->chat);
>  =

>  	DBG("");
>  =

>  	g_at_ppp_unref(gcd->ppp);
>  	gcd->ppp =3D NULL;
> -	g_at_chat_resume(gcd->chat);
> +
> +	if (g_at_io_get_channel(io) =3D=3D NULL) {
> +		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, FALSE, NULL,
> +					NULL, NULL, NULL, gcd->cb_data);
> +		goto done;
> +	}

I don't believe the above addition is actually necessary, just moving
the g_at_chat_resume to the bottom should be enough.

>  =

>  	switch (gcd->state) {
>  	case STATE_ENABLING:
> @@ -108,8 +114,15 @@ static void ppp_disconnect(GAtPPPDisconnectReason re=
ason, gpointer user_data)
>  		break;
>  	}
>  =

> +done:
>  	gcd->active_context =3D 0;
>  	gcd->state =3D STATE_IDLE;
> +	/*
> +	 * If the channel of gcd->chat is NULL, it might cause
> +	 * gprs_context_remove get called and the gprs context will be
> +	 * removed.
> +	 */
> +	g_at_chat_resume(gcd->chat);
>  }
>  =

>  static gboolean setup_ppp(struct ofono_gprs_context *gc)
> @@ -257,7 +270,7 @@ static void at_gprs_context_remove(struct ofono_gprs_=
context *gc)
>  =

>  	DBG("");
>  =

> -	if (gcd->state !=3D STATE_IDLE) {
> +	if (gcd->state !=3D STATE_IDLE && gcd->ppp) {
>  		g_at_ppp_unref(gcd->ppp);
>  		g_at_chat_resume(gcd->chat);
>  	}

Regards,
-Denis

--===============2284474287400965515==--

