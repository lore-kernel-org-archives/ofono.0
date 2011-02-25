Content-Type: multipart/mixed; boundary="===============7184475520016131151=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stk: Add null pointer check
Date: Fri, 25 Feb 2011 11:58:23 -0600
Message-ID: <4D67EDBF.4060701@gmail.com>
In-Reply-To: <AANLkTik8FOtSTWfyATp_eXV-7Prp9+Ao3BA1NBNoJMnm@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7184475520016131151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew / Lasse,

> diff --git a/src/stk.c b/src/stk.c
> index bc46b2f..c4e988b 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -2514,6 +2514,7 @@ static void stk_proactive_command_cancel(struct
> ofono_stk *stk)
>                 stk_command_free(stk->pending_cmd);
>                 stk->pending_cmd =3D NULL;
>                 stk->cancel_cmd =3D NULL;
> +               stk->respond_on_exit =3D FALSE;
>         }
>  }
> =


Patch looks good to me, however I'd like it in something I can actually
apply.

Lasse, can you confirm this patch solves your issue?

Regards,
-Denis

--===============7184475520016131151==--

