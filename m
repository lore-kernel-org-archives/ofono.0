Content-Type: multipart/mixed; boundary="===============5406071769432598689=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] GPRS context setup and teardown
 (doc/dataconnectionmanager-api.txt)
Date: Sat, 24 Oct 2009 12:37:32 -0500
Message-ID: <200910241237.32751.denkenz@gmail.com>
In-Reply-To: <fb249edb0910240118h21bb3464ya8b655ae4db9aba0@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5406071769432598689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> 2009/10/24 andrzej zaborowski <balrogg@gmail.com>:
> > 2009/10/24 Denis Kenzior <denkenz@gmail.com>:
> >> Ok, so I took the patch and hacked on it for a while.  I disagreed with
> >> how you split up responsibilities, so much of the logic got moved into
> >> the core and the driver was simplified.
>
> By the way I notice that in most atoms' _create functions, when we
> loop over the drivers
> and call drv->probe() until we succeed, we still return success even if
> none of the drivers succeeded, should we return a NULL?

I think my intention was to eventually have foo_driver_register functions a=
lso =

go through the probe process.  Without the driver the atoms are never =

registered, so the way it is now is OK for now.

Regards,
-Denis

--===============5406071769432598689==--

