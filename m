Content-Type: multipart/mixed; boundary="===============1935189205205559240=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] AGPS Support
Date: Wed, 03 Nov 2010 11:39:55 +0100
Message-ID: <1288780795.9615.44.camel@aeonflux>
In-Reply-To: <AANLkTinyJ8AMTOp1+rObyxfn6BK+yJVRgm26SQFEH4b=@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1935189205205559240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> >> > On positioning framework side, XML containers encoding/decoding does=
 not seem to be yet widely used, while the support of RRC and RRLP framing =
is common, thanks to the support of SUPL.
> >> >
> >> > Using XML and 27.007 format would be great as long as long as ofono =
is not obliged to interpret the XML containers.
> >>
> >> Denis, is this something you would consider as an option, to transport
> >> both ASN.1 coded RRC / RRLP frames
> >> and XML transparently over the oFono API ?
> >
> > can some just quickly summarize for me what kind of different data type
> > representation we actually have here. And what the different modems and
> > standard suggest on how to encode them.
> =

> The RRLP, RRC and LPP standards all use ASN.1 to specify the data that
> is transferred,
> this encoded using packed en coding rules.  The data is represented as
> SEQUENCES of
> INTEGER and ENUMERATED data types.   A lot of items are subject to
> interesting scaling
> algorithms to get them into an integral format.  A handful of items
> (locations and required
> assistance data) are effectively octet strings from other 3gpp standards.
> =

> Most of the data  is assistance data describing reference location,
> reference time, satellite orbits,
> expected doppler and code phase.  The UE calculates the location and
> returns this as a GAD shape
> which is basically an ellipse with uncertainty, the coordinates scaled
> to be integral values.
> =

> > And then really who needs to "transcode" what in to what standard if we
> > would be going for XML as format?
> =

> The STE-Ericsson modem is doing the transcoding to XML on the modem side,
> using the 27.007 AT commands defined for AGPS.
> =

> For other modems sending the raw RRC/RRLP frames I guess the transcoding =
to XML
> would need to happen in the ofono driver or in ofono core if you want
> to expose an
> oFono XML API.

so here is my take on XML. If we have to parse it, then in general that
is a bad idea. Creating XML is just fine. It is not something totally
horrible, but nevertheless it is something that I would like to avoid.
If we can assume that we can use GMarkup (and its restrictions) for it,
then it mitigates this a little bit.

That said, I am with Denis here. If XML is defined in 27.007, then it
does make sense to do it. And as long as the core just sees it as a
stream of bytes, I am fine with this.

This of course means that the modems that don't use XML native for this
have to do some transcoding here. That is then up to the modem driver.

No on the other hand ASN.1 description of packets is also fine to me.
However same rule applies that oFono core should not need to look into
the data. It should just hand them off.

Or do we expect oFono core to do something with this data? I am under
the impression that oFono core is just a pipe here.

And in conclusion we have XML and ASN.1 adding some overhead to the
actual data that is encoded. None of them is coming for free.

If we wanna look at this not from the 27.007 standard angle, then we
have to look at what the users of this D-Bus are talking and what would
be easiest for them.

Regards

Marcel



--===============1935189205205559240==--

