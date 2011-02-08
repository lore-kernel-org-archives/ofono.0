Content-Type: multipart/mixed; boundary="===============0382076369417666695=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: Re: [PATCH 1/4] nettime: Network time plugin implementation
Date: Tue, 08 Feb 2011 14:25:15 +0200
Message-ID: <1297167915.8586.7.camel@apaila-ThinkPad-T410>
In-Reply-To: <1297105120.1520.427.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0382076369417666695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Mon, 2011-02-07 at 10:58 -0800, ext Marcel Holtmann wrote:
> Hi Antti,
> =

> >  plugins/nettime.c |  326 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 files changed, 326 insertions(+), 0 deletions(-)
> >  create mode 100644 plugins/nettime.c
> =

> I would prefer if we call this nokia-timed.c or in case this actually
> becomes default part of MeeGo, them maybe meego-timed.c. I would be also
> fine with {nokia,meego}-nettime.c.
> =

> Just calling it nettime.c is too generic. It needs to be clear what this
> is for.
> =

> > +#define TIMED_PATH "/com/meego/time"
> > +#define TIMED_SERVICE "com.meego.time"
> =

> So the intention is to convert the Nokia timed into a MeeGo specific
> daemon? I would have expected to see com.nokia.timed here.

My understanding is that this will be Meego specific plugin since timed
is part of Meego. Hence, the service 'com.meego.timed'.  =


> > +struct nt_data {
> > +	gboolean time_available;
> > +	gboolean time_pending;
> > +	time_t nw_time_utc;
> > +	time_t received;
> > +	int dst;
> > +	int time_zone;
> > +	const char *mcc;
> > +	const char *mnc;
> =

> Why do you bother with these here. You might better just reference the
> netreg atom. The memory is only valid if netreg atom is present.

Timed expects to receive the mcc and mnc in the time notification.
However, if the mcc and mnc don't change we don't resend the
information. These fields contain the mnc and mcc that oFono sent
in the previous time notification.

Best Regards,
  Antti


--===============0382076369417666695==--

