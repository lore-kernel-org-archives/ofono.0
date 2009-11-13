Content-Type: multipart/mixed; boundary="===============8145271627549976962=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: ppp
Date: Fri, 13 Nov 2009 13:23:28 +0100
Message-ID: <1258115008.3299.19.camel@violet>
In-Reply-To: <20091113121338.168862sljn41kiw4@boatman.intrepid.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8145271627549976962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Chris,

> >> > Unfortunately it is not that simple.  pppd requires a proper kernel =
file
> >> > descriptor to hand off to the kernel ppp line discipline.  In our  =

> >> userspace
> >> > implementation that is not the case.  1 kernel file descriptor is  =

> >> shared by
> >> > potentially many GAtChat channels using a multiplexing protocol.   =

> >> Hence why we
> >> > can't reuse the kernel implementation.
> >> >
> >>
> >> Not sure how relevant this is, but many many years ago (1997) I used a
> >> "telnet modem" to circumvent a firewall. It was a user land process th=
at
> >> presented a fake /dev/modem which I used using pppd and chat..
> >>
> >> My machine was behind a firewall with a telnet proxy.. Using the softw=
are
> >> + pppd + chat, it was set up along the lines:
> >>
> >> start telnet modem which presented a /dev/modem.. start pppd using
> >> /dev/modem:
> >>
> >> ATDT 1.2.3.4
> >> CONNECT 1.2.3.4
> >> the-telnet-proxy>
> >> telnet my.host 23
> >> connected to my.host:23
> >> login:
> >> mypppuser
> >> password:
> >> mypassword
> >> end of chat script... start pppd
> >>
> >> In this situation, pppd and the kernel device would have been
> >> communicating with a local userland process. The TCP connection to 1.2=
.3.4
> >> created by the telnet modem could not have been used by the ppp interf=
ace
> >> as the telnet modem was passing the streams in either direction
> >> essentially joining the fd of the telnet connection and fd used by ppp=
d..
> >>
> >> I'm not sure if the requirements of ppp in the kernel have chagned, but
> >> couldn't something like this be repeated in this situation.. allowing =
pppd
> >> to speak to a local socket/fifo/pair of pipes that is terminated in us=
er
> >> space?
> >
> > yes we could do that, but why bother with a PTY to push the data packets
> > into the kernel. At that point we can also run PPP in userspace and use
> > a TUN/TAP device to create our network interface. The question is when
> > do we wanna move the data from userspace into the kernel.
> >
> > Also pppd does the whole setup of PPP session. The ppp_generic in the
> > kernel only das the data packets transport. Meaning the PPP session
> > setup needs to be done in userspace anyway.
> >
> =

> I understand your point about the setup being done in user space, but  =

> would it not be faster to present a vanilla pppd with a pty and allow  =

> it to setup the connection and pass data to the kernel interface  =

> rather than providing a new implementation? I mean from the point of  =

> view of reusing software that is already available and very well tested?

if you look at the pppd code and tell us how to control it properly from
within another daemon, then we can talk. That is just stupid to the end
and would require massive extension of pppd. Also it ends up setting IP,
routing and DNS details and some other magic. It works as a quick hack,
but in the long run needs to be replaced.

> On the down side I see the "eeeew" factor of creating a pty pair just  =

> to pass data about, but if it means that far less code needs to be  =

> written (and much less code that is to interpret line traffic) I  =

> thought it might be safer solution. For example, if pppd is used, it  =

> already supports a wealth of authentication and feature negotiation.

And the authentication etc. is not really that much with GSM cards. They
are fairly limited in what they support. Especially since PPP only run
between the card and the host. It doesn't go over the network.

Regards

Marcel



--===============8145271627549976962==--

