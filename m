Content-Type: multipart/mixed; boundary="===============0838360252825039165=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: Re: [PATCH] doc: Add experimental handsfree-audio API
Date: Wed, 20 Feb 2013 17:50:32 +0100
Message-ID: <CANT-zCUEjKtZV05j4hzSDUm9mD+-HOgokDOMrtHR6HHi9XJ-1Q@mail.gmail.com>
In-Reply-To: <5124EF80.2060606@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0838360252825039165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, Feb 20, 2013 at 4:45 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Mikel,
>
>
>> However, I still see some value in having a more coupled relation
>> between modems and audio-cards, beyond the RemoteAddress/LocalAddress
>> pair. This is specially interesting for the HS role, since otherwise
>> both modems and audio-cards need to be tracked and matched.
>>
>> The two roles might actually need to be separated. After all, there
>> are some fundamental differences: audio-cards representing a remote
>> gateway would be statically associated to a modem. Actually the modem
>> *represents* this device, so signals such as CardAdded/CardRemoved
>> provide little value.
>>
>
> This API is meant specifically for PA or another Audio subsystem.  What y=
ou
> want to be tracking and cross-referencing I'm not quite sure of.

I already mentioned one example: if a headset wants to ignore the
inband ringtone, and use it's own custom one, it needs to match the
audio-card and the voicecall state. During the ringtone (callsetup=3D1),
the SCO stream would be ignored, as suggested in section 4.13.4 of the
spec.

I could list more examples too if needed, but they would involve
multiple connected AGs.

According to this API, the audio subsystem would have to find the
relevant modem by comparing the remote BT address of the audio-card
with the serial number of the modems. This is not very nice, not to
mention that the serial number doesn't expose the adapter's BT adress.
So I think having an object path to the modem would be preferable, or
as discussed, even registering the interface in the modem's object
path.

>
>
>> On the other hand, audio-cards representing remote headsets are more
>> dynamic: they come and go depending on the number of paired headsets
>> (or more likely, the connected ones - it's not clear what "attached"
>> means in the doc).
>
>
> In practice, attached means an established SLC connection.
>
>
>>
>> One possibility would be to register HandsfreeAudioCard in the modem
>> object path for the HS role (as I proposed before) and dynamically
>> register the necessary objects for the AG role. In the later case, the
>> connected headsets could be announced as in Denis' original proposal
>> (perhaps renamed to HeadsetAdded/HeadsetRemoved).
>>
>
> Perhaps, but why would you be using this API and not one from PA?

I'm not following here. My proposal is concerning how a
client/audio-agent would be implemented, so all my comments above were
trying to improve the API in order to simplify client code.

Not that I agree with the idea of re-engineering the Media API, but anyway.=
..

>
>
>> The ability to distinguish HS and AG roles in the client's side is
>> desirable (at least PulseAudio heavily depends on this information).
>> So even if the proposal above is not accepted, at least the role
>> (UUID) would have to be exposed somehow.
>>
>
> The type information was left out on purpose from this proposal.  Likely =
it
> is necessary, but for the initial phase it does not seem relevant.  I also
> have yet to hear concise and clear summary on the utility of providing th=
is
> information.

I can summarize PulseAudio's case. The current policies slightly
differ in the way SCO is handled. The HS role is more passive,
accepting remote SCO connections and releases. The AG, on the other
hand, initiates an SCO connection as soon as some audio starts
streaming, or the user sets the card's profile to "hsp" manually.

The HS role currently switches between HSP/HFP and A2DP automatically.
So if SCO starts streaming, the profile is switched and the audio gets
routed. This is not the case for the AG role (desktop use-case) where
no automatic switch exists and the user-setting applies. I believe
this shouldn't be necessary in the long term, if the routing problem
was solved, but that alone is a big topic.

Finally, PA exposes per-profile information in the UI, so the user
actually distinguishes AG and HS roles. So if you pair a Nokia support
both profiles, you would see them both in the UI. I guess this could
be changed, but not without a controversial discussion. Even several
BlueZ developers have argued that this information is very convenient
for development and testing.

Note that the HSP vs HFP difference is not relevant, so I'm just
talking about separating AG vs HS roles.

>
>>>> If so, I have some concerns about the potential race conditions. If
>>>> SCO was closed and reopen immediately afterwards, the client could
>>>> receive the (second) NewConnection before the HUP.
>>>>
>
> You are going over-the-air vs local machine.  I really do not see this ev=
er
> happening.  But even if it does, is this really a hard problem for the Ag=
ent
> to deal with?

I think it would be quite obscure to assume that the previous socket
will HUP shortly after this second NewConnection is received. So if
this approach is encouraged, I'd expect some reference in the doc.

Cheers,
Mikel

--===============0838360252825039165==--

