Content-Type: multipart/mixed; boundary="===============4528436214091436756=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC] doc: Proposal for LTE/IMS API.
Date: Mon, 31 Jan 2011 13:15:06 +0100
Message-ID: <AANLkTi=g4Eev-MpkpPgiPTFM1NazKKTiHAGvO3_O5cHy@mail.gmail.com>
In-Reply-To: <4D42A866.5040604@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4528436214091436756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0string =C2=A0PrivateImsIdentity [read=
only, optional]
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Identity used for IMS r=
egistration.
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Available if present on=
 the ISIM.
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0string =C2=A0PublicImsIdentity [reado=
nly, optional]
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Identity used for IMS r=
egistration.
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Available if present on=
 the ISIM.
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0string =C2=A0HomeDomainName[readonly,=
 optional]
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Identity used for IMS r=
egistration.
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Available if present on=
 the ISIM.
>> =C2=A0+
>
> Will these not be known to the user?
> When does this interface becomes alive (org.ofono.ims)? post_sim or
> post_online?

These are read from the ISIM, so I believe this should be available post_si=
m.

>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0string =C2=A0ImsToCsHandoverStatus [r=
eadonly, optional]
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Indicate the handover p=
rogress status during a CS
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fallback procedure. Thi=
s property will only be present
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0when in LTE coverage. T=
he possible values are:
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"none", "started","comp=
lete", "failure".
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Related AT URC: +CIREP
>> =C2=A0+
>
> Again which specification details these AT commands?. Do we need a proper=
ty
> like this to show the CSFB?

ImsToCsHandoverStatus is the progress notification of the actual
handover from LTE to CS,
I believe this information will be needed for setting up the CMT
device (CS Audio) and
knowing when to switch from IMS Audio to CS Audio streams.

> why can't we...
>
> while in LTE:
> =C2=A0 =C2=A0oFono has network registration, connection manager, SIM and =
LTE
> =C2=A0 =C2=A0specific interfaces
>
> while in CSFB :
> =C2=A0 =C2=A0oFono has all other interfaces too.

Yes, agree.
CSFB will look similar to the case where you loose your LTE coverage
and move to WCDMA/GSM. You will have the same oFono APIs available
in both cases, regardless of how the change was initiated.


>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0array{dict,array{dict}} QosFilters [r=
eadonly, optional]
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Information about the Q=
oSes and associated Packet
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Filters for the Default=
 PDN and it's dedicated bearers.
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0It is organized as a li=
st of QoS definitions with
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a list of corresponding=
 packet filters.
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8 QoS=
ClassIdentifier [readonly]
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0The numeric parameter that specifying
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0the class of QoS. (3GPP TS 23.203 [85])
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00 =C2=A0 =C2=A0QCI is selected by network
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0[1 =E2=80=93 4] guaranteed bit rate
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0[5 =E2=80=93 9] non-guaranteed bit rate
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16 Up=
linkRate [readonly, optional]
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Guaranteed Uplink Bit-rate in kb/sec.
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16 Do=
wnlinkRate [readonly, optional]
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Guaranteed Downlink Bit-rate in kb/sec.
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0For each QoS defined th=
ere may be a list of Packet
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Filters. Each Packet Fi=
lter is a dictionary defining
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the filter. An empty Pa=
cket Filter represents the
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"default" filter (Defau=
lt PDN connection).
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0string Di=
rection [readonly]
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0"uplink", "downlink", "bidirectional"
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8 Pro=
tocolNumber [readonly]
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0IP protocol number (0-256)
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0string Pe=
erAddress [readonly]
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0The remote peer's IP address.
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16 Pe=
erPortMin [readonly]
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Remote peer's port number min. value
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16 Pe=
erPortMax [readonly]
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Remote peer's port number max. value
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16 Lo=
calePortMin [readonly]
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0The local port number min. value
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16 Lo=
calPortMax [readonly]
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0The local port number max. value
>>
>
> Do we really need this?. What is the real usage of this information?.
> In 27.007 there are few AT commands for TFT, and are not used, may be
> because no body (operator) supports this.
>
> In LTE will this be going to be different?

In LTE the network will be responsible for setting up Dedicated
Bearers (Secondary PDPs).
And I believe the IMS application needs information about the
TFT/QoSes when setting up a call.

BTW, did you see the response from Kai earlier in this mail thread?
[kai.vehmanen(a)nokia.com wrote:]
>this is used e.g. for SDP preconditions mechanism used in IMS:
>http://www.faqs.org/rfcs/rfc3312.html
>The QoS is signalled on a per port/media basis, so relaying
>the packet-filters seems like a sane approach to me (cannot really
>say the same about 3312, but that's a different thing ;P).


Regards,
Sjur

--===============4528436214091436756==--

