Content-Type: multipart/mixed; boundary="===============3943819873224033204=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2 2/2] mbm: retry modem init
Date: Mon, 23 Aug 2010 16:34:56 +0200
Message-ID: <1282574096.23399.243.camel@localhost.localdomain>
In-Reply-To: <1282573090-8351-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3943819873224033204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> If the first initialization command results are catastrophic. Retry it
> 10 times and refuse to enable modem if it still fails.
> ---
>  plugins/mbm.c |   75 ++++++++++++++++++++++++++++++++++++++++++++-------=
------
>  1 files changed, 58 insertions(+), 17 deletions(-)
> =

> diff --git a/plugins/mbm.c b/plugins/mbm.c
> index 8541aaf..753a4f1 100644
> --- a/plugins/mbm.c
> +++ b/plugins/mbm.c
> @@ -55,8 +55,8 @@ static const char *none_prefix[] =3D { NULL };
>  struct mbm_data {
>  	GAtChat *modem_port;
>  	GAtChat *data_port;
> -	guint cpin_poll_source;
> -	guint cpin_poll_count;
> +	guint poll_source;
> +	guint poll_count;
>  	gboolean have_sim;
>  };
>  =

> @@ -86,8 +86,8 @@ static void mbm_remove(struct ofono_modem *modem)
>  	g_at_chat_unref(data->data_port);
>  	g_at_chat_unref(data->modem_port);
>  =

> -	if (data->cpin_poll_source > 0)
> -		g_source_remove(data->cpin_poll_source);
> +	if (data->poll_source > 0)
> +		g_source_remove(data->poll_source);
>  =

>  	g_free(data);
>  }
> @@ -109,13 +109,13 @@ static void simpin_check(gboolean ok, GAtResult *re=
sult, gpointer user_data)
>  	DBG("");
>  =

>  	/* Modem returns an error if SIM is not ready. */
> -	if (!ok && data->cpin_poll_count++ < 5) {
> -		data->cpin_poll_source =3D
> +	if (!ok && data->poll_count++ < 5) {
> +		data->poll_source =3D
>  			g_timeout_add_seconds(1, init_simpin_check, modem);
>  		return;
>  	}
>  =

> -	data->cpin_poll_count =3D 0;
> +	data->poll_count =3D 0;
>  =

>  	/* There is probably no SIM if SIM is not ready after 5 seconds. */
>  	data->have_sim =3D ok;
> @@ -128,7 +128,7 @@ static gboolean init_simpin_check(gpointer user_data)
>  	struct ofono_modem *modem =3D user_data;
>  	struct mbm_data *data =3D ofono_modem_get_data(modem);
>  =

> -	data->cpin_poll_source =3D 0;
> +	data->poll_source =3D 0;
>  =

>  	g_at_chat_send(data->modem_port, "AT+CPIN?", cpin_prefix,
>  			simpin_check, modem, NULL);
> @@ -220,6 +220,55 @@ static void emrdy_query(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>  					cfun_query, modem, NULL);
>  };
>  =

> +static gboolean init_check(gpointer user_data);
> +
> +static void init_result(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct mbm_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	if (!ok && data->poll_count++ < 10) {
> +		data->poll_source =3D g_timeout_add_seconds(1, init_check, modem);
> +		return;
> +	}
> +
> +	data->poll_count =3D 0;
> +
> +	if (!ok) {
> +		g_at_chat_unref(data->modem_port);
> +		data->modem_port =3D NULL;
> +
> +		g_at_chat_unref(data->data_port);
> +		data->data_port =3D NULL;
> +
> +		ofono_modem_set_powered(modem, FALSE);
> +		return;
> +	}
> +
> +	g_at_chat_register(data->modem_port, "*EMRDY:", emrdy_notifier,
> +					FALSE, modem, NULL);
> +
> +	g_at_chat_send(data->modem_port, "AT*E2CFUN=3D1", none_prefix,
> +					NULL, NULL, NULL);
> +	g_at_chat_send(data->modem_port, "AT*EMRDY?", none_prefix,
> +				emrdy_query, modem, NULL);
> +}
> +
> +static gboolean init_check(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct mbm_data *data =3D ofono_modem_get_data(modem);
> +
> +	data->poll_source =3D 0;
> +
> +	g_at_chat_send(data->modem_port, "AT&F E0 V1 X4 &C1 +CMEE=3D1", NULL,
> +					init_result, modem, NULL);
> +
> +	return FALSE;
> +}
> +
>  static GAtChat *create_port(const char *device)
>  {
>  	GAtSyntax *syntax;
> @@ -277,15 +326,7 @@ static int mbm_enable(struct ofono_modem *modem)
>  	if (getenv("OFONO_AT_DEBUG"))
>  		g_at_chat_set_debug(data->data_port, mbm_debug, "Data:");
>  =

> -	g_at_chat_register(data->modem_port, "*EMRDY:", emrdy_notifier,
> -					FALSE, modem, NULL);
> -
> -	g_at_chat_send(data->modem_port, "AT&F E0 V1 X4 &C1 +CMEE=3D1", NULL,
> -					NULL, NULL, NULL);
> -	g_at_chat_send(data->modem_port, "AT*E2CFUN=3D1", none_prefix,
> -					NULL, NULL, NULL);
> -	g_at_chat_send(data->modem_port, "AT*EMRDY?", none_prefix,
> -				emrdy_query, modem, NULL);
> +	init_check(modem);

don't you think we should leave the EMRDY notifier in the mbm_enable
callback. I don't think it is a good idea to register more than one of
these.

Can the AT&F line really fail? Or can we just assume that one will just
work fine and not try to send it again.

Regards

Marcel



--===============3943819873224033204==--

