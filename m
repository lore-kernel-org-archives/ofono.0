Content-Type: multipart/mixed; boundary="===============2888379154479162951=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH] stk: Clear 'respond_on_exit' flag after sending
 the	terminal response
Date: Wed, 20 Apr 2011 18:06:24 +0200
Message-ID: <4DAF0480.6030306@linux.intel.com>
In-Reply-To: <BANLkTinLsBpz9ZBspNM+uE+rep+wdJk2PA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2888379154479162951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thank you for your review.

>> @@ -1699,8 +1686,6 @@ static void confirm_call_cb(enum stk_agent_result =
result, gboolean confirm,
>>         struct stk_response rsp;
>>         int err;
>>
>> -       stk->respond_on_exit =3D FALSE;
>
> However there's a change in behaviour here which I think is incorrect.
>   We need to wait for the call to be cancelled or connected before
> responding, so I'd just leave this line as is.
>



According to me, this change doesn't impact your expectation.
It offers only the possibility for the user to end properly the session =

when exiting the on screen STK agent and before the dialer App becomes =

foreground. I know, this could be unlikely to happen due to timing =

consideration but still, I think this change is more safe.
Indeed, when the STK agent quits, normally the callback =

"session_agent_notify" is called. If the flag respond_on exit is set to =

FALSE, no chance to cancel the command neither to send the appropriate =

terminal response with the result "user ends the session".

Now, indeed, the user is still able to cancel the call in the dialer App =

(and a terminal response will be sent at the end) but I feel we missed =

to consider first the STK agent exit.

Also, you mentioned:
"the spec only mentions the "session terminated by the user" response in =

the "confirmation phase" and not in the "setup phase".

According to me, the session still exists during the setup phase, =

therefore, the result "session terminated by the user" should be possible.
Also, it's more logical to return "use cleared down call before =

connection" when the user decides to cancel the call, this way the SAP =

application can propose alternatively the previous sub-menu and still =

keep active the session.
Here, the proposed change is precisely linked with the STK agent exit, =

it means that the user wants indeed to cancel the call but he wants =

first to end the session. That's why I think the result "session =

terminated by the user" is also relevant during the setup phase.

Regards,

Philippe.



--===============2888379154479162951==--

