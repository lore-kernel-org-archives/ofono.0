Content-Type: multipart/mixed; boundary="===============4035123263602609603=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/5] Call Counters (2nd)
Date: Sat, 11 Dec 2010 15:57:33 +0100
Message-ID: <1292079453.30085.44.camel@aeonflux.mpl.access-company.com>
In-Reply-To: <201012110157.04661.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4035123263602609603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > > > > Personally I think the every-10sec interval is too short.
> > > > > It's also highly system specific when wakeups start to get
> > > > > too costly, so picking up one value seems difficult.
> > > > =

> > > > My take here is that a granularity of 1 minute is enough.
> > > =

> > > There are definitely call fares with sub-minute granularity. The minu=
te
> > > is definitely INSUFFICIENT.
> > =

> > let me repeat my question here. Does this suppose to be represent spent
> > time on calls (what I called talk time) or actual billing minutes.
> =

> As said earlier, this is about the talk time. The scenario is a user ejec=
ts =

> the battery during an already long-standing call or gets the device to cr=
ash =

> or reset, gets billed, and comes and complain to its operator that (s)he =
gets =

> overcharged. The counters will be much more wrong if we do not flush them=
 to =

> disk frequently.
> =

> We do not need to "implement" the billing policy for that. This is only a=
bout =

> the total talk time.
> =

> > If we talk about correct billing minutes then you are just opening
> > pandora's box. Since we don't know the billing. And difference between
> > air time, incoming/outgoing calls, multiparty calls, hold calls etc. and
> > their billing schemes make this just insane.
> =

> Sure. We don't wants this.
> =

> > So what is the actual requirement here. So far ever single answer was
> > not satisfying. And that is why I proposed to just make this count the
> > talk time.
> =

> The requirement is that the user cannot deduct (much) talk time from the =
call =

> counters.

is actually everybody in agreement here that we talk about actual time
spent on the phone talking? Denis and myself clearly see it that this is
a sensible approach to overall call counters.

And if that is the case, then this maps closely to what PA has to track
anyway. The more and more we talk about this, the more and more it makes
sense to me to do this as a plugin to PA that stores the overall call
time values into Tracker. And then can also be reset via Tracker.

This would satisfy all my concern that I have from an process wakeup and
IO utilization overhead and battery consumption point of view.

> > > > Doing this every 10 seconds and displaying it on a per second level
> > > > sounds insane to me.
> > > =

> > > So I made a lengthy call to my mum this morning, using a desk phone. =
And
> > > it was showing minute:second, not just minutes. I have never seen a
> > > phone that does not show seconds and it would look pretty dumb to me.
> > =

> > You do realize that this is NOT the feature we are talking about here.
> > =

> > The actual display of the duration of a call is pretty simple and
> > currently easy to handle inside the UI. And that can be done up to the
> > millisecond display if you or your UI designer wants it.
> > =

> > The proposed call counters here are long term counters showing your
> > overall time. So showing minutes seems to be precise enough.
> =

> Showing minutes, as in flushing the counters every 60 seconds might work,=
 but =

> I'd rather make this a configurable knob.
> =

> That said, I do believe the stored value has to be more precise than minu=
tes. =

> Otherwise per call "error" may add up far too quickly.

I don't see this as a problem at all. This does not add up.

So if you loose 59 seconds in a 4 hours call, then that is pretty much
statistically irrelevant. And that is only the case if you magically
loose your battery.

In case you run out of battery or end the call properly, you will still
get the accurate counter to the second. Since the device management
daemon or oFono will inform you about it.

What you should really ask yourself is what you present to the user. If
you use your phone for 3 phone calls that are less than three seconds,
you might wanna display seconds. However in that case you have the
accurate counter when ending the call in the first place. If you loose
your battery and have not used the phone longer than a minute, why
bother. This is not the problem that needs to be solved.

If you spent something crazy like 60 hours on the phone per month and
then loose 59 seconds, it makes no difference either. At that point that
inaccuracy is statistically irrelevant and can be ignored. And again,
this is only a problem if you battery magically gets loose and flies
away. Otherwise you are accurate to the second.

So in conclusion having an IO sync of the ongoing call every 60 seconds
seems to be reasonable enough. And at the same time you keep a down to
the second call time in case of a healthy device.

With all this in mind. How often does someone magically loose the
battery and then goes complain to someone about a "big" difference in
the bills. Or is this more an esoteric feature request. Can we not try
to solve this sensible without going overboard and trying to solve world
hunger ;)

Regards

Marcel



--===============4035123263602609603==--

