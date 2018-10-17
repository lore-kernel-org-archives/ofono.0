Content-Type: multipart/mixed; boundary="===============0674241640662890068=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH v4 1/2] Gemalto: voicecall atom
Date: Wed, 17 Oct 2018 10:33:08 +0200
Message-ID: <7cf3ee00-de57-a0f3-1530-c9d580706f07@southpole.se>
In-Reply-To: <CAKSBH7HTtr_bh4AcnsOCXUecLRAOvG4YHkwRaqzmp_QArEm_Mg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0674241640662890068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,


On 17/10/18 09:30, Giacinto Cifelli wrote:

>>> +
>>> +#ifdef HAVE_CONFIG_H
>>> +#include <config.h>
>>> +#endif
>>> +
>>> +#define _GNU_SOURCE
>> What requires _GNU_SOURCE?
> I don't know. It was part of drivers/atmodem/voicecall.c.
> Maybe Denis knows?

If you don't know that you need it, drop it.=C2=A0 If the code fails to bui=
ld =

without it, you need it.=C2=A0 I can't immediately see what requires this i=
n =

your code, but maybe there's something.=C2=A0 Otherwise it would be nice no=
t =

to propagate this further when somebody cut-and-paste's your code. :)

drivers/atmodem/voicecall.c doesn't need it either.=C2=A0 Builds fine witho=
ut.

>
>>> +
>>> +static struct ofono_voicecall_driver driver =3D {
>>> +     .name                   =3D "gemaltomodem",
>>> +     .probe                  =3D gemalto_voicecall_probe,
>>> +     .remove                 =3D gemalto_voicecall_remove,
>>> +     .dial                   =3D gemalto_dial,
>>> +     .answer                 =3D gemalto_answer,
>>> +     .hangup_all             =3D gemalto_hangup_all,
>>> +     .hangup_active          =3D gemalto_hangup,
>>> +     .hold_all_active        =3D gemalto_hold_all_active,
>>> +     .release_all_held       =3D gemalto_release_all_held,
>>> +     .set_udub               =3D gemalto_set_udub,
>>> +     .release_all_active     =3D gemalto_release_all_active,
>>> +     .release_specific       =3D gemalto_release_specific,
>>> +     .private_chat           =3D gemalto_private_chat,
>>> +     .create_multiparty      =3D gemalto_create_multiparty,
>>> +     .transfer               =3D gemalto_transfer,
>>> +     .deflect                =3D NULL,
>>> +     .swap_without_accept    =3D NULL,
>> Are other drivers explicit about _not_ providing implementations? I'd
>> drop these otherwise?
>>
> again, it is done so in the original drivers/atmodem/voicecall.c.

I would drop them...

>
> overall, thank you for reviewing and also for your questions, it gave
> me the possibility to clarify some points.
>
> regards,
> Giacinto
> ---
> full list of suspicious externs:

Thanks.=C2=A0 Some of those "suspicious externs" are mine, too! :)

/Jonas


--===============0674241640662890068==--

