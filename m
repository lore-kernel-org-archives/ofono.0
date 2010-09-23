Content-Type: multipart/mixed; boundary="===============1347216260320425872=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Fix valid_ussd_string()
Date: Thu, 23 Sep 2010 11:11:58 +0900
Message-ID: <1285207918.20811.60.camel@localhost.localdomain>
In-Reply-To: <1285180359-12802-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1347216260320425872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> The valid_ussd_string() returns true if MMI input is to be sent as USSD.
> ---
>  src/common.c |   39 ++++++++++++++-------------------------
>  src/common.h |    2 +-
>  src/ussd.c   |    2 +-
>  3 files changed, 16 insertions(+), 27 deletions(-)
> =

> diff --git a/src/common.c b/src/common.c
> index 55c4b40..e0a8387 100644
> --- a/src/common.c
> +++ b/src/common.c
> @@ -393,7 +393,7 @@ void string_to_phone_number(const char *str, struct o=
fono_phone_number *ph)
>  	}
>  }
>  =

> -int valid_ussd_string(const char *str)
> +gboolean valid_ussd_string(const char *str, gboolean call_in_progress)
>  {
>  	int len =3D strlen(str);
>  =

> @@ -401,37 +401,26 @@ int valid_ussd_string(const char *str)
>  		return FALSE;
>  =

>  	/*
> -	 * It is hard to understand exactly what constitutes a valid USSD string
> -	 * According to 22.090:
> -	 * Case a - 1, 2 or 3 digits from the set (*, #) followed by 1X(Y),
> -	 * where X=3Dany number 0=E2=80=914, Y=3Dany number 0=E2=80=919, then, =
optionally "*
> -	 * followed by any number of any characters", and concluding with #SEND
> -	 *
> -	 * Case b - 1, 2 or 3 digits from the set (*, #) followed by 1X(Y),
> -	 * where X=3Dany number 5=E2=80=919, Y=3Dany number 0=E2=80=919, then, =
optionally "*
> -	 * followed by any number of any characters", and concluding with #SEND
> -	 *
> -	 * Case c - 7(Y) SEND, where Y=3Dany number 0=E2=80=919
> -	 *
> -	 * Case d - All other formats
> -	 *
>  	 * According to 22.030 Figure 3.5.3.2 USSD strings can be:
>  	 *
> -	 * Supplementary service control
> -	 * SIM control
> -	 * Manufacturer defined
> -	 * Terminated by '#'
> -	 * Short String - This can be any 2 digit short string.  If the string
> -	 *                starts with a '1' and no calls are in progress then
> -	 *                this string is treated as a call setup request
> +	 * 1) Terminated by '#'
> +	 * 2) A short string of 1 or 2 digits.
>  	 *
> -	 * Everything else is not a valid USSD string
> +	 * If a 2 digit string starts with a '1' and no calls are in
> +	 * progress then this string is treated as a call setup request
> +	 * instead.
>  	 */

this is not an acceptable patch. You are removing functionality and
lengthy comment without providing a comment in the commit message from
equal length and detail.

We can not do it like this since 1 month later nobody remembers what has
been done here and why. This needs proper documentation.

Regards

Marcel



--===============1347216260320425872==--

