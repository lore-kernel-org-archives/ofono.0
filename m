Content-Type: multipart/mixed; boundary="===============7644584035331271796=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] atmodem: move USSD quirk to probe and use it also for
 STE modems
Date: Fri, 14 Jan 2011 15:20:35 +0100
Message-ID: <1295014835.3873.147.camel@aeonflux>
In-Reply-To: <1295014353-9106-1-git-send-email-lasse.kunnasluoto@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7644584035331271796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

> Fixing issues in USSD quirk:
> 1) MT USSD are not handled correctly if modem uses IRA character set (cha=
nge character set to GSM already in probe)
> 2) Responses from NW to MO USSD are not hadled as internal variable is no=
t updated after cscs=3D command (Query right after setting)
> 3) Use the same quirk for STE modems

Hi Lasse,

> ---
>  drivers/atmodem/ussd.c |   21 ++++++++++++---------
>  1 files changed, 12 insertions(+), 9 deletions(-)
> =

> diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
> index 651b6af..411b1de 100644
> --- a/drivers/atmodem/ussd.c
> +++ b/drivers/atmodem/ussd.c
> @@ -219,15 +219,6 @@ static void at_ussd_request(struct ofono_ussd *ussd,=
 int dcs,
>  				converted, dcs);
>  	}
>  =

> -	if (data->vendor =3D=3D OFONO_VENDOR_QUALCOMM_MSM) {
> -		/* Ensure that the modem is using GSM character set. It
> -		 * seems it defaults to IRA and then umlauts are not
> -		 * properly encoded. The modem returns some weird from
> -		 * of Latin-1, but it is not really Latin-1 either. */
> -		g_at_chat_send(data->chat, "AT+CSCS=3D\"GSM\"", none_prefix,
> -							NULL, NULL, NULL);
> -	}
> -
>  	if (g_at_chat_send(data->chat, buf, cusd_prefix,
>  				cusd_request_cb, cbd, g_free) > 0)
>  		return;
> @@ -314,6 +305,18 @@ static int at_ussd_probe(struct ofono_ussd *ussd, un=
signed int vendor,
>  =

>  	ofono_ussd_set_data(ussd, data);
>  =

> +	switch (data->vendor) {
> +	case OFONO_VENDOR_QUALCOMM_MSM:
> +	case OFONO_VENDOR_STE:
> +		/*
> +		* Ensure that the modem is using GSM character set. It
> +		* seems it defaults to IRA and then umlauts are not
> +		* properly encoded. The modem returns some weird from
> +		* of Latin-1, but it is not really Latin-1 either.
> +		*/
> +		g_at_chat_send(data->chat, "AT+CSCS=3D\"GSM\"", none_prefix,
> +							NULL, NULL, NULL);
> +		break;
> +	}
> +
>  	g_at_chat_send(chat, "AT+CSCS?", cscs_prefix, read_charset_cb, data,
>  			NULL);
>  =


so we don't really wanna do it this way since other atoms like the
phonebook can switch the character sets as well.

The best is if the STE modem would provide access to the USSD in PDU
mode and we can then decode it properly. Using text mode for USSD is not
the best idea actually. Same as text mode for SMS is utterly broken ;)

Regards

Marcel



--===============7644584035331271796==--

