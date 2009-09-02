Content-Type: multipart/mixed; boundary="===============1729965259061737934=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: GPRS support for Ofono
Date: Wed, 02 Sep 2009 10:39:42 -0700
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C968003549@orsmsx508.amr.corp.intel.com>
In-Reply-To: <200909021126.16772.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1729965259061737934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > > This really belong in the kernel.  Only the kernel can reliably know
> > > when a network interface has been brought down and notify the =

> > > interested applications with the statistics.
> >
> > You're missing the point.
> >
> > Yes, any body can extract the statistics for a running context. But data
> > counters are cumulating. To compute the sum properly, there are but two
> > options:
> > # Either the GPRS middleware requests kernel per-interface statistics
> > right before destroying the interface, and sums with the earlier total.
> > # Or the modem does it internally.
> =

> I know why you want this, but I'm still against the counter being an oFono
> driver API.  There needs to be a proper kernel interface that signals the
> application when an interface has gone away with the rx/tx details.  This
> way we handle this generically for all modems without relying on some
> intrinsic hardware capabilities.

This still doesn't solve the case where the modem is accessed from a PC cli=
ent and forwards PPP data as that data will not go through any network inte=
rface, e.g. BT DUN or USB tethering.

The modem is really in the best position to provide the most reliable infor=
mation on data usage. You can still use statistics from the network interfa=
ces as a fall-back in case the modem can not provide this information.

Cheers,
Waldo

--===============1729965259061737934==--

