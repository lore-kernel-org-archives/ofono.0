Content-Type: multipart/mixed; boundary="===============2232231984866340521=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH v2 2/2] plugins/gemalto: added voice support
Date: Sun, 14 Oct 2018 18:50:47 +0200
Message-ID: <53ceb48a-0e9b-898a-67fd-94a7a65073a5@southpole.se>
In-Reply-To: <20181014141728.20227-3-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2232231984866340521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 14/10/18 16:17, Giacinto Cifelli wrote:
> The plugin for Gemalto modems is enriched with all voice-related atoms,
> as well as USSD.
> All except the voicecall itself are from the atmodem, while the
> voicecall is from gemaltomodem.
> ---
>   plugins/gemalto.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> index 0fcf30d8..8a965748 100644
> --- a/plugins/gemalto.c
> +++ b/plugins/gemalto.c
> @@ -571,6 +571,10 @@ static void gemalto_pre_sim(struct ofono_modem *mode=
m)
>   =

>   	ofono_devinfo_create(modem, 0, "atmodem", data->app);
>   	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
> +
> +	ofono_modem_set_integer(modem, "GemaltoVtsQuotes", 1);

Do you really mean to set this unconditionally for all models?

/Jonas

> +	ofono_voicecall_create(modem, 0, "gemaltomodem", data->app);
> +
>   	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_GEMALTO, "atmodem",
>   						data->app);
>   =

> @@ -597,6 +601,13 @@ static void gemalto_post_sim(struct ofono_modem *mod=
em)
>   	if (gprs && gc)
>   		ofono_gprs_add_context(gprs, gc);
>   =

> +	ofono_ussd_create(modem, 0, "atmodem", data->app);
> +
> +	ofono_call_forwarding_create(modem, 0, "atmodem", data->app);
> +	ofono_call_settings_create(modem, 0, "atmodem", data->app);
> +	ofono_call_meter_create(modem, 0, "atmodem", data->app);
> +	ofono_call_barring_create(modem, 0, "atmodem", data->app);
> +
>   	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x))
>   		ofono_lte_create(modem, OFONO_VENDOR_CINTERION,
>   						"atmodem", data->app);


--===============2232231984866340521==--

