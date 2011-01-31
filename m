Content-Type: multipart/mixed; boundary="===============5305685408342289048=="
MIME-Version: 1.0
From: Jessica Nilsson <nilsson.r.j@gmail.com>
Subject: Re: [PATCH 1/1] gisi: Updated subscriptions and pipe handling to
 accomodate additional isimodem versions
Date: Mon, 31 Jan 2011 13:05:51 +0100
Message-ID: <AANLkTinb2+-z_etsSfv7zqN0L=cMu=uQ266wmnqep0oP@mail.gmail.com>
In-Reply-To: <201101281633.44721.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5305685408342289048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

2011/1/28 R=C3=A9mi Denis-Courmont <remi.denis-courmont@nokia.com>
>
> It looks like you are mixing up services (PN_* from 0 to 255), with device
> addresses (PN_DEV_* multiple of four from 0 to 252).

Yes, you are right. We will change it.



>
> > @@ -61,6 +61,7 @@ struct _GIsiModem {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned index;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 GHashTable *services;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 gboolean subs_source;
> > + =C2=A0 =C2=A0 =C2=A0 GIsiVersion version;
>
> I can't see where this gets set?!

In g_isi_modem_set_version() in plugins/u8500.c
New file, that will hopefully be sent in a patch to the mailing list today.



>
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (g_isi_modem_version_major(modem) =3D=3D 2 &&
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_isi_modem_version_=
minor(modem) =3D=3D 5) {
>
> You really need to factor this check out. It's going to be a disaster when
> there are more than two versions otherwise.

Well, we really need the PNS_SUBSCRIBED_RESOURCES_EXTEND_IND because
the other one doesn't work for us.

Would a lookup function do the trick, with filling in the necessary
values in msg depending on which version it is?
If that is not satisfactory, could you please be a bit more specific
in what you would like to see so we don't misunderstand?
>
> >
> > @@ -363,13 +382,31 @@ static gboolean modem_subs_update(gpointer data)
>
>
> That should probably be a separate patch.

Yes, you are right.
>
> > diff --git a/gisi/pipe.c b/gisi/pipe.c
>
>
> We already have this in kernel and I wonder why this needs to be duplicat=
ed in
> userspace now?! Furthermore pipe.c is about pipes. Pipe endpoints code be=
longs
> in pep.c. If you want to implement a pipe controller in gisi, then I thin=
k it
> really deserves a new file of its own.
>

isimodem2.5 needs this code, the kernel struct won't be applicable for
us in the modem case.

We will move the pep functions to the pep.c

Best Regards,
Jessica Nilsson
ST-Ericsson

--===============5305685408342289048==--

