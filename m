Content-Type: multipart/mixed; boundary="===============3591191997670981519=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/7] Fix: isimodem handling of call barring services.
Date: Thu, 18 Mar 2010 12:50:30 -0500
Message-ID: <201003181250.30513.denkenz@gmail.com>
In-Reply-To: <80fd4e751003181038o4618052bpa92aba34c3afa2d2@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3591191997670981519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> Hi Denis,
> =

> 2010/3/18 Denis Kenzior <denkenz@gmail.com>:
> >> -     if (!cbd || !passwd || strlen(passwd) > 4 || cls !=3D 7)
> >> +     if (!cbd || !lock)
> >> +             goto error;
> >> +     if (!passwd || strlen(passwd) !=3D 4 || strspn(passwd, "01234567=
89")
> >> !=3D 4) goto error;
> >
> > I suggest not doing this checking in the driver code, if the core is
> > sending you something you don't expect, let us fix the core.
> =

> Do you suggest removing all the current checks, and leaving only the
> checks for possible features the driver does not support?

Correct.  The reason is that I want to avoid the situation of each driver =

doing its own checking.  This quickly leads to a bunch of useless code and =

most of it ends up incorrect or with only partial coverage.

If the core is sending things which are not valid, then the core has to be =

fixed.  This automatically fixes all the drivers too.

Regards,
-Denis

--===============3591191997670981519==--

