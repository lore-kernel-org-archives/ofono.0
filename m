Content-Type: multipart/mixed; boundary="===============4049697160257201625=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/3] EF-SPN API to sim-atom
Date: Tue, 01 Feb 2011 11:38:05 +0100
Message-ID: <1296556685.1520.248.camel@aeonflux>
In-Reply-To: <4D4719FF.3060107@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4049697160257201625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > On Thu, 2011-01-27 at 15:22 +0200, Jukka Saunamaki wrote:
> >> Here is an asynchronous implementation of SIM Service Provider Name (E=
F-SPN) getter API.
> >> The trick is to delay setting sim ready until spn reading is finished.
> > =

> > Any comments about this? =

> > So, yes, it slightly delays SIM initialisation (usually SPN value should
> > come from disk cache), but then netreg can use it immediately when it
> > registers. =

> > Alternative is still to create an asyncronous API now that there is a
> > patch for safe SIM file reading.
> =

> So my main problem here is that you require the SPN a handful of times
> in the phone's lifetime, more likely once.  Yet you pay the cost of
> reading and delaying the initialization every time.  In my view this is
> not really acceptable.

does it really matter in the end? It gets read once and after that we
are caching it on disk anyway.

Regards

Marcel



--===============4049697160257201625==--

