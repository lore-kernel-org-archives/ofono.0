Content-Type: multipart/mixed; boundary="===============6882728561912190786=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] doc: Add experimental handsfree-audio API
Date: Fri, 22 Feb 2013 13:14:46 -0600
Message-ID: <5127C3A6.4060604@gmail.com>
In-Reply-To: <CANT-zCV0Zik0ZQf9FpbU1Jp133W_pMmTaiO+cAKNUErEZbpS2Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6882728561912190786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 02/22/2013 04:06 AM, Mikel Astiz wrote:
> Hi Denis,
>
> On Wed, Feb 20, 2013 at 6:34 PM, Denis Kenzior<denkenz@gmail.com>  wrot=
e:
>> Hi Mikel,
>>
>>
>>>> This API is meant specifically for PA or another Audio subsystem.  What
>>>> you
>>>> want to be tracking and cross-referencing I'm not quite sure of.
>>>
>>>
>>> I already mentioned one example: if a headset wants to ignore the
>>> inband ringtone, and use it's own custom one, it needs to match the
>>> audio-card and the voicecall state. During the ringtone (callsetup=3D1),
>>> the SCO stream would be ignored, as suggested in section 4.13.4 of the
>>> spec.
>>
>>
>> Why? Just select a different sound device if the call status is incoming.
>> Why do you need to know this down to the lowest level of detail?  Or bet=
ter
>> yet, just turn the in-band ringing off at the AG side and be done with i=
t.
>
> I'm not following any of these proposals.
>
> For the first one, in order to know the call status, it's necessary to
> known the association between the audio-card and the modem. I don't
> know what you mean with "lowest level of detail". Just the mapping
> between org.ofono.Modem and org.ofono.AudioCard needs to be known, and
> ideally, without having to use the modem's serial number.

Why? You have an incoming call on Modem A.  You know the contact as =

Contact X.  You are ignoring the SCO in-band ring anyway.  Just play the =

'ring-tone for contact X' until you have an active call.  There is no =

need for you to do any cross-referencing that I see.

>
> Regarding the second proposal, I'm not aware of this being possible.
> Perhaps you can point to some part in the spec where this is defined?
>

I went back and re-read the spec.  I mis-spoke on this one.  Indeed only =

the AG can change this setting, which in practice means it is fully =

pointless part of the protocol.  The fact that HF cannot control in-band =

ringing setting is a major oversight in the protocol in my opinion.

>>
>> The AG can start an audio connection for any reason whatsoever, trying to
>> 'outsmart' it will likely never work due to deficiencies in the protocol=
.  I
>> would love to hear how you plan to implement voice recognition policies.
>
> The AG reports when voice recognition is active, so I see no big deal
> with this one.
>

Yes it does.  My point here was that you still do not need any =

cross-referencing here.  Just pipe the data to SCO when it is asked for.

>>>
>>> I could list more examples too if needed, but they would involve
>>> multiple connected AGs.
>>
>>
>> Please do.
>
> Examples include two connected AGs (phone A and phone B) where one of
> them (A) contains an active call, and the other one (B) contains a
> held call. In this case the audio from phone A should be routed, and
> the one from phone B ignored.
>
> This one is very similar to the first example: the audio-subsystem
> needs to know the call status associated to each audio-card.
>

So we're off into advanced use-cases lala land, where we have multiple =

SCO streams, have you even tested whether multiple simultaneous mSBC =

streams work?

And how do you even get to this point?  If phone A is on the call and =

you get a call on Phone B, what do you even do?  Auto-hold Phone A? =

Play Ring Tone while Phone A is active?  More importantly, why would you =

keep both SCO links active in the first place?

Actually, I'm not sure I want to know ;)  Right now we don't even have =

the simple 1:1 connection case working properly, so lets get that =

working first before running off into the weeds.

>>
>>
>>> Not that I agree with the idea of re-engineering the Media API, but
>>> anyway...
>>>
>>
>> Lets put it this way, Media API has a snowball's chance in hell of going=
 to
>> oFono upstream.  So lets put this discussion to rest already.
>
> You're certainly aware that this duplicates the client code since they
> have to have separate implementations for A2DP and HSP/HFP. The motto
> of "simplifying client code" is not relevant anymore, as it seems.
>

I disagree completely.  Media API was trying to abstract both protocols =

which are completely different.  It didn't do a very good job, whatever =

was being encapsulated still bled through into the API, particularly =

things oFono would never ever care about.  In short, the oFono side of =

things looked just plain awful.

By the way, whatever points you are raising above, would still apply to =

the Media API, you just have to deal with even more complexity.  In the =

end I rather have more code that is simpler to understand than less code =

that is unreadable.

Regards,
-Denis

--===============6882728561912190786==--

