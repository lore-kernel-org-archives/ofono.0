Content-Type: multipart/mixed; boundary="===============4014304984947884075=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/4] Add GAtServer basic parsing support
Date: Thu, 14 Jan 2010 13:53:08 -0800
Message-ID: <1263505988.5591.21.camel@localhost.localdomain>
In-Reply-To: <201001141124.30514.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4014304984947884075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > +#include "gatserver.h"
> > +
> > +#define DBG(fmt, arg...) g_print("%s:%s() " fmt, __FILE__, __FUNCTION_=
_ ,
> >  ## arg) +
> =

> Move this to gat.h

can we actually not be using DBG inside gatchat. Why is that suddenly
needed?

Regards

Marcel



--===============4014304984947884075==--

