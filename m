Content-Type: multipart/mixed; boundary="===============9193473730785158092=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH 2/8] stkagent: '+' is considered as a digit
Date: Thu, 23 Aug 2012 17:53:55 +0200
Message-ID: <50365213.7070607@linux.intel.com>
In-Reply-To: <5035635D.5020800@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9193473730785158092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 08/23/2012 12:55 AM, Denis Kenzior wrote:
> Hi Philippe,
>
> On 08/22/2012 11:18 AM, Philippe Nunes wrote:
>> The function 'valid_phone_number_format' does not comply with GCF test
>> cases
>> expectation. For STK, the character '+' should be considered as a
>> whole digit.
>> ---
>> src/stkagent.c | 26 ++++++++++++++++++++++++--
>> 1 file changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/stkagent.c b/src/stkagent.c
>> index 7c3f697..392a2b2 100644
>> --- a/src/stkagent.c
>> +++ b/src/stkagent.c
>> @@ -69,6 +69,27 @@ struct stk_agent {
>> #define TERMINATE_ERROR ERROR_PREFIX ".EndSession"
>> #define BUSY_ERROR ERROR_PREFIX ".Busy"
>>
>> +static gboolean check_digit(const char *digit)
>
> I really don't like the name...
>
>> +{
>> + int len =3D strlen(digit);
>> + int i;
>> +
>> + if (!len)
>> + return FALSE;
>> +
>> + for (i =3D 0; i< len; i++) {
>> + if (digit[i]>=3D '0'&& digit[i]<=3D '9')
>> + continue;
>> +
>> + if (digit[i] =3D=3D '*' || digit[i] =3D=3D '#' || digit[i] =3D=3D '+')
>> + continue;
>> +
>> + return FALSE;
>> + }
>> +
>> + return TRUE;
>
> And this function is entirely too long-winded for what it is doing.
> Please refer to 'man strspn'. It might be easier to simply use strspn
> below...
>
>> +}
>> +
>> static void stk_agent_send_noreply(struct stk_agent *agent, const char
>> *method)
>> {
>> DBusConnection *conn =3D ofono_dbus_get_connection();
>> @@ -541,7 +562,7 @@ static void get_digit_cb(DBusPendingCall *call,
>> void *data)
>> DBUS_TYPE_STRING,&digit,
>> DBUS_TYPE_INVALID) =3D=3D FALSE ||
>> strlen(digit) !=3D 1 ||
>> - !valid_phone_number_format(digit)) {
>> + !check_digit(digit)) {
>
> This is still wrong as it also needs to take care of the hidden_input
> case where the '+' is not allowed.

Good point. But then, it requires to retrieve the command qualifier (or =

at least the hidden_val property from the agent->msg).

I think this is more complicated to perform this checking here. It =

should be more convenient to place this in the callback (here =

'request_key_cb').
But we can think also to simply remove any checking. For GET_INPUT, we =

are not checking the min/max length ;o)

Note that apparently, we missed to consider the hidden property in =

'handle_command_get_inkey'. Therefore, we are not sending this =

information to the STK agent. I'm willing to correct this.

Regards,

Philippe.




>
>> ofono_error("Can't parse the reply to GetDigit()");
>> remove_agent =3D TRUE;
>> goto error;
>> @@ -675,7 +696,8 @@ static void get_digits_cb(DBusPendingCall *call,
>> void *data)
>>
>> if (dbus_message_get_args(reply, NULL,
>> DBUS_TYPE_STRING,&string,
>> - DBUS_TYPE_INVALID) =3D=3D FALSE) {
>> + DBUS_TYPE_INVALID) =3D=3D FALSE ||
>> + !check_digit(string)) {
>
> As above
>
>> ofono_error("Can't parse the reply to GetDigits()");
>> remove_agent =3D TRUE;
>> goto error;
>
> Regards,
> -Denis
>


--===============9193473730785158092==--

