Content-Type: multipart/mixed; boundary="===============1549030457582537272=="
MIME-Version: 1.0
From: Marko.Ovaska@nokia.com
Subject: RE: [PATCH] doc: Add Location Services API
Date: Fri, 26 Nov 2010 16:29:47 +0100
Message-ID: <B737AE8337D70F47B693AC85FA440B08328D7512B8@NOK-EUMSG-02.mgdnok.nokia.com>
In-Reply-To: <129600E5E5FB004392DDC3FB599660D70104DAF2A3@irsmsx504.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1549030457582537272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



: Behalf Of Marko.Ovaska(a)nokia.com
: >Sent: Monday, November 22, 2010 10:01 AM
--
: > I'm proposing that either we have
: > a) fully opaque 'raw' 3GPP defined frames between modem and Linux
: > b) or well defined D-BUS API for LCS commands, but keeping the
: assistance payload in 'raw' format


Checked the 27.007 and Sjur's proposal: XML format after, for example +CPOS=
 command, is above a) option with XML formatted payload.

I'll rephrase the ASN.1 formatted opaque option as a2). =


Rationale is that position engine in Linux user space or GPS chip must do A=
SN.1 processing in handset: Positioning engine uses both OMA specified SUPL=
 server and LCS server in cellular network. Adding new format to cellular n=
etwork LCS server messages increases work into modem and positioning engine.

Then the ASN.1 formatted interface
void SendPositioningControl(string xml_element)
becomes

void SendPositioningControl(string asn1_element)

and text refers to RRLP format in TS 44.031 and RRC in TS 25.331.




: For the option b, I would tend to not support you. I just recheck the
: 23.032 (Universal GeoGraphical Area Description), and the number of
: ways to express a position with velocity and uncertainty may not make
: the API simple.
: Just have a look for instance the +CMOLR's XML DTD location_parameters.
: :)

Payload gets complicated, I agree. Following the generic oFono interface de=
finitions...

   Marko



--===============1549030457582537272==--

