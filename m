Content-Type: multipart/mixed; boundary="===============7313679742996612751=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Fri, 07 Jan 2011 13:05:31 -0800
Message-ID: <1294434331.2501.25.camel@aeonflux>
In-Reply-To: <1294396338.2602.20.camel@apaila-ThinkPad-T410>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7313679742996612751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

> > > > > But then it is far simpler to have a D-Bus getter and a D-Bus sig=
nal by any =

> > > > > sane measure of complexity.
> > > > =

> > > > So you did consider the complexity on both sides, ofonod and timed?=
 And
> > > > not just looked at one side of picture?
> > > =

> > > Timed also needs to follow the registration status, namely the MNC/MCC
> > > of the registered network.  This information it needs to be able to f=
ind
> > > the correct timezone, as the UTC offset alone only indicates the
> > > geographic longitude for the timezone.
> > > =

> > > Factor that in to the equation, and timed already needs to enumerate
> > > available modems, call GetProperties, and listen to the
> > > NetworkRegistration interface's PropertyChanged signals.
> > > =

> > > However, if we refactor the time plugin to also send the MNC/MCC pair=
 --
> > > or better yet, the ISO country code based on MCC or even the actual
> > > timezone from matching zone.tab entry -- then following netreg is no
> > > longer needed.
> > > =

> > > *Then* I agree a method call is actually a lot simpler from timed poi=
nt
> > > of view; all it needs to do is implement a single method on some
> > > org.ofono.NetworkTimeConsumer interface and not worry about enumerati=
ng
> > > modems via ModemManager or listening on any signals.
> > =

> > we are doing the country alpha2 matching to MCC already in ConnMan for
> > the WiFi regulatory enforcement update. I am not sure that I wanna copy
> > these tables around all the time.
> > =

> > So the struct ofono_nettime_context has already a reference to struct
> > ofono_modem, so why not add a reference to the struct ofono_netreg and
> > then you have the MCC/MNC details available inside the plugin.

one additional comment here about getting the MCC and MNC (or other atom
details). You can use __ofono_modem_find_atom() to get the netreg atom
from the modem pointer. This means that any nettime plugin already has
all the needed information available.

> If I would like to do conversion from mcc to alpha2 in ofono, what would
> be your suggestion for doing this. I noticed that in connman you have
> mcc.h that contains the mapping array, but in ofono we don't have such
> an array. As a temporary solution, would it be feasible to just import
> the mcc.h to ofono until a more generic solution is implemented?

I don't even like the fact that we imported it in ConnMan. That might
have been a mistake actually. I really prefer to have that on the
filesystem and we just mmap() it. And it is up to the distribution to
provide such a file.

We do a similar thing with OUI for BlueZ, so that is clearly the better
approach here.

Regards

Marcel



--===============7313679742996612751==--

