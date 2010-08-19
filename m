Content-Type: multipart/mixed; boundary="===============2903293174125618301=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/3] mbm: register gprs as STE to utilize STE quirks
Date: Thu, 19 Aug 2010 10:45:49 +0200
Message-ID: <1282207549.23399.165.camel@localhost.localdomain>
In-Reply-To: <1282207087-16257-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2903293174125618301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> No AT+CGEREP=3D2,1 on mbm either.
> ---
>  plugins/mbm.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/mbm.c b/plugins/mbm.c
> index a06c444..e77e61c 100644
> --- a/plugins/mbm.c
> +++ b/plugins/mbm.c
> @@ -395,7 +395,8 @@ static void mbm_post_sim(struct ofono_modem *modem)
>  	ofono_cbs_create(modem, 0, "atmodem", data->modem_port);
>  	ofono_ussd_create(modem, 0, "atmodem", data->modem_port);
>  =

> -	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->modem_port);
> +	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_STE, "atmodem",
> +					data->modem_port);
>  	gc =3D ofono_gprs_context_create(modem, 0, "mbm", data->modem_port);

looks good, but I actually prefer if we turn this around. Make the quirk
in drivers/atmodem/gprs.c an OFONO_VENDOR_MBM quirk with a proper
comment that this applies to STE and MBM modems. And then have the MBM
and STE plugin use that quirk.

Regards

Marcel



--===============2903293174125618301==--

