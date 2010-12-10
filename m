Content-Type: multipart/mixed; boundary="===============7449422079140536091=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 0/5] Call Counters (2nd)
Date: Fri, 10 Dec 2010 19:57:51 +0200
Message-ID: <201012101957.51512.remi.denis-courmont@nokia.com>
In-Reply-To: <1291935199.30085.7.camel@aeonflux.mpl.access-company.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7449422079140536091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 10 December 2010 00:53:19 ext Marcel Holtmann, you wrote:
> > > this is not really true. We can not wakeup ofonod every single second.
> > > You might wanna start running powertop.

Yes we can. PulseAudio is going to be waking up the CPU 10 times per second=
s =

or more.

> > uhm, but I'm not claiming that. I was just stating that moving
> > the timers to e.g. pulseaudio in this case won't save much if
> > anything (the CPU will be woken up anyways, and the cost between
> > scheduling ofonod or a thread from PA, has really no difference
> > to overall consumption.. the CPU is woken up anyways and roughly
> > the same code to handle the timer is run).
> > =

> > So whether this code is in oFono or elsewhere, does not matter
> > much (to overall power consumption). The main question is of course
> > how often the counters are synced.
> =

> actually it does matter since you have no extra context switch and in
> addition you not accidentally wake up PA and then ofonod. You have one
> centralized wakeup of one thread.

No! The one extra context switch is negligible compared to the several few =

system calls that updating the call counter requires. And as Kai already sa=
id, =

the CPU will wake up anyway.

The real power consumption difference lies in the I/O, which would not happ=
en =

if it weren't for fault-tolerant call counters. In that respect, which proc=
ess =

writes, PulseAudio, oFono, or something else, is irrelevant.

> Of course this should be smart and done along with the PA audio
> processing and not async to that one.

No. PulseAudio has no business with the call counters. It might not know th=
at =

it is a call. And even if it did know, it might not know whether the call i=
s =

ringing or connected.

oFono on the other hand has the informations. Also, if we gave up on fault =

tolerance to save power, oFono would be the logical place to provide call =

counters (through D-Bus). So it only makes sense that oFono does this - if =

anyone.

And then, it's our nor your decision to make how often (if at all) the call =

counters need to be flushed to the memory card. That's a matter for the =

vendor's legal & liability departement. So it really just needs to be =

configurable, including the ability to disable the feature altogether if it=
 is =

not needed.

> If we consider that the only sensible thing is to track the actual
> talking time, then PA becomes a nice choice for this.

I don't think so.

> This doesn't mean that you should be implementing it, but I am still
> maintaining that this would be a pretty damn smart way of solving this
> efficiently.
> =

> > Personally I think the every-10sec interval is too short.
> > It's also highly system specific when wakeups start to get
> > too costly, so picking up one value seems difficult.
> =

> My take here is that a granularity of 1 minute is enough.

There are definitely call fares with sub-minute granularity. The minute is =

definitely INSUFFICIENT.

> Doing this every 10 seconds and displaying it on a per second level
> sounds insane to me.

So I made a lengthy call to my mum this morning, using a desk phone. And it =

was showing minute:second, not just minutes. I have never seen a phone that =

does not show seconds and it would look pretty dumb to me.

But of course, that's a matter for UI designers, not for middleware oFono =

software engineers anyway.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============7449422079140536091==--

