Content-Type: multipart/mixed; boundary="===============5678833544928844429=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH v4 1/2] Gemalto: voicecall atom
Date: Wed, 17 Oct 2018 12:29:24 +0200
Message-ID: <eb04bece-800f-c563-782b-038c7bcfecc9@southpole.se>
In-Reply-To: <CAKSBH7EfkmnKapRox2ajEQVL3nKCiyKOgbosBfQGfwgY6bmAXw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5678833544928844429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 17/10/18 10:52, Giacinto Cifelli wrote:
>
>>>>> +
>>>>> +static struct ofono_voicecall_driver driver =3D {
>>>>> +     .name                   =3D "gemaltomodem",
>>>>> +     .probe                  =3D gemalto_voicecall_probe,
>>>>> +     .remove                 =3D gemalto_voicecall_remove,
>>>>> +     .dial                   =3D gemalto_dial,
>>>>> +     .answer                 =3D gemalto_answer,
>>>>> +     .hangup_all             =3D gemalto_hangup_all,
>>>>> +     .hangup_active          =3D gemalto_hangup,
>>>>> +     .hold_all_active        =3D gemalto_hold_all_active,
>>>>> +     .release_all_held       =3D gemalto_release_all_held,
>>>>> +     .set_udub               =3D gemalto_set_udub,
>>>>> +     .release_all_active     =3D gemalto_release_all_active,
>>>>> +     .release_specific       =3D gemalto_release_specific,
>>>>> +     .private_chat           =3D gemalto_private_chat,
>>>>> +     .create_multiparty      =3D gemalto_create_multiparty,
>>>>> +     .transfer               =3D gemalto_transfer,
>>>>> +     .deflect                =3D NULL,
>>>>> +     .swap_without_accept    =3D NULL,
>>>> Are other drivers explicit about _not_ providing implementations? I'd
>>>> drop these otherwise?
>>>>
>>> again, it is done so in the original drivers/atmodem/voicecall.c.
>> I would drop them...
> I would like to know why they weren't dropped in atmodem in the first
> place, before dropping them.
> Either solution is ok for me, I just want some clarification.

Make the declaration 'const' while you're at it.

/Jonas

--===============5678833544928844429==--

