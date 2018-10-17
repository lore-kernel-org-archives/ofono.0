Content-Type: multipart/mixed; boundary="===============3101675720378019615=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH v4 1/2] Gemalto: voicecall atom
Date: Wed, 17 Oct 2018 10:52:40 +0200
Message-ID: <CAKSBH7EfkmnKapRox2ajEQVL3nKCiyKOgbosBfQGfwgY6bmAXw@mail.gmail.com>
In-Reply-To: <7cf3ee00-de57-a0f3-1530-c9d580706f07@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3101675720378019615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 17, 2018 at 10:33 AM Jonas Bonn <jonas@southpole.se> wrote:
>
> Hi,
>
>
> On 17/10/18 09:30, Giacinto Cifelli wrote:
>
> >>> +
> >>> +#ifdef HAVE_CONFIG_H
> >>> +#include <config.h>
> >>> +#endif
> >>> +
> >>> +#define _GNU_SOURCE
> >> What requires _GNU_SOURCE?
> > I don't know. It was part of drivers/atmodem/voicecall.c.
> > Maybe Denis knows?
>
> If you don't know that you need it, drop it.  If the code fails to build
> without it, you need it.  I can't immediately see what requires this in
> your code, but maybe there's something.  Otherwise it would be nice not
> to propagate this further when somebody cut-and-paste's your code. :)
>
> drivers/atmodem/voicecall.c doesn't need it either.  Builds fine without.

it builds without. I have dropped it.
I will push a patch for atmodem/voicecall too.

>
> >
> >>> +
> >>> +static struct ofono_voicecall_driver driver =3D {
> >>> +     .name                   =3D "gemaltomodem",
> >>> +     .probe                  =3D gemalto_voicecall_probe,
> >>> +     .remove                 =3D gemalto_voicecall_remove,
> >>> +     .dial                   =3D gemalto_dial,
> >>> +     .answer                 =3D gemalto_answer,
> >>> +     .hangup_all             =3D gemalto_hangup_all,
> >>> +     .hangup_active          =3D gemalto_hangup,
> >>> +     .hold_all_active        =3D gemalto_hold_all_active,
> >>> +     .release_all_held       =3D gemalto_release_all_held,
> >>> +     .set_udub               =3D gemalto_set_udub,
> >>> +     .release_all_active     =3D gemalto_release_all_active,
> >>> +     .release_specific       =3D gemalto_release_specific,
> >>> +     .private_chat           =3D gemalto_private_chat,
> >>> +     .create_multiparty      =3D gemalto_create_multiparty,
> >>> +     .transfer               =3D gemalto_transfer,
> >>> +     .deflect                =3D NULL,
> >>> +     .swap_without_accept    =3D NULL,
> >> Are other drivers explicit about _not_ providing implementations? I'd
> >> drop these otherwise?
> >>
> > again, it is done so in the original drivers/atmodem/voicecall.c.
>
> I would drop them...

I would like to know why they weren't dropped in atmodem in the first
place, before dropping them.
Either solution is ok for me, I just want some clarification.

>
> >
> > overall, thank you for reviewing and also for your questions, it gave
> > me the possibility to clarify some points.
> >
> > regards,
> > Giacinto
> > ---
> > full list of suspicious externs:
>
> Thanks.  Some of those "suspicious externs" are mine, too! :)

so we keep them?

>
> /Jonas
>

Giacinto

--===============3101675720378019615==--

