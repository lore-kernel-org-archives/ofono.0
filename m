Content-Type: multipart/mixed; boundary="===============7321891527327200190=="
MIME-Version: 1.0
From: Philippe De Swert <philippe.deswert@nomovok.com>
Subject: Re: [PATCH V2 2/8] voicecallmanager: Handle last number dialled DBUS
 call
Date: Sun, 05 Nov 2017 12:11:48 +0200
Message-ID: <2474cc74-536d-6684-de0d-0e0174093ca1@nomovok.com>
In-Reply-To: <60b70962-1338-a29a-f8fd-8c4f0abb8818@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7321891527327200190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


On 03/11/17 20:30, Denis Kenzior wrote:
> Hi Philippe,
>
> On 10/31/2017 03:39 AM, Philippe De Swert wrote:
>> Handle the new DialLast method on the voicecallmanager interface
>> ---
>>   src/voicecall.c | 87 =

>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 87 insertions(+)
>>
>
> I went ahead and applied this patch, however:
>
>> diff --git a/src/voicecall.c b/src/voicecall.c
>> index a8a2bcde..cef36a29 100644
>> --- a/src/voicecall.c
>> +++ b/src/voicecall.c
>> @@ -1577,6 +1577,92 @@ static DBusMessage =

>> *manager_dial(DBusConnection *conn,
>>       return __ofono_error_failed(msg);
>>   }
>>   +static void manager_dial_last_callback(const struct ofono_error =

>> *error, void *data)
>> +{
>> +    struct ofono_voicecall *vc =3D data;
>> +    DBusMessage *reply;
>> +    struct voicecall *v;
>> +
>
> You were not handling error conditions here.  E.g. if the result of =

> the BLDN was an error.

Ok I must have missed something about the error handling then. Thanks =

for fixing it up.

>> +    v =3D synthesize_outgoing_call(vc, NULL);
>> +
>> +    if (v) {
>> +        const char *path =3D voicecall_build_path(vc, v->call);
>> +
>> +        reply =3D dbus_message_new_method_return(vc->pending);
>> +
>> +        dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
>> +                        DBUS_TYPE_INVALID);
>> +    } else {
>> +        reply =3D __ofono_error_failed(vc->pending);
>> +    }
>> +
>> +    __ofono_dbus_pending_reply(&vc->pending, reply);
>> +
>> +    voicecalls_emit_call_added(vc, v);
>
> Also, in the unlikely case that synthethize_outgoing_call failed, we =

> should not be trying to emit anything...
>
>> +}
>> +
>
> I fixed this up in a follow on commit =

> f58e7685b0078df470300b99cd89fb9b3c45d1c0.  Please check that I didn't =

> screw anything up.

I'll check it and if it works I=C2=B4ll see how the same logic fits the =

dialing from index/memory bit as I made the exact same mistake there. =

Fix it and re-submit.

Thanks,

Philippe

--===============7321891527327200190==--

