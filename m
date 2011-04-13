Content-Type: multipart/mixed; boundary="===============4474643920416952837=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] stk: Introduce BIP command handlers
Date: Wed, 13 Apr 2011 09:37:09 -0500
Message-ID: <4DA5B515.2070909@gmail.com>
In-Reply-To: <4DA5AD11.30902@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4474643920416952837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>>> @@ -112,6 +123,9 @@ static int stk_respond(struct ofono_stk *stk,
>>> struct stk_response *rsp,
>>>
>>>       DBG("");
>>>
>>> +    if (stk->pending_cmd =3D=3D NULL)
>>> +        return 0;
>>> +
>>
>> This seems fishy, why do you need this?  Is this a bug you discovered or
>> a behavior change necessitated by BIP support?
> =

> No, in fact, just looking to the code below (session_agent_notify), I
> found logical and more safe to add also this check in the function
> stk_respond:
> =

> if (stk->current_agent =3D=3D stk->session_agent && stk->respond_on_exit)=
 {
>     if (stk->pending_cmd)
>         stk->cancel_cmd(stk);
> =

>     DBG("Sending Terminate response for session agent");
>     send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
> }
> =

> Now, I agree that if the flag 'respond_on_exit' is TRUE, it requires
> necessarily a pending command especially with the modification I did
> below (since the flag is set back to False just after the pending_cmd is
> set to NULL).
> So, I can forget this check but logically we could remove also the check
> before calling stk->cancel_cmd.

Briefly looking at it the
if (stk->pending_cmd)

does indeed look to be redundant.  Feel free to send such a patch, but
Andrew has to take a look as well.

>>> +
>>> +    if (stk->pending_cmd&&
>>> +        stk->pending_cmd->type =3D=3D STK_COMMAND_TYPE_CLOSE_CHANNEL)
>>
>> doc/coding-style.txt M4
> =

> =

> In this case, as it is not possible to indent the second line condition,
> should I indent one more the body?

No, indenting the body is a bad idea.  You will have to get creative,
e.g. breaking up the =3D=3D over two lines.

>>>   static void user_termination_cb(enum stk_agent_result result, void
>>> *user_data)
>>>   {
>>>       struct ofono_stk *stk =3D user_data;
>>>
>>> -    if (result =3D=3D STK_AGENT_RESULT_TERMINATE) {
>>> -        stk->respond_on_exit =3D FALSE;
>>> +    if (result !=3D STK_AGENT_RESULT_TERMINATE)
>>> +        return;
>>> +
>>> +    if (stk->pending_cmd) {
>>>           send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
>>> +        stk->cancel_cmd(stk);
>>
>> I don't think this will work out.  send_simple_responses NULLs out
>> cancel_cmd...
>>
>> I'm guessing you're trying to guarantee that send_dtmf is properly
>> canceled when the agent sends an EndSession error...
> =

> yes, that was the idea. I need to call the cancel function before
> sending the response...
> =


You will probably need a dedicated callback for this case.

>>>   static int duration_to_msecs(const struct stk_duration *duration)
>>>   {
>>>       int msecs =3D duration->interval;
>>> @@ -598,7 +788,6 @@ static void default_agent_notify(gpointer user_data)
>>>
>>>       stk->default_agent =3D NULL;
>>>       stk->current_agent =3D stk->session_agent;
>>> -    stk->respond_on_exit =3D FALSE;
>>
>> You really need to put these into a separate patch with a huge
>> description of what you're trying to fix and why.  respond_on_exit is
>> pretty much tricky to get right, and really has to be reviewed
>> independently from BIP command handlers...
> =

> Indeed, in practice, this modification is coming from BIP handler
> implementation, but this is uncorrelated from BIP.
> Here, the idea of this modification is to update the flag only once the
> Terminal response has been sent.
> My understanding of this flag is to allow to send a Terminal response
> "Proactive UICC session terminated by the user" once the stk agent exits
> (user quits).

Yep, that is correct.

> =

> But this case still subsists even after the user confirms to setup a
> voice call or to setup a BIP channel. For such cases, we need to
> establish the link before returning the terminal response, which can
> take a while.
> =

> Actually, in the callback 'confirm_call_cb', the flag
> stk->respond_on_exit is set back to FALSE whereas the Terminal response
> is not already sent. Fact is that the user may exit the stk agent before
> the call is connected. In this case, no terminal response is sent,
> leading to a potential mismatch regarding the expected answer from SIM.

This is a good point.  Andrew's idea was that once the Dial has been
sent, the EndSesion can be triggered by hanging up the call and tracking
the session agent is no longer needed (as Setup Call is usually the end
of a session anyway)

I don't mind triggering EndSession via the Agent exiting as well in this
case.

> =

> So I found more safe and logical to reinitialise this flag only in the
> function stk_respond after the terminal response is sent.
> =

> If you agree with this approach, I'm willing to submit a dedicated patch
> for that.
> =


Sure, it does seem that respond_on_exit clearing can be simplified
somewhat.  However, it was hard to judge when it was mixed with 500
lines of additional changes ;)

Regards,
-Denis

--===============4474643920416952837==--

