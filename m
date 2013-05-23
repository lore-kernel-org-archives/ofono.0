Content-Type: multipart/mixed; boundary="===============1103309708020678425=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] common: Fix parsing SS control string
Date: Wed, 22 May 2013 21:42:13 -0500
Message-ID: <519D8205.80000@gmail.com>
In-Reply-To: <1369258118-6331-1-git-send-email-lucas.demarchi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1103309708020678425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 05/22/2013 04:28 PM, Lucas De Marchi wrote:
> It's not possible to be both greater than '9' and less than '0'. This
> would lead to accepting things like "#$33#" as activation and "*$33#" as
> deactivation, even though the string makes no sense.
> ---
>   src/common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/common.c b/src/common.c
> index 94d70dd..17d1d58 100644
> --- a/src/common.c
> +++ b/src/common.c
> @@ -554,7 +554,7 @@ gboolean parse_ss_control_string(char *str, int *ss_t=
ype,
>
>   	cur =3D 1;
>
> -	if (str[1] !=3D '*' && str[1] !=3D '#' && str[1] > '9' && str[1] < '0')
> +	if (str[1] !=3D '*' && str[1] !=3D '#' && (str[1] > '9' || str[1] < '0'=
))

Funny how it is hiding in plain sight and nobody has found it in over 4 =

years.  And I think you just got an award for finding the oldest bug :P

Patch has been applied, thanks.

>   		goto out;
>
>   	if (str[0] =3D=3D '#' && str[1] =3D=3D '*')
>

Regards,
-Denis

--===============1103309708020678425==--

