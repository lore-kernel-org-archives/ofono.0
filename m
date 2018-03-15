Content-Type: multipart/mixed; boundary="===============3675309055472444601=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/6] gemalto: handle sim is inserted or removed URCs
Date: Thu, 15 Mar 2018 12:26:21 -0500
Message-ID: <9a9cd20d-6877-08bd-0ba9-7b4facc6c91e@gmail.com>
In-Reply-To: <1521118170-23722-5-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3675309055472444601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

On 03/15/2018 07:49 AM, Gabriel Lucas wrote:
> From: Mariem Cherif <mariem.cherif@ardia.com.tn>
> =

> ---
>   plugins/gemalto.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> =

> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> index 16ca463..c7fb783 100644
> --- a/plugins/gemalto.c
> +++ b/plugins/gemalto.c
> @@ -497,6 +497,36 @@ static void gemalto_set_online(struct ofono_modem *m=
odem, ofono_bool_t online,
>   	g_free(cbd);
>   }
>   =

> +static void gemalto_ciev_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_sim *sim =3D user_data;
> +	const char *sim_status =3D "simstatus";
> +	const char *ind_str;
> +	int status;
> +	GAtResultIter iter;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CIEV:"))
> +		return;
> +

So generally +CIEV indication is an <index>,<value> syntax.

> +	if (!g_at_result_iter_next_unquoted_string(&iter, &ind_str))
> +		return;

Does Gemalto use some other syntax here?  If so, you might want to =

document a simple example above.

> +
> +	if (!g_str_equal(sim_status, ind_str))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &status))
> +		return;
> +
> +	DBG("sim status %d", status);
> +	if (status =3D=3D 0) {
> +		ofono_sim_inserted_notify(sim, FALSE);
> +	} else if(status =3D=3D 1) {
> +		ofono_sim_inserted_notify(sim, TRUE);
> +	}

Okay, but simpler written as ofono_sim_inserted_notify(sim, status);

> +}
> +
>   static void gemalto_pre_sim(struct ofono_modem *modem)
>   {
>   	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> @@ -509,6 +539,13 @@ static void gemalto_pre_sim(struct ofono_modem *mode=
m)
>   	sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION, "atmodem",
>   						data->app);
>   =

> +	/* Register for specific sim status reports */
> +	g_at_chat_register(data->app, "+CIEV:",
> +			gemalto_ciev_notify, FALSE, sim, NULL);
> +
> +	g_at_chat_send(data->app, "AT^SIND=3D\"simstatus\",1", none_prefix,
> +			NULL, NULL, NULL);
> +
>   	if (sim && data->have_sim =3D=3D TRUE)
>   		ofono_sim_inserted_notify(sim, TRUE);
>   }
> =


Regards,
-Denis

--===============3675309055472444601==--

