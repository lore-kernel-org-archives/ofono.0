Content-Type: multipart/mixed; boundary="===============6047714546648007335=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [RERESEND] [PATCH 2/2] Update the network documentation
Date: Tue, 23 Nov 2010 16:58:18 +0200
Message-ID: <201011231658.18154.remi.denis-courmont@nokia.com>
In-Reply-To: <1290523574.13641.11.camel@aeonflux.mpl.access-company.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6047714546648007335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 23 November 2010 16:46:14 ext Marcel Holtmann, you wrote:
> > -			The possible values are: "gsm", "edge", "umts", "hspa",
> > -							"lte"
> > +			The possible values are: "gsm", "edge", "umts",
> > +			"hsdpa", "hsupa", "hspa" (meaning both hsdpa and hsupa)
> > +			and "lte"
> =

> so what is the intended usage for showing this difference? When we
> discussed this the last time, it was clear that we need to show a
> difference between 3G (umts) and 3.5G (hspa) and where HSPA would be
> either HSDPA or HSUPA or both.

In some UI scenarios, we want to know the difference between those three st=
ates =

as they show downlink and uplink separately. This gives the flexibility to =
do =

so.

In fact, I have some cases where we'd need know whether HSDPA/HSUPA channel=
s =

are actually allocated, not just whether the cell supports them. ISI does =

that, but there does not seem to be any standard way to get that informatio=
ns =

out of the modem. In particular, I assume that both the CREG and CGREG =

technology indications are always equal :-(

Anyway, lets fix what's easy to fix...

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============6047714546648007335==--

