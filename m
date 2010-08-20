Content-Type: multipart/mixed; boundary="===============6359865651085951042=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: About Connection between PPP and linux Sockets
Date: Fri, 20 Aug 2010 13:33:35 +0200
Message-ID: <1282304015.23399.210.camel@localhost.localdomain>
In-Reply-To: <4C6E428F.8040507@neusoft.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6359865651085951042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Steven,

> >>>>>>>> I have a little question just as the title said?
> >>>>>>>> In Ofono how to connect PPP to Linux socket, when we receive
> >>>>>>>> packet from network, how the packet go through the kernel to
> >>>>>>>> application=EF=BC=9F =

> >>>>>>>>
> >>>>>>>> modem -->PPP-->? --> linux kernel(network part)--> socket -->
> >>>>>>>> application?
> >>>>>>> it is more like this:
> >>>>>>>
> >>>>>>> modem -> TTY -> PPP -> TUN/TAP -> Kernel Net-Stack -> socket ->
> >>>>>>> application. =

> >>>>>>>
> >>>>>>> With the TTY being in kernel, the PPP being in userspace, and
> >>>>>>> TUN/TAP etc. begin in the kernel again.
> >>>>>>>
> >>>>>>> A future enhancement is to use the kernel PPP layer, but we
> >>>>>>> haven't gotten there yet.
> >>>>>> I am interested to know how could we use kernel PPP layer instead
> >>>>>> of gatppp. Shall we add this item into our TODO?
> >>>>>>
> >>>>> Maybe you can reference to RILD in Android, it used kernel PPP.
> >>>> Thanks. Will take a look then.
> >>> This information is a good start point.
> >>> http://www.devdiv.net/viewthread-26543
> >>>
> >>> But only for Chinese people:(
> >> Thanks. I have read this before. ;-). The original article is from max=
leng's blog:
> >>
> >> http://blog.csdn.net/maxleng/archive/2010/05/10/5576509.aspx
> >>
> >> However, it's just a big picture about phone stack in Android. It said=
 nothing about how Android works with kernel PPP layer.
> > =

> > could be that Andoid uses the kernel PPP and also uses pppd for it. We
> > are not using pppd on purpose since it is the wrong piece for an
> > embedded phone solution. We are not using the kernel PPP part, because
> > we haven't gotten around that yet. It also only works when having real
> > TTY devices.
> I don't think using pppd is a wrong piece for embedded phone, if we =

> using pppd, we can ease the ppp part of ofono and also support full ppp =

> functionalities, such as auth method(plain text, pap, chap, eap and so on)

for a mobile telephony stack, pppd is wrong. Once you understand how 3G
missuses PPP for IP and PDP context setup, you see what I mean ;)

>   If your multiplexer runs in userspace then you also have
> > the problem that you don't have a real TTY. And using a PTS, then you
> > can just run PPP also in userspace.
> =

> A little question, if we runs multiplexer in kernel space, can we using =

> kernel ppp part?

Yes, we could. We have a kernel multiplexer, but not tested or
integrated it with oFono or real hardware.

Regards

Marcel



--===============6359865651085951042==--

