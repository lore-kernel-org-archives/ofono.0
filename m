Content-Type: multipart/mixed; boundary="===============8377420754713080207=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] gemalto: gprs: support automatic context activation
Date: Wed, 23 Dec 2020 19:48:53 -0600
Message-ID: <63295129-3fac-ea80-6dfe-914816988728@gmail.com>
In-Reply-To: <X+Ore+aBV4PX7UN+@curiosity>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8377420754713080207==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

>> Are you sure you don't want to wait until swwan_cb to return success to =
the
>> core?  AT^SWWAN can still fail...?
> =

> AT^SWWAN command is yet another way to activate a PDP context. AT commands
> spec for this modem is a bit vague about SWWAN details, but according to
> other materials from Gemalto as well as my experiments, this command
> activates internal DHCP server, so DHCP client can be started for modem
> USB ethernet interfaces. Based on my observations, SWWAN command does
> not return until DHCP flow is completed.

Ugh.  I'd 'window.throw(modem)'...

> =

> So the idea is to send SWWAN command to modem and make it possible to
> start DHCP flow right away. I assume that I need both things: mark
> interface for DHCP and signal success to the core. Callback swwan_cb is

So the problem with this is that you've now blocked the app/modem port unti=
l =

that DHCP negotiation happens.  Maybe it does, maybe it doesn't.  It is les=
s =

than ideal to depend on some external component; there are frequently situa=
tions =

where people would be running without ConnMan for example.

> supposed to handle the case when SWWAN command fails: mark context as
> deactivated and let oFono proceed with further connection attempts.
> =


Another thing to consider is to just run dhcp yourself.  ell has had a DHCP=
v4 =

client for a while now.  So you could just run l_dhcp_client to obtain the =

address and signal it to the core, leaving the app port in a known state...

Or better yet, don't use SWWAN if you can help it...

<snip>

> Sure, I can add a comment. What whould be better: to add a comment in
> driver or to write a more detailed commit message ?

Given how unusual this behavior is, I'd add a comment directly in the code.

Regards,
-Denis
--===============8377420754713080207==--

