Content-Type: multipart/mixed; boundary="===============3806780676795718948=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] simutil: Fill unused part of AID with FFs
Date: Fri, 30 Apr 2021 09:54:53 -0500
Message-ID: <1b396bfc-bb2b-66a8-ee52-74723b7b1250@gmail.com>
In-Reply-To: <20210429160921.3153725-1-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3806780676795718948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 4/29/21 11:09 AM, Slava Monich wrote:
> Correct handling of short AIDs will take more than that, but
> leaving part of the array uninitialized is wrong in any case.
> ---
>   src/simutil.c | 1 +
>   1 file changed, 1 insertion(+)
> =

> diff --git a/src/simutil.c b/src/simutil.c
> index 5d2aa6a2..e648c918 100644
> --- a/src/simutil.c
> +++ b/src/simutil.c
> @@ -1588,6 +1588,7 @@ GSList *sim_parse_app_template_entries(const unsign=
ed char *buffer, int len)
>   			goto error;
>   =

>   		memcpy(app.aid, aid, app.aid_len);
> +		memset(app.aid + app.aid_len, 0xff, 16 - app.aid_len);

Would it not be easier to fix sim-auth to take aid_len into account instead=
 of =

hard-coding 16?  It seems like sim_auth_register is the only one affected, =
but I =

didn't look deeply.

>   =

>   		app.type =3D (app.aid[5] << 8) | app.aid[6];
>   =

> =


Regards,
-Denis
--===============3806780676795718948==--

