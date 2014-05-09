Content-Type: multipart/mixed; boundary="===============1676938872481124294=="
MIME-Version: 1.0
From: Patrik Flykt <Patrik.Flykt@linux.intel.com>
Subject: Re: Network preference gsm is only working when allowing roaming?
Date: Fri, 09 May 2014 23:28:17 +0300
Message-ID: <1399667297.22541.26.camel@pflykt-mobl1>
In-Reply-To: <536D2308.9080900@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1676938872481124294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


	Hi,

On Fri, 2014-05-09 at 13:48 -0500, Denis Kenzior wrote:
> On 05/09/2014 01:31 AM, Patrik Flykt wrote:
> > =

> > 	Hi,
> > =

> > On Thu, 2014-05-08 at 16:51 +0200, Niclas Karlsson wrote:
> > =

> >>     [ org.ofono.NetworkRegistration ]
> >>         Status =3D roaming
> =

> The modem tells us it is roaming.  Nothing can be done about that.
> =

> <snip>
> =

> > =

> > ...this combined looks like your SIM says MobileNetworkCode 08 while the
> > network attached to is 24. So ofono thinks your are roaming now. Is an
> > update needed to some database? Is this in ofono or in some other sw?
> > =

> > Let's ask ofono ml for an answer.
> > =

> =

> I'm not sure what the context of the question is, but RadioSettings API
> is completely independent of the current registration status.

The context was that SIM shows home network as 08 with the current
network being 24. The device thinks it is roaming while the user, in
this case Niclas Karlsson, knows the device should be in its home
network. So org.ofono.NetworkRegistration is the correct one here and
any change in roaming status must come from the network? So this boils
down to simply being connected to the wrong network after all?

Cheers,

	Patrik



--===============1676938872481124294==--

