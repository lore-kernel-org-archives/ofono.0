Content-Type: multipart/mixed; boundary="===============1764881765564419449=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] src/gprs: support for NONE auth
Date: Tue, 09 Oct 2018 12:37:18 -0500
Message-ID: <b4b5e9b2-9109-6ee0-8902-4470b9f31f87@gmail.com>
In-Reply-To: <20181006054520.26737-3-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1764881765564419449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/06/2018 12:45 AM, Giacinto Cifelli wrote:
> ---
>   src/gprs.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Applied, see below:

> =

> diff --git a/src/gprs.c b/src/gprs.c
> index 79fafdbc..235c8884 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -261,6 +261,10 @@ static const char *gprs_auth_method_to_string(enum o=
fono_gprs_auth_method auth)
>   		return "chap";
>   	case OFONO_GPRS_AUTH_METHOD_PAP:
>   		return "pap";
> +	case OFONO_GPRS_AUTH_METHOD_NONE:
> +		return "none";
> +	default:
> +		return NULL;

I dropped this default statement for reasons outlined in our earlier =

discussions.

>   	};
>   =

>   	return NULL;
> @@ -275,6 +279,9 @@ static gboolean gprs_auth_method_from_string(const ch=
ar *str,
>   	} else if (g_str_equal(str, "pap")) {
>   		*auth =3D OFONO_GPRS_AUTH_METHOD_PAP;
>   		return TRUE;
> +	} else if (g_str_equal(str, "none")) {
> +		*auth =3D OFONO_GPRS_AUTH_METHOD_NONE;
> +		return TRUE;
>   	}
>   =

>   	return FALSE;
> =


Regards,
-Denis

--===============1764881765564419449==--

