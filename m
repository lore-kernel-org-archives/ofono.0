Content-Type: multipart/mixed; boundary="===============1661729627199467669=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC 1/3] doc: addidng documentation for basic assisted gps
Date: Fri, 05 Nov 2010 21:41:11 +0100
Message-ID: <1288989671.9615.144.camel@aeonflux>
In-Reply-To: <4CD46871.40507@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1661729627199467669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >>> So in general I'm currently against introducing this API as oFono
> >>> official API.  I suggest prefixing this with an IFX specific identifi=
er.
> >>>  Maybe modem.ifx.AgpsManager.
> >>
> >> I would actually go one step further and call this com.infineon.Agps or
> >> something like that.
> >>
> >> As I stated this many times, before we make this a generic oFono API, =
we
> >> need at least three types of modems that support this kind of feature
> >> and find the common API.
> >>
> >> For me this is clearly IFX and ISI right now. And it looks to me that
> >> Sjur has also shown interested, so the third one might be STE/MBM.
> > =

> > Yes, I can confirm that we are looking into this and are planning to
> > support AGPS for
> > oFono. Would you be interested if we proposed an API whith transparent =
transport
> > of the XML specified by 3GPP? Such an API should be possible to
> > implement with the
> > 3GPP standardized AGPS commands, so that a generic driver could be impl=
emented
> > (atmodem/agps.c).
> > =

> =

> I would definitely like to see a 27.007 based aGPS proposal.

I agree. If 27.007 bothered to standardize it, the seems like a good
idea to go for it.

Btw. I don't like the term aGPS. Especially GPS. That is actually more
like a product name and not really generic. Especially if you think
about the positioning systems from the European Union or Russia. So I
would like to see something like AssistedPositioning or in that spirit
of it.

Regards

Marcel



--===============1661729627199467669==--

