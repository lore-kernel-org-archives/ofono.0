Content-Type: multipart/mixed; boundary="===============8129537972531644055=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: Re: [RFC hwdb v1 20/28] telitqmi: drop unused device rule
Date: Fri, 31 Mar 2017 09:35:23 +0100
Message-ID: <0236a140-5fe2-2e07-209e-7c7505cb2d8c@gmail.com>
In-Reply-To: <20170330205309.25850-21-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8129537972531644055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 30/03/17 21:53, Jonas Bonn wrote:
> The rule might match for some device but setup_telitqmi does not attempt
> to do anything for interfaces that aren't driven by the qmi_wwan driver
> so it's pointless.

As I described before, this rule is not pointless, it prevents this rule:
  	{ "telit",	"option",	"1bc7"		},

from taking over the device, and using setup_telit instead of setup_telitqm=
i.

Lukasz


> ---
>  plugins/udevng.c | 1 -
>  1 file changed, 1 deletion(-)
> =

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 3aef447..d02cc6e 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1324,7 +1324,6 @@ static struct {
>  	{ "telit",	"usbserial",	"1bc7"		},
>  	{ "telit",	"option",	"1bc7"		},
>  	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
> -	{ "telitqmi",	"option",	"1bc7", "1201"	},
>  	{ "quectel",	"option",	"05c6", "9090"	},
>  	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
>  	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
>=20

--===============8129537972531644055==--

