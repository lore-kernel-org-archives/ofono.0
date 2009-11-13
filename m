Content-Type: multipart/mixed; boundary="===============2972454282499029996=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: ppp
Date: Fri, 13 Nov 2009 13:02:39 +0100
Message-ID: <1258113759.3299.16.camel@violet>
In-Reply-To: <alpine.LNX.2.00.0911121929570.21838@boatman.intrepnet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2972454282499029996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Chris,

> > Unfortunately it is not that simple.  pppd requires a proper kernel file
> > descriptor to hand off to the kernel ppp line discipline.  In our users=
pace
> > implementation that is not the case.  1 kernel file descriptor is share=
d by
> > potentially many GAtChat channels using a multiplexing protocol.  Hence=
 why we
> > can't reuse the kernel implementation.
> >
> =

> Not sure how relevant this is, but many many years ago (1997) I used a =

> "telnet modem" to circumvent a firewall. It was a user land process that =

> presented a fake /dev/modem which I used using pppd and chat..
> =

> My machine was behind a firewall with a telnet proxy.. Using the software =

> + pppd + chat, it was set up along the lines:
> =

> start telnet modem which presented a /dev/modem.. start pppd using =

> /dev/modem:
> =

> ATDT 1.2.3.4
> CONNECT 1.2.3.4
> the-telnet-proxy>
> telnet my.host 23
> connected to my.host:23
> login:
> mypppuser
> password:
> mypassword
> end of chat script... start pppd
> =

> In this situation, pppd and the kernel device would have been =

> communicating with a local userland process. The TCP connection to 1.2.3.=
4 =

> created by the telnet modem could not have been used by the ppp interface =

> as the telnet modem was passing the streams in either direction =

> essentially joining the fd of the telnet connection and fd used by pppd..
> =

> I'm not sure if the requirements of ppp in the kernel have chagned, but =

> couldn't something like this be repeated in this situation.. allowing ppp=
d =

> to speak to a local socket/fifo/pair of pipes that is terminated in user =

> space?

yes we could do that, but why bother with a PTY to push the data packets
into the kernel. At that point we can also run PPP in userspace and use
a TUN/TAP device to create our network interface. The question is when
do we wanna move the data from userspace into the kernel.

Also pppd does the whole setup of PPP session. The ppp_generic in the
kernel only das the data packets transport. Meaning the PPP session
setup needs to be done in userspace anyway.

Regards

Marcel



--===============2972454282499029996==--

