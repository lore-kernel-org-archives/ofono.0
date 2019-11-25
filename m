Content-Type: multipart/mixed; boundary="===============5262829818524111609=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH] udevng: Add support for Quectel BG96 modem
Date: Mon, 25 Nov 2019 10:05:29 +0100
Message-ID: <8e92adb3-4426-11dd-e86e-296e13b8e866@geanix.com>
In-Reply-To: <20191125082655.5270-1-sean@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5262829818524111609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On 11/25/19 9:26 AM, Sean Nyekjaer wrote:
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

No signoff when submitting to ofono.

// Martin

> ---
>   plugins/udevng.c | 2 ++
>   1 file changed, 2 insertions(+)
> =

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 40ed2b02..cc294c94 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1790,6 +1790,8 @@ static struct {
>   	{ "quectelqmi",	"qcserial",	"2c7c", "0121"	},
>   	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0125"	},
>   	{ "quectelqmi",	"qcserial",	"2c7c", "0125"	},
> +	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0296"	},
> +	{ "quectelqmi",	"qcserial",	"2c7c", "0296"	},
>   	{ "ublox",	"cdc_acm",	"1546", "1010"	},
>   	{ "ublox",	"cdc_ncm",	"1546", "1010"	},
>   	{ "ublox",	"cdc_acm",	"1546", "1102"	},
>=20
--===============5262829818524111609==--

