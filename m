Content-Type: multipart/mixed; boundary="===============7318468903915606080=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: trying to understand context creation
Date: Mon, 27 Feb 2012 09:30:30 -0800
Message-ID: <1330363830.3392.59.camel@aeonflux>
In-Reply-To: <CAHiDW_F06hjNRJuzNqCM3U1qinMmjOq35Dqp6wssGtL_4M8RbA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7318468903915606080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

> >> From a UI point of view, connman crashing and connman being stopped
> >> are 100% same -- the only thing the UI can do is inform the user that
> >> there is a critical  problem, so they won't just wait there expecting
> >> that Wifi AP to show up any moment now... I hope the users would never
> >> have to see that but they sometimes do.
> >
> > I would do this centralized with a system that monitors systemd status
> > and make sure that systemd restarts ConnMan properly. So that even if
> > something goes wrong, the user never really sees this. Unless it is like
> > a real fatal problem.
> >
> > But trying to handle this different than a restart of ConnMan is kinda
> > weird. I would not even bother. Especially since there is nothing you
> > can do about it anyway.
> =

> I was maybe not clear enough. I only handle the case of connman
> disappearing from the bus. And by "handle" I mean "tell the user there
> is a problem".

I am not sure even that is a good idea. I would expect just systemd to
restart connmand right away and you could just go on with it, but fair
enough.

> To be extra clear: I do not try to restart connman or ofono or
> anything stupid like that, I totally realize that's not for my
> component to do. The only thing I want to is to prevent user confusion
> about what they can do or cannot do at specific times. Exactly the
> same thing that I want to do when e.g. cellular services aren't
> appearing as expected or when they fail.
> =

> >> I'm not sure what you mean by "going out of my way". I either handle
> >> this situation or I don't. The same goes for ofono contexts that are,
> >> from my POV, broken.
> >
> > Why are they broken again?
> =

> I'm referring to the empty contexts I mentioned below. They are what I
> believe most ofono+mbpi users will get at the moment, and as far as I
> can tell they are useless, if not broken.

The initial context is actually there to make it a lot easier for the UI
to handle the APN setup. And checking for an empty APN is a fair thing
to do. If MBPI does not give us useful information, we are kinda
screwed.

And btw. the database/provision support in oFono is pluggable. We do not
have to use MBPI. It is just that nobody else has bothered to create
something better.

> >> >> We are in total agreement. I will gladly remove this whole UI when =
you
> >> >> or someone else with knowledge on this tells me that ofono + mbpi c=
an
> >> >> handle things. Likewise, if you tell me I can drop the manual setti=
ngs
> >> >> part and that won't harm many users, I will do it in a heart beat.
> >> >>
> >> >
> >> > I would guesstimate that it works in 90% of the cases today, the oth=
er
> >> > 5-9% are handled using a simple dialog.  If this is not the case, th=
en
> >> > we would like to know what is failing / not working.
> >> >
> >> > Dropping the settings UI is probably never going to be feasible, but=
 it
> >> > should be made into an avenue of last resort.  E.g. something that t=
he
> >> > user can be guided through by tech support at the carrier for instan=
ce.
> >> >  Not something that the user should ever see under 99% of circumstan=
ces.
> >>
> >> Let's work on this then -- that is my goal as well, but my
> >> understanding of current situation was just way grimmer: maybe I've
> >> missed some bit about how the provisioning works. This is my
> >> understanding:
> >>   * connman shows a cellular service for every internet context
> >>   * ofono creates a internet context for every modem that is capable
> >>   * if there are multiple APNs defined in mbpi for the carrier, the
> >> ofono context will be empy
> >>   * mbpi has lots and lots of carriers with multiple APNs, most of the
> >> big names I checked seem to have multiple ones.
> >>
> >> This seems to imply that by far the most common use case is this:
> >>   * user plugs in a new modem
> >>   * ofono creates an empty context (because of multiple APNs defined
> >> for carrier)
> >>   * connman shows a broken cellular service that does absolutely
> >> nothing -- it stays in "idle" forever and does not react to anything.
> >>
> >> You said 90% of the cases should just work -- where does this
> >> difference in experiences come from?
> >
> > As pointed out by Denis, the automated setup experience can only be as
> > good as your database. However it is not our job to install or create
> > the perfect APN list. That is an OEMs job and it depends on what kind of
> > quality and experience they wanna have.
> =

> I understand this.
> =

> I still have to provide a UI that works with the middleware we have
> and the mbpi we have.

Maybe at this point it is time to provide something better than MBPI,
but that is out of the scope for oFono actually.

> > Problem is that MBPI needs to be clearly improved. It is currently a
> > dumping ground for random information. And btw. neither Apple nor
> > Android gets this fully right. I have an ICS that keep resetting the APN
> > configuration as TIM Italy while network is Wind in Canada.
> >
> > So if you really care about ConnMan showing an empty cellular service,
> > then we can talk about adapting ConnMan to not bother showing that
> > service if the APN is empty.
> =

> I still feel like I must be missing something: you seem to imply that
> I should _not_ care about connman showing a non-working cellular
> service that appears to most cellular users? I don't think that is a
> real option.
> =

> If we have a way to make this work for ~95% of users -- yeah, I do
> want to do that. Not showing a service for empty internet contexts
> would seem to go a long way towards that goal, so I would be very
> happy with that.

As I said, we can just make ConnMan not show that service if the APN
setting from oFono is empty. Care to provide a patch for that?

Regards

Marcel



--===============7318468903915606080==--

