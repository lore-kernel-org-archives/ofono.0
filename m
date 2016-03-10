Content-Type: multipart/mixed; boundary="===============5734722345415807078=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 05/19] plugins/ublox: allow enabling of TOBY L2 modems
Date: Thu, 10 Mar 2016 08:11:44 -0600
Message-ID: <56E180A0.3050300@gmail.com>
In-Reply-To: <1457538300-7183-6-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5734722345415807078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 03/09/2016 09:44 AM, Dragos Tatulea wrote:
> For this we need to:
> * Set the vendor family based on model id.
> * Not use modem interface for the TOBY L2 family.
> ---
>   plugins/ublox.c | 53 ++++++++++++++++++++++++++++++++++++++++++++------=
---
>   1 file changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/plugins/ublox.c b/plugins/ublox.c
> index 89ca709..171d59d 100644
> --- a/plugins/ublox.c
> +++ b/plugins/ublox.c
> @@ -47,6 +47,7 @@ static const char *none_prefix[] =3D { NULL };
>   struct ublox_data {
>   	GAtChat *modem;
>   	GAtChat *aux;
> +	enum ofono_vendor vendor_family;
>   };
>
>   static void ublox_debug(const char *str, void *user_data)
> @@ -138,24 +139,58 @@ static void cfun_enable(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>   static int ublox_enable(struct ofono_modem *modem)
>   {
>   	struct ublox_data *data =3D ofono_modem_get_data(modem);
> +	const char *model_str =3D NULL;
> +	int model_id;
>
>   	DBG("%p", modem);
>
> -	data->modem =3D open_device(modem, "Modem", "Modem: ");
> -	if (data->modem =3D=3D NULL)
> +	model_str =3D ofono_modem_get_string(modem, "Model");
> +	if (model_str =3D=3D NULL)
>   		return -EINVAL;
>
> +	/*
> +	 * Toby L2 devices are more complex and special than previously
> +	 * supported U-Blox devices. So they need a vendor of their own.
> +	 */
> +	model_id =3D atoi(model_str);
> +	switch (model_id) {
> +		case 1102:
> +			data->vendor_family =3D OFONO_VENDOR_UBLOX;
> +			break;
> +		case 1141:
> +		case 1146:
> +			data->vendor_family =3D OFONO_VENDOR_UBLOX_TOBY_L2;
> +			break;
> +		case 1143:
> +			DBG("low/medium throughtput profile unsupported");
> +		default:
> +			DBG("unknown ublox model id %d", model_id);
> +			return -EINVAL;
> +	}
> +
>   	data->aux =3D open_device(modem, "Aux", "Aux: ");
> -	if (data->aux =3D=3D NULL) {
> -		g_at_chat_unref(data->modem);
> -		data->modem =3D NULL;
> -		return -EIO;
> +	if (data->aux =3D=3D NULL)
> +		return -EINVAL;
> +
> +	if (data->vendor_family =3D=3D OFONO_VENDOR_UBLOX) {
> +

No empty line here please

> +		data->modem =3D open_device(modem, "Modem", "Modem: ");
> +		if (data->modem =3D=3D NULL) {
> +			g_at_chat_unref(data->aux);
> +			data->aux =3D NULL;
> +			return -EIO;
> +		}
> +
> +		g_at_chat_set_slave(data->modem, data->aux);
> +
> +		g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", none_prefix,
> +						NULL, NULL, NULL);
> +

No unneeded whitespace here please

>   	}
>
> -	g_at_chat_set_slave(data->modem, data->aux);
> +	/* The modem can take a while to wake up if just powered on. */
> +	g_at_chat_set_wakeup_command(data->aux, "AT\r", 1000, 11000);

This is a pretty nasty hack specific for TI Calypso.  I wouldn't use it =

unless you really need it.

>
> -	g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", none_prefix,
> -					NULL, NULL, NULL);
>   	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", none_prefix,
>   					NULL, NULL, NULL);
>
>

Regards,
-Denis

--===============5734722345415807078==--

