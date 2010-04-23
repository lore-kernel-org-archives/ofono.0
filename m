Content-Type: multipart/mixed; boundary="===============1912528766746832302=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] Fix: transaction id usage in gisi/server.c
Date: Fri, 23 Apr 2010 16:07:11 +0300
Message-ID: <h2g80fd4e751004230607t327144f8ze035f37c184c1cdf@mail.gmail.com>
In-Reply-To: <201004221627.21946.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1912528766746832302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/4/23 Denis Kenzior <denkenz@gmail.com>:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(void *)&spn, (sizeof spn)) !=3D (sizeof req)) {
>
> Casting to or from void is not necessary.

Oh, it is. If a struct sockaddr_pn structure is casted directly to
struct sockaddr, gcc will issue alignment warning on ARM.

-- =

Pekka.Pessi mail at nokia.com

--===============1912528766746832302==--

