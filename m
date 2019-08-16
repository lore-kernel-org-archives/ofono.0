Content-Type: multipart/mixed; boundary="===============3446448298711197224=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] gprs: Check for LTE in gprs_attached_update
Date: Fri, 16 Aug 2019 10:55:36 -0500
Message-ID: <6ecf0d74-122b-14bf-c745-5a66280d1c3b@gmail.com>
In-Reply-To: <CAHB-PjkGTSJDmhCg8gGFwRGez=cCEGJYdGUNVm8jf4viv1jwrA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3446448298711197224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 8/16/19 5:44 AM, Richard R=C3=B6jfors wrote:
> Hi Denis,
> =

> Den tors 15 aug. 2019 kl 22:47 skrev Denis Kenzior <denkenz@gmail.com =

> <mailto:denkenz@gmail.com>>:
> =

>     Hi Richard,
> =

>     On 8/14/19 1:24 PM, richard.rojfors(a)gmail.com
>     <mailto:richard.rojfors@gmail.com> wrote:
>      > From: Richard R=C3=B6jfors <richard@puffinpack.se
>     <mailto:richard@puffinpack.se>>
>      >
>      > Since we have a different condition for the attach state
>      > when running on LTE, we should consider it in gprs_attached_update.
>      > Previously it's done in some instances. But for instance if
>      > the driver got detached from GPRS but now running on LTE with a
>      > context up, we would be deattached.
> =

>     So are you talking about a hand-over? Do we have logs to help visuali=
ze
>     this?
> =

> =

> Sorry I have no logs.
> I think an example would be;
> Let say we are registered on non-LTE, and GPRS do attach.
> Then we flip to LTE and if GPRS gets de-attached. We would brutally
> exit the attached state, since LTE is currently not considered in that =

> code path.

Okay, so handover.  It would be helpful to have logs to help visualize =

what is happening.

> =

> =

>      > ---
>      >=C2=A0 =C2=A0src/gprs.c | 52
>     +++++++++++++++++++++++++++++-----------------------
>      >=C2=A0 =C2=A01 file changed, 29 insertions(+), 23 deletions(-)
>      >
>      > diff --git a/src/gprs.c b/src/gprs.c
>      > index bba482cb..94d13f82 100644
>      > --- a/src/gprs.c
>      > +++ b/src/gprs.c
>      > @@ -1571,13 +1571,34 @@ static void
>     release_active_contexts(struct ofono_gprs *gprs)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>      >=C2=A0 =C2=A0}
>      >
>      > +static gboolean on_lte(struct ofono_gprs *gprs)
>      > +{
>      > +=C2=A0 =C2=A0 =C2=A0if (ofono_netreg_get_technology(gprs->netreg)=
 =3D=3D
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ACCESS_TECHNOLOGY_EUTRAN &&
>     have_read_settings(gprs))
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TRUE;
>      > +
>      > +=C2=A0 =C2=A0 =C2=A0return FALSE;
>      > +}
>      > +
>      >=C2=A0 =C2=A0static void gprs_attached_update(struct ofono_gprs *gp=
rs)
>      >=C2=A0 =C2=A0{
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_bool_t attached;
>      > +=C2=A0 =C2=A0 =C2=A0int status =3D gprs->status;
>      >
>      > -=C2=A0 =C2=A0 =C2=A0attached =3D gprs->driver_attached &&
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(gprs->status =3D=
=3D
>     NETWORK_REGISTRATION_STATUS_REGISTERED ||
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0gprs->status =3D=3D
>     NETWORK_REGISTRATION_STATUS_ROAMING);
>      > +=C2=A0 =C2=A0 =C2=A0if (on_lte(gprs))
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * For LTE we att=
ached status reflects successful
>     context
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * activation.
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Since we in gp=
rs_netreg_update not even try to
>     attach
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * to GPRS if we =
are running on LTE, we can on some
>     modems
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * expect the gpr=
s status to be unknown. That must not
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * result in deta=
ching...
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attached =3D have=
_active_contexts(gprs);
> =

>     On LTE Attached should just be always True.=C2=A0 Someone can correct=
 me if
>     I'm wrong, but a default context is a pre-requisite for E-UTRAN
>     attachment.
> =

> =

> I guess this is about race conditions, since we read back settings of =

> the context,
> so in theory I think we might not consider the context available yet. =

> Should be
> a very short period of time.
> In netreg status we do not immediately change to attached in case of
> LTE, we require the context settings to have been read first.

I think it makes sense to signal Attached right away in the case that we =

know we are on LTE.  But I can accept your argument of not signaling =

Attached until the first context is active.  That is likely more driven =

by ConMan not being updated for LTE, which likely won't work in the end.

Regards,
-Denis

--===============3446448298711197224==--

