Content-Type: multipart/mixed; boundary="===============8476118788957491508=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH v3 2/7] stk: Introduce BIP command handlers
Date: Tue, 17 May 2011 11:55:26 +0200
Message-ID: <4DD2460E.9050401@linux.intel.com>
In-Reply-To: <BANLkTin0K_wovwFOsmkO2JUhODC+H=O2yw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8476118788957491508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Andrew,

>> +
>> +       stk->tx_buffer.data.array =3D g_try_malloc(oc->buf_size);
>> +       if (stk->tx_buffer.data.array =3D=3D NULL) {
>> +               rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
>> +               goto out;
>> +       }
>
> A minor nitpick: we tend to return one of the temporary error codes
> when out of memory.
>

OK, I will return in this case the general result =

"STK_RESULT_TYPE_TERMINAL_BUSY" with the additional info "no specific =

cause".

>> +static void confirm_open_channel_cb(enum stk_agent_result result,
>> +                                       gboolean confirm,
>> +                                       void *user_data)
>> +{
>> +       struct ofono_stk *stk =3D user_data;
>> +
>> +       switch (result) {
>> +       case STK_AGENT_RESULT_TERMINATE:
>> +               send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATE=
D);
>> +               return;
>> +
>> +       case STK_AGENT_RESULT_TIMEOUT:
>> +               confirm =3D FALSE;
>> +               /* Fall through */
>> +
>> +       case STK_AGENT_RESULT_OK:
>> +               if (confirm)
>> +                       break;
>> +               /* Fall through */
>
> According to 6.4.27 we should return STK_RESULT_TYPE_USER_REJECT if
> the user does not accept the channel setup.
>
>> +
>> +       default:
>> +               send_simple_response(stk, STK_RESULT_TYPE_TERMINAL_BUSY);
>> +               return;
>> +       }
>
> I think Jeevaka determined that this needs an additional info field.


In practice, I applied the same code than "confirm_launch_browser_cb". =

But you're right, for Open channel, we should return the terminal =

response "User did not accept the proactive command".

For the additional info field, I just simplified the code seen in =

"confirm_launch_browser_cb" as in this case, no specific cause is given.
But your remark is true, it is mandatory to return an additional =

information in case of general result "STK_RESULT_TYPE_TERMINAL_BUSY".

To clean both issues you raised and for an homogeneous behavior, I =

propose to follow the code written in "confirm_call_cb".Thus, in case of =

no answer, I will return STK_RESULT_TYPE_USER_TERMINATED and not =

STK_RESULT_TYPE_TERMINAL_BUSY.

Thank you for your review.
Best regards,

Philippe.

--===============8476118788957491508==--

