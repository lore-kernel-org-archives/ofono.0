Content-Type: multipart/mixed; boundary="===============7866475708302724019=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: added inline function to parse AT+CESQ result
 for signal strenght It complements the function
 at_util_convert_signal_strength for AT+CSQ,
 which does not apply well to 3G and not at all to LTE. The AT+CESQ returns 3
 sets of values, one for each technology (2G, 3G, LTE).
Date: Thu, 20 Sep 2018 10:22:18 -0500
Message-ID: <7a37ec5a-03ba-cbbe-3d2b-0e654862d293@gmail.com>
In-Reply-To: <1537413839-3460-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7866475708302724019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

So just to make sure:
- Your commit header should be no longer than 50 characters

Your commit description can be as long as you need, but broken down into =

72 character wide lines.

It looks like your description is included in the header.  I can't apply =

this :)

On 09/19/2018 10:23 PM, Giacinto Cifelli wrote:
> ---
>   drivers/atmodem/atutil.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> =

> diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
> index 7113a4c..57573cb 100644
> --- a/drivers/atmodem/atutil.h
> +++ b/drivers/atmodem/atutil.h
> @@ -115,6 +115,20 @@ static inline int at_util_convert_signal_strength(in=
t strength)
>   	return result;
>   }
>   =

> +static inline int at_util_convert_signal_strength_cesq(int strength_GSM,=
 int strength_UTRAN, int strength_EUTRAN)

doc/coding-style.txt item M4.

> +{
> +	int result =3D -1;
> +
> +	if (strength_GSM !=3D 99)
> +		result =3D (strength_GSM * 100) / 63;
> +	else if (strength_UTRAN !=3D 255)
> +		result =3D (strength_UTRAN * 100) / 96;
> +	else if (strength_EUTRAN !=3D 255)
> +		result =3D (strength_EUTRAN * 100) / 97;
> +
> +	return result;
> +}
> +
>   #define CALLBACK_WITH_FAILURE(cb, args...)		\
>   	do {						\
>   		struct ofono_error cb_e;		\
> =


Regards,
-Denis

--===============7866475708302724019==--

