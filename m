Content-Type: multipart/mixed; boundary="===============8585064914768993990=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] doc: Add experimental handsfree-audio API
Date: Wed, 20 Feb 2013 11:19:43 +0200
Message-ID: <20130220091943.GA17522@x220>
In-Reply-To: <CANT-zCXA0E-5MOu-KWu9HL=8e3BrPRavufd3cM3mY_-u3jaKvA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8585064914768993990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On Wed, Feb 20, 2013, Mikel Astiz wrote:
> > +Handsfree Audio Card hierarchy [experimental]
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Service                org.ofono
> > +Interface      org.ofono.HandsfreeAudioCard
> > +Object path    /{device0,device1,...}
> =

> I'd propose dropping this interface entirely or at least using the
> conventional modem object path, assuming that every HandsfreeAudioCard
> would necessarily have an associated modem.
> =

> After all, the Audio agent would typically have to match cards with
> modems, probably because the associated voicecall status needs to be
> known (e.g. if the HS wants to ignore the inband-ringing and instead
> use another ring tone).

What you describe would only cover the HF role of HFP but not AG. With
AG you can have multiple HF devices connected to you (hence multiple
"cards") while still having just one oFono modem object.

> > +Methods                dict GetProperties()
> > +
> > +                       Returns properties for the device object. See
> > +                       the properties section for available properties.
> > +
> > +               void Connect()
> > +
> > +                       Attempts to establish the SCO audio connection.
> > +                       The Agent NewConnection() method will be called
> > +                       whenever the SCO audio link has been establishe=
d.  If
> > +                       the audio connection could not be established, =
this
> > +                       method will return an error.
> =

> Isn't Disconnect() missing here? How would the agent release an SCO?

I think the idea was that the client can just use the shutdown() system
call.

> > +Handsfree Audio Agent hierarchy [experimental]
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Service                <freely defined>
> > +Interface      org.ofono.HandsfreeAudioAgent
> > +Object         <freely defined>
> > +
> > +Methods                void NewConnection(object card, fd sco, byte co=
dec)
> > +
> > +                       Notifies the handler that a new SCO connection =
is
> > +                       available. Returning an error will cause oFono =
to
> > +                       disconnect the SCO connection.
> =

> Same here. How would the agent receive a release-notification? Perhaps
> this would be implicit in the socket HUP?

I think that was the idea (but I'll let Denis clarify if I'm wrong).

> If so, I have some concerns about the potential race conditions. If
> SCO was closed and reopen immediately afterwards, the client could
> receive the (second) NewConnection before the HUP.
> =

> Besides, is this D-Bus API intended to support SCO-over-PCM as well?
> If yes, several considerations seems to be missing, specially
> regarding the socket fd. In particular, the HUP approach for
> disconnections would not be valid anymore.

I don't see why it would not be valid. Even if you do SCO over PCM the
SCO socket will give you the right connection state info since it's
hooked to the same connect and disconnect HCI events which occur
regardless of how you route the SCO data.

Johan

--===============8585064914768993990==--

