Content-Type: multipart/mixed; boundary="===============0416646720181013663=="
MIME-Version: 1.0
From: Simon LETHBRIDGE <simon.lethbridge@stericsson.com>
Subject: RE: [PATCH] doc: Add Location Services API
Date: Mon, 15 Nov 2010 11:19:26 +0000
Message-ID: <B4268AAFAFA3E244B5B0641D5914917048B767142E@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <4CDC6501.3070206@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0416646720181013663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: 11 November 2010 21:50
> To: ofono(a)ofono.org
> Cc: Sjur Br=C3=A6ndeland; Simon LETHBRIDGE; Sjur BRENDELAND
> Subject: Re: [PATCH] doc: Add Location Services API
 =


> =

> So let me summarize 27.007 briefly.  It defines the following elements =

> for +CPOS/+CPOSR:
> =

> - location
> - assist_data
> - pos_meas
> - GPS_meas
> - GPS_assist_req
> - msg
> - pos_err
> =

> So from my understanding +CPOS command can be used to send <location>, =

> <GPS_assist_req> and <pos_err> elements.
> =

> And +CPOSR can transfer the following elements from the network:
> <assist_data>, <pos_meas>, <msg>.
> =

> Am I right so far?

This is substantially correct, however the assistance data request can only=
 be
made in response to a positioning request from the network.  If assistance =
is
required otherwise then an MOLR is needed, which we don't support yet. =


> =

> Where does the <GPS_meas> element fall into?

There are two types of procedure "MSB" where the location is calculated in =
the mobile,
and "MSA" where it is calculated in the network.  For MSA code phase measur=
ements
and doppler are sent to the network.  One possible benefit of MSA procedure=
s is =

that less assistance data needs to be transferred. =

> =

> What about other location services related commands defined in 27.007?
> How do they fit in? E.g.:
> - +CMOLR
> - +CMTLR
> - +CMTLRA
These are not required for NILR (Network Initiated - Location Requests) =

procedures (e.g. E911 procedures).  However it could be useful to add suppo=
rt later.

The current proposal only supports NILR.

Regards,

Simon


--===============0416646720181013663==--

