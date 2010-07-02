Content-Type: multipart/mixed; boundary="===============5573303607009999298=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 5/9] stk: Handle ENVELOPEs in a queue, retry on sim busy.
Date: Fri, 02 Jul 2010 21:15:24 +0200
Message-ID: <AANLkTik3HelFZuepUeO1ZLM3DjE8thjCurS5xIL_pb1V@mail.gmail.com>
In-Reply-To: <4C2D4EDD.1000701@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5573303607009999298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 2 July 2010 04:28, Denis Kenzior <denkenz@gmail.com> wrote:
>>>> + =C2=A0 =C2=A0 GQueue *envelope_q;
>>>> +};
>>>> +
>>>> +struct envelope_op {
>>>> + =C2=A0 =C2=A0 struct stk_envelope e;
>>>> + =C2=A0 =C2=A0 int retries;
>>>> + =C2=A0 =C2=A0 void (*cb)(struct ofono_stk *stk, gboolean ok,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const unsigned char *data, int length);
>>>
>>> Is the callback really needed? =C2=A0What can we intelligently do besid=
es
>>> printing an error to the log?
>>
>> In the generic case we should inform whoever asked us to submit the
>> information to the UICC. =C2=A0We don't currently have any such case (in
>> case of Cell Broadcast there's no one to inform. =C2=A0 In case of the
>> SimAppAgent our d-bus api doesn't let us do it. =C2=A0In case of SMS-PP
>> download it's a technical difficulty). =C2=A0But, for example the Timer
>> Expiration event is more complicated because it needs to be retried
>> until it succeeds, and every time we retry sending the envelope it
>> will be different because it contains current time. =C2=A0So the Timer
>> Expiration retrying has to be imlemented separately.
>>
>
> So I suggest keeping it simple for now and not having the callback. =C2=
=A0We
> can always add it if really needed.

I tried to remove it (I use the success callback in the menu patch..
but I planned to get rid of that usage anyway), but now I think it
would be conceptually wrong.  The ENVELOPEs send information both
ways, it's a request and a response.  For example the Call Control
envelopes return a response and we will definitely need to know what
the response was.  So I think it's easier to do correctly from the
beginning, instead of remove it and then in a couple of weeks come
back to it and look for what needs to be changed and what other code
may be affected.

It's just about two lines of code anyway.

Best regards

--===============5573303607009999298==--

