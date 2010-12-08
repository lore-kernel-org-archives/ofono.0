Content-Type: multipart/mixed; boundary="===============4211507490402541191=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/5] Call Counters (2nd)
Date: Wed, 08 Dec 2010 23:32:14 +0100
Message-ID: <1291847534.4795.200.camel@aeonflux>
In-Reply-To: <4CFFC0B2.5000600@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4211507490402541191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,
       =

> >> The call counters are shown to the user when he or she opens up
> >> an application/applet whatever UI component that is meant for
> >> showing this information.
> >>      =

> > do we have a clear use case requirement from an UI point of view on how
> > this is expected to be working.
> >    =

> In our case, it is expected to have the counters information shown to the
> user continuously updated with about 1 second granularity, as long as the
> user keeps opened the UI showing the counters. This practically means
> "live" call counters in the UI.

are your interaction designers aware of that users wanna use their phone
for making phone calls and not watching call counters increasing every
single second?

My iPhone has a granularity of 1 minute and I actually had to go out of
my normal calling behavior to watch that counter. And it does not update
actually during the call. It only updates when the call end.

And just to be clear here. Calling a D-Bus method every single second is
not acceptable. That is a sure way to drain you battery.

> > I checked with my iPhone and how it does it. Basically it just updates
> > after the call and only after you re-entered that menu.
> >
> > So here again, do we have a requirement to make this realtime or not.
> > And I mean that from an user interaction point of view.
> >
> >    =

> >> Coming to the reliability part, saving the call counters information
> >> often enough, gives us sort of hard guarantee that whatever happens
> >> with any subsystem, be that SW or HW, the call counters will stay enou=
gh
> >> accurate. Syncing to the permanent storage, based on our product
> >> requirements, should take place in fact every 5 sec, or could be
> >> configurable.
> >>      =

> > Writing and syncing something to disk every 5 seconds costs us IO. Is
> > this really a sacrifice that is acceptable.
> >
> >    =

> I agree, from pure technical point of view it's a costly operation.

So here is my problem with this whole idea. How much do you care about
battery life and call time?

You keep waking up ofonod during the call (which is not needed) and you
keep the IO active. So from how I am looking at this problem, ofonod is
the wrong place to solve this.

> >> There might be some liability issues if for some reason the counters w=
ould
> >> "loose" time, the user my blame the phone manufacturer for the extra
> >> expenses incurred by inaccurate counters.
> >>      =

> > To be honest the counters can not be considered accurate anyway. Only
> > the billing system has the final say.
> >    =

> I think any info we decide to show to the user has to be accurate enough,
> otherwise becomes meaningless.

Even if we entertain this for a bit, does a user really care about
seconds of overall call time. For a single call, maybe, but for your
overall call time. Is minutes not enough? How accurate does this really
have to be?
       =

> >> We can discuss the place of the call counters plugin, but I think usin=
g the
> >> ofono history framework is a reasonable choice, with the note that the=
 it
> >> needs to be expanded with a history function called in the beginning
> >> of a call.
> >> The call counters plugin could be an optionally compiled/included (dyn=
amic)
> >> plugin or "downgraded" to experimental status.
> >>      =

> > So I am actually thinking that doing that inside PulseAudio is a lot
> > more efficient solution.
> >
> > The idea is that PA already runs in the user session and has to monitor
> > the uplink/downlink state (and additionally could monitor call states as
> > well if needed). So it knows when a call is active and it is active
> > anyway doing the audio processing. So it could just then go ahead and
> > write your call accounting into Tracker.
> >
> > Would such an architecture work for you guys?
> >    =

> I don't know at the moment whether this solution is good and elegant
> enough, we need to think about it.

Please think about this. While not obvious at first, it seems pretty
much reasonable to me. PA will be most likely active anyway.

However here is one thing that is unclear to me. Are we tracking talk
time or call time. In case of call time, how do we deal with multiparty
calls etc. Is a call on hold equals double time and so on.

So does this have to reflect billed time or actual time spent talking on
the phone.

I am really missing a well defined features requirement from top to
bottom with these details explained.

> >>>> The reason these are not properties is just because it makes no sense
> >>>> to update the counters "live". The UI can poll if it so wishes, but
> >>>> the poll interval is not something we want to decide.
> >>>>
> >>>>
> >>>>          =

> >>>>> What are the granularity there. What is the expected user experience
> >>>>> with this API. I don't see any clear usage model here.
> >>>>>
> >>>>> In addition to that, what is the problem with just updating the sta=
ts
> >>>>> after the call has ended?
> >>>>>
> >>>>>            =

> >>>> Because if your battery runs out in the middle of a 4 hour conference
> >>>> call, your timers are not updated and become worthless. Obviously,
> >>>> this is a compromise between how reliable the counters are and how
> >>>> many wakeups and IO we can bear.
> >>>>
> >>>>          =

> >>> I think this is not a good idea to have oFono handles this. Why can't
> >>> the system daemon just shutdown all calls when the battery reaches
> >>> critical limit.
> >>>
> >>> You will never fully run down the battery anyway. One of the system
> >>> health components in the system will prevent it and then can cleanly
> >>> shutdown oFono and thus all calls. The only case where the system cou=
ld
> >>> potentially misfunction in this area would be an emergency call. But
> >>> that is a total different use case anyway.
> >>>
> >>>        =

> >> It was already pointed out by Mika Liljeberg there could be cases when=
 we
> >> might not get the chance to sync our data. We need to be prepared to c=
ope
> >> with such cases as well (syncing the data often "enough").
> >>      =

> > Are these cases are really real life problems. For example with devices
> > moving toward hotswap SIM cards, the exchange of battery and
> > accidentally (or on purpose) removal seems to become more and more
> > unrealistic.
> >    =

> Probably this whole data reliability issue shouldn't be an oFono concern
> after all, there must be a backend doing that and not only for oFono
> data but any other highly important data.

I would highly recommend against making oFono responsible here. Since
the ofonod process should be mostly sleeping during a voice call and not
being busy with IO.

Regards

Marcel



--===============4211507490402541191==--

