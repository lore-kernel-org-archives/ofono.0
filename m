Content-Type: multipart/mixed; boundary="===============4499292589369284840=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Startup sequence for Online / offline mode
Date: Fri, 13 Aug 2010 14:55:36 +0200
Message-ID: <1281704136.23399.4.camel@localhost.localdomain>
In-Reply-To: <AANLkTi=_Pep4E8tq+aXfrCrtADYT6Ee3JS34H6EcCn6S@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4499292589369284840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> > My understanding was that the Online state would be initialized by a co=
mponent like Telepathy-ring or some sort of system management daemon to ens=
ure that the dialer is up and running and able to accept calls before the O=
nline state is entered. If ConnMan initializes the Online state, how is it =
ensured that all required clients (Dialer, SMS, etc.) have registered alrea=
dy?
> =

> I'd propose the connman would delay the transition of ofono modems to
> the online until the tp-ring/dialer has registered with ofono modem.
> The VoiceCallManager would need some kind of
> "RegisterCallHandler"method and add the list of the registered call
> handlers as a property. I suppose this would concern only the
> voice-centric devices.

this sounds rather complicated and I don't wanna have a dependency for
tp-ring here in the mix. Also I think this is more a theoretical problem
than a real one. tp-ring needs to check for the current ringing calls
anyway and can just pick where it left off. So lets talk about this once
we cross this bridge.

Regards

Marcel



--===============4499292589369284840==--

