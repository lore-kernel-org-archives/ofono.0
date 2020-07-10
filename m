Content-Type: multipart/mixed; boundary="===============7249315017604985849=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH v2] udevng: Add support for Quectel BG96 modem
Date: Fri, 10 Jul 2020 09:55:35 +0200
Message-ID: <0135db3b-d931-c0aa-5dbb-16a23763e8d8@geanix.com>
In-Reply-To: <20200228110719.21099-1-sean@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7249315017604985849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Did this patch (and Sean's original one from november) never reach the =

mailing list?

// Martin

On 28/02/2020 12.07, Sean Nyekjaer wrote:
> ---
> Changes since v1:
>   - Removed signoff
> =

>   plugins/udevng.c | 2 ++
>   1 file changed, 2 insertions(+)
> =

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 4a38621b..8a279bf3 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1795,6 +1795,8 @@ static struct {
>   	{ "quectelqmi",	"qcserial",	"2c7c", "0121"	},
>   	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0125"	},
>   	{ "quectelqmi",	"qcserial",	"2c7c", "0125"	},
> +	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0296"	},
> +	{ "quectelqmi",	"qcserial",	"2c7c", "0296"	},
>   	{ "ublox",	"cdc_acm",	"1546", "1010"	},
>   	{ "ublox",	"cdc_ncm",	"1546", "1010"	},
>   	{ "ublox",	"cdc_acm",	"1546", "1102"	},
>=20
--===============7249315017604985849==--

