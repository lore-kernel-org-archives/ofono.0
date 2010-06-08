Content-Type: multipart/mixed; boundary="===============1989582275140736131=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [RFC patches 06/13] smutil.h: add missing header file dependencies
Date: Tue, 08 Jun 2010 22:30:59 +0000
Message-ID: <1276036526.2478.55.camel@localhost.localdomain>
In-Reply-To: <201005280931.42298.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1989582275140736131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-05-28 at 07:31 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> > +#include <glib/gtypes.h>
> > +#include <glib/gslist.h>
> > +#include <glib/gmessages.h>
> > +#include <glib/gchecksum.h>
> =

> Isn't it sufficient to just add glib/glib.h here?

You can definitely do that, but it also increases the compilation
time...not that you or I would notice anyway.



--===============1989582275140736131==--

