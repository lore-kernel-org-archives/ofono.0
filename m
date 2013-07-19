Content-Type: multipart/mixed; boundary="===============9208273869412483042=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] voicecall: Allow second stage string on Dial()
Date: Fri, 19 Jul 2013 09:21:27 -0500
Message-ID: <51E94B67.1040009@gmail.com>
In-Reply-To: <CAMOw1v5A78BTX7Ds9WdaN8LxO1wG8h7crF32Bm_83vS7-4V10w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9208273869412483042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,
 >>
>> AFAIK the original reason this was here was to have the Audio Framework
>> generate the DTMF tones locally.  It was not intended for user feedback.
>>
>> The question is how you want your UI to look like.  For example, do you =
want
>> to show the progress of the DTMF tones (e.g. text changing from gray ->
>> black) as they are being dialed?
>
> Could be.  Updating one char at a time would cover the feedback from
> the audio framework, but then we need to know what's the tone
> duration.
> I'm just seeing an item in the TODO and brainstorming ideas ;-). I
> have no use case for it.

The tone duration is the troubling bit.  In theory all modems should =

support the Start/Stop version of DTMF commands.  In practice that is =

rarely true and they only support +VTS.  Perhaps we can do this only on =

the hardware that supports the start / stop commands for the first attempt.

The reason this is still a TODO item is that nobody had any clue how to =

solve it properly or time to try some things out.  So I'm fully open to =

new ideas on this one.

>
>>
>>
>>>>
>>>> Another interesting case to consider is what should happen if we have a
>>>> Three-Way call, start a DTMF queue and then swap calls.
>>>
>>>
>>> Right now we continue sending the tones, right? We could change
>>> voicecall.c to associate a queue to the active call and throw it away
>>> when this  call change state, setting the property to error as above.
>>>
>>
>> The trouble is DTMFs can be applied to a dialing call as well, though I'=
ll
>> need to do some digging to understand how/why.
>
> Yes, but what I said is that we could throw it away when going *out*
> of ACTIVE... if we started the queue on ACTIVE or DIALING is
> irrelevant in this scenario
>

Fair enough.  I'm open to this one.  It may be useful if we can check =

the behavior of some other devices in this area.

>> The number being dialed is sanitized in voicecall_dial.  You do not sani=
tize
>> the tones at all.  tone_queue will reject invalid input, but then you sh=
ould
>> not even accept an invalid dial string here in the first place.
>
> Adding a function to sanitize the tones part and also call it on
> manager_send_tones() then...
>

manager_tone() is fine.  Re-read the code if you're not convinced :)

Regards,
-Denis


--===============9208273869412483042==--

