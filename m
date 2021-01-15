Content-Type: multipart/mixed; boundary="===============7169604800278022214=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH v2 3/3] gemalto: netmon measurements scaling
Date: Fri, 15 Jan 2021 22:11:37 +0300
Message-ID: <YAHo6esXmIRoaTC9@curiosity>
In-Reply-To: <9407799e-a301-9058-f787-ebd6dcf37d36@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7169604800278022214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

> > Gemalto modem reports raw measurements in dBm. Reported values may
> > include negative numbers. Meanwhile oFono follows ETSI TS 27.007,
> > so negative numbers do not really exist at the API level.
> > =

> > Modify gemalto netmon driver to report measurements according to
> > 27.007. For this purpose re-scale from what Gemalto firmware
> > reports into something that 27.007 recommends.
> > ---
> >   drivers/gemaltomodem/netmon.c | 52 ++++++++++++++++++++++++++++++++---
> >   1 file changed, 48 insertions(+), 4 deletions(-)
> > =

> =

> I went ahead and applied all three patches after making minor tweaks in t=
his one:

Thanks!

> > +static int gemalto_rscp_scale(int value)
> > +{
> > +	if (value < -120)
> > +		return 0;
> > +
> > +	if (value > -24)
> > +		return 96;
> > +
> > +	return (value + 120);
> =

> The ()s weren't needed here..

Well, I did check coding style document for arithmetic expressions,
but I did not find anything other than spaces around operators. =

So I made a wrong guess...

Regards,
Sergey

--===============7169604800278022214==--

