Content-Type: multipart/mixed; boundary="===============4556439469263813656=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Thu, 03 Feb 2011 00:12:39 +0100
Message-ID: <1296688359.1520.358.camel@aeonflux>
In-Reply-To: <E9010BA84901F04DBE0FC93A424E0E4501097604@008-AM1MPN1-035.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4556439469263813656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kai,

> > So yes, there might be conditions where you crash before fsync really
> > completes and you lose the SMS.  However, there's nothing in the world
> > you can do about this case anyway, since both the write and the fsync
> > succeeded.
> =

> I think this is perfectly reasonable. Even if some storage system =

> had some internal caches outside the kernel sync's reach, I'd imagine
> flushing these would be a prime candidate for last-minute actions done
> before battery dies (or some sensor detecting the device is about to
> hit a brick wall in about a few milliseconds ;)). =


so the device health or charging daemon or whatever will most likely
shut down the device cleanly before the battery dies completely. The
case that a device suddenly dies, because the battery is empty does not
really exist. At least with all the charging magic these days that would
be pretty bad for the device and the battery. I would expect a clean
kill of the oFono daemon and I bet you that even have time to shutdown
the modem properly. So even the modem can save all its states.

Regards

Marcel



--===============4556439469263813656==--

