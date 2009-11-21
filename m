Content-Type: multipart/mixed; boundary="===============8891544641531699823=="
MIME-Version: 1.0
From: morphis@gravedo.de
Subject: Re: Palm Pre modem plugin
Date: Sat, 21 Nov 2009 11:14:45 +0100
Message-ID: <20091121101445.GA4375@nirvana>
In-Reply-To: <fb249edb0911200517l69b51186i39a1374e034999a3@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8891544641531699823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2009 at 02:17:06PM +0100, andrzej zaborowski wrote:
> Hi,
> =

> 2009/11/20  <morphis@gravedo.de>:
> > The Problem why we do this is the following: As I and some other people
> > find out,
> > there is no support on the data channel (the one you use in oFono to sp=
eak
> > plain AT with the modem) for unsolicited responses.
> >
> > So the only option is to support the binary protocol to get minimally t=
he
> > response from the modem when for example a call arrives.
> >
> > So my question is: How do you want to manage this with your plugin for =
the
> > Palm Pre modem? Do you even plan to use the serial interface on the
> > /dev/modemuart port?
> =

> We plan to use this port when enough is known about the protocol the
> modem firmware speaks on it that it can be used reliably.  I don't
> have any specification for that protocol or the current firmware
> sources so I can't modify it, or the WebOS telephony daemon sources.

Ok. I don't think anyone else has the plain sources of the telephony
daemon, but if anyone have, please tell :D

> Personally I've looked at the binary protocol and added some of my
> findings to this page:
> http://www.webos-internals.org/wiki/Research_Pre_GSM_Modem_Protocol ,
> for that I modified the kernel to cache all the ttyS0 communication
> from the start, later communication can be inspected with strace or by
> renaming the /dev node to something else and providing a pty.
> Do you have a fuller description of the protocol?  It doesn't seem
> there's much work on it done at webos-internals for the last couple of
> weeks.

You are right, I don't published very much informations about my
research the last time. I am currently working on the implementation of
the basics I found out about the protocol. I split the whole code into
two projects: msmcommd and libmsmcomm. msmcommd is a daemon which does
all the link layer protocol handling which is required to speak probably
with the modem. The library libmsmcomm is an easy utilitiy to format
the different messages type and decode them on receive. =


The link layer part is nearly done. Establishment of a link should work
and on the handling of sending and receiving data I am currently
working.

When libmsmcomm and msmcommd are done I have the plan to open from
fsogsmd a network channel to msmcommd and send all my telephony commands
to msmcommd whichs put them into link layer frames and sends them to the
modem. =


The big part which is mostly undone at the moment, is the one how the
real messages are decoded. My current informations are that commands are
even as small as the AT ones. So you have one for getting the imei, one =

for starting a call and so on. =


> =

> The ofono plugin is experimental, but some unsolicited responses are
> available on the AT port, like incoming SMS.  I've not checked
> incoming voice calls yet, outgoing calls worked fine in my test.

Hm ok. That maybe opens us the way to do most things with AT commands
and only a little subset like power management with the binary protocol.

> Regards
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============8891544641531699823==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xMCAoR05V
L0xpbnV4KQoKaUVZRUFSRUNBQVlGQWtzSHZaVUFDZ2tRcWxpNGFTWGl3TS96VndDZlJoc3hYWDNP
VHFvTGhGUXRNSFZZT3l5bAp3UThBb0xlODRaTVlqNkZWbEJjSWhMUDJmZDRZQ3NBSwo9eFZabwot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============8891544641531699823==--

