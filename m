Content-Type: multipart/mixed; boundary="===============0898764163375357509=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: About Connection between PPP and linux Sockets
Date: Fri, 20 Aug 2010 03:18:07 +0200
Message-ID: <1282267087.23399.187.camel@localhost.localdomain>
In-Reply-To: <33AB447FBD802F4E932063B962385B352A353FAC@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0898764163375357509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> >> I have a little question just as the title said?
> >> In Ofono how to connect PPP to Linux socket, when we receive packet
> >> from network, how the packet go through the kernel to application=EF=
=BC=9F
> >> =

> >> modem -->PPP-->? --> linux kernel(network part)--> socket -->
> >> application? =

> > =

> > it is more like this:
> > =

> > modem -> TTY -> PPP -> TUN/TAP -> Kernel Net-Stack -> socket ->
> > application. =

> > =

> > With the TTY being in kernel, the PPP being in userspace, and TUN/TAP
> > etc. begin in the kernel again.
> > =

> > A future enhancement is to use the kernel PPP layer, but we haven't
> > gotten there yet.
> =

> I am interested to know how could we use kernel PPP layer instead of gatp=
pp. Shall we add this item into our TODO?

the kernel PPP line discipline can be used and then LCP and IPCP will be
spoken via a side channel to the kernel. And all the packet handling is
done by the kernel itself via the TTY line discipline. It is a bit more
work than just using a TUN/TAP device. And of course it only works in
real TTYs. Not on the GIOChannel that you get from GAtMux.

Regards

Marcel



--===============0898764163375357509==--

