Content-Type: multipart/mixed; boundary="===============6722284060821230393=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Specify vendor ID for Huawei modem while creating GPRS
 context
Date: Mon, 06 Dec 2010 21:21:22 -0600
Message-ID: <4CFDA832.9090309@gmail.com>
In-Reply-To: <1291389772.2043.27.camel@Twins.TonnyLab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6722284060821230393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tonny,

On 12/03/2010 09:22 AM, Tonny Tzeng wrote:
> ---
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

There's no need to pass the vendor flag here.  The atmodem gprs_context
driver does not have any vendor handling code inside it.

>  =

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

Same comment as above

>  		else
> -			data->gc =3D ofono_gprs_context_create(modem, 0,
> +			data->gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_HUAWEI,
>  						"atmodem", data->modem);

ditto.

>  =

>  		if (data->gprs && data->gc)

Regards,
-Denis

--===============6722284060821230393==--

