Content-Type: multipart/mixed; boundary="===============1176799654571114471=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono running on new Freerunner distribution
Date: Mon, 23 Nov 2009 15:05:18 -0600
Message-ID: <200911231505.18505.denkenz@gmail.com>
In-Reply-To: <4B0AA845.1020100@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1176799654571114471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dario,

> GREAT!!!! It worked!!! :)
> It registers in less than one minute! :)
> I noticed I don't need to call the Register method of
> NetworkRegistration interface but I just need to power up the modem, is
> it ok?

By default the netreg atom registers you automatically.  However it does =

remember the setting, so if you choose manual registration or deregister fr=
om =

the network it will not attempt to register you the next time you reboot.

> I have another question but maybe it's my fault: I noticed if I want to
> hangup a call during its "alerting" state, I can't, the other party
> continues ringing even if I call the hangup method on the correct path (
> /calypso0/voicecall01). What am I missing?

This seems to be a peculiarity of the Calypso modem.  When using ATD on an =

uninitialized port the ATD returns immediately.  This means that =

dialing/alerting calls can be hung up.  However, we use CPI indications and =

for some reason the ATD behavior changes when this is used.  ATD now only =

returns when a call connects, which means we can't hangup dialing/alerting =

calls, as you point out.  There are a couple of solutions we can try, stay =

tuned.

Regards,
-Denis

--===============1176799654571114471==--

