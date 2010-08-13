Content-Type: multipart/mixed; boundary="===============7634456891506229584=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Startup sequence for Online / offline mode
Date: Fri, 13 Aug 2010 11:45:18 +0300
Message-ID: <AANLkTi=_Pep4E8tq+aXfrCrtADYT6Ee3JS34H6EcCn6S@mail.gmail.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C90111C20D94@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7634456891506229584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/8/13 Bastian, Waldo <waldo.bastian@intel.com>:
> My understanding was that the Online state would be initialized by a comp=
onent like Telepathy-ring or some sort of system management daemon to ensur=
e that the dialer is up and running and able to accept calls before the Onl=
ine state is entered. If ConnMan initializes the Online state, how is it en=
sured that all required clients (Dialer, SMS, etc.) have registered already?

I'd propose the connman would delay the transition of ofono modems to
the online until the tp-ring/dialer has registered with ofono modem.
The VoiceCallManager would need some kind of
"RegisterCallHandler"method and add the list of the registered call
handlers as a property. I suppose this would concern only the
voice-centric devices.

-- =

Pekka.Pessi mail at nokia.com

--===============7634456891506229584==--

