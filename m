Content-Type: multipart/mixed; boundary="===============1479512882430288455=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] emulator: add +COPS support
Date: Thu, 17 Mar 2011 16:18:28 -0500
Message-ID: <4D827AA4.4080306@gmail.com>
In-Reply-To: <1300380656-8757-5-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1479512882430288455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 03/17/2011 11:50 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> This needs to be in emulator as HFP plugin should answer AT+COPS requests
> even when oFono is not registered on network.
> ---
>  src/emulator.c |   72 ++++++++++++++++++++++++++++++++++++++++++++
>  src/network.c  |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+----
>  2 files changed, 155 insertions(+), 7 deletions(-)
> =

> diff --git a/src/emulator.c b/src/emulator.c
> index 864e50b..eb4f49e 100644
> --- a/src/emulator.c
> +++ b/src/emulator.c
> @@ -49,6 +49,8 @@ struct ofono_emulator {
>  	int events_mode;
>  	gboolean events_ind;
>  	GSList *indicators;
> +	char op_name[17];
> +	int net_mode;
>  };
>  =

>  struct indicator {
> @@ -387,6 +389,59 @@ fail:
>  	}
>  }
>  =

> +static void cops_cb(GAtServer *server, GAtServerRequestType type,
> +			GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_emulator *em =3D user_data;
> +	char buf[32];
> +
> +	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP && em->slc =3D=3D FALSE) {
> +		g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
> +		return;
> +	}
> +

There's no need for this if you use ofono_emulator_add_handler since the
handler_proxy will take care of this detail.

> +	switch (type) {
> +	case G_AT_SERVER_REQUEST_TYPE_QUERY:
> +		sprintf(buf, "+COPS: %d,0,\"%s\"", em->net_mode, em->op_name);
> +		g_at_server_send_info(em->server, buf, TRUE);
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +		break;
> +
> +	case G_AT_SERVER_REQUEST_TYPE_SET:
> +	{
> +		GAtResultIter iter;
> +		int val;
> +
> +		g_at_result_iter_init(&iter, result);
> +		g_at_result_iter_next(&iter, "");
> +
> +		if (!g_at_result_iter_next_number(&iter, &val))
> +			goto fail;
> +
> +		if (val !=3D 3)
> +			goto fail;
> +
> +		if (!g_at_result_iter_next_number(&iter, &val))
> +			goto fail;
> +
> +		if (val !=3D 0)
> +			goto fail;
> +
> +		/* check there is no more parameter */
> +		if (g_at_result_iter_skip_next(&iter))
> +			goto fail;
> +
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +		break;
> +	}
> +
> +	default:
> +fail:
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
> +		break;
> +	}
> +}
> +

Please move this function to netreg.c.  This should make this patch
quite a bit simpler.

<snip>

Regards,
-Denis

--===============1479512882430288455==--

