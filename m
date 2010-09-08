Content-Type: multipart/mixed; boundary="===============1761578006419038418=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFCv3] Add message agent API
Date: Wed, 08 Sep 2010 18:52:58 +0200
Message-ID: <1283964778.6640.65.camel@localhost.localdomain>
In-Reply-To: <AANLkTimrsDCHVAyP-ZrjMEvv-o+X__qybDjhfA=Z009r@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1761578006419038418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> >> +             void RegisterAgent(object path, string type)
> >> +
> >> +                     Registers an agent to handle received messages.
> >> +
> >> +                     The object path defines the path of the agent th=
at
> >> +                     will be called when a message is ready to be
> >> +                     dispatched.  The type parameters accepts a MIME
> >> +                     type of the messages this agent is willing to
> >> +                     accept.  Some common types include:
> >> +
> >> +                             "text/plain" - Regular text messages
> >> +                             "text/x-vcard" - vCard objects
> >> +                             "text/calendar" - vCalendar objects
> >> +                             "application/vnd.oma.push" - WAP push
> >> +                             "application/x-sms-agent" - Any datagram
> >> +
> >> +                     Wildcards are not allowed as the MIME subtype, b=
ut
> >> +                     registering an agent on a generic port is suppor=
ted.
> >> +                     For instance, to listen on port 5678, the agent
> >> +                     would need to register using type:
> >> +
> >> +                             "application/x-sms-agent;port=3D5678"
> >
> > so my obvious question here is, what kind of x-sms-agent type
> > applications do you expect? The need for text, vcard, vcalendar and push
> > messages is pretty clear. I still haven't figured out what other
> > applications are out there that we want do support with this. Can you
> > please give us some concert examples.
> =

> Example: a voice and video over IP client that doesn't drain the
> battery in half a day. My server sends a wakeup over SMS on an
> incoming call.

isn't this most likely done better via WAP Push? Do you have any concert
specification of an VoIP client doing this as SMS datagram.

> Example: a device lock service. I send a binary SMS to my stolen phone
> on a well-known port containing a cryptographic token, causing my
> phone to lock and/or wipe itself clean.

I think this is clear example where it should be done as an oFono plugin
and not go via the user session.

> Fact is, SMS is still the most widely available and power-efficient
> rendezvous service on a mobile phone. It would be silly not to support
> it to its full potential.

Yes, SMS is nice, but I am trying to figure out what use cases we have
that are done inside the user session and where it makes no sense to
have a specific oFono plugin doing the proper task. Meaning what really
needs user interaction or requires an application for it.

I can only come up with some theoretical examples and potential
applications. I like to see some applications that exist right now and
use SMS in this way. That is my problem right now, I just can't find
them. Since you spent some time thinking about real uses, do you have
examples all existing application using SMS like this?

Keep in mind that SMS are actually causing costs and we have to protect
random application from sending or receiving random messages as well.

> > I think that everybody else has abandoned any other SMS message types.
> =

> Quite the contrary. Every other mobile telephony API out there that I
> know of has the ability to send and receive binary messages on an
> arbitrary port.

And is it actually in use. That telephony API can make coffee for me if
it likes to, but if I am not using it, why bother?

I am not against supporting binary SMS over D-Bus, but I am trying hard
to understand the use cases and failing right now. I really like to get
a clear picture of what is needed by the application and why.

We have been always asking these hard questions and justifying them with
real use cases. That is the only way to avoid a cluttered API where only
30% is actually used.

This doesn't mean in any way that binary SMS are not supported. That is
not true at all. They are supported via oFono plugins all ready and
should be supported that way. No questions asked. My question is driven
towards the D-Bus API and its users.

Regards

Marcel



--===============1761578006419038418==--

