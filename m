Content-Type: multipart/mixed; boundary="===============1215798893856089393=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC] doc: Proposal for LTE/IMS API.
Date: Thu, 27 Jan 2011 14:48:41 +0100
Message-ID: <AANLkTinOOiOpoWbhSpENNZqgwP+6g52eA7gS4AX=VCcO@mail.gmail.com>
In-Reply-To: <C50CA21D80D6B74F80FB941E215DF4145B46DD@008-AM1MPN1-001.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1215798893856089393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kai,

>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0array{dict,array{dict}} QosF=
ilters [readonly, optional]
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Information about the QoSes and associated Packet
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Filters for the Default PDN and it's dedicated bearers.
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
It is organized as a list of QoS definitions with
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
a list of corresponding packet filters.
>>
>> We really need to understand what the IMS application will need. If
>> this is about codecs or other things, then maybe oFono should give codec
>> advise directly. Proposals are welcome. Right now this looks like going
>> overboard.
>
> this is used e.g. for SDP preconditions mechanism used in IMS:
> http://www.faqs.org/rfcs/rfc3312.html
>
> The QoS is signalled on a per port/media basis, so relaying
> the packet-filters seems like a sane approach to me (cannot really
> say the same about 3312, but that's a different thing ;P).

OK, good to hear.

The 27007 spec specifies the following responses related to TFT/QoS:
+CGTFTRDP: <cid>,<packet filter identifier>,<evaluation precedence index>,
<source address and subnet mask>,<protocol number (ipv4) / next header (ipv=
6)>,
<destination port range>, <source port range>,<ipsec security
parameter index (spi)>,
<type of service (tos) (ipv4) and mask / traffic class (ipv6) and mask>,
<flow label (ipv6)>,<direction>,<NW packet filter Identifier>

+CGEQOSRDP: <cid>,<QCI>,[<DL_GBR>,<UL_GBR>],[<DL_MBR>,<UL_MBR>]

I tried to pick the minimal set of interesting parameters,
but I would really love some feedback on this from someone who knows
more about the IMS requirements here.

Regards,
Sjur

--===============1215798893856089393==--

