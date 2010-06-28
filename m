Content-Type: multipart/mixed; boundary="===============0034115140372702103=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [SMS D-Bus 02/23] util.h: Add BUILD_BUG_ON() and friends for
 compile-time assert checking
Date: Mon, 28 Jun 2010 09:58:50 -0700
Message-ID: <1277744330.3006.3.camel@localhost.localdomain>
In-Reply-To: <201006281201.43560.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0034115140372702103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-06-28 at 10:01 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> > From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> > =

> > These have been stolen from the Linux kernel source; come pretty handy
> > to make build-time consistency checks and thus avoid run-time
> > surprises.
> > ---
> >  src/util.h |   28 ++++++++++++++++++++++++++++
> >  1 files changed, 28 insertions(+), 0 deletions(-)
> > =

> =

> This stuff really doesn't belong in util.h.  That file is ancient and if =
I were =

> to do it again, I'd rename it into textutil.h or gsmutil.h.  I only reall=
y =

> want to keep text conversions there.
> =

> I suggest putting this stuff into include/bug.h per Marcel's earlier emai=
l.

Okey dokey, will do so.


--===============0034115140372702103==--

