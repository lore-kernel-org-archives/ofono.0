Content-Type: multipart/mixed; boundary="===============4457067490238765235=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/8] stkagent: '+' is considered as a digit
Date: Thu, 23 Aug 2012 13:15:48 -0500
Message-ID: <50367354.2080004@gmail.com>
In-Reply-To: <50365213.7070607@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4457067490238765235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>>> +}
>>> +
>>> static void stk_agent_send_noreply(struct stk_agent *agent, const char
>>> *method)
>>> {
>>> DBusConnection *conn =3D ofono_dbus_get_connection();
>>> @@ -541,7 +562,7 @@ static void get_digit_cb(DBusPendingCall *call,
>>> void *data)
>>> DBUS_TYPE_STRING,&digit,
>>> DBUS_TYPE_INVALID) =3D=3D FALSE ||
>>> strlen(digit) !=3D 1 ||
>>> - !valid_phone_number_format(digit)) {
>>> + !check_digit(digit)) {
>>
>> This is still wrong as it also needs to take care of the hidden_input
>> case where the '+' is not allowed.
>
> Good point. But then, it requires to retrieve the command qualifier (or
> at least the hidden_val property from the agent->msg).
>
> I think this is more complicated to perform this checking here. It
> should be more convenient to place this in the callback (here
> 'request_key_cb').
> But we can think also to simply remove any checking. For GET_INPUT, we
> are not checking the min/max length ;o)

No, we do need to sanitize any output from the agent.  We do this in a =

half assed way right now and that needs to be fixed.

>
> Note that apparently, we missed to consider the hidden property in
> 'handle_command_get_inkey'. Therefore, we are not sending this
> information to the STK agent. I'm willing to correct this.

Please do.

Regards,
-Denis

--===============4457067490238765235==--

