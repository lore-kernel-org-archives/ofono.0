Content-Type: multipart/mixed; boundary="===============5425735000360675360=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 0/5] Call Counters (2nd)
Date: Thu, 09 Dec 2010 23:53:19 +0100
Message-ID: <1291935199.30085.7.camel@aeonflux.mpl.access-company.com>
In-Reply-To: <725063E4C37388418CDDC5A2C287906A20D08A1DCE@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5425735000360675360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kai,

> >> I share the concern for the IO/CPU cost, but I don't think it
> >> matters much in which daemon this is done. Especially if some slack
> >> is> allowed for the timers (which should be the case), ofonod will be
> >> scheduled when the CPU is anyways woken up (e.g. modem/audio interrupt=
s =

> >> wake up pulseaudio). =

> >
> > this is not really true. We can not wakeup ofonod every single second.
> > You might wanna start running powertop.
> =

> uhm, but I'm not claiming that. I was just stating that moving =

> the timers to e.g. pulseaudio in this case won't save much if =

> anything (the CPU will be woken up anyways, and the cost between =

> scheduling ofonod or a thread from PA, has really no difference
> to overall consumption.. the CPU is woken up anyways and roughly
> the same code to handle the timer is run).
> =

> So whether this code is in oFono or elsewhere, does not matter
> much (to overall power consumption). The main question is of course =

> how often the counters are synced.

actually it does matter since you have no extra context switch and in
addition you not accidentally wake up PA and then ofonod. You have one
centralized wakeup of one thread.

Of course this should be smart and done along with the PA audio
processing and not async to that one.

If we consider that the only sensible thing is to track the actual
talking time, then PA becomes a nice choice for this.

This doesn't mean that you should be implementing it, but I am still
maintaining that this would be a pretty damn smart way of solving this
efficiently.

> Personally I think the every-10sec interval is too short.
> It's also highly system specific when wakeups start to get =

> too costly, so picking up one value seems difficult.

My take here is that a granularity of 1 minute is enough.

Doing this every 10 seconds and displaying it on a per second level
sounds insane to me.

Regards

Marcel



--===============5425735000360675360==--

