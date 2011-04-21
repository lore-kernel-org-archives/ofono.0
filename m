Content-Type: multipart/mixed; boundary="===============4265004481693324164=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH] stk: Clear 'respond_on_exit' flag after sending
 the	terminal response
Date: Thu, 21 Apr 2011 16:50:35 +0200
Message-ID: <4DB0443B.70607@linux.intel.com>
In-Reply-To: <BANLkTi=+qfw5OGQCb=8=zpgiO-JD31Kv4Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4265004481693324164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,


On 04/20/2011 09:11 PM, Andrzej Zaborowski wrote:
> Hi,
>
> On 20 April 2011 18:06, Philippe Nunes<philippe.nunes@linux.intel.com> =
 wrote:
>>>> @@ -1699,8 +1686,6 @@ static void confirm_call_cb(enum stk_agent_result
>>>> result, gboolean confirm,
>>>>         struct stk_response rsp;
>>>>         int err;
>>>>
>>>> -       stk->respond_on_exit =3D FALSE;
>>>
>>> However there's a change in behaviour here which I think is incorrect.
>>>   We need to wait for the call to be cancelled or connected before
>>> responding, so I'd just leave this line as is.
>>>
>>
>> According to me, this change doesn't impact your expectation.
>> It offers only the possibility for the user to end properly the session =
when
>> exiting the on screen STK agent and before the dialer App becomes
>> foreground. I know, this could be unlikely to happen due to timing
>> consideration but still, I think this change is more safe.
>
> The problem is not that it's unlikely, but by my reading of the
> specification the user should be able to quit the STK session without
> disturbing the call setup.
>
>> Indeed, when the STK agent quits, normally the callback
>> "session_agent_notify" is called. If the flag respond_on exit is set to
>> FALSE, no chance to cancel the command neither to send the appropriate
>> terminal response with the result "user ends the session".
>>
>> Now, indeed, the user is still able to cancel the call in the dialer App
>> (and a terminal response will be sent at the end) but I feel we missed to
>> consider first the STK agent exit.
>>
>> Also, you mentioned:
>> "the spec only mentions the "session terminated by the user" response in=
 the
>> "confirmation phase" and not in the "setup phase".
>>
>> According to me, the session still exists during the setup phase, theref=
ore,
>
> Yes it exists, and if the user closes the session then in this case
> nothing should happen (same as during Send DTMF or other commands).
> TS 102.223 6.4 lists the allowed responses for every scenario and if
> we want to follow it, then the current behaviour is more correct than
> the proposed one.
>

For Send DTMF proactive command, I can read "If the user indicates the =

need to end the proactive UICC session whilst the terminal is sending =

the DTMF string, the terminal shall stop sending the DTMF string and =

shall send a terminal response with "proactive UICC session terminated =

by the user" result value. That's precisely what is allowing this change.

For setup call, the specification is not so clear but since this result =

code is allowed for SETUP CALL, I guess that the spec should have =

pointed that it was however not possible to send this result code during =

the call setup.

For me, this change brings at least an homogeneous behavior.


> All in all I'm okay with this patch because the change is minor but
> whenever there's a behaviour change the reasoning needs to be
> documented in the commit message optimally with reference to the
> specification. (possibly in the code too)
>

I agree. I didn't realize that this change could be problematic.

Regards,

Philippe.


--===============4265004481693324164==--

