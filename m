Content-Type: multipart/mixed; boundary="===============1325197116381268172=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 7/7] Fix: isimodem handling of call barring services.
Date: Thu, 18 Mar 2010 19:38:56 +0200
Message-ID: <80fd4e751003181038o4618052bpa92aba34c3afa2d2@mail.gmail.com>
In-Reply-To: <201003181151.29899.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1325197116381268172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/3/18 Denis Kenzior <denkenz@gmail.com>:
>> - =C2=A0 =C2=A0 if (!cbd || !passwd || strlen(passwd) > 4 || cls !=3D 7)
>> + =C2=A0 =C2=A0 if (!cbd || !lock)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
>> + =C2=A0 =C2=A0 if (!passwd || strlen(passwd) !=3D 4 || strspn(passwd, "=
0123456789") !=3D 4)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
>
> I suggest not doing this checking in the driver code, if the core is send=
ing
> you something you don't expect, let us fix the core.

Do you suggest removing all the current checks, and leaving only the
checks for possible features the driver does not support?

--Pekka

-- =

Pekka.Pessi mail at nokia.com

--===============1325197116381268172==--

