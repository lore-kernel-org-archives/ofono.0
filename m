Content-Type: multipart/mixed; boundary="===============0297767891596021644=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 0/5] Call Counters (2nd)
Date: Sat, 11 Dec 2010 01:57:04 +0200
Message-ID: <201012110157.04661.remi.denis-courmont@nokia.com>
In-Reply-To: <1292006087.30085.25.camel@aeonflux.mpl.access-company.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0297767891596021644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 10 December 2010 20:34:47 ext Marcel Holtmann, you wrote:
> Hi Remi,
> =

> > > > Personally I think the every-10sec interval is too short.
> > > > It's also highly system specific when wakeups start to get
> > > > too costly, so picking up one value seems difficult.
> > > =

> > > My take here is that a granularity of 1 minute is enough.
> > =

> > There are definitely call fares with sub-minute granularity. The minute
> > is definitely INSUFFICIENT.
> =

> let me repeat my question here. Does this suppose to be represent spent
> time on calls (what I called talk time) or actual billing minutes.

As said earlier, this is about the talk time. The scenario is a user ejects =

the battery during an already long-standing call or gets the device to cras=
h =

or reset, gets billed, and comes and complain to its operator that (s)he ge=
ts =

overcharged. The counters will be much more wrong if we do not flush them t=
o =

disk frequently.

We do not need to "implement" the billing policy for that. This is only abo=
ut =

the total talk time.

> If we talk about correct billing minutes then you are just opening
> pandora's box. Since we don't know the billing. And difference between
> air time, incoming/outgoing calls, multiparty calls, hold calls etc. and
> their billing schemes make this just insane.

Sure. We don't wants this.

> So what is the actual requirement here. So far ever single answer was
> not satisfying. And that is why I proposed to just make this count the
> talk time.

The requirement is that the user cannot deduct (much) talk time from the ca=
ll =

counters.

> > > Doing this every 10 seconds and displaying it on a per second level
> > > sounds insane to me.
> > =

> > So I made a lengthy call to my mum this morning, using a desk phone. And
> > it was showing minute:second, not just minutes. I have never seen a
> > phone that does not show seconds and it would look pretty dumb to me.
> =

> You do realize that this is NOT the feature we are talking about here.
> =

> The actual display of the duration of a call is pretty simple and
> currently easy to handle inside the UI. And that can be done up to the
> millisecond display if you or your UI designer wants it.
> =

> The proposed call counters here are long term counters showing your
> overall time. So showing minutes seems to be precise enough.

Showing minutes, as in flushing the counters every 60 seconds might work, b=
ut =

I'd rather make this a configurable knob.

That said, I do believe the stored value has to be more precise than minute=
s. =

Otherwise per call "error" may add up far too quickly.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============0297767891596021644==--

