Content-Type: multipart/mixed; boundary="===============1156542430118084779=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Mon, 29 Mar 2010 21:29:54 +0300
Message-ID: <80fd4e751003291129n5baa0b5bhf16e404e95491d1c@mail.gmail.com>
In-Reply-To: <201003191318.35173.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1156542430118084779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi denis,

2010/3/19 Denis Kenzior <denkenz@gmail.com>:
> I've been talking about this exact issue with Marcel but so far we have n=
ot
> firmly agreed on any solution. =C2=A0Our current thinking is to keep Powe=
red
> semantics as they are, but to also add Flight mode property. =C2=A0This w=
ould in
> affect allow interaction with the SIM while the radio is off. =C2=A0For s=
ome modems
> it might not even make sense to support flight mode (e.g. HFP)
>
> We're also trying to figure out how this would interact with SIM removal =
/ SIM
> dead events.

I've been porting the N900 modem control code to oFono. The semantics
of Powered is fine with respect of the atoms, in other words, if the
modem crashes and boots itself, all the atoms are flushed nicely.
When powering up, the Powered can be set to true when the modem is
really up and running.

However, then powering modem down, there are problems. The N900 modem
control needs to make difference between the state where the modem is
no more useful and the safe-to-exit state when the power off request
has been completed, modem has flushed its state to flash and given
some time to safely turn off the SIM card.

Also, if an another SetProperty("Powered") call is made while the
driver is powering the modem on or off, the change is ignored. It
seems to me that we need more fine grained power control than just the
current boolean in the core, too.

> If you have strong feelings about a particular approach feel free to disc=
uss
> it here or on IRC.

I'll see if I can find my irssi screen...

-- =

Pekka.Pessi mail at nokia.com

--===============1156542430118084779==--

