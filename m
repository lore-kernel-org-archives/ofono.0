Content-Type: multipart/mixed; boundary="===============4052250176087561911=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 2/3] network-registration.c: implement CIND forTelit
 UC864-G
Date: Wed, 25 May 2011 12:08:04 -0700
Message-ID: <1306350484.2681.38.camel@aeonflux>
In-Reply-To: <1306329265-12066-2-git-send-email-Bernhard.Guillon@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4052250176087561911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bernhard,

> *UC864 has an incompatible CIND
> *add a Telit specific check for "not measurable" strength
> =

> Co-authored-by: Christopher Vogl <Christopher.Vogl@hale.at>
> ---
>  drivers/atmodem/network-registration.c |   40 ++++++++++++++++++++++++++=
+++--
>  1 files changed, 37 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/net=
work-registration.c
> index b3aa511..984e85e 100644
> --- a/drivers/atmodem/network-registration.c
> +++ b/drivers/atmodem/network-registration.c
> @@ -666,7 +666,20 @@ static void ciev_notify(GAtResult *result, gpointer =
user_data)
>  	if (!g_at_result_iter_next_number(&iter, &strength))
>  		return;
>  =

> -	strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
> +	switch (nd->vendor) {
> +	case OFONO_VENDOR_TELIT:
> +		/* Check for "signal not measurable" */
> +		if (strength =3D=3D 99)
> +			strength =3D 0;
> +		else
> +			strength =3D (strength * 100) / (nd->signal_max -
> +						nd->signal_min);
> +		break;
> +	default:
> +		strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
> +		break;
> +	}
> +

this is something that does not look like vendor quirk. The 99 is always
a special value and we should just do this for all modems.

Denis, any thoughts?

>  	ofono_netreg_strength_notify(netreg, strength);
>  }
>  =

> @@ -798,8 +811,19 @@ static void cind_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
>  =

>  	g_at_result_iter_next_number(&iter, &strength);
>  =

> -	strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
> -
> +	switch (nd->vendor) {
> +	case OFONO_VENDOR_TELIT:
> +		/* Check for "signal not measurable" */
> +		if (strength =3D=3D 99)
> +			strength =3D 0;
> +		else
> +			strength =3D (strength * 100) / (nd->signal_max -
> +						nd->signal_min);
> +		break;
> +	default:
> +		strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
> +		break;
> +	}
>  	cb(&error, strength, cbd->data);
>  }

If we really need quirks, then this code should be extracted into its
own function. However right now I would say to just treat 99 special for
all modems.

> @@ -1302,6 +1326,16 @@ static void at_creg_set_cb(gboolean ok, GAtResult =
*result, gpointer user_data)
>  	case OFONO_VENDOR_NOKIA:
>  		/* Signal strength reporting via CIND is not supported */
>  		break;
> +	case OFONO_VENDOR_TELIT:
> +		/* Use RSSI instead of signal.*/
> +		nd->signal_index =3D 9;
> +		nd->signal_min =3D 0;
> +		nd->signal_max =3D 5;
> +		g_at_chat_send(nd->chat, "AT+CIND=3D1", cind_prefix,
> +						NULL, NULL, NULL);
> +		g_at_chat_register(nd->chat, "+CIEV:", ciev_notify,
> +					FALSE, netreg, NULL);
> +		break;
>  	default:
>  		g_at_chat_send(nd->chat, "AT+CIND=3D?", cind_prefix,
>  				cind_support_cb, netreg, NULL);

Regards

Marcel



--===============4052250176087561911==--

