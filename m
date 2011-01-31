Content-Type: multipart/mixed; boundary="===============5459091192209271483=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] TODO: SMS Validity Period
Date: Mon, 31 Jan 2011 11:31:52 +0100
Message-ID: <1296469912.1520.199.camel@aeonflux>
In-Reply-To: <1296468405.1662.67.camel@miia-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5459091192209271483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Miia,

> > > +- Add support for setting the SMS Validity Period (3GPP 23.040). Cur=
rently the
> > > +  value is hard coded as 24 hours.
> > =

> > didn't we actually change this to be the maximum value?
> =

> Only place I could find this to be edited was following line in
> smsutil.c (3421)
> =

>   template.submit.vp.relative =3D 0xA7; /* 24 Hours */
> =

> Have I missed something then?
> =

> In any case, I'd rather see the value something that API allows to set
> instead of hard coded value, as user can have different needs for the
> SMS validity period and sometimes it is not the best thing either that
> period is set to maximum. =


why does the user have different needs here? Where are these needs
coming from?

How does a normal user actually know what this means for him and the
network he is using? Is the network actually honoring these values at
all these days?

Regards

Marcel



--===============5459091192209271483==--

