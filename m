Content-Type: multipart/mixed; boundary="===============7247802422944255058=="
MIME-Version: 1.0
From: Marcel Holtmann <holtmann@linux.intel.com>
Subject: Re: License question: Why GPLv2 only?
Date: Mon, 11 May 2009 23:58:05 -0700
Message-ID: <1242111485.2970.27.camel@localhost.localdomain>
In-Reply-To: <87fxfaak7w.fsf@mocca.josefsson.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7247802422944255058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Simon,

> Interesting project.  I read some of the source code you have published,
> and some files are licensed under the GPLv2 or later:
> =

> http://git.kernel.org/?p=3Dnetwork/ofono/ofono.git;a=3Dblob;f=3Dgdbus/mai=
nloop.c;hb=3DHEAD
> =

> However, many files are licensed under the GPLv2 only, with no option of
> using later license versions, for example:
> =

> http://git.kernel.org/?p=3Dnetwork/ofono/ofono.git;a=3Dblob;f=3Dgatchat/g=
atchat.c;hb=3DHEAD
> http://git.kernel.org/?p=3Dnetwork/ofono/ofono.git;a=3Dblob;f=3Dsrc/dbus-=
gsm.c;hb=3DHEAD
> =

> Has it been a conscious decision to use GPLv2-only for some files?

these are on purpose this way. The files gdbus/*.[ch] contain the
original license and copyright from the BlueZ project, because they are
copied from there.

All the rest of the oFono source code is GPLv2 only.

> Are you aware that using GPLv2-only makes your work license incompatible
> with (L)GPLv3 work?  If I understand correctly, you cannot combine any
> of your GPLv2-only work with code licensed under the LGPLv3 or GPLv3.
> The GPLv2-only license is not compatible with the (L)GPLv3 license, see:
> =

> http://www.gnu.org/licenses/gpl-faq.html#AllCompatibility
> =

> I would humbly request that you use GPLv2-or-later for code instead, to
> allow you, and everyone else, to combine your work with (L)GPLv3 code.

That is not really up to me and there are concerns with the GPLv3
license that hasn't been addressed properly at this moment. I am not a
lawyer and I am bound by company policy in this regard.

Even if we would switch to GPLv3 license, then we can not be linked with
GPLv2 or LGPLv2 only code.

Regards

Marcel



--===============7247802422944255058==--

