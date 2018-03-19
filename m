Content-Type: multipart/mixed; boundary="===============6817823849182981935=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/6] gemalto: handle sim is inserted or removed URCs
Date: Mon, 19 Mar 2018 11:08:25 -0500
Message-ID: <2788d45f-5193-6b07-f376-c2bb4f6d28a1@gmail.com>
In-Reply-To: <1521475041-11660-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6817823849182981935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

On 03/19/2018 10:57 AM, Gabriel Lucas wrote:
> From: Mariem Cherif <mariem.cherif@ardia.com.tn>
> =

> ---
>   plugins/gemalto.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++----
>   1 file changed, 66 insertions(+), 4 deletions(-)
> =

> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> index 5573606..13270d6 100644
> --- a/plugins/gemalto.c
> +++ b/plugins/gemalto.c
> @@ -489,20 +489,82 @@ static void gemalto_set_online(struct ofono_modem *=
modem, ofono_bool_t online,
>   	g_free(cbd);
>   }
>   =

> +static void sim_ready_cb(gboolean present, gpointer user_data)
> +{
> +	struct ofono_sim *sim =3D user_data;
> +
> +	DBG("sim present: %d", present);
> +
> +	ofono_sim_inserted_notify(sim, present);

You should free sim_state_query here and zero out the variable, =

otherwise you will leak memory on repeated sim insertion / reinsertion.

> +}
> +
> +static void gemalto_ciev_notify(GAtResult *result, gpointer user_data)

Okay, this part looks good now

>   static void gemalto_pre_sim(struct ofono_modem *modem)
>   {
>   	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> -	struct ofono_sim *sim;
>   =

>   	DBG("%p", modem);
>   =

>   	ofono_devinfo_create(modem, 0, "atmodem", data->app);
>   	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
> -	sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION, "atmodem",
> +	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION, "atmodem",
>   						data->app);
>   =

> -	if (sim && data->have_sim =3D=3D TRUE)
> -		ofono_sim_inserted_notify(sim, TRUE);
> +	/* Register for specific sim status reports */
> +	g_at_chat_register(data->app, "+CIEV:",
> +			gemalto_ciev_notify, FALSE, modem, NULL);
> +
> +	g_at_chat_send(data->app, "AT^SIND=3D\"simstatus\",1", none_prefix,
> +			NULL, NULL, NULL);
> +

As a general rule of thumb, there should be no AT commands being sent in =

pre_sim/post_sim/post_online callbacks.  Move this sequence as part of =

the initialization procedure, perhaps after calling =

ofono_modem_set_powered() in sim_state_cb()

> +	if (data->sim && data->have_sim =3D=3D TRUE)
> +		ofono_sim_inserted_notify(data->sim, TRUE);
>   }
>   =

>   static void gemalto_post_sim(struct ofono_modem *modem)
> =


Regards,
-Denis

--===============6817823849182981935==--

