Content-Type: multipart/mixed; boundary="===============0637234018782089393=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH 3/5] gemalto: gprs: support automatic context activation
Date: Thu, 24 Dec 2020 23:22:07 +0300
Message-ID: <X+T4bxyhlEwD1gtf@curiosity>
In-Reply-To: <63295129-3fac-ea80-6dfe-914816988728@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0637234018782089393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > > Are you sure you don't want to wait until swwan_cb to return success =
to the
> > > core?  AT^SWWAN can still fail...?
> > =

> > AT^SWWAN command is yet another way to activate a PDP context. AT comma=
nds
> > spec for this modem is a bit vague about SWWAN details, but according to
> > other materials from Gemalto as well as my experiments, this command
> > activates internal DHCP server, so DHCP client can be started for modem
> > USB ethernet interfaces. Based on my observations, SWWAN command does
> > not return until DHCP flow is completed.
> =

> Ugh.  I'd 'window.throw(modem)'...

Well, suggested revision works fairly well in conjunction with ConnMan.
So I would give it a chance )
 =

> > =

> > So the idea is to send SWWAN command to modem and make it possible to
> > start DHCP flow right away. I assume that I need both things: mark
> > interface for DHCP and signal success to the core. Callback swwan_cb is
> =

> So the problem with this is that you've now blocked the app/modem port un=
til
> that DHCP negotiation happens.  Maybe it does, maybe it doesn't.  It is l=
ess
> than ideal to depend on some external component; there are frequently
> situations where people would be running without ConnMan for example.
> =

> > supposed to handle the case when SWWAN command fails: mark context as
> > deactivated and let oFono proceed with further connection attempts.
> > =

> =

> Another thing to consider is to just run dhcp yourself.  ell has had a
> DHCPv4 client for a while now.  So you could just run l_dhcp_client to
> obtain the address and signal it to the core, leaving the app port in a
> known state...
> =

> Or better yet, don't use SWWAN if you can help it...

I guess that can be done as well. As I mentioned previously, SWWAN is
just one possible option. I assume that another option is to use
CGDCONT/CGACT and then to retrieve IP settings from modem. There were
earlier patches on the mail list for PLS8x modem, IIRC at least one
of them suggested both CGACT and SWWAN. I think I will take a look
and update those patches as soon as I am done with this SWWAN part.
Though at the moment I have no idea how to make configurable gprs
driver selection in gemalto plugin...

> <snip>
> =

> > Sure, I can add a comment. What whould be better: to add a comment in
> > driver or to write a more detailed commit message ?
> =

> Given how unusual this behavior is, I'd add a comment directly in the cod=
e.

Ok, I will do both in v2: clarify commit message and add a comment into
the driver.

Regards,
Sergey
--===============0637234018782089393==--

