Content-Type: multipart/mixed; boundary="===============1098497595632226831=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: AT channel problem
Date: Thu, 05 May 2016 10:10:48 -0500
Message-ID: <572B6278.7050806@gmail.com>
In-Reply-To: <CAH4ZQwv2U6yYnNmE8+DseJyPf2KFuj1AXBA1NCqoptk5GN_iNA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1098497595632226831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

 > Anyway, I managed to solve the problem with a simple yet potentially
> dangerous fix: I deleted the if statement in the
> GSM_PERMISSIVE_STATE_RESPONSE_STRING case, so, it changed from:
>
> =E2=80=8Bgatchat/gatsyntax.c (row 309 more or less)=E2=80=8B
> case GSM_PERMISSIVE_STATE_RESPONSE_STRING:
>      if (byte =3D=3D '"')
> syntax->state =3D GSM_PERMISSIVE_STATE_RESPONSE;
> break;=E2=80=8B
>
> =E2=80=8BTo:
>
> =E2=80=8Bcase GSM_PERMISSIVE_STATE_RESPONSE_STRING:
> syntax->state =3D GSM_PERMISSIVE_STATE_RESPONSE;
> break;=E2=80=8B
>
> =E2=80=8BWith this fix everything seem to work in my case.
> Do you think it is dangerous in any way?=E2=80=8B

Yes.  This particular logic enables strings (e.g. text enclosed in =

quotes) to contain various special characters that would otherwise be =

interpreted differently.

It looks like you have an unterminated " in one of the AT command =

responses...

Regards,
-Denis

--===============1098497595632226831==--

