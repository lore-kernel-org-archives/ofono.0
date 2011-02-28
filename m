Content-Type: multipart/mixed; boundary="===============7436486330726002612=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: Re: [PATCH] stk: Add null pointer check
Date: Mon, 28 Feb 2011 11:50:55 +0200
Message-ID: <1298886655.8937.7.camel@lkunnasl-desktop>
In-Reply-To: <4D67EDBF.4060701@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7436486330726002612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2011-02-25 at 19:58 +0200, Denis Kenzior wrote:
> Hi Andrew / Lasse,
> =

> > diff --git a/src/stk.c b/src/stk.c
> > index bc46b2f..c4e988b 100644
> > --- a/src/stk.c
> > +++ b/src/stk.c
> > @@ -2514,6 +2514,7 @@ static void stk_proactive_command_cancel(struct
> > ofono_stk *stk)
> >                 stk_command_free(stk->pending_cmd);
> >                 stk->pending_cmd =3D NULL;
> >                 stk->cancel_cmd =3D NULL;
> > +               stk->respond_on_exit =3D FALSE;
> >         }
> >  }
> > =

> =

> Patch looks good to me, however I'd like it in something I can actually
> apply.
> =

Andrew can probably provide a patch for this?

> Lasse, can you confirm this patch solves your issue?
Yes, it solves the issue. The null pointer check would be good to have
as well, but not mandatory if this is taken in

BR,
-Lasse

> =

> Regards,
> -Denis



--===============7436486330726002612==--

