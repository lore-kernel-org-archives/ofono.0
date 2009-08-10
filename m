Content-Type: multipart/mixed; boundary="===============5104657670945239245=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] Add a MessageWaiting interface to track message
 waiting indications.
Date: Mon, 10 Aug 2009 11:35:29 -0500
Message-ID: <200908101135.30188.denkenz@gmail.com>
In-Reply-To: <fb249edb0908062025y39be4855ub305387906d8ed92@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5104657670945239245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> 2009/8/5 Denis Kenzior <denkenz@gmail.com>:
> > Hi Andrew,
> >
> >> > For setting mailbox numbers, a working EF-MBDN is required since the
> >> > only alternative would be to store them on the filesystem.
> >>
> >> mw_set_indicator does the right thing, I missed this fact.  But when a
> >> mailbox number is set or received from network all clients get a
> >> PropertyChanged and the new number can be retrieved from the interface
> >> but only when the store succeeded, previously it would be available
> >> regardless of MBDN on the card and the writing to card was secondary.
> >> The number is kind of important if you want to hear the messages.
> >
> > So you're right that even if we get an enhanced voice mail notification
> > message the Mailbox number won't be signaled unless we have the SIM
> > provisioned with EF-MBI & EF-MBDN.
> >
> > The problem is, if we don't have the SIM files available, then the next
> > time oFono is restarted this information is lost anyway until the next
> > MWI notification arrives.  So you're back to not being able to dial the
> > mailbox.
> >
> > This is also an issue with the indications themselves.  If we don't have
> > EF- MWIS provisioned, the information is lost when oFono is restarted.
> >  So we're now inconsistent between MBDN/MWIS, so maybe we shouldn't
> > update them either in this case.
>
> True.  (or update them both in this case)
>
> It would make sense for the providers to resend the MWI information
> everytime subscriber connects the network and then it would be less
> problematic in case the information couldn't be written to SIM, but I
> don't know if they ever do this.

Probably they don't, there are also weird roaming cases to consider, where =
you =

receive MWI, turn phone off, step on a plane and turn phone on with some ot=
her =

network entirely.

Can we make the MWI interface smarter somehow?  Perhaps by not enabling it =

unless at least the EFmwis file is available, or by always storing the EFmw=
is =

contents on the filesystem?

Regards,
-Denis

--===============5104657670945239245==--

