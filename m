Content-Type: multipart/mixed; boundary="===============7685345807118185929=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Present list of preferred languages on SimManager
 interface.
Date: Wed, 23 Sep 2009 17:30:03 -0500
Message-ID: <200909231730.03820.denkenz@gmail.com>
In-Reply-To: <fb249edb0909231501k213b46f4lcd388351e16b0f45@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7685345807118185929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> 2009/9/23 Denis Kenzior <denkenz@gmail.com>:
> > Hi Andrew,
> >
> >> The only corner case where order is now different is when the first
> >
> > Sorry, I'm not following, can you elaborate?  If sim_efli_format
> > encounters an empty entry it simply continues on...
>
> In 5.1.1.2 of 31.102, EFpl also takes precedence before EFli if FFFF
> is in the first entry of EFli, you may interpret this case as EFpl
> comes first then EFli, or EFli is discarded altogether.

Ah yes, you're correct.  I pushed a patch to simply ignore EFli if the firs=
t =

entry is 0xffff

Regards,
-Denis

--===============7685345807118185929==--

