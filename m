Content-Type: multipart/mixed; boundary="===============2595160578797780333=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/4] nettime: Network time plugin implementation
Date: Tue, 08 Feb 2011 07:46:30 -0800
Message-ID: <1297179990.1520.457.camel@aeonflux>
In-Reply-To: <1297167915.8586.7.camel@apaila-ThinkPad-T410>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2595160578797780333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

> > >  plugins/nettime.c |  326 +++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  1 files changed, 326 insertions(+), 0 deletions(-)
> > >  create mode 100644 plugins/nettime.c
> > =

> > I would prefer if we call this nokia-timed.c or in case this actually
> > becomes default part of MeeGo, them maybe meego-timed.c. I would be also
> > fine with {nokia,meego}-nettime.c.
> > =

> > Just calling it nettime.c is too generic. It needs to be clear what this
> > is for.
> > =

> > > +#define TIMED_PATH "/com/meego/time"
> > > +#define TIMED_SERVICE "com.meego.time"
> > =

> > So the intention is to convert the Nokia timed into a MeeGo specific
> > daemon? I would have expected to see com.nokia.timed here.
> =

> My understanding is that this will be Meego specific plugin since timed
> is part of Meego. Hence, the service 'com.meego.timed'.  =


this is fine with me, but so far the timed.git tree has nothing alike
this mentioned. It currently still uses com.nokia.timed.

> > > +struct nt_data {
> > > +	gboolean time_available;
> > > +	gboolean time_pending;
> > > +	time_t nw_time_utc;
> > > +	time_t received;
> > > +	int dst;
> > > +	int time_zone;
> > > +	const char *mcc;
> > > +	const char *mnc;
> > =

> > Why do you bother with these here. You might better just reference the
> > netreg atom. The memory is only valid if netreg atom is present.
> =

> Timed expects to receive the mcc and mnc in the time notification.
> However, if the mcc and mnc don't change we don't resend the
> information. These fields contain the mnc and mcc that oFono sent
> in the previous time notification.

But this const pointer points to memory inside netreg. It will never
change. It always points to the same address.

Regards

Marcel



--===============2595160578797780333==--

