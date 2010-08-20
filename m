Content-Type: multipart/mixed; boundary="===============5704043876503861450=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: About Connection between PPP and linux Sockets
Date: Fri, 20 Aug 2010 10:29:42 +0200
Message-ID: <1282292982.23399.195.camel@localhost.localdomain>
In-Reply-To: <33AB447FBD802F4E932063B962385B352A3540B8@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5704043876503861450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> >>>>>> I have a little question just as the title said?
> >>>>>> In Ofono how to connect PPP to Linux socket, when we receive
> >>>>>> packet from network, how the packet go through the kernel to
> >>>>>> application=EF=BC=9F =

> >>>>>> =

> >>>>>> modem -->PPP-->? --> linux kernel(network part)--> socket -->
> >>>>>> application?
> >>>>> it is more like this:
> >>>>> =

> >>>>> modem -> TTY -> PPP -> TUN/TAP -> Kernel Net-Stack -> socket ->
> >>>>> application. =

> >>>>> =

> >>>>> With the TTY being in kernel, the PPP being in userspace, and
> >>>>> TUN/TAP etc. begin in the kernel again.
> >>>>> =

> >>>>> A future enhancement is to use the kernel PPP layer, but we
> >>>>> haven't gotten there yet.
> >>>> I am interested to know how could we use kernel PPP layer instead
> >>>> of gatppp. Shall we add this item into our TODO?
> >>>> =

> >>> Maybe you can reference to RILD in Android, it used kernel PPP.
> >> =

> >> Thanks. Will take a look then.
> > =

> > This information is a good start point.
> > http://www.devdiv.net/viewthread-26543
> > =

> > But only for Chinese people:(
> =

> Thanks. I have read this before. ;-). The original article is from maxlen=
g's blog:
> =

> http://blog.csdn.net/maxleng/archive/2010/05/10/5576509.aspx
> =

> However, it's just a big picture about phone stack in Android. It said no=
thing about how Android works with kernel PPP layer.

could be that Andoid uses the kernel PPP and also uses pppd for it. We
are not using pppd on purpose since it is the wrong piece for an
embedded phone solution. We are not using the kernel PPP part, because
we haven't gotten around that yet. It also only works when having real
TTY devices. If your multiplexer runs in userspace then you also have
the problem that you don't have a real TTY. And using a PTS, then you
can just run PPP also in userspace.

Regards

Marcel



--===============5704043876503861450==--

