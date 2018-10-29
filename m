Content-Type: multipart/mixed; boundary="===============5822379141039081512=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/9] simutil: remove check for impossible condition
Date: Mon, 29 Oct 2018 13:44:02 -0500
Message-ID: <a19dbbb1-52d4-45d2-89c4-985f122b6be6@gmail.com>
In-Reply-To: <20181026101319.27709-6-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5822379141039081512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 10/26/2018 05:13 AM, Jonas Bonn wrote:
> From: Jonas Bonn <jonas@southpole.se>
> =

> Addresses following warning:
> =

> src/simutil.c:1546:12: error: comparison of constant 8 with expression
> of type
>        'enum sim_cphs_service' is always false
>        [-Werror,-Wtautological-constant-out-of-range-compare]
>          if (index >=3D 2 * 4u)

This is clang right?

> ---
>   src/simutil.c | 3 ---
>   1 file changed, 3 deletions(-)
> =

> diff --git a/src/simutil.c b/src/simutil.c
> index 9287df17..7f0e316e 100644
> --- a/src/simutil.c
> +++ b/src/simutil.c
> @@ -1543,9 +1543,6 @@ gboolean sim_sst_is_active(unsigned char *efsst, un=
signed char len,
>   =

>   gboolean sim_cphs_is_active(unsigned char *cphs, enum sim_cphs_service =
index)
>   {
> -	if (index >=3D 2 * 4u)
> -		return FALSE;
> -

This is where gcc & clang give differing advice.  In theory there's =

nothing preventing index from being any value up to =

MAX_UCHAR/MAX_USHRT/MAX_UINT depending on what the compiler chooses to =

represent enums as.

>   	return ((cphs[index / 4] >> ((index % 4) * 2)) & 3) =3D=3D 3;
>   }
>   =

> =


Regards,
-Denis

--===============5822379141039081512==--

