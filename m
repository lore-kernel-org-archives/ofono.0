Content-Type: multipart/mixed; boundary="===============3131785151605751183=="
MIME-Version: 1.0
From: Patrik Flykt <Patrik.Flykt@linux.intel.com>
Subject: Re: Unable to reconnect to 3G network after
Date: Thu, 13 Mar 2014 10:04:57 +0200
Message-ID: <1394697897.15951.63.camel@pflykt-mobl1>
In-Reply-To: <CAK+sfosv5Pg1YVkwXxPWrSoz+djJhEYR=Qyrn2yHxG9k0rsYCA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3131785151605751183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2014-03-12 at 15:27 +0000, Homam Dabis wrote:
> Patirk,
> =

> Issue seems to be that ofono does not activate the context when I re-inse=
rt
> the Huawei E303 3G dongle.
> =

> ofono log gives:
> =

> "/ofono-1.14/src/gprs.c:pri_activate_callback() Activating context failed
> with error: Unknown error type"
> =

> If you have any suggestions then great.
> =

> Homam

As this is happening in oFono, let's take the discussion to the ofono
ml.

Cheers,

	Patrik

> > Date: Wed, 12 Mar 2014 09:59:54 +0200
> > From: Patrik Flykt <Patrik.Flykt@linux.intel.com>
> > To: connman(a)connman.net
> > Subject: Re: Unable to reconnect to 3G network after
> >         removing/reinserting a dongle
> > Message-ID: <1394611194.15951.39.camel@pflykt-mobl1>
> > Content-Type: text/plain; charset=3D"UTF-8"
> >
> >
> >         Hi,
> >
> > On Mon, 2014-03-10 at 16:21 +0000, Homam Dabis wrote:
> > > Hi,
> > >
> > > I am using connman 1.20, ofono 1.14 and linux 2.6.35.
> > >
> > > I have a Huawei 3G USB dongle that I use to connect to a particular A=
PN.
> > >
> > > I can connect OK. However, if I remove the dongle and reinsert it, The
> > > process fails at the connect to service stage. I did some debugging a=
nd
> > it
> > > seems that the APN is not being set properly by ofono.
> > >
> > > If I restart either ofonod or connmand then all is ok.
> > >
> > > Do I need to perform a reconfigure or something like that?
> >
> > All should just work, and connman should pick up the network. If you run
> > connman with debugs enabled, i.e. 'connmand -d plugins/ofono.c', do you
> > see any messages containing AccessPointName followed by the APN string?
> > If not, it means ofono isn't sending the APN information.
> >
> >
> > Cheers,
> >
> >         Patrik



--===============3131785151605751183==--

