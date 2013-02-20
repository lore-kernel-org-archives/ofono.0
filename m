Content-Type: multipart/mixed; boundary="===============5718397515390734293=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: Re: [PATCH] doc: Add experimental handsfree-audio API
Date: Wed, 20 Feb 2013 12:04:41 +0100
Message-ID: <CANT-zCWRxEiYLNV07fsm6xfV8s+kDHE9dsgxrq8SmxOamLWzgQ@mail.gmail.com>
In-Reply-To: <20130220091943.GA17522@x220>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5718397515390734293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Wed, Feb 20, 2013 at 10:19 AM, Johan Hedberg <johan.hedberg@gmail.com>=
 wrote:
> Hi Mikel,
>
> On Wed, Feb 20, 2013, Mikel Astiz wrote:
>> > +Handsfree Audio Card hierarchy [experimental]
>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> > +
>> > +Service                org.ofono
>> > +Interface      org.ofono.HandsfreeAudioCard
>> > +Object path    /{device0,device1,...}
>>
>> I'd propose dropping this interface entirely or at least using the
>> conventional modem object path, assuming that every HandsfreeAudioCard
>> would necessarily have an associated modem.
>>
>> After all, the Audio agent would typically have to match cards with
>> modems, probably because the associated voicecall status needs to be
>> known (e.g. if the HS wants to ignore the inband-ringing and instead
>> use another ring tone).
>
> What you describe would only cover the HF role of HFP but not AG. With
> AG you can have multiple HF devices connected to you (hence multiple
> "cards") while still having just one oFono modem object.

I see the point now.

However, I still see some value in having a more coupled relation
between modems and audio-cards, beyond the RemoteAddress/LocalAddress
pair. This is specially interesting for the HS role, since otherwise
both modems and audio-cards need to be tracked and matched.

The two roles might actually need to be separated. After all, there
are some fundamental differences: audio-cards representing a remote
gateway would be statically associated to a modem. Actually the modem
*represents* this device, so signals such as CardAdded/CardRemoved
provide little value.

On the other hand, audio-cards representing remote headsets are more
dynamic: they come and go depending on the number of paired headsets
(or more likely, the connected ones - it's not clear what "attached"
means in the doc).

One possibility would be to register HandsfreeAudioCard in the modem
object path for the HS role (as I proposed before) and dynamically
register the necessary objects for the AG role. In the later case, the
connected headsets could be announced as in Denis' original proposal
(perhaps renamed to HeadsetAdded/HeadsetRemoved).

The ability to distinguish HS and AG roles in the client's side is
desirable (at least PulseAudio heavily depends on this information).
So even if the proposal above is not accepted, at least the role
(UUID) would have to be exposed somehow.

>
>> > +Methods                dict GetProperties()
>> > +
>> > +                       Returns properties for the device object. See
>> > +                       the properties section for available propertie=
s.
>> > +
>> > +               void Connect()
>> > +
>> > +                       Attempts to establish the SCO audio connection.
>> > +                       The Agent NewConnection() method will be called
>> > +                       whenever the SCO audio link has been establish=
ed.  If
>> > +                       the audio connection could not be established,=
 this
>> > +                       method will return an error.
>>
>> Isn't Disconnect() missing here? How would the agent release an SCO?
>
> I think the idea was that the client can just use the shutdown() system
> call.
>
>> > +Handsfree Audio Agent hierarchy [experimental]
>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> > +
>> > +Service                <freely defined>
>> > +Interface      org.ofono.HandsfreeAudioAgent
>> > +Object         <freely defined>
>> > +
>> > +Methods                void NewConnection(object card, fd sco, byte c=
odec)
>> > +
>> > +                       Notifies the handler that a new SCO connection=
 is
>> > +                       available. Returning an error will cause oFono=
 to
>> > +                       disconnect the SCO connection.
>>
>> Same here. How would the agent receive a release-notification? Perhaps
>> this would be implicit in the socket HUP?
>
> I think that was the idea (but I'll let Denis clarify if I'm wrong).
>
>> If so, I have some concerns about the potential race conditions. If
>> SCO was closed and reopen immediately afterwards, the client could
>> receive the (second) NewConnection before the HUP.
>>
>> Besides, is this D-Bus API intended to support SCO-over-PCM as well?
>> If yes, several considerations seems to be missing, specially
>> regarding the socket fd. In particular, the HUP approach for
>> disconnections would not be valid anymore.
>
> I don't see why it would not be valid. Even if you do SCO over PCM the
> SCO socket will give you the right connection state info since it's
> hooked to the same connect and disconnect HCI events which occur
> regardless of how you route the SCO data.

You're right, I thought no socket would exist in this scenario, but
that's not the case. So my point was not valid.

Cheers,
Mikel

--===============5718397515390734293==--

