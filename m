Content-Type: multipart/mixed; boundary="===============3389764073604243233=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] stk: Add parser for send ussd commands
Date: Sun, 20 Jun 2010 11:26:46 -0500
Message-ID: <201006201126.47297.denkenz@gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4731ED8E752@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3389764073604243233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> >Again, please watch out for this.  If your patch touches something in two
> > or more directories of oFono, please send multiple patches.
> =

> Thank you for applying the patches. But I have a question on this: Should
>  we keep the code compile-able after each patch? Due to this consideratio=
n,
>  I put those changes all in patch 2. This would sometimes be helpful when
>  we want to investigate a regression after a bunch of patches. If this is
>  not a requirement for this project, I will pay more attention on how to
>  split the patches reasonably.

Keeping the code compilable is always preferable.  For instance, if you're =

adding a function to smsutil to use elsewhere, it is always preferable to h=
ave =

a commit with this function and then commit(s) using this function.

However, there are cases when you're moving code around and breaking compil=
e =

in transient commits is unavoidable.  In that case I still prefer clean, =

logical patches.  I will apply them all or not at all, so as long as the co=
de =

compiles & works cleanly afterward, it is fine.

Regards,
-Denis

> =

> >Regards,
> >-Denis
> =

> Regards,
> -Yang
>=20

--===============3389764073604243233==--

