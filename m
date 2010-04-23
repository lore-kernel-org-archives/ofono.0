Content-Type: multipart/mixed; boundary="===============1486152737031616418=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] Fix: transaction id usage in gisi/server.c
Date: Fri, 23 Apr 2010 17:57:13 +0300
Message-ID: <z2y80fd4e751004230757ic2998de7nef3c79753dc3ab2@mail.gmail.com>
In-Reply-To: <0f719e09b0048c8e277f38b1937eeb11@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1486152737031616418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/4/23 R=C3=A9mi Denis-Courmont <remi@remlab.net>:
> On Fri, 23 Apr 2010 16:07:11 +0300, Pekka Pessi <ppessi@gmail.com> wrot=
e:
>> 2010/4/23 Denis Kenzior <denkenz@gmail.com>:
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(void *)&spn, (sizeof spn)) !=3D
>> (sizeof req)) {
>>>
>>> Casting to or from void is not necessary.
>>
>> Oh, it is. If a struct sockaddr_pn structure is casted directly to
>> struct sockaddr, gcc will issue alignment warning on ARM.
>
> The cast-align warning is a can of false positives. First that warning
> should probably not be enabled. It does nothing on x86, and it's a waste =
of
> time with ARM and other pointer-picky platforms.

BTW, why we have __attribute__ ((packed)) in sockaddr_pn definition?
Looks like it is the cause of the problems here.

-- =

Pekka.Pessi mail at nokia.com

--===============1486152737031616418==--

