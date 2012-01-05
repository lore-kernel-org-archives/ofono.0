Content-Type: multipart/mixed; boundary="===============7644098821619933672=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] udevng: use huaweicdma driver for olive V-ME101
Date: Thu, 05 Jan 2012 00:03:33 -0800
Message-ID: <1325750613.6454.65.camel@aeonflux>
In-Reply-To: <1321619263-28308-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7644098821619933672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

>  plugins/udevng.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> =

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index be87320..8d478cf 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -800,11 +800,10 @@ static struct {
>  	{ "hso",	"hso"				},
>  	{ "gobi",	"qcserial"			},
>  	{ "sierra",	"sierra"			},
> -	{ "huawei",	"option",	"201e", "2009"	},
> +	{ "huaweicdma",	"option",	"201e", "2009"	},
>  	{ "huawei",	"cdc_ether",	"12d1"		},
>  	{ "huawei",	"option",	"12d1"		},
>  	{ "huaweicdma",	"option",	"12d1", "140b"	},
> -	{ "huaweicdma", "option",	"201e"		},
>  	{ "speedupcdma","option",	"1c9e", "9e00"	},
>  	{ "speedup",	"option",	"1c9e"		},
>  	{ "speedup",	"option",	"2020"		},

the commit message does not explain why you are removing huaweicdma in
general for VID 0x201e.

Regards

Marcel



--===============7644098821619933672==--

