Content-Type: multipart/mixed; boundary="===============1258648753607338010=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: EF-SPN API (was: [gprs-provision PATCHv7 0/5] Plugin API for
 provisioning of GPRS context settings)
Date: Thu, 27 Jan 2011 09:53:32 +0200
Message-ID: <1296114812.30517.35.camel@jsaunama-desktop>
In-Reply-To: <1296113837.1520.142.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1258648753607338010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Thu, 2011-01-27 at 08:37 +0100, ext Marcel Holtmann wrote:
> > > you can have a look on what it would take to store a) read SPN in the
> > > SIM atom and store it and b) let netreg atom use that value.
> > =

> > Simple solution for this would be something like:
> > ... =

> don't make this asynchronous. Just read the SPN and store it. Then it
> can be easily accessed similar to MCC and MNC.
> =

> The GPRS atom and netreg for that matter will not be available before
> the SIM atom has been fully initialized anyway.
> =

> If there is any race condition with this one, the we need to be really
> really careful since it has a lot of consequences.

This is the hard part of this, how to be sure SPN reading is ready early
enough. I am not yet familiar enough with SIM initialisation to say how
to do it. But I can start looking at it.

--Jukka



--===============1258648753607338010==--

