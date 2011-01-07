Content-Type: multipart/mixed; boundary="===============9205651365375012898=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Fri, 07 Jan 2011 12:32:18 +0200
Message-ID: <1294396338.2602.20.camel@apaila-ThinkPad-T410>
In-Reply-To: <1294177770.5852.109.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9205651365375012898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, 2011-01-04 at 13:49 -0800, ext Marcel Holtmann wrote:
> Hi Aki,
> =

> > > > But then it is far simpler to have a D-Bus getter and a D-Bus signa=
l by any =

> > > > sane measure of complexity.
> > > =

> > > So you did consider the complexity on both sides, ofonod and timed? A=
nd
> > > not just looked at one side of picture?
> > =

> > Timed also needs to follow the registration status, namely the MNC/MCC
> > of the registered network.  This information it needs to be able to find
> > the correct timezone, as the UTC offset alone only indicates the
> > geographic longitude for the timezone.
> > =

> > Factor that in to the equation, and timed already needs to enumerate
> > available modems, call GetProperties, and listen to the
> > NetworkRegistration interface's PropertyChanged signals.
> > =

> > However, if we refactor the time plugin to also send the MNC/MCC pair --
> > or better yet, the ISO country code based on MCC or even the actual
> > timezone from matching zone.tab entry -- then following netreg is no
> > longer needed.
> > =

> > *Then* I agree a method call is actually a lot simpler from timed point
> > of view; all it needs to do is implement a single method on some
> > org.ofono.NetworkTimeConsumer interface and not worry about enumerating
> > modems via ModemManager or listening on any signals.
> =

> we are doing the country alpha2 matching to MCC already in ConnMan for
> the WiFi regulatory enforcement update. I am not sure that I wanna copy
> these tables around all the time.
> =

> So the struct ofono_nettime_context has already a reference to struct
> ofono_modem, so why not add a reference to the struct ofono_netreg and
> then you have the MCC/MNC details available inside the plugin.

If I would like to do conversion from mcc to alpha2 in ofono, what would
be your suggestion for doing this. I noticed that in connman you have
mcc.h that contains the mapping array, but in ofono we don't have such
an array. As a temporary solution, would it be feasible to just import
the mcc.h to ofono until a more generic solution is implemented?

Best Regards,
 Antti


--===============9205651365375012898==--

