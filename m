Content-Type: multipart/mixed; boundary="===============0799847820667175204=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: Re: [PATCH 2/5] netmon: handle
 OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP|OPERATOR} in D-Bus
Date: Wed, 30 Nov 2016 12:48:41 +0100
Message-ID: <CAH562ETxkcORpxzhTGVB+qt4LVZaQMPf1SKZuDOTFw3Npp+Q3w@mail.gmail.com>
In-Reply-To: <583DB188.1020402@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0799847820667175204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 29 November 2016 at 17:49, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Djalal,
>
> On 11/25/2016 08:00 AM, djalal(a)endocode.com wrote:
>>
>> From: Djalal Harouni <djalal@endocode.com>
>>
>> Handle the previously added types in D-Bus.
>> ---
>>   src/netmon.c | 40 +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/netmon.c b/src/netmon.c
>> index eb18b9c..c87980a 100644
>> --- a/src/netmon.c
>> +++ b/src/netmon.c
>> @@ -78,7 +78,8 @@ void ofono_netmon_serving_cell_notify(struct
>> ofono_netmon *netmon,
>>         const char *technology =3D cell_type_to_tech_name(type);
>>         char *mcc =3D NULL;
>>         char *mnc =3D NULL;
>> -       int intval;
>> +       char *op =3D NULL;
>> +       int intval =3D -1;
>
>
> Why the initializer?  Our rule of thumb is not to initialize in order to =
let
> the compiler (hopefully) or valgrind catch instances of uninitialized
> variable use (e.g. bugs).

Ok dropped that one too, but in this case it does not matter, va_arg()
is undefined any way...

>
>>         netmon->reply =3D dbus_message_new_method_return(netmon->pending=
);
>>
>>         if (netmon->reply =3D=3D NULL)
>> @@ -180,6 +181,43 @@ void ofono_netmon_serving_cell_notify(struct
>> ofono_netmon *netmon,
>>                                         intval, uint8_t, DBUS_TYPE_BYTE);
>>                         break;
>>
>> +               case OFONO_NETMON_INFO_RSCP:
>> +                       intval =3D va_arg(arglist, int);
>> +
>> +                       CELL_INFO_DICT_APPEND(&dict,
>> "ReceivedSignalCodePower",
>> +                                       intval, uint8_t, DBUS_TYPE_BYTE);
>> +                       break;
>> +
>> +               case OFONO_NETMON_INFO_ECN0:
>> +                       intval =3D va_arg(arglist, int);
>> +
>> +                       CELL_INFO_DICT_APPEND(&dict,
>> "ReceivedEnergyRatio",
>> +                                       intval, uint8_t, DBUS_TYPE_BYTE);
>> +                       break;
>> +
>> +               case OFONO_NETMON_INFO_RSRQ:
>> +                       intval =3D va_arg(arglist, int);
>> +
>> +                       CELL_INFO_DICT_APPEND(&dict,
>> "ReferenceSignalReceivedQuality",
>> +                                       intval, uint8_t, DBUS_TYPE_BYTE);
>> +                       break;
>> +
>> +               case OFONO_NETMON_INFO_RSRP:
>> +                       intval =3D va_arg(arglist, int);
>> +
>> +                       CELL_INFO_DICT_APPEND(&dict,
>> "ReferenceSignalReceivedPower",
>> +                                       intval, uint8_t, DBUS_TYPE_BYTE);
>> +                       break;
>> +
>
>
> This looks fine, however there should be a patch documenting these and th=
eir
> respective value ranges inside doc/netmon-api.txt.

OK documented in netmonmonitor-api.txt of v2 of the patches. Thank you!

>> +               case OFONO_NETMON_INFO_OPERATOR:
>> +                       op =3D va_arg(arglist, char *);
>> +
>> +                       if (op && strlen(op))
>> +                               ofono_dbus_dict_append(&dict, "Operator",
>> +                                               DBUS_TYPE_STRING, &op);
>> +
>> +                       break;
>> +
>>                 case OFONO_NETMON_INFO_INVALID:
>>                         break;
>>                 }
>>
>
> Regards,
> -Denis

--===============0799847820667175204==--

