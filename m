Content-Type: multipart/mixed; boundary="===============0587819340099259463=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v5 6/8] plugins/modemconf.c add support for Interface for
 STE plugin.
Date: Tue, 17 Aug 2010 14:51:14 +0200
Message-ID: <1282049474.23399.94.camel@localhost.localdomain>
In-Reply-To: <1282047754-15562-7-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0587819340099259463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

>  plugins/modemconf.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/modemconf.c b/plugins/modemconf.c
> index 3747cd9..d7b1354 100644
> --- a/plugins/modemconf.c
> +++ b/plugins/modemconf.c
> @@ -138,6 +138,7 @@ static struct {
>  	{ "g1",		set_device	},
>  	{ "wavecom",	set_device	},
>  	{ "ste",	set_device	},
> +	{ "ste",	set_interface	},
>  	{ "calypso",	set_device	},
>  	{ "palmpre",	set_device	},
>  	{ "isimodem",	set_interface	},

I applied this patch, but keep in mind that modemconf will go away
pretty soon.

Regards

Marcel



--===============0587819340099259463==--

