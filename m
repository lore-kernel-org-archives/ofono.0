Content-Type: multipart/mixed; boundary="===============1691563620959392500=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [RFC] voicecall: Allow second stage string on Dial()
Date: Fri, 19 Jul 2013 11:10:51 -0300
Message-ID: <CAMOw1v5A78BTX7Ds9WdaN8LxO1wG8h7crF32Bm_83vS7-4V10w@mail.gmail.com>
In-Reply-To: <51E945D1.3090603@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1691563620959392500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2013 at 10:57 AM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Lucas,
>
>
>> Humn...  I was guided by this comment in dial_handle_result():
>>
>>
>> /*
>>   * Dial request may return before existing active call
>>   * is put on hold or after dialed call has got active
>>   */
>>
>> So either I misunderstood what "after dialed call has got active" means
>> or:
>>
>> ATD...;
>> CALLSTATE: dialing
>> CALLSTATE: alerting
>> CALLSTATE: active
>> OK
>>
>
> I've not seen this behavior, in theory it is possible.  But mostly that
> comment is about the case of three way calls.  Even then, we can simply r=
un
> the dial string from the ATD callback.
>
>
>>> The user can disconnect / switch the call to a Held state mid-way for
>>
>>
>> mid-way while the tones are being sent, right?
>
>
> Correct.  Try it on an iPhone for example.  Your tone will never get sent.
>
>
>>
>>> example, in which case all the tones are lost.  I think that this is ju=
st
>>> fine, unless you have some nice way of presenting this fact to the user?
>>
>>
>> I was thinking about a property SecondStageNumber that is set once we
>> start sending it and then if it errors out, we set it to "error" or
>> the like.
>> Or we can update the property like below:
>>
>> SecondStageNumber=3D1234567AB
>> ...
>> SecondStageNumber=3D4567AB
>> ...
>> SecondStageNumber=3DAB
>> SecondStageNumber=3D"failed"
>>
>> Just throwing away some ideas... We could do it with signals too:
>
>
> Throw these away ;)  I don't see the point in setting the error.  As I sa=
id,
> do you have a user usecase for it?
>
>
>>
>> SendToneStarted(string complete_number)
>> SendToneUpdate(string partial_number)
>> SendToneEnd()
>>
>
> This is much more likely, however having three signals is way too much, t=
he
> TODO proposal is likely enough.
>
>
>> I think this would cover the other TODO item?
>>
>> "
>> - Provide feedback of sent DTMF tones. Emit SendingTones signal if modem
>> can
>>    provide approximate starting and stopping times for DTMF tones. Signal
>>    argument contains a string of DTMF tones to be sent, or empty string
>> when
>>    all tones has been sent."
>>
>> Or what the TODO item says.
>>
>
> AFAIK the original reason this was here was to have the Audio Framework
> generate the DTMF tones locally.  It was not intended for user feedback.
>
> The question is how you want your UI to look like.  For example, do you w=
ant
> to show the progress of the DTMF tones (e.g. text changing from gray ->
> black) as they are being dialed?

Could be.  Updating one char at a time would cover the feedback from
the audio framework, but then we need to know what's the tone
duration.
I'm just seeing an item in the TODO and brainstorming ideas ;-). I
have no use case for it.

>
>
>>>
>>> Another interesting case to consider is what should happen if we have a
>>> Three-Way call, start a DTMF queue and then swap calls.
>>
>>
>> Right now we continue sending the tones, right? We could change
>> voicecall.c to associate a queue to the active call and throw it away
>> when this  call change state, setting the property to error as above.
>>
>
> The trouble is DTMFs can be applied to a dialing call as well, though I'll
> need to do some digging to understand how/why.

Yes, but what I said is that we could throw it away when going *out*
of ACTIVE... if we started the queue on ACTIVE or DIALING is
irrelevant in this scenario

>
>>
>>>
>>>
>
> <snip>
>
>
>>>> @@ -1570,12 +1601,24 @@ static DBusMessage *manager_dial(DBusConnection
>>>> *conn,
>>>>
>>>>          vc->pending =3D dbus_message_ref(msg);
>>>>
>>>> +       tones =3D strpbrk(number, "pP");
>>>> +
>>>
>>>
>>>
>>> Doing this is not safe, you might want to sanitize this input.
>>
>>
>> How so? Searching for "pP" is as safe as calculating the length in
>> valid_number_format().
>
>
> The number being dialed is sanitized in voicecall_dial.  You do not sanit=
ize
> the tones at all.  tone_queue will reject invalid input, but then you sho=
uld
> not even accept an invalid dial string here in the first place.

Adding a function to sanitize the tones part and also call it on
manager_send_tones() then...


Lucas De Marchi

--===============1691563620959392500==--

