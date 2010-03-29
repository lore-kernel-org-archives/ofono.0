Content-Type: multipart/mixed; boundary="===============4138586694143218851=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] Fix: simplify isimodem call-barring driver.
Date: Mon, 29 Mar 2010 21:20:59 +0300
Message-ID: <80fd4e751003291120l54a7cbc8h33e9c53fae223a3f@mail.gmail.com>
In-Reply-To: <201003231653.14125.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4138586694143218851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/3/23 Denis Kenzior <denkenz@gmail.com>:
>> Add support for lock codes AG and AC (MMI codes 333 and 353. respectivel=
y).
>
> First of all, please keep your commit messages less than 72 characters lo=
ng
> and headings less than 50 characters long.

Is there any git setting or nice filter which could complain
automatically if the limits are reached?

>> + =C2=A0 =C2=A0 SS_GSM_ALL_FORWARDINGS =3D 002,
>> + =C2=A0 =C2=A0 SS_GSM_ALL_COND_FORWARDINGS =3D 004,
>
> Are you sure this isn't octal syntax? =C2=A0It still works, but you might=
 simply
> use 2 and 4 =C2=A0here.

Those values equal to MMI codes (002 and 004); I just think it is a
good idea to show it.

> From now on we'll require all enum values to be tab aligned so they're a =
bit
> easier to read. =C2=A0See src/stkutil.h for reference.

I've reformatted <ss.h>.

-- =

Pekka.Pessi mail at nokia.com

--===============4138586694143218851==--

