Content-Type: multipart/mixed; boundary="===============4476435337820695415=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] Add GAtServer basic parsing support
Date: Thu, 14 Jan 2010 14:57:43 -0600
Message-ID: <201001141457.43301.denkenz@gmail.com>
In-Reply-To: <1263505988.5591.21.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4476435337820695415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> Hi Denis,
> =

> > > +#include "gatserver.h"
> > > +
> > > +#define DBG(fmt, arg...) g_print("%s:%s() " fmt, __FILE__,
> > > __FUNCTION__ , ## arg) +
> >
> > Move this to gat.h
> =

> can we actually not be using DBG inside gatchat. Why is that suddenly
> needed?

Actually good point. I agree this should be removed.

Regards,
-Denis

--===============4476435337820695415==--

