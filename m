Content-Type: multipart/mixed; boundary="===============7879948470540610719=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: [PATCH] doc: Add dial-number/username/password Property
Date: Thu, 23 Jun 2011 03:31:31 +0000
Message-ID: <0E7E5CACD8E9F248AA009C292CC772A0759B40@ALA-MBA.corp.ad.wrs.com>
In-Reply-To: <4E00B3C7.6000405@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7879948470540610719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> On 06/21/2011 04:53 AM, Caiwen Zhang wrote:
> > Some network's dial-number isn't #777 and user name and password
> > are required when setup data connection.
> >
> > ---
> >  doc/cdma-connman-api.txt |   14 ++++++++++++++
> >  1 files changed, 14 insertions(+), 0 deletions(-)
> >
> > diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
> > index e486c09..f76a2c5 100644
> > --- a/doc/cdma-connman-api.txt
> > +++ b/doc/cdma-connman-api.txt
> > @@ -35,6 +35,20 @@ Properties	boolean Powered [readwrite]
> >  			Contains whether the connection is dormant.  Will
> >  			always be false if the connection is not powered.
> >
> > +		string DialNumber [readwrite]
> > +
> > +			Holds the dialed number.
> > +
> =

> We discussed this during the oFono CDMA workshop and the consensus was
> that this is not needed in practice.
> =

> > +		string Username [readwrite]
> > +
> > +			Holds the username to be used for authentication
> > +			purposes.
> > +
> > +		string Password [readwrite]
> > +
> > +			Holds the password to be used for authentication
> > +			purposes.
> > +
> =

> We discussed these as well and the consensus was that these are
> probably
> not needed.  If we ever come across a network that does, then we can
> re-examine this decision.
> =


For China Telecom there are two different settings:
WAP access(Access China Telecom internal network): =

    Dial-number: #777
    Username: ctwap(a)mycdma.cn
    password: vnet.mobi

Internet access(Access internet):
    Dial-number: #777
    Username: ctnet(a)mycdma.cn
    password: vnet.mobi

It seems there are some other operator's setting need username and password=
 too. Please
refer to:
http://my-test.opera.com/iskandarajas/blog/setting-dial-up-cdma-indonesia

Anyway, it should be flexible to keep the settings variable.

> >  		dict Settings [readonly, optional]
> >
> >  			Holds all the IP network settings
> =


Best regards,
Caiwen

--===============7879948470540610719==--

