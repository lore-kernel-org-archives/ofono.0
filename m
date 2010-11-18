Content-Type: multipart/mixed; boundary="===============9187738241618497807=="
MIME-Version: 1.0
From: Simon LETHBRIDGE <simon.lethbridge@stericsson.com>
Subject: RE: [PATCH] doc: Add Location Services API
Date: Thu, 18 Nov 2010 11:57:30 +0100
Message-ID: <B4268AAFAFA3E244B5B0641D5914917048B76BEBA1@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <4CDC6501.3070206@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9187738241618497807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: 11 November 2010 21:50
> To: ofono(a)ofono.org
> Cc: Sjur Br=C3=A6ndeland; Simon LETHBRIDGE; Sjur BRENDELAND
> Subject: Re: [PATCH] doc: Add Location Services API
> =

	 =

> =

> What about other location services related commands defined in 27.007?
> How do they fit in? E.g.:
> - +CMOLR
> - +CMTLR
> - +CMTLRA
> =


The proposed API only covers support for "Measure Position Requests" =

from the network.  This is sufficient for E911 =

(and other NILRs "network initiated - location requests" )
"Measure Position Requests" use the RRLP, RRC and LPP 3GPP protocols.

It does not support MTLR (Mobile Terminated - Location Requests ), =

this is where the user is notified that a 3rd party is trying to find =

the users location. MTLRs use the 3GPP SS protocol.

The proposal does not support MOLR (Mobile Originated - =

Positioning Requests) where the user requests the users position.  =

MOLR's can be used to request assistance data using a =

different protocol to that used with "Measure Position Requests". =

MOLRs also use the 3GPP SS protocol.

We have had some discussion about this internally.  It would be =

beneficial to define the APIs in a way that keeps "Measure Position =

Requests" separate from MOLRs and MTLRs.  There are three possible
approaches

1	Define different top level interfaces e.g.
	org.ofono.LocationServicesManager used by applications and
	org.ofono.GNSS                    used by the GNSS/GPS driver


2	Define different agents e.g.
	RegisterPositioningRequestAgent  used by the GNSS driver
	RegisterPositioningNotificationAgent used for MTLR notifications
	RegisterLocationAgent used for applications

3	Use one set of interfaces for everything.

Which approached is preferred? =


For mobile originated procedures the SS protocol must be used to get
locations and/or assistance data. for network initiated procedures
on ly the RRLP, RRC or LPP protocols can be used.

Regards,

Simon

--===============9187738241618497807==--

