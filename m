Content-Type: multipart/mixed; boundary="===============3347677961771564423=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0] Fix voice call initialization problem
Date: Wed, 02 Jan 2019 12:44:18 -0600
Message-ID: <6741daac-090a-2fc8-50e4-f20e085558d9@gmail.com>
In-Reply-To: <1546444142-28813-1-git-send-email-khaled.romdhani@ardia.com.tn>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3347677961771564423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Khaled,

On 01/02/2019 09:49 AM, Khaled ROMDHANI wrote:
> when the voice call driver is probing, I noticed sometimes
> a CME Error with the code =3D 4 (operation not supported)
> related to AT commands "AT+CSSN=3D1,1" and "AT^SLCC=3D1".
> =

> In the current voice call implementation for Gemalto modems
> the ofono_voicecall_create() is called on the gemalto_pre_sim().
> The sim is not totaly readed by the module, it is not yet
> online which is causing a sporadic problem at driver
> intialization also when launching some outgoing/incoming calls.
> =

> This change moves the ofono_voicecall_create() to the
> gemalto_post_online() to be sure that sim is well registred
> and online.
> =

> Signed-off-by: khaled romdhani <khaled.romdhani@ardia.com.tn>

No Signed-off-by for oFono please...

> ---
>   plugins/gemalto.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> =

> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> index 2f84258..eb782a7 100644
> --- a/plugins/gemalto.c
> +++ b/plugins/gemalto.c
> @@ -573,9 +573,6 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
>   	ofono_devinfo_create(modem, 0, "atmodem", data->app);
>   	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
>   =

> -	ofono_modem_set_integer(modem, "GemaltoVtsQuotes", 1);
> -	ofono_voicecall_create(modem, 0, "gemaltomodem", data->app);
> -
>   	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_GEMALTO, "atmodem",
>   						data->app);
>   =

> @@ -604,11 +601,6 @@ static void gemalto_post_sim(struct ofono_modem *mod=
em)
>   =

>   	ofono_ussd_create(modem, 0, "atmodem", data->app);
>   =

> -	ofono_call_forwarding_create(modem, 0, "atmodem", data->app);

Do note that call_forwarding can be post_sim, but either works...

> -	ofono_call_settings_create(modem, 0, "atmodem", data->app);
> -	ofono_call_meter_create(modem, 0, "atmodem", data->app);
> -	ofono_call_barring_create(modem, 0, "atmodem", data->app);
> -
>   	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x))
>   		ofono_lte_create(modem, OFONO_VENDOR_GEMALTO,
>   						"atmodem", data->app);
> @@ -621,6 +613,14 @@ static void gemalto_post_online(struct ofono_modem *=
modem)
>   	DBG("%p", modem);
>   =

>   	ofono_netreg_create(modem, OFONO_VENDOR_GEMALTO, "atmodem", data->app);
> +	=

> +	ofono_modem_set_integer(modem, "GemaltoVtsQuotes", 1);
> +	ofono_voicecall_create(modem, 0, "gemaltomodem", data->app);

This does imply that no emergency calls are possible when no SIM is =

inserted or the PIN not in 'READY' state.

> +
> +	ofono_call_forwarding_create(modem, 0, "atmodem", data->app);
> +	ofono_call_settings_create(modem, 0, "atmodem", data->app);
> +	ofono_call_meter_create(modem, 0, "atmodem", data->app);
> +	ofono_call_barring_create(modem, 0, "atmodem", data->app);
>   }
>   =

>   static struct ofono_modem_driver gemalto_driver =3D {
> =


Regards,
-Denis

--===============3347677961771564423==--

