Content-Type: multipart/mixed; boundary="===============5200966283843984971=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 3/8] gprs: Add 'stk' gprs context type
Date: Wed, 01 Jun 2011 00:30:00 -0500
Message-ID: <4DE5CE58.8030902@gmail.com>
In-Reply-To: <1305908781-8322-3-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5200966283843984971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 05/20/2011 11:26 AM, Philippe Nunes wrote:
> ---
>  include/gprs-context.h |    1 +
>  src/gprs.c             |    7 +++++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> =


Please refer to 'Submitting patches' section in HACKING.  We do prefer
these to be two separate patches.

> diff --git a/include/gprs-context.h b/include/gprs-context.h
> index f82fcaa..e7976a1 100644
> --- a/include/gprs-context.h
> +++ b/include/gprs-context.h
> @@ -46,6 +46,7 @@ enum ofono_gprs_context_type {
>  	OFONO_GPRS_CONTEXT_TYPE_MMS,
>  	OFONO_GPRS_CONTEXT_TYPE_WAP,
>  	OFONO_GPRS_CONTEXT_TYPE_IMS,
> +	OFONO_GPRS_CONTEXT_TYPE_STK,
>  };
>  =

>  struct ofono_gprs_primary_context {
> diff --git a/src/gprs.c b/src/gprs.c
> index deffeb8..9657a3e 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -188,6 +188,8 @@ static const char *gprs_context_default_name(enum ofo=
no_gprs_context_type type)
>  		return "WAP";
>  	case OFONO_GPRS_CONTEXT_TYPE_IMS:
>  		return "IMS";
> +	case OFONO_GPRS_CONTEXT_TYPE_STK:
> +		return "STK";
>  	}
>  =

>  	return NULL;
> @@ -207,6 +209,8 @@ static const char *gprs_context_type_to_string(
>  		return "wap";
>  	case OFONO_GPRS_CONTEXT_TYPE_IMS:
>  		return "ims";
> +	case OFONO_GPRS_CONTEXT_TYPE_STK:
> +		return "stk";
>  	}
>  =

>  	return NULL;
> @@ -227,6 +231,9 @@ static gboolean gprs_context_string_to_type(const cha=
r *str,
>  	} else if (g_str_equal(str, "ims")) {
>  		*out =3D OFONO_GPRS_CONTEXT_TYPE_IMS;
>  		return TRUE;
> +	} else if (g_str_equal(str, "stk")) {
> +		*out =3D OFONO_GPRS_CONTEXT_TYPE_STK;
> +		return TRUE;
>  	}
>  =

>  	return FALSE;

I don't really see the point of these changes though.  We do not want to
expose STK contexts over D-Bus, so none of these are going to be used.

Regards,
-Denis

--===============5200966283843984971==--

