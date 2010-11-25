Content-Type: multipart/mixed; boundary="===============4607213709402643521=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH] Add voice call boolean property for MO/MT distinction
Date: Thu, 25 Nov 2010 09:40:42 +0200
Message-ID: <201011250940.42941.remi.denis-courmont@nokia.com>
In-Reply-To: <4CED843F.8040306@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4607213709402643521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday 24 November 2010 23:31:43 ext Denis Kenzior, you wrote:
> Hi R=C3=A9mi,
> =

> > +		boolean Originated [readonly]
> > +
> > +			Indicates whether the call was mobile-originated
> > +			(true) or mobile-terminated (false).
> > +
> =

> What use case are you trying to enable with this API?  I don't see how
> this could be useful for the UI...

This becomes a problem if we have more than one application "managing" voic=
e =

calls. And I expect that will _be_ the most common case. You have the main =

call UI, but you also have the Bluetooth headset/carkit, the USB AT command=
s =

port, and possibly some third party call applications.

Generally speaking, I don't see the point in oFono hiding obvious stuff tha=
t it =

knows about.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============4607213709402643521==--

