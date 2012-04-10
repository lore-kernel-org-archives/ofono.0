Content-Type: multipart/mixed; boundary="===============0005141479349340478=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] ussd: rise up buffer lenght for ussd strings
Date: Tue, 10 Apr 2012 08:55:47 -0500
Message-ID: <4F843BE3.5030000@gmail.com>
In-Reply-To: <1334072105-32105-2-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0005141479349340478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 04/10/2012 10:35 AM, Nicolas Bertrand wrote:
> Some ZTE modems used to convert any ussd strings in UCS2,
> and so the buffer length is double. Considering the limit of
> 182 characters, 364 will avoid crash.
> ---
>  drivers/atmodem/ussd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
> index 443251a..f5b38e2 100644
> --- a/drivers/atmodem/ussd.c
> +++ b/drivers/atmodem/ussd.c
> @@ -106,7 +106,7 @@ static void cusd_parse(GAtResult *result, struct ofon=
o_ussd *ussd)
>  	const char *content;
>  	int dcs;
>  	enum sms_charset charset;
> -	unsigned char msg[160];
> +	unsigned char msg[364];

Actually I'm not happy with this since the core is still expecting raw
160 byte PDUs.  If ZTE reports all USSDs as unpacked UCS2 data, then we
need to pack that back up into packed GSM 7 bit.  This probably requires
a custom driver for ZTE modems.

Alternatively you can see whether ZTE provides some way to modify the
USSD reporting behavior, similar to what Huawei did with ^USSDMODE.

Regards,
-Denis

--===============0005141479349340478==--

