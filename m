Content-Type: multipart/mixed; boundary="===============4179923658028196691=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/8] sierra: Support CDMA modems
Date: Sun, 30 Dec 2012 20:34:29 -0600
Message-ID: <50E0F9B5.20906@gmail.com>
In-Reply-To: <20121228193613.GM18339@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4179923658028196691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Forest,

> -	ofono_netreg_create(modem, 0, "atmodem", data->modem);
> +	if (data->have_gsm =3D=3D TRUE) {
> +		ofono_netreg_create(modem, 0, "atmodem", data->modem);
> +	} else if (data->have_cdma =3D=3D TRUE) {
> +		/*
> +		 * Once we have CnS protocol support, we should be able to do
> +		 * netreg that way instead of using the same port for both.
> +		 */
> +		ofono_cdma_netreg_create(modem, 0, "sierramodem", data->modem);
> +		ofono_cdma_connman_create(modem, OFONO_VENDOR_SIERRA,
> +						"cdmamodem", data->modem);
> +	}

Ah I see what you're doing now.  This is really not going to work too =

well if you have just one AT port available...

Regards,
-Denis

--===============4179923658028196691==--

