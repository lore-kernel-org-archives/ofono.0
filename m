Content-Type: multipart/mixed; boundary="===============7958818383557331360=="
MIME-Version: 1.0
From: mikhail.zabaluev@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Thu, 03 Feb 2011 10:54:19 +0000
Message-ID: <A459777776EB4841B844E1134E7928740157B4A3@008-AM1MPN1-016.mgdnok.nokia.com>
In-Reply-To: <1296688359.1520.358.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7958818383557331360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of ext Marcel Holtmann
> Sent: Thursday, February 03, 2011 1:13 AM
> To: ofono(a)ofono.org
> Subject: RE: [RFC 2/2] doc: Add description for history agent interface
> =

> > > So yes, there might be conditions where you crash before fsync
> really
> > > completes and you lose the SMS.  However, there's nothing in the
> world
> > > you can do about this case anyway, since both the write and the
> fsync
> > > succeeded.
> >
> > I think this is perfectly reasonable. Even if some storage system
> > had some internal caches outside the kernel sync's reach, I'd imagine
> > flushing these would be a prime candidate for last-minute actions
> done
> > before battery dies (or some sensor detecting the device is about to
> > hit a brick wall in about a few milliseconds ;)).
> =

> so the device health or charging daemon or whatever will most likely
> shut down the device cleanly before the battery dies completely. The
> case that a device suddenly dies, because the battery is empty does not
> really exist.

Obviously you never dropped a phone on the floor so luckily that the batter=
y pops out :)
There are also kernel crashes, and I wouldn't always trust the system daemo=
ns to perform a graceful shutdown.
There is no excuse to not using reliable persistence mechanisms when 1) the=
y are readily available; 2) their usage is mandated by certification requir=
ements.

Best regards,
  Mikhail

--===============7958818383557331360==--

