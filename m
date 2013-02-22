Content-Type: multipart/mixed; boundary="===============0931338117170193022=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: Re: [PATCH] doc: Add experimental handsfree-audio API
Date: Fri, 22 Feb 2013 11:06:20 +0100
Message-ID: <CANT-zCV0Zik0ZQf9FpbU1Jp133W_pMmTaiO+cAKNUErEZbpS2Q@mail.gmail.com>
In-Reply-To: <51250939.9090607@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0931338117170193022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, Feb 20, 2013 at 6:34 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Mikel,
>
>
>>> This API is meant specifically for PA or another Audio subsystem.  What
>>> you
>>> want to be tracking and cross-referencing I'm not quite sure of.
>>
>>
>> I already mentioned one example: if a headset wants to ignore the
>> inband ringtone, and use it's own custom one, it needs to match the
>> audio-card and the voicecall state. During the ringtone (callsetup=3D1),
>> the SCO stream would be ignored, as suggested in section 4.13.4 of the
>> spec.
>
>
> Why? Just select a different sound device if the call status is incoming.
> Why do you need to know this down to the lowest level of detail?  Or bett=
er
> yet, just turn the in-band ringing off at the AG side and be done with it.

I'm not following any of these proposals.

For the first one, in order to know the call status, it's necessary to
known the association between the audio-card and the modem. I don't
know what you mean with "lowest level of detail". Just the mapping
between org.ofono.Modem and org.ofono.AudioCard needs to be known, and
ideally, without having to use the modem's serial number.

Regarding the second proposal, I'm not aware of this being possible.
Perhaps you can point to some part in the spec where this is defined?

>
> The AG can start an audio connection for any reason whatsoever, trying to
> 'outsmart' it will likely never work due to deficiencies in the protocol.=
  I
> would love to hear how you plan to implement voice recognition policies.

The AG reports when voice recognition is active, so I see no big deal
with this one.

>
> If you want to control everything down to the nitty gritty, you probably
> need a dedicated application.  There's no way all of this level of detail=
 is
> ever going to be exposed over IPC.  Even oFono core lacks much of this
> information due to abstractions.

What exactly do you mean? I don't see any information missing so far.
Just the mapping between audio-cards and modems is not explicit enough
IMO in the proposed Handsfree-Audio API. I'm just trying to argue that
this coupling could be more explicit.

>
>>
>> I could list more examples too if needed, but they would involve
>> multiple connected AGs.
>
>
> Please do.

Examples include two connected AGs (phone A and phone B) where one of
them (A) contains an active call, and the other one (B) contains a
held call. In this case the audio from phone A should be routed, and
the one from phone B ignored.

This one is very similar to the first example: the audio-subsystem
needs to know the call status associated to each audio-card.

>
>
>> Not that I agree with the idea of re-engineering the Media API, but
>> anyway...
>>
>
> Lets put it this way, Media API has a snowball's chance in hell of going =
to
> oFono upstream.  So lets put this discussion to rest already.

You're certainly aware that this duplicates the client code since they
have to have separate implementations for A2DP and HSP/HFP. The motto
of "simplifying client code" is not relevant anymore, as it seems.

>
>
>>>
>>>
>>>> The ability to distinguish HS and AG roles in the client's side is
>>>> desirable (at least PulseAudio heavily depends on this information).
>>>> So even if the proposal above is not accepted, at least the role
>>>> (UUID) would have to be exposed somehow.
>>>>
>>>
>>> The type information was left out on purpose from this proposal.  Likely
>>> it
>>> is necessary, but for the initial phase it does not seem relevant.  I
>>> also
>>> have yet to hear concise and clear summary on the utility of providing
>>> this
>>> information.
>>
>>
>> I can summarize PulseAudio's case. The current policies slightly
>> differ in the way SCO is handled. The HS role is more passive,
>> accepting remote SCO connections and releases. The AG, on the other
>> hand, initiates an SCO connection as soon as some audio starts
>> streaming, or the user sets the card's profile to "hsp" manually.
>>
>> The HS role currently switches between HSP/HFP and A2DP automatically.
>> So if SCO starts streaming, the profile is switched and the audio gets
>> routed. This is not the case for the AG role (desktop use-case) where
>> no automatic switch exists and the user-setting applies. I believe
>> this shouldn't be necessary in the long term, if the routing problem
>> was solved, but that alone is a big topic.
>>
>> Finally, PA exposes per-profile information in the UI, so the user
>> actually distinguishes AG and HS roles. So if you pair a Nokia support
>> both profiles, you would see them both in the UI. I guess this could
>> be changed, but not without a controversial discussion. Even several
>> BlueZ developers have argued that this information is very convenient
>> for development and testing.
>>
>> Note that the HSP vs HFP difference is not relevant, so I'm just
>> talking about separating AG vs HS roles.
>>
>
> I'm still lost.  But that is okay.  Can we please implement the basic
> proposal as it is now and then start adding features?  Remember the motto,
> 'make it work, then make it work better'.

Sure, I'm completely fine with that.

>
>>>
>>>>>> If so, I have some concerns about the potential race conditions. If
>>>>>> SCO was closed and reopen immediately afterwards, the client could
>>>>>> receive the (second) NewConnection before the HUP.
>>>>>>
>>>
>>> You are going over-the-air vs local machine.  I really do not see this
>>> ever
>>> happening.  But even if it does, is this really a hard problem for the
>>> Agent
>>> to deal with?
>>
>>
>> I think it would be quite obscure to assume that the previous socket
>> will HUP shortly after this second NewConnection is received. So if
>> this approach is encouraged, I'd expect some reference in the doc.
>
>
> Uhhh, this situation will never happen.  Too much thinking, stop it ;) If
> you want to be ultra-paranoid just close the previous socket when you get=
 a
> NewConnection with the same card id, but I digress...

Cheers,
Mikel

--===============0931338117170193022==--

