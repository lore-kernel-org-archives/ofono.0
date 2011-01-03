Content-Type: multipart/mixed; boundary="===============4504932813869352861=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2] plugin: Add ste modem initd integration
Date: Mon, 03 Jan 2011 14:54:36 -0800
Message-ID: <1294095276.5852.48.camel@aeonflux>
In-Reply-To: <AANLkTi=4GrWaC7OiYEyM=4C=C3NYn0Vob70-CMmnUvWj@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4504932813869352861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> >> Signals       StateChange(string State)
> >>
> >>                       The modems state sent from when
> >>                       a modem state change occurs. State is the only
> >>                       dynamic property in this Interface.
> >
> >I would personally just go straight for PropertyChanged signal here and
> >not bother with StateChanged. It is actually "...Changed" since at that
> >time the state has already changed ;)
> =

> OK, I'll look into this. I thought StateChange was the only dynamic param=
eter,
> but I might have been wrong here (see below).
> =

> > You also need the following signals:
> >
> >        ModemAdded(object, dict)
> >
> >        ModemRemoved(object)
> =

> I think I'd rather add this when I see a use case for it. The Modem
> Init Deamon would need to
> know what GPIOs are associated with what modems, and what CAIF
> interfaces to use etc.
> This information is not dynamic, at least not at the moment. So
> ModemAdded and ModemRemoved
> will not happen in the current implementation, all the modems will be
> known when the Manager
> interface becomes available.

what about potential USB based CAIF devices?

> ...
> >>               string CaifAtInterface [readonly]
> >>
> >>                       CAIF Link Layer interface to be used for
> >>                       AT channels for a modem.
> >
> > I would really just call this "Interface" to make it simpler. Don't
> > think that you are expecting more than just CAIF interface here anyway.
> =

> OK, Fair enough.
> =

> > And in addition if we can have the modem serial number here as "Serial"
> > as well would be good. Even it is is not right away available, you can
> > signal a change via PropertyChanged signal.
> >
> > That way we can construct a proper modem object path inside oFono. I
> > really rather use the serial number and only fallback to the interface
> > name.
> >
> =

> OK, a Serial property is doable, but I think this is only available
> after state "on" (ready)

That is fine. We have the same case in oFono that the SubscriberIdentity
only becomes available a bit later. That is in the end easy to handle.

I would just ask to send the property changed signal for the serial
number before sending the signal for on/ready.

> has been reached. The drawback is that my assumption of State being the o=
nly
> dynamic property wrong.
> Crap you were right - I might need to add a PropertyChanged signal.

This way you are a lot more flexible in the future.

Regards

Marcel



--===============4504932813869352861==--

