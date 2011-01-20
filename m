Content-Type: multipart/mixed; boundary="===============6679251378043230562=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [RFC 0/1] Add modem technology type property
Date: Thu, 20 Jan 2011 13:08:43 -0800
Message-ID: <1295557724-10185-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6679251378043230562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a RFC to initiate discussion regarding the addition of a modem
technology type indicator property to the modem DBus interface. The need for
such a property has arisen as we cannot use the current interface to
guarantee understanding of a modem device's technology type to the upper la=
yers
at all times.

The current design supports the behaviour where the upper layers can search=
 for
whichever technology interfaces are available and instantiated by the curre=
nt
modem device and execute accordingly. However, such behaviour only applies =
in
the case where there are distinguishing atoms (and associated DBus interfac=
es)
representing fundamentally different behaviour for different modem types. We
need to support the scenario where, for example, the different modem types
share the same DBus interface due to some, e.g. abstraction, in property
meaning, but the upper layers need to behave differently depending on the
technology. Currently, any technology distinguishing atoms are optional, wh=
ich
means we cannot rely on these to provide interfaces to be used by the upper
layers to establish the technology type, e.g. ofono.cdma.voicecall may not
always be available even if the underlying modem is a CDMA modem. This impl=
ies
we would need to assign the responsibility of broadcasting the modem device
technology type through the core modem interface.

An example use case:

In 3GPP, the serial number of a device is referred to as the International
Mobile Equipment Identity (IMEI).
In 3GPP2, the serial number of a device is referred to as the Mobile Equipm=
ent
Identifier (MEID).
In oFono, such a feature is abstracted to the same serial number concept so=
 GSM
and CDMA modems can both broadcast through the "Serial" modem interface.
However, the upper layer may need to process this value differently dependi=
ng
on the current technology for e.g. display purposes. This interface is prov=
ided
through the core modem code, but we have no way of communicating the current
modem device type if operating in an initial offline mode without any other
atoms instantiated.

We envisage the potential for more such use cases in the future and look
forward to comments/discussion regarding our options.

Thank you

Dara Spieker-Doyle (1):
  doc: Add modem technology type property

 doc/modem-api.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)


--===============6679251378043230562==--

