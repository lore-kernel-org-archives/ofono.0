Content-Type: multipart/mixed; boundary="===============3548391341049124709=="
MIME-Version: 1.0
From: Marcel Holtmann <holtmann@linux.intel.com>
Subject: Re: License question: Why GPLv2 only?
Date: Tue, 12 May 2009 00:29:24 -0700
Message-ID: <1242113364.2970.30.camel@localhost.localdomain>
In-Reply-To: <87bppyais3.fsf@mocca.josefsson.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3548391341049124709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Simon,

> >> Interesting project.  I read some of the source code you have publishe=
d,
> >> and some files are licensed under the GPLv2 or later:
> >> =

> >> http://git.kernel.org/?p=3Dnetwork/ofono/ofono.git;a=3Dblob;f=3Dgdbus/=
mainloop.c;hb=3DHEAD
> >> =

> >> However, many files are licensed under the GPLv2 only, with no option =
of
> >> using later license versions, for example:
> >> =

> >> http://git.kernel.org/?p=3Dnetwork/ofono/ofono.git;a=3Dblob;f=3Dgatcha=
t/gatchat.c;hb=3DHEAD
> >> http://git.kernel.org/?p=3Dnetwork/ofono/ofono.git;a=3Dblob;f=3Dsrc/db=
us-gsm.c;hb=3DHEAD
> >> =

> >> Has it been a conscious decision to use GPLv2-only for some files?
> >
> > these are on purpose this way. The files gdbus/*.[ch] contain the
> > original license and copyright from the BlueZ project, because they are
> > copied from there.
> >
> > All the rest of the oFono source code is GPLv2 only.
> =

> Ah, thanks for explaining.  Maybe these details could be recorded in
> documentation somewhere.  When/if will be packaged for a GNU/Linux
> distribution, it will become relevant.

the license is GPLv2 only since gdbus/*.[ch] is linked statically.

> >> Are you aware that using GPLv2-only makes your work license incompatib=
le
> >> with (L)GPLv3 work?  If I understand correctly, you cannot combine any
> >> of your GPLv2-only work with code licensed under the LGPLv3 or GPLv3.
> >> The GPLv2-only license is not compatible with the (L)GPLv3 license, se=
e:
> >> =

> >> http://www.gnu.org/licenses/gpl-faq.html#AllCompatibility
> >> =

> >> I would humbly request that you use GPLv2-or-later for code instead, to
> >> allow you, and everyone else, to combine your work with (L)GPLv3 code.
> >
> > That is not really up to me and there are concerns with the GPLv3
> > license that hasn't been addressed properly at this moment. I am not a
> > lawyer and I am bound by company policy in this regard.
> =

> Sure, I understand.
> =

> > Even if we would switch to GPLv3 license, then we can not be linked with
> > GPLv2 or LGPLv2 only code.
> =

> Btw, using the LGPLv2+ would allow for combining with any *GPLv*
> license.  Of course, that wouldn't work for the BlueZ code.

We picked the GPL (and not LGPL) on purpose. We want that the whole code
base and its plugins stay open source. Binary only plugins running in
the same process context are not desirable. =


Regards

Marcel



--===============3548391341049124709==--

