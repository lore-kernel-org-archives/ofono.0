Content-Type: multipart/mixed; boundary="===============4107954607186431143=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] common: Accept pause character in the dialing number
Date: Wed, 05 Sep 2012 14:25:36 -0500
Message-ID: <5047A730.4060008@gmail.com>
In-Reply-To: <1346865579-24794-3-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4107954607186431143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 09/05/2012 12:19 PM, Philippe Nunes wrote:
> ---
>   src/common.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/common.c b/src/common.c
> index 94d70dd..de1ad26 100644
> --- a/src/common.c
> +++ b/src/common.c
> @@ -257,7 +257,7 @@ gboolean valid_number_format(const char *number, int =
length)
>   		if (number[i]>=3D '0'&&  number[i]<=3D '9')
>   			continue;
>
> -		if (number[i] =3D=3D '*' || number[i] =3D=3D '#')
> +		if (number[i] =3D=3D '*' || number[i] =3D=3D '#' || number[i] =3D=3D '=
p')
>   			continue;
>
>   		return FALSE;

You can't really mess directly with this function since it is used in =

places where pause characters are not appropriate, e.g. SMS, Call =

Forwarding, Deflection, numbers stored on the SIM, etc.

Also, we can't simply accept the pause character in the voicecall atom =

today.  That would require us to implement proper dial string support as =

sending pause characters directly is not really supported on many modems.

Regards,
-Denis

--===============4107954607186431143==--

