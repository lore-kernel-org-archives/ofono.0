Content-Type: multipart/mixed; boundary="===============2354994010266457790=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Specify vendor ID for Huawei modem while creating GPRS
 context
Date: Tue, 07 Dec 2010 11:29:52 +0100
Message-ID: <1291717792.4795.135.camel@aeonflux>
In-Reply-To: <1291389772.2043.27.camel@Twins.TonnyLab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2354994010266457790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tonny,

>  plugins/huawei.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index 25dfaca..32cf70d 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -454,7 +454,7 @@ static void huawei_disconnect(gpointer user_data)
>  			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
>  		ofono_info("Reopened GPRS context channel");
>  =

> -		data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
> +		data->gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_HUAWEI,
> "atmodem",
>  								data->modem);

this not doing anything. Behavior is still the same.

>  		if (data->gprs && data->gc)
> @@ -631,12 +631,12 @@ static void huawei_post_online(struct ofono_modem
> *modem)
>  =

>  	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
>  			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
> -		data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->pcui);
> +		data->gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
> data->pcui);
>  		if (data->ndis =3D=3D TRUE)
> -			data->gc =3D ofono_gprs_context_create(modem, 0,
> +			data->gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_HUAWEI,
>  						"huaweimodem", data->pcui);

This one makes no sense. It is Huawei specific already.

>  		else
> -			data->gc =3D ofono_gprs_context_create(modem, 0,
> +			data->gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_HUAWEI,
>  						"atmodem", data->modem);
>  =


This is also not doing anything either actually.

Regards

Marcel



--===============2354994010266457790==--

