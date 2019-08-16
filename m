Content-Type: multipart/mixed; boundary="===============1130005719559900040=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] gprs: Always call gprs_attached_update on context
 deactivation.
Date: Fri, 16 Aug 2019 10:42:30 -0500
Message-ID: <cb676015-45dc-be57-397d-7deb1503b087@gmail.com>
In-Reply-To: <CAHB-PjkmAqc3OATbEaAXhM_DCS7TvvMe7hAj0ATGrLAzXEtAHw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1130005719559900040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

>      > attached, and connection managers (at least connman) start
>      > to hammer us to connect a context, eventhough it happens
>      > automatically in LTE.
> =

>     What happens automatically?=C2=A0 Yes, it is true that you need a def=
ault
>     context to attach to LTE.=C2=A0 So activating a context is basically =
a part
>     of the LTE attach procedure.
> =

>     But that default context does not need to be an internet context (e.g.
>     Verizon uses (or used to) use an ims context for this). So ConnMan
>     still
>     might need to activate an Internet context even if we're on LTE.
> =

> =

> To do that wouldn't we need to be able to flag attached even without
> registered context for LTE?
> Or will the modem not attach to 4G until the context is configured?
> I can not test that case with my modems.

It sort of depends on the configuration.  But basically we will not get =

on LTE without a default bearer.  The default bearer configuration can =

come from the modem itself, or actually from the network.  That default =

bearer is essentially an active context.  This is why gprs.c goes to the =

trouble of matching it against existing contexts, but if it isn't found, =

then adds a new one (which is supposed to be transient/temporary).

Typically, on a well-configured system, you'll have the default bearer =

setup via LongTermEvolution.DefaultAccessPointName and also provisioned =

in the provisioning database.  But as I mentioned earlier, the default =

context doesn't have to be an internet one.

Regards,
-Denis

> =

> =

>     I'm also not sure that the heuristic of 0 active contexts means not
>     attached is a good one.=C2=A0 Shouldn't you be using +CREG or +CEREG =
status
>     for this?
> =

> =

> As you say that is probably more correct :)
> First I wanted to get things running with the current solution which =

> uses an active
> context as condition.
> =

> =

>      > ---
>      >=C2=A0 =C2=A0src/gprs.c | 9 +++++----
>      >=C2=A0 =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
>      >
>      > diff --git a/src/gprs.c b/src/gprs.c
>      > index 94d13f82..cb31e2d2 100644
>      > --- a/src/gprs.c
>      > +++ b/src/gprs.c
>      > @@ -2738,11 +2738,12 @@ void
>     ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If "Attached" property was about to b=
e signalled as TRUE
>     but there
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 * were still active contexts, try again=
 to signal
>     "Attached" property
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 * to registered applications after acti=
ve contexts have
>     been released.
>      > +=C2=A0 =C2=A0 =C2=A0 *
>      > +=C2=A0 =C2=A0 =C2=A0 * ... or in the case of LTE where the attach=
ed state were
>     a registered
>      > +=C2=A0 =C2=A0 =C2=A0 * context is a condition for being attached
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>      > -=C2=A0 =C2=A0 =C2=A0if (gc->gprs->flags & GPRS_FLAG_ATTACHED_UPDA=
TE) {
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gc->gprs->flags &=
=3D ~GPRS_FLAG_ATTACHED_UPDATE;
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gprs_attached_upd=
ate(gc->gprs);
>      > -=C2=A0 =C2=A0 =C2=A0}
>      > +=C2=A0 =C2=A0 =C2=A0gc->gprs->flags &=3D ~GPRS_FLAG_ATTACHED_UPDA=
TE;
>      > +=C2=A0 =C2=A0 =C2=A0gprs_attached_update(gc->gprs);
>      >=C2=A0 =C2=A0}
>      >
>      >=C2=A0 =C2=A0int ofono_gprs_context_driver_register(
>      >
> =

>     Regards,
>     -Denis
> =



--===============1130005719559900040==--

