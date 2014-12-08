Content-Type: multipart/mixed; boundary="===============1208047974953367688=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] test: Add ModemTechnologies to list-modems
Date: Sun, 07 Dec 2014 22:47:49 -0600
Message-ID: <54852D75.50004@gmail.com>
In-Reply-To: <1417797991-19700-5-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1208047974953367688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 12/05/2014 10:46 AM, Alfonso Sanchez-Beato wrote:
> ---
>   test/list-modems | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/test/list-modems b/test/list-modems
> index b9f510a..cc150f6 100755
> --- a/test/list-modems
> +++ b/test/list-modems
> @@ -40,7 +40,8 @@ for path, properties in modems:
>   					"PreferredLanguages",
>   					"PrimaryContexts",
>   					"LockedPins",
> -					"Features"]:
> +					"Features",
> +					"ModemTechnologies"]:

AvailableTechnologies here please

>   				val =3D ""
>   				for i in properties[key]:
>   					val +=3D i + " "
>

Regards,
-Denis

--===============1208047974953367688==--

