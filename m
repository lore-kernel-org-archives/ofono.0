Content-Type: multipart/mixed; boundary="===============0463657993403496780=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: Re: [PATCH 1/5] netmon: add
 OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP|OPERATOR}
Date: Wed, 30 Nov 2016 12:45:13 +0100
Message-ID: <CAH562ESXeb3gVhkZn=H94Z69WFemrwb4Ui7o8QD_KqCfRQD3bQ@mail.gmail.com>
In-Reply-To: <583DB016.1050603@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0463657993403496780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 29 November 2016 at 17:43, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Djalal,
>
>
> On 11/25/2016 08:00 AM, djalal(a)endocode.com wrote:
>>
>> From: Djalal Harouni <djalal@endocode.com>
>>
>> Add more ofono netmon info types that will be served through the netmon
>> interface. The main user of this now will be the ublox modem.
>>
>> RSCP: Received Signal Code Power
>> ECN0: Received Energy Ratio
>> RSRQ: Reference Signal Received Quality
>> RSRP: Reference Signal Received Power
>> OPERATOR: the operator
>>
>> Patches using these types to follow.
>> ---
>>   include/netmon.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/include/netmon.h b/include/netmon.h
>> index ec8a2e1..abde225 100644
>> --- a/include/netmon.h
>> +++ b/include/netmon.h
>> @@ -59,6 +59,11 @@ enum ofono_netmon_info {
>>         OFONO_NETMON_INFO_RSSI, /* int */
>>         OFONO_NETMON_INFO_TIMING_ADVANCE, /* int */
>>         OFONO_NETMON_INFO_PSC, /* int */
>> +       OFONO_NETMON_INFO_RSCP, /* int */
>> +       OFONO_NETMON_INFO_ECN0, /* int */
>> +       OFONO_NETMON_INFO_RSRQ, /* int */
>> +       OFONO_NETMON_INFO_RSRP, /* int */
>> +       OFONO_NETMON_INFO_OPERATOR, /* char *, up to 24 digits */
>
>
> MCC & MNC are not enough?  This API is intended for various location
> services which hardly care about the text representation of the operator.
> They'd rather know the lac & ci, and possibly the mcc & mnc.
>
> I'm not sure if its worth including this as it is likely just coming from=
 an
> MCCMNC database in the modem and this info is available via
> NetworkRegistration anyway.

Ok I dropped that one and will try to see how we can fix this at our end.

>>         OFONO_NETMON_INFO_INVALID,
>>   };
>>
>>
>
> Regards,
> -Denis

--===============0463657993403496780==--

