Content-Type: multipart/mixed; boundary="===============0265624728859680114=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: Do not detach when running LTE and GPRS is
 unavailable.
Date: Mon, 12 Aug 2019 14:57:10 -0500
Message-ID: <2780a75b-5342-bb17-677d-a03c3d613217@gmail.com>
In-Reply-To: <CAHB-Pjmp4Jxz5ezRscKS8_wErmrPhAL8o6X0H6Gv4ru4djjDpw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0265624728859680114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

>     So I don't get this.=C2=A0 We have CREG telling us: "we're on LTE" an=
d CGREG
>     telling us "Oh we don't know what our status is".=C2=A0 Why do you tr=
ust one
>     and not the other?=C2=A0 Are you sure this doesn't belong in a driver=
 quirk
>     somewhere?
> =

> =

> When CREG tells us we are on LTE, we will probably not even try attach =

> to gprs (CGATT),
> refer to=C2=A0gprs_netreg_update.
> In my understanding that means that its natural that CGREG reports =

> unknown or similar.
> CEREG would be the interesting one... but since the code is built around
> using activated context as condition when running on LTE I think we should
> use the same condition here.

Ah, so you're on one of those modems that started using CEREG instead of =

CGREG for reporting LTE.  So in that case I'm fine with this (maybe add =

a more clarifying comment).  But I suspect that we also need to consider =

adding ofono_gprs_lte_status as well and taking both into account.

Regards,
-Denis

--===============0265624728859680114==--

