Content-Type: multipart/mixed; boundary="===============1896696174293045038=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/6] stemodem: add default case
Date: Tue, 26 Oct 2010 17:35:26 +0200
Message-ID: <1288107326.3613.22.camel@aeonflux>
In-Reply-To: <1288107113-2740-3-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1896696174293045038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> ---
>  drivers/stemodem/radio-settings.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/stemodem/radio-settings.c b/drivers/stemodem/radio-s=
ettings.c
> index 5b16ec0..a345975 100644
> --- a/drivers/stemodem/radio-settings.c
> +++ b/drivers/stemodem/radio-settings.c
> @@ -90,7 +90,7 @@ static gboolean ofono_mode_to_ste_mode(enum ofono_radio=
_access_mode mode,
>  	case OFONO_RADIO_ACCESS_MODE_UMTS:
>  		*stemode =3D STE_RADIO_WCDMA_ONLY;
>  		return TRUE;
> -	case OFONO_RADIO_ACCESS_MODE_LTE:
> +	default:
>  		break;

no default for enums please. I want the compiler to warn us about not
handled switch statements.

Regards

Marcel



--===============1896696174293045038==--

