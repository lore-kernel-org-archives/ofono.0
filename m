Content-Type: multipart/mixed; boundary="===============1136353808408620895=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [gprs-provision PATCHv7 0/5] Plugin API for provisioning of GPRS
 context settings
Date: Thu, 27 Jan 2011 07:59:23 +0100
Message-ID: <1296111563.1520.138.camel@aeonflux>
In-Reply-To: <1296110516.30517.8.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1136353808408620895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > > And again a patchset about automatic provisioning of GPRS context set=
tings.
> > > =

> > > Since the safe reading of EF-SPN turned out to be impossible until ge=
neral solution is implemented, I must temporary give up my insistence on it.
> > > =

> > > So the following provisioning driver API must be considered as provis=
ional. =

> > > When proper solution for SPN comes up, we should redesign the API. Wi=
thout SPN, correct settings cannot be provisioned for all service providers=
, but at least for now most cases should work with just the MCC and MNC val=
ues provided with this API.
> > > =

> > =

> > I've applied all of your patches but have refactored them heavily
> > afterward.  Let me know if I broke anything.
> =

> Excellent. Seems to work OK, thanks.
> =

> So, now while waiting for some solution to SIM reading issue, I can
> start looking at proper provisioning plugin. And looking forward to
> interesting discussions regarding merits of various XML-file formats for
> settings database...

you can have a look on what it would take to store a) read SPN in the
SIM atom and store it and b) let netreg atom use that value.

Regards

Marcel



--===============1136353808408620895==--

