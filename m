Content-Type: multipart/mixed; boundary="===============7886282483962587761=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC] AGPS Support
Date: Wed, 03 Nov 2010 11:27:10 +0100
Message-ID: <AANLkTinyJ8AMTOp1+rObyxfn6BK+yJVRgm26SQFEH4b=@mail.gmail.com>
In-Reply-To: <1288730685.3322.184.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7886282483962587761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.

>> > On positioning framework side, XML containers encoding/decoding does n=
ot seem to be yet widely used, while the support of RRC and RRLP framing is=
 common, thanks to the support of SUPL.
>> >
>> > Using XML and 27.007 format would be great as long as long as ofono is=
 not obliged to interpret the XML containers.
>>
>> Denis, is this something you would consider as an option, to transport
>> both ASN.1 coded RRC / RRLP frames
>> and XML transparently over the oFono API ?
>
> can some just quickly summarize for me what kind of different data type
> representation we actually have here. And what the different modems and
> standard suggest on how to encode them.

The RRLP, RRC and LPP standards all use ASN.1 to specify the data that
is transferred,
this encoded using packed en coding rules.  The data is represented as
SEQUENCES of
INTEGER and ENUMERATED data types.   A lot of items are subject to
interesting scaling
algorithms to get them into an integral format.  A handful of items
(locations and required
assistance data) are effectively octet strings from other 3gpp standards.

Most of the data  is assistance data describing reference location,
reference time, satellite orbits,
expected doppler and code phase.  The UE calculates the location and
returns this as a GAD shape
which is basically an ellipse with uncertainty, the coordinates scaled
to be integral values.

> And then really who needs to "transcode" what in to what standard if we
> would be going for XML as format?

The STE-Ericsson modem is doing the transcoding to XML on the modem side,
using the 27.007 AT commands defined for AGPS.

For other modems sending the raw RRC/RRLP frames I guess the transcoding to=
 XML
would need to happen in the ofono driver or in ofono core if you want
to expose an
oFono XML API.

Regards,
Sjur and Simon

--===============7886282483962587761==--

