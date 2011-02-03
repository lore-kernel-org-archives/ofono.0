Content-Type: multipart/mixed; boundary="===============6175540783633827640=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] voicecall API changes (proposal 2)
Date: Thu, 03 Feb 2011 10:29:19 -0600
Message-ID: <4D4AD7DF.6060401@gmail.com>
In-Reply-To: <4D4A8946.8050208@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6175540783633827640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

>> The explanations you have should be applied to the type.  Another point
>> is whether we want this signal on the call object itself.  Question is
>> how reliably we can figure out the call index.  At what point does CSSI
>> / CSSU fire, before or after the call goes to active / disconnected
>> state?
> Usually, the user is informed about the call barred situation in a
> very generic wording, like "call barring active" with no interest
> in the call index information.
> I prefer to keep it simple and make this signal call index "free". I
> suggest keeping it on the VoiceCallManager interface.
> The CSSI indication comes right after when call reached the MO
> dialing state and an operator announcement is played over
> and over again telling the caller the reason why calls are not
> possible.
> =


Ok, sounds fine to me.

>>> +        OutgoingCallCondForwarded()
>>> +
>>> +            Signal is emitted when an outgoing voice call is made
>>> +            and the call has been redirected to another number due
>>> +            to the remote party's conditional "Call Forwarding"
>>> +            Supplementary Service settings.
>>> +
>>> +        OutgoingCallUncondForwarded()
>>> +
>>> +            Signal is emitted when an outgoing voice call is made
>>> +            and the call has been redirected to another number due
>>> +            to the remote party's unconditional "Call Forwarding"
>>> +            Supplementary Service settings.
>>> +
>> Same with these two, lets call it CallForwarded(string type)
>>
>> where type is:
>> "conditional" or "unconditional"
> I'll combine them into one, that's fine.
>> And the same question applies here as well, do we want this on the call
>> object itself?  If so, then calling this signal Forwarded(string type)
>> would be better.  Perhaps adding another type for incoming calls that
>> are forwarded and removing the 'Forwarded' property would be a good idea
>> as well.  e.g. something like "incoming" type.
> I am thinking along the same line. Let's replace the "Forwarded"
> property with the "Forwarded" signal and add the "incoming" type
> you were suggesting to this signal.
> And we shall not care about the call index, since most probably
> is not going to be used anywhere, in this respect this cases is
> pretty similar to the call barring signaling case; signal will be
> emitted on the VoiceCallManager interface.

Sounds good to me.

Please resend V3 for final review.

Regards,
-Denis

--===============6175540783633827640==--

