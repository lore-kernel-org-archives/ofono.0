Content-Type: multipart/mixed; boundary="===============7296870469592539159=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] doc: Add dial-number/username/password Property
Date: Wed, 22 Jun 2011 20:38:36 -0700
Message-ID: <1308800318.2196.80.camel@aeonflux>
In-Reply-To: <0E7E5CACD8E9F248AA009C292CC772A0759B40@ALA-MBA.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7296870469592539159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

> > > Some network's dial-number isn't #777 and user name and password
> > > are required when setup data connection.
> > >
> > > ---
> > >  doc/cdma-connman-api.txt |   14 ++++++++++++++
> > >  1 files changed, 14 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
> > > index e486c09..f76a2c5 100644
> > > --- a/doc/cdma-connman-api.txt
> > > +++ b/doc/cdma-connman-api.txt
> > > @@ -35,6 +35,20 @@ Properties	boolean Powered [readwrite]
> > >  			Contains whether the connection is dormant.  Will
> > >  			always be false if the connection is not powered.
> > >
> > > +		string DialNumber [readwrite]
> > > +
> > > +			Holds the dialed number.
> > > +
> > =

> > We discussed this during the oFono CDMA workshop and the consensus was
> > that this is not needed in practice.
> > =

> > > +		string Username [readwrite]
> > > +
> > > +			Holds the username to be used for authentication
> > > +			purposes.
> > > +
> > > +		string Password [readwrite]
> > > +
> > > +			Holds the password to be used for authentication
> > > +			purposes.
> > > +
> > =

> > We discussed these as well and the consensus was that these are
> > probably
> > not needed.  If we ever come across a network that does, then we can
> > re-examine this decision.
> > =

> =

> For China Telecom there are two different settings:
> WAP access(Access China Telecom internal network): =

>     Dial-number: #777
>     Username: ctwap(a)mycdma.cn
>     password: vnet.mobi
> =

> Internet access(Access internet):
>     Dial-number: #777
>     Username: ctnet(a)mycdma.cn
>     password: vnet.mobi
> =

> It seems there are some other operator's setting need username and passwo=
rd too. Please
> refer to:
> http://my-test.opera.com/iskandarajas/blog/setting-dial-up-cdma-indonesia
> =

> Anyway, it should be flexible to keep the settings variable.

give it a try without it actually. A lot of GSM providers still list
these settings officially, but in the end they accept any
username/password. So once you reach the stage of PPP CHAP, you just
reply with empty username and an empty password and it will succeed.

Lets face it here, the authentication is not done via username and
password, it is done via the backend. So they can clearly tell your data
plan apart and bill you accordingly.

And if this is really really really needed, then we can add this later
on easily. No need to worry about this now.

Regards

Marcel



--===============7296870469592539159==--

