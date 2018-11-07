Content-Type: multipart/mixed; boundary="===============3464878775016644689=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 3/3] sim800: add udev detection.
Date: Wed, 07 Nov 2018 15:02:54 +0100
Message-ID: <c0e9bf5f-1d09-bc59-2306-b820e72382e9@norrbonn.se>
In-Reply-To: <1541599227-3084-3-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3464878775016644689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 07/11/2018 15:00, Clement Viel wrote:
> ---
>   plugins/udevng.c | 1 +
>   1 file changed, 1 insertion(+)
> =

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index ff6e1fc..d0a849d 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1308,6 +1308,7 @@ static struct {
>   	{ "calypso",	setup_serial_modem	},
>   	{ "cinterion",	setup_serial_modem	},
>   	{ "nokiacdma",	setup_serial_modem	},
> +	{ "sim800",	setup_serial_modem	},

Right... that's much simpler.  And given that you are extending the =

sim900 driver to handle the sim800 model, you don't need the above line =

either.

/Jonas

>   	{ "sim900",	setup_serial_modem	},
>   	{ "wavecom",	setup_wavecom		},
>   	{ "tc65",	setup_tc65		},
>=20

--===============3464878775016644689==--

