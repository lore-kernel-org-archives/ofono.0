Content-Type: multipart/mixed; boundary="===============5134450470002649752=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] radio-settings: Add handling of dual mode technology
 preference
Date: Tue, 01 Jun 2021 10:53:40 -0500
Message-ID: <7701b2b8-fca3-c82d-22e9-aa4aa4e866fc@gmail.com>
In-Reply-To: <20210531114932.68629-2-sean@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5134450470002649752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On 5/31/21 6:49 AM, Sean Nyekjaer wrote:
> Allow setting of "lte,gsm" mode,
> for modems that doesn't support ANY mode.
> ---
>   src/radio-settings.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> =

> diff --git a/src/radio-settings.c b/src/radio-settings.c
> index 7283aa98..e2e5f33b 100644
> --- a/src/radio-settings.c
> +++ b/src/radio-settings.c
> @@ -79,6 +79,9 @@ static const char *radio_access_mode_to_string(enum ofo=
no_radio_access_mode m)
>   	if (m =3D=3D (OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_UMTS=
))
>   		return "lte,umts";
>   =

> +	if (m =3D (OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_GSM))

I think you meant '=3D=3D' here, so I fixed that.

> +		return "lte,gsm";
> +
>   	return NULL;
>   }
>   =

> @@ -104,6 +107,9 @@ static gboolean radio_access_mode_from_string(const c=
har *str,
>   	} else if (g_str_equal(str, "lte,umts")) {
>   		*mode =3D OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_UMTS;
>   		return TRUE;
> +	} else if (g_str_equal(str, "lte,gsm")) {
> +		*mode =3D OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_GSM;
> +		return TRUE;
>   	}
>   =

>   	return FALSE;
> =


All three patches applied, thanks.

Regards,
-Denis
--===============5134450470002649752==--

