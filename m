Content-Type: multipart/mixed; boundary="===============5668056748949280331=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/8] gprs: add quirk for Telit modems
Date: Mon, 13 Aug 2012 08:36:48 -0500
Message-ID: <502902F0.8010008@gmail.com>
In-Reply-To: <1344864148-23060-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5668056748949280331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 08/13/2012 08:22 AM, Christopher Vogl wrote:
> Telit does not support AT+CGAUTO, use AT#AUTOATT=3D0 instead.
> ---
>   drivers/atmodem/gprs.c |    8 +++++++-
>   1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> index 65a8b7b..f87548e 100644
> --- a/drivers/atmodem/gprs.c
> +++ b/drivers/atmodem/gprs.c
> @@ -342,7 +342,13 @@ retry:
>   		goto error;
>
>   	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
> -	g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL, NULL=
);
> +
> +	/* Telit does not support AT+CGAUTO */
> +	if (gd->vendor =3D=3D OFONO_VENDOR_TELIT)
> +		cmd =3D "AT#AUTOATT=3D0";
> +	else
> +		cmd =3D "AT+CGAUTO=3D0";
> +	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);

Actually the two command indents are different. CGAUTO means do not auto =

accept network initiated PDP context activation requests.  Refer to =

Section 10.1.15 in 3GPP 27.007.  It is fine to ignore it if it is not =

supported.

The #AUTOATT=3D0 tells the modem not to automatically initiate auto-attach =

proceedures on its own.  This is correct, but probably belongs in the =

main telit plugin.
>
>   	switch (gd->vendor) {
>   	case OFONO_VENDOR_MBM:

Regards,
-Denis

--===============5668056748949280331==--

