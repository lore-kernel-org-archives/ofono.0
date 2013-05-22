Content-Type: multipart/mixed; boundary="===============4374481369765959872=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] common: Fix parsing SS control string
Date: Wed, 22 May 2013 19:52:59 -0300
Message-ID: <CAMOw1v4y0fvUhxC+GsKJCrGwZzAwdV-ne_JEUGmPWHD+GWdY0w@mail.gmail.com>
In-Reply-To: <1369258118-6331-1-git-send-email-lucas.demarchi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4374481369765959872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2013 at 6:28 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> It's not possible to be both greater than '9' and less than '0'. This
> would lead to accepting things like "#$33#" as activation and "*$33#" as
> deactivation, even though the string makes no sense.
> ---
>  src/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/common.c b/src/common.c
> index 94d70dd..17d1d58 100644
> --- a/src/common.c
> +++ b/src/common.c
> @@ -554,7 +554,7 @@ gboolean parse_ss_control_string(char *str, int *ss_t=
ype,
>
>         cur =3D 1;
>
> -       if (str[1] !=3D '*' && str[1] !=3D '#' && str[1] > '9' && str[1] =
< '0')
> +       if (str[1] !=3D '*' && str[1] !=3D '#' && (str[1] > '9' || str[1]=
 < '0'))
>                 goto out;

this is actually caught later in the function:

for (i =3D 0; i < strlen(*sc); i++)
        if (!g_ascii_isdigit((*sc)[i]))
                goto out;

But fixing the check would be good.


Lucas De Marchi

--===============4374481369765959872==--

