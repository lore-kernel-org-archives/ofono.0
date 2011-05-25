Content-Type: multipart/mixed; boundary="===============1370634732465056414=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v6 4/5] emulator: add dun_ato_cb() definition and register
 it in GAtServer
Date: Wed, 25 May 2011 05:43:05 -0500
Message-ID: <4DDCDD39.3080901@gmail.com>
In-Reply-To: <1305884296-2601-5-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1370634732465056414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 05/20/2011 04:38 AM, Guillaume Zajac wrote:
> ---
>  src/emulator.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
>  1 files changed, 54 insertions(+), 0 deletions(-)

I applied this patch, but fixed it up for you afterwards:

> +static void dun_ato_cb(GAtServer *server, GAtServerRequestType type,
> +			GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_emulator *em =3D user_data;
> +	GAtResultIter iter;
> +	int val;
> +
> +	DBG("");
> +
> +	if (em->ppp =3D=3D NULL) {
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_NO_CARRIER);
> +		return;
> +	}

Please avoid doing this, syntax checking should be done beforehand (and
perhaps an appropriate error set).  Then the actual validity checking
should be done.

> +
> +	switch (type) {
> +	case G_AT_SERVER_REQUEST_TYPE_SET:
> +		g_at_result_iter_init(&iter, result);
> +		g_at_result_iter_next(&iter, "");
> +
> +		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE)
> +			goto error;
> +
> +		if (val !=3D 0)
> +			goto error;
> +
> +		g_at_server_send_intermediate(em->server, "CONNECT");
> +		em->source =3D g_idle_add(resume_ppp, em);
> +		break;
> +
> +	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
> +		g_at_server_send_intermediate(em->server, "CONNECT");
> +		em->source =3D g_idle_add(resume_ppp, em);

This should have used set_write_done...

> +		break;
> +
> +	default:
> +error:
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
> +		break;
> +	}
> +
> +	return;

Please do not ever use return statements at the end of the function
returning void

> +}
> +
>  static struct indicator *find_indicator(struct ofono_emulator *em,
>  						const char *name, int *index)
>  {
> @@ -775,6 +828,7 @@ void ofono_emulator_register(struct ofono_emulator *e=
m, int fd)
>  	case OFONO_EMULATOR_TYPE_DUN:
>  		g_at_server_register(em->server, "D", dial_cb, em, NULL);
>  		g_at_server_register(em->server, "H", dun_ath_cb, em, NULL);
> +		g_at_server_register(em->server, "O", dun_ato_cb, em, NULL);
>  		break;
>  	case OFONO_EMULATOR_TYPE_HFP:
>  		g_at_server_set_echo(em->server, FALSE);

Regards,
-Denis

--===============1370634732465056414==--

