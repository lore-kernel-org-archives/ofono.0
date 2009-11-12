Content-Type: multipart/mixed; boundary="===============8332254232809720325=="
MIME-Version: 1.0
From: Chris Pitchford <ofono@intrepid.cx>
Subject: Re: ppp
Date: Thu, 12 Nov 2009 19:39:40 +0000
Message-ID: <alpine.LNX.2.00.0911121929570.21838@boatman.intrepnet>
In-Reply-To: <200911121237.30698.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8332254232809720325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 12 Nov 2009, Denis Kenzior wrote:

>
> Unfortunately it is not that simple.  pppd requires a proper kernel file
> descriptor to hand off to the kernel ppp line discipline.  In our userspa=
ce
> implementation that is not the case.  1 kernel file descriptor is shared =
by
> potentially many GAtChat channels using a multiplexing protocol.  Hence w=
hy we
> can't reuse the kernel implementation.
>

Not sure how relevant this is, but many many years ago (1997) I used a =

"telnet modem" to circumvent a firewall. It was a user land process that =

presented a fake /dev/modem which I used using pppd and chat..

My machine was behind a firewall with a telnet proxy.. Using the software =

+ pppd + chat, it was set up along the lines:

start telnet modem which presented a /dev/modem.. start pppd using =

/dev/modem:

ATDT 1.2.3.4
CONNECT 1.2.3.4
the-telnet-proxy>
telnet my.host 23
connected to my.host:23
login:
mypppuser
password:
mypassword
end of chat script... start pppd

In this situation, pppd and the kernel device would have been =

communicating with a local userland process. The TCP connection to 1.2.3.4 =

created by the telnet modem could not have been used by the ppp interface =

as the telnet modem was passing the streams in either direction =

essentially joining the fd of the telnet connection and fd used by pppd..

I'm not sure if the requirements of ppp in the kernel have chagned, but =

couldn't something like this be repeated in this situation.. allowing pppd =

to speak to a local socket/fifo/pair of pipes that is terminated in user =

space?

I'll see if I can drag the code out to see what it actually did.. and =

even better see if I can get it to work on a 2.6 kernel!!




--===============8332254232809720325==--

