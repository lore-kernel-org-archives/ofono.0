Content-Type: multipart/mixed; boundary="===============7421818612896054130=="
MIME-Version: 1.0
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: Re: trying to understand context creation
Date: Mon, 27 Feb 2012 15:20:45 +0200
Message-ID: <CAHiDW_F06hjNRJuzNqCM3U1qinMmjOq35Dqp6wssGtL_4M8RbA@mail.gmail.com>
In-Reply-To: <1330340049.3392.43.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7421818612896054130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2012 at 12:54 PM, Marcel Holtmann <marcel@holtmann.org> w=
rote:
>> From a UI point of view, connman crashing and connman being stopped
>> are 100% same -- the only thing the UI can do is inform the user that
>> there is a critical =C2=A0problem, so they won't just wait there expecti=
ng
>> that Wifi AP to show up any moment now... I hope the users would never
>> have to see that but they sometimes do.
>
> I would do this centralized with a system that monitors systemd status
> and make sure that systemd restarts ConnMan properly. So that even if
> something goes wrong, the user never really sees this. Unless it is like
> a real fatal problem.
>
> But trying to handle this different than a restart of ConnMan is kinda
> weird. I would not even bother. Especially since there is nothing you
> can do about it anyway.

I was maybe not clear enough. I only handle the case of connman
disappearing from the bus. And by "handle" I mean "tell the user there
is a problem".

To be extra clear: I do not try to restart connman or ofono or
anything stupid like that, I totally realize that's not for my
component to do. The only thing I want to is to prevent user confusion
about what they can do or cannot do at specific times. Exactly the
same thing that I want to do when e.g. cellular services aren't
appearing as expected or when they fail.

>> I'm not sure what you mean by "going out of my way". I either handle
>> this situation or I don't. The same goes for ofono contexts that are,
>> from my POV, broken.
>
> Why are they broken again?

I'm referring to the empty contexts I mentioned below. They are what I
believe most ofono+mbpi users will get at the moment, and as far as I
can tell they are useless, if not broken.

>> >> We are in total agreement. I will gladly remove this whole UI when you
>> >> or someone else with knowledge on this tells me that ofono + mbpi can
>> >> handle things. Likewise, if you tell me I can drop the manual settings
>> >> part and that won't harm many users, I will do it in a heart beat.
>> >>
>> >
>> > I would guesstimate that it works in 90% of the cases today, the other
>> > 5-9% are handled using a simple dialog. =C2=A0If this is not the case,=
 then
>> > we would like to know what is failing / not working.
>> >
>> > Dropping the settings UI is probably never going to be feasible, but it
>> > should be made into an avenue of last resort. =C2=A0E.g. something tha=
t the
>> > user can be guided through by tech support at the carrier for instance.
>> > =C2=A0Not something that the user should ever see under 99% of circums=
tances.
>>
>> Let's work on this then -- that is my goal as well, but my
>> understanding of current situation was just way grimmer: maybe I've
>> missed some bit about how the provisioning works. This is my
>> understanding:
>> =C2=A0 * connman shows a cellular service for every internet context
>> =C2=A0 * ofono creates a internet context for every modem that is capable
>> =C2=A0 * if there are multiple APNs defined in mbpi for the carrier, the
>> ofono context will be empy
>> =C2=A0 * mbpi has lots and lots of carriers with multiple APNs, most of =
the
>> big names I checked seem to have multiple ones.
>>
>> This seems to imply that by far the most common use case is this:
>> =C2=A0 * user plugs in a new modem
>> =C2=A0 * ofono creates an empty context (because of multiple APNs defined
>> for carrier)
>> =C2=A0 * connman shows a broken cellular service that does absolutely
>> nothing -- it stays in "idle" forever and does not react to anything.
>>
>> You said 90% of the cases should just work -- where does this
>> difference in experiences come from?
>
> As pointed out by Denis, the automated setup experience can only be as
> good as your database. However it is not our job to install or create
> the perfect APN list. That is an OEMs job and it depends on what kind of
> quality and experience they wanna have.

I understand this.

I still have to provide a UI that works with the middleware we have
and the mbpi we have.

> Problem is that MBPI needs to be clearly improved. It is currently a
> dumping ground for random information. And btw. neither Apple nor
> Android gets this fully right. I have an ICS that keep resetting the APN
> configuration as TIM Italy while network is Wind in Canada.
>
> So if you really care about ConnMan showing an empty cellular service,
> then we can talk about adapting ConnMan to not bother showing that
> service if the APN is empty.

I still feel like I must be missing something: you seem to imply that
I should _not_ care about connman showing a non-working cellular
service that appears to most cellular users? I don't think that is a
real option.

If we have a way to make this work for ~95% of users -- yeah, I do
want to do that. Not showing a service for empty internet contexts
would seem to go a long way towards that goal, so I would be very
happy with that.

- Jussi

--===============7421818612896054130==--

