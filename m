Content-Type: multipart/mixed; boundary="===============3901427401392076563=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] netreg, gprs: Use -1 as netreg status during init.
Date: Fri, 02 Aug 2019 08:39:46 -0500
Message-ID: <9e4aac2d-c4d8-b1cc-da93-69d798aaa7b0@gmail.com>
In-Reply-To: <CAHB-Pjkop6uD2zqQe5ychdacApJiKFHATTSPbmYWswsjA+1VVw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3901427401392076563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

>      > +=C2=A0 =C2=A0 =C2=A0gprs->netreg_status =3D -1;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0gprs->used_pids =3D l_uintset_new(MAX_CO=
NTEXTS);
>      >
> =

>     Wouldn't changes to gprs.c be sufficient, without touching netreg.c?
> =

> =

> No unfortunately not. gprs reads the netreg status when it attaches to =

> the atom. Which would be unknown if we do not touch netreg.c.
> .. and unknown is a valid status which can not be distinguished from =

> "not yet updated".

Hmm, okay. But then, can't you set gprs->netreg_status to -1 inside =

netreg_watch and just wait until netreg_status_changed to get it set =

properly?

That seems to be your real culprit, the gprs->netreg_status assignment =

from ofono_netreg_get_status()

> =

> =

>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0return gprs;
>      > diff --git a/src/network.c b/src/network.c
>      > index 2824eae6..1db01bcf 100644
>      > --- a/src/network.c
>      > +++ b/src/network.c
>      > @@ -1874,7 +1874,7 @@ struct ofono_netreg
>     *ofono_netreg_create(struct ofono_modem *modem,
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0if (netreg =3D=3D NULL)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
>      >
>      > -=C2=A0 =C2=A0 =C2=A0netreg->status =3D NETWORK_REGISTRATION_STATU=
S_UNKNOWN;
>      > +=C2=A0 =C2=A0 =C2=A0netreg->status =3D -1;
> =

>     Okay, but a minor problem with this is that there now exists a brief
>     moment in type where the Status property has a weird value...
> =

> =

> I looked at this, and most statuses, even some defined results as =

> unknown. Any unhandled values as negative would do that too.
> If you are refering to the D-Bus property?

Yes.  Most of the time -1 simply means the property is omitted.  In this =

case that is not actually what happens.  Refer to src/common.c =

registration_status_to_string()

Regards,
-Denis

--===============3901427401392076563==--

