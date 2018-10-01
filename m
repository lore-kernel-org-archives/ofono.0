Content-Type: multipart/mixed; boundary="===============0181522302900875676=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] network: add support eutran sms only states
Date: Mon, 01 Oct 2018 14:42:52 -0500
Message-ID: <e4f924bd-4ae3-2ebf-ab36-33ac389fcd24@gmail.com>
In-Reply-To: <1538112672-18092-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0181522302900875676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anirudh,

On 09/28/2018 12:31 AM, Anirudh Gargi wrote:
> EUTRAN SMS states mapped to registered and roaming respectively.
> For the new CREG status (9/10) of CREG, it can be map to a new Dbus
> CSFB property.
> =

> Added clarity in API doc for voice calling in case of lte.
> ---
>   doc/network-api.txt |  4 +++-
>   src/common.c        |  4 ++++
>   src/common.h        | 19 +++++++++++++------
>   3 files changed, 20 insertions(+), 7 deletions(-)
> =


I split this patch into two and...

> diff --git a/doc/network-api.txt b/doc/network-api.txt
> index 83a2bc0..9c367c7 100644
> --- a/doc/network-api.txt
> +++ b/doc/network-api.txt
> @@ -77,7 +77,9 @@ Properties	string Mode [readonly]
>   =

>   		string Status [readonly]
>   =

> -			The current registration status of a modem.
> +			The current registration status of a modem. In case
> +			technology is 'lte', 'registered' and 'roaming' may
> +			not necessarily mean voice calling available.
>   =

>   			The possible values are:
>   				"unregistered"  Not registered to any network
> diff --git a/src/common.c b/src/common.c
> index 3ccaf7c..0db412a 100644
> --- a/src/common.c
> +++ b/src/common.c
> @@ -669,6 +669,10 @@ const char *registration_status_to_string(int status)
>   		return "unknown";
>   	case NETWORK_REGISTRATION_STATUS_ROAMING:
>   		return "roaming";
> +	case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
> +		return "registered";
> +	case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
> +		return "roaming";
>   	}
>   =

>   	return "";
> diff --git a/src/common.h b/src/common.h
> index 1b6b01d..f7bd3cb 100644
> --- a/src/common.h
> +++ b/src/common.h
> @@ -37,12 +37,19 @@ enum access_technology {
>   =

>   /* 27.007 Section 7.2 <stat> */
>   enum network_registration_status {
> -	NETWORK_REGISTRATION_STATUS_NOT_REGISTERED =3D	0,
> -	NETWORK_REGISTRATION_STATUS_REGISTERED =3D	1,
> -	NETWORK_REGISTRATION_STATUS_SEARCHING =3D		2,
> -	NETWORK_REGISTRATION_STATUS_DENIED =3D		3,
> -	NETWORK_REGISTRATION_STATUS_UNKNOWN =3D		4,
> -	NETWORK_REGISTRATION_STATUS_ROAMING =3D		5,
> +	NETWORK_REGISTRATION_STATUS_NOT_REGISTERED =3D		0,
> +	NETWORK_REGISTRATION_STATUS_REGISTERED =3D		1,
> +	NETWORK_REGISTRATION_STATUS_SEARCHING =3D			2,
> +	NETWORK_REGISTRATION_STATUS_DENIED =3D			3,
> +	NETWORK_REGISTRATION_STATUS_UNKNOWN =3D			4,
> +	NETWORK_REGISTRATION_STATUS_ROAMING =3D			5,
> +	NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN =3D	6,
> +	NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN =3D	7,
> +	/*
> +	 * Add along with new CSFB Dbus property.
> +	NETWORK_REGISTRATION_STATUS_REGISTERED_NO_CSFB_EUTRAN =3D	9,
> +	NETWORK_REGISTRATION_STATUS_ROAMING_NO_CSFB_EUTRAN =3D	10,
> +	*/

Took out this commented out block.

>   };
>   =

>   /* 27.007 Section 7.3 <stat> */
> =


Patches have been applied, thanks.

Regards,
-Denis

--===============0181522302900875676==--

