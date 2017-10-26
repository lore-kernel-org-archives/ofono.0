Content-Type: multipart/mixed; boundary="===============0222150002177079781=="
MIME-Version: 1.0
From: Philippe De Swert <philippe.deswert@nomovok.com>
Subject: Re: [PATCH 2/4] voicecallmanager: Handle last number dialled DBUS call
Date: Thu, 26 Oct 2017 09:33:22 +0300
Message-ID: <166b2f17-668d-e010-2865-9149a127035a@nomovok.com>
In-Reply-To: <6f9197ca-4bd3-f796-1fa0-034047842c04@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0222150002177079781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

Thank you for the quick review!

On 18/10/17 20:03, Denis Kenzior wrote:
> Hi Philippe,
>
> On 10/18/2017 09:04 AM, Philippe De Swert wrote:
>> Handle the new DialLast method on the voicecallmanager interface
>> ---
>>   src/voicecall.c | 89 =

>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 89 insertions(+)
>>
>> diff --git a/src/voicecall.c b/src/voicecall.c
>> index 2ff9aa15..4eeb6621 100644
>> --- a/src/voicecall.c
>> +++ b/src/voicecall.c
>> @@ -1595,6 +1595,94 @@ static DBusMessage =

>> *manager_dial(DBusConnection *conn,
>>       return __ofono_error_failed(msg);
>>   }
>>   +static void manager_dial_last_callback(const struct ofono_error =

>> *error, void *data)
>> +{
>> +    struct ofono_voicecall *vc =3D data;
>> +    DBusMessage *reply;
>> +    gboolean need_to_emit;
>> +    struct voicecall *v;
>> +
>> +    v =3D dial_handle_result(vc, error, NULL, &need_to_emit);
>
> dial_handle_result is a bit tricky because it handles situations where =

> ATD returns immediately and then the call is notified via an =

> unsolicited notification, or ATD returns first.
>
> In the case of +BLDN, I believe HFP spec mandates that BLDN always =

> returns first, which means that much of the logic in =

> dial_handle_result is not applicable.  It may be better to just =

> perform the necessary logic directly here.
>
> In the current proposal, we will always generate a new call with an =

> empty phone number which will (hopefully) eventually be updated.  I'm =

> not so sure that this is a great approach, but I can't think of =

> anything better...

Not sure I understand your comment completely here. So I don't use =

dial_handle_result and just setup a voicecall from the callback =

(voicecall_create)? Or do you mean it is not ideal but acceptable for now?

Regarding your second comment, yes the extra addition of ';' at the end =

should go. Once I know how to deal with your first comment I'll update =

the patch and send an extra one for memory dialling which is similar to =

these.

Thanks,

Philippe.

--===============0222150002177079781==--

