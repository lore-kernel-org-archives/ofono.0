Content-Type: multipart/mixed; boundary="===============7966460680030995218=="
MIME-Version: 1.0
From: Marko.Ovaska@nokia.com
Subject: RE: [PATCH] doc: Add Location Services API
Date: Mon, 22 Nov 2010 10:01:14 +0100
Message-ID: <B737AE8337D70F47B693AC85FA440B08328D6CF9C4@NOK-EUMSG-02.mgdnok.nokia.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C90157D0B15E@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7966460680030995218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


: -----Original Message-----
: From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
: Behalf Of ext Bastian, Waldo

: Subject: RE: [PATCH] doc: Add Location Services API
 =

: Conformance testing per 3GPP 34.109s5.4.1.3 requires that
: RESET UE POSITIONING STORED INFO is handled.
: Similar for 3GPP RESET MS POSITIONING STORED INFO per 3GPP 44.014s12.
: =

: As far as I can see there is no provision for that in commands / XML
: defined by 27.007.
: =


Hi!

Entering the thread a bit late and partially to wrong thread. My comments w=
ill overlap the AGPS thread as well.

The client for the positioning interfaces two sources: OMA SUPL servers and=
 cellular network servers. The SUPL definitions are in OMA TS ULP and AD SU=
PL specs, for example V1.0 level from openmobilealliance.org.

The SUPL data handling catch is that the SUPL server command and assistance=
 data format refers directly to "TIA-801, RRLP or RRC" defined data transfe=
r protocols. RRLP and RRC frames are ASN.1 BER en/decoded, and there is lim=
ited number of location related commands.

The oFono API means that positioning engine and either modem or oFono drive=
r would need to do the XML to ASN.1 conversions. As discussed in AGPS threa=
d. 27.007 position related definition does not mandate XML as such, it defi=
nes the parameters in XML DTD.

I'm proposing that either we have =

a) fully opaque 'raw' 3GPP defined frames between modem and Linux
b) or well defined D-BUS API for LCS commands, but keeping the assistance p=
ayload in 'raw' format

Both a) and b) approaches break the 27.007 defined positioning commands. Ra=
tionale is that 27.007 positioning related re-formatting creates additional=
 effort to any positioning engine, whether it resides in modem, dedicated c=
hip or in Linux.

  Marko



--===============7966460680030995218==--

