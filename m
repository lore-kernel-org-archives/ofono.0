Content-Type: multipart/mixed; boundary="===============3611985036984844466=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] Add agent API to message atom
Date: Tue, 31 Aug 2010 08:37:40 -0400
Message-ID: <1283258260.7452.13.camel@localhost.localdomain>
In-Reply-To: <AANLkTi=Sbv=KB5gTCN4dd-iaF=y7gT-r3mJ_FvkgRk+3@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3611985036984844466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> >> +             void RegisterApplicationAgent(object path, uint dest, ui=
nt src)
> >> +
> >> +                     Registers an agent to receive application messag=
es.
> >> +
> >> +                     The object path defines the path of the agent th=
at
> >> +                     will be called when an application message is re=
ady
> >> +                     to be dispatched.
> >> +
> >> +                     The dest parameter is the destination application
> >> +                     port number, and the src parameter is the option=
al
> >> +                     source application port number.
> >> +
> >> +                     Possible Errors: [service].Error.InvalidArguments
> >> +                                      [service].Error.InvalidFormat
> >> +                                      [service].Error.InUse
> >> +
> >> +             void UnregisterAgent(object path)
> >> +
> >> +                     Unregisters an agent.  If no agent is registered
> >> +                     that matches the type of an arriving message, it=
 is
> >> +                     silently dropped.
> >> +
> >> +                     Possible Errors: [service].Error.InvalidArguments
> >> +                                      [service].Error.InvalidFormat
> >> +                                      [service].Error.NotFound
> >> +                                      [service].Error.NotAuthorized
> >> +
> >
> > I prefer if we can do a RegisterAgent and UnregisterAgent like we have
> > in the STK interface. This makes it a lot more consistent throughout the
> > whole oFono APIs.
> =

> Ok.
> =

> > This of course means that we need a bit more intelligent matching of the
> > handled types. In general I am against the overhead of regex for this. I
> > prefer glob style matching with just * and ?. That should be good
> > enough. If you really need regex pattern matching then then I think a
> > specialized oFono plugin with its own APIs is the way to go.
> =

> This was basically what I was thinking, too, with the addition of ^
> and $ for matching at the end or beginning of a message.

within GLib we have glob pattern matching functions, but nothing that
additionally takes ^ and $. Why do you think this would be useful and
needed? How many message agents to you expect to be running that are not
using port numbers? Do you have some examples messages in mind?

> >> +Methods              void ImmediateMessage(string message, dict info)
> >> +
> >> +                     New immediate (class 0) SMS received.  Info has =
Sender,
> >> +                     LocalSentTime, and SentTime information.  Sender
> >> +                     address is given in string format.  LocalSentTim=
e and
> >> +                     SentTime are given in string form using ISO8601 =
format.
> >
> > Should these really be delivered via an agent?
> =

> Why not?

These class 0 message are special and I think the home screen applet can
just use the current D-Bus signal to deal with them. I don't think that
we need special handling for them.

> >> +             void IncomingMessage(string message, dict info)
> >> +
> >> +                     New incoming text SMS received.  Info has Sender,
> >> +                     LocalSentTime, and SentTime information.
> >> +
> >> +             void IncomingPush(array{byte} message, dict info)
> >> +
> >> +                     New incoming push message received.  Info has Se=
nder,
> >> +                     LocalSentTime, SentTime, and ApplicationId infor=
mation.
> >> +
> >> +             void IncomingApplication(array{byte} message, dict info)
> >> +
> >> +                     New incoming application message received.  Info=
 has
> >> +                     Sender, LocalSentTime, SentTime, DestinationPort=
, and
> >> +                     SourcePort information.
> >
> > Why the difference between Push and Application. The dict could be
> > easily used here to differentiate.
> =

> True. And in fact we discussed this in IRC with Denis a bit and
> decided that separating WAP push makes little sense overall. If the
> agent needs to decode the WSP anyway, we're not providing much value
> add in oFono just decoding the X-Wap-Application-Id header field. So
> the agent might as well just use the application ports to register.

Personally I like the idea of doing the whole WSP decoding inside oFono,
but if we have WAP Push over IP transport and the WAP Push daemon has to
do the decoding again anyway, this seems to be not a good idea.

Regards

Marcel



--===============3611985036984844466==--

