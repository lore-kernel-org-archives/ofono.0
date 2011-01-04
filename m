Content-Type: multipart/mixed; boundary="===============5375185146659504094=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Tue, 04 Jan 2011 13:49:30 -0800
Message-ID: <1294177770.5852.109.camel@aeonflux>
In-Reply-To: <1294148265.3120.1644.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5375185146659504094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > > But then it is far simpler to have a D-Bus getter and a D-Bus signal =
by any =

> > > sane measure of complexity.
> > =

> > So you did consider the complexity on both sides, ofonod and timed? And
> > not just looked at one side of picture?
> =

> Timed also needs to follow the registration status, namely the MNC/MCC
> of the registered network.  This information it needs to be able to find
> the correct timezone, as the UTC offset alone only indicates the
> geographic longitude for the timezone.
> =

> Factor that in to the equation, and timed already needs to enumerate
> available modems, call GetProperties, and listen to the
> NetworkRegistration interface's PropertyChanged signals.
> =

> However, if we refactor the time plugin to also send the MNC/MCC pair --
> or better yet, the ISO country code based on MCC or even the actual
> timezone from matching zone.tab entry -- then following netreg is no
> longer needed.
> =

> *Then* I agree a method call is actually a lot simpler from timed point
> of view; all it needs to do is implement a single method on some
> org.ofono.NetworkTimeConsumer interface and not worry about enumerating
> modems via ModemManager or listening on any signals.

we are doing the country alpha2 matching to MCC already in ConnMan for
the WiFi regulatory enforcement update. I am not sure that I wanna copy
these tables around all the time.

So the struct ofono_nettime_context has already a reference to struct
ofono_modem, so why not add a reference to the struct ofono_netreg and
then you have the MCC/MNC details available inside the plugin.

Regards

Marcel



--===============5375185146659504094==--

