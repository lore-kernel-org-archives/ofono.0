Content-Type: multipart/mixed; boundary="===============3057022345765907867=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] plugins: Handle HE910 and UE910 variants
Date: Thu, 26 Jan 2017 13:33:37 -0600
Message-ID: <6e150fed-2ddc-3778-916b-1920333cbdbd@gmail.com>
In-Reply-To: <20170126162253.25442-3-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3057022345765907867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Piotr,

On 01/26/2017 10:22 AM, Piotr Haber wrote:
> Telit modems HE910 and UE910 share the same USB
> vendor and device IDs (1bc7:0021) but they are
> different devices.
> HE910 is HSPA Class 14/6 and UE910 is Class 8/6.
> Both come in voice-enabled variants.
> HE910 also comes in variants with built-in GPS.
> ---
>  plugins/xe910.c | 167 ++++++++++++++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 143 insertions(+), 24 deletions(-)
>

I went ahead and applied a modified version of this patch.  Mostly =

fixing all sorts of coding style issues (spaces being used for =

indentation, etc)

Please pay attention to our coding style guidelines.

Also, I modified the patch in 2 places:

> @@ -201,16 +229,8 @@ static void cfun_enable_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
>
>  	DBG("%p", modem);
>
> -	if (!ok) {
> -		g_at_chat_unref(data->chat);
> -		data->chat =3D NULL;
> -
> -		g_at_chat_unref(data->modem);
> -		data->modem =3D NULL;
> -
> -		ofono_modem_set_powered(modem, FALSE);
> -		return;
> -	}
> +	if (!ok)
> +	    return;
>

I squished this change since you want to clean up properly if the CFUN =

fails.

>  	/*
>  	 * Switch data carrier detect signal off.

<snip>

> +static void cfun_gmm_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct xe910_data *data =3D ofono_modem_get_data(modem);
> +	const char * model_variant;
> +
> +	DBG("%p", modem);
> +
> +	if (!ok)
> +	    goto error;
> +
> +	/* Get +GMM response */
> +	if(!at_util_parse_attr(result, "", &model_variant))
> +	    goto error;
>
> +	/* Try to find modem model and variant */
> +	if(!find_model_variant(modem, model_variant)) {
> +	    ofono_info("Unknown xE910 model/variant %s", model_variant);
> +	    goto error;
> +	}
> +
> +	/* Set phone functionality */
> +	if (g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
> +				cfun_enable_cb, modem, NULL) > 0)
> +	    return;
> +
> +error:
> +	g_at_chat_unref(data->chat);
> +	data->chat =3D NULL;
> +
> +	g_at_chat_unref(data->modem);
> +	data->modem =3D NULL;
> +
> +	ofono_modem_set_powered(modem, FALSE);
> +	return;

I took out this pointless return statement.

> +}
> +
>  static int xe910_enable(struct ofono_modem *modem)
>  {
>  	struct xe910_data *data =3D ofono_modem_get_data(modem);

Regards,
-Denis


--===============3057022345765907867==--

