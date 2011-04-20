Content-Type: multipart/mixed; boundary="===============7164926529495960031=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] stk: Clear 'respond_on_exit' flag after sending the
 terminal response
Date: Wed, 20 Apr 2011 21:11:10 +0200
Message-ID: <BANLkTi=+qfw5OGQCb=8=zpgiO-JD31Kv4Q@mail.gmail.com>
In-Reply-To: <4DAF0480.6030306@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7164926529495960031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 20 April 2011 18:06, Philippe Nunes <philippe.nunes@linux.intel.com> w=
rote:
>>> @@ -1699,8 +1686,6 @@ static void confirm_call_cb(enum stk_agent_result
>>> result, gboolean confirm,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_response rsp;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
>>>
>>> - =C2=A0 =C2=A0 =C2=A0 stk->respond_on_exit =3D FALSE;
>>
>> However there's a change in behaviour here which I think is incorrect.
>> =C2=A0We need to wait for the call to be cancelled or connected before
>> responding, so I'd just leave this line as is.
>>
>
> According to me, this change doesn't impact your expectation.
> It offers only the possibility for the user to end properly the session w=
hen
> exiting the on screen STK agent and before the dialer App becomes
> foreground. I know, this could be unlikely to happen due to timing
> consideration but still, I think this change is more safe.

The problem is not that it's unlikely, but by my reading of the
specification the user should be able to quit the STK session without
disturbing the call setup.

> Indeed, when the STK agent quits, normally the callback
> "session_agent_notify" is called. If the flag respond_on exit is set to
> FALSE, no chance to cancel the command neither to send the appropriate
> terminal response with the result "user ends the session".
>
> Now, indeed, the user is still able to cancel the call in the dialer App
> (and a terminal response will be sent at the end) but I feel we missed to
> consider first the STK agent exit.
>
> Also, you mentioned:
> "the spec only mentions the "session terminated by the user" response in =
the
> "confirmation phase" and not in the "setup phase".
>
> According to me, the session still exists during the setup phase, therefo=
re,

Yes it exists, and if the user closes the session then in this case
nothing should happen (same as during Send DTMF or other commands).
TS 102.223 6.4 lists the allowed responses for every scenario and if
we want to follow it, then the current behaviour is more correct than
the proposed one.

All in all I'm okay with this patch because the change is minor but
whenever there's a behaviour change the reasoning needs to be
documented in the commit message optimally with reference to the
specification. (possibly in the code too)

Best regards

--===============7164926529495960031==--

