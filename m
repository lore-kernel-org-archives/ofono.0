Content-Type: multipart/mixed; boundary="===============5086706806951204835=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] When setting the serial port,
 the previous settings need to be preserved.
Date: Tue, 20 Oct 2009 10:36:02 -0500
Message-ID: <200910201036.03028.denkenz@gmail.com>
In-Reply-To: <4ADDDC78.8030605@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5086706806951204835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

> > You're blowing away the result of cfmakeraw.  Most of the devices are n=
ot
> > true serial devices and so do not need any of the special options. =

> > Passing a NULL options GHashTable should result in cfmakeraw.  Why don't
> > you just pass all the options you need instead of using tcgetattr?
>
> Should i just move the tcgetattr() to happen before cfmakeraw()?

Only one (executed last) will have effect, and I want it to be the cfmakera=
w.  =

So simply get rid of tcgetattr.

>
> > The other parts of the patch look good to me.
>
> Ok. Why don't i just add the string options ("read", others...) in
> gattty.c?

This is what I would prefer.

Regards,
-Denis

--===============5086706806951204835==--

