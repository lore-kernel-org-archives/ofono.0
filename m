Content-Type: multipart/mixed; boundary="===============2039489730936689937=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH] sms: Add delay before submitting multiple SMS to modem
Date: Thu, 23 Aug 2012 11:04:05 +0200
Message-ID: <5035F205.8040008@linux.intel.com>
In-Reply-To: <503563CC.2000503@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2039489730936689937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 23/08/2012 00:57, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 08/22/2012 04:29 AM, Guillaume Zajac wrote:
>> For 3GPP GSM test case 34.2.9.1 and 34.2.9.1 and WCDMA test
>> case 16.1.9.1 and 16.1.9.2, we need to transmitmultiple SMS
>> using same RRC channel.
>> oFono needs to wait its tx queue to be filled in with the
>> next SMS before submitting the first one to use +CMMS=3D1 modem
>> option.
>> ---
>>   src/sms.c |    4 +++-
>>   1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/sms.c b/src/sms.c
>> index acfc39b..443e502 100644
>> --- a/src/sms.c
>> +++ b/src/sms.c
>> @@ -50,6 +50,8 @@
>>   #define TXQ_MAX_RETRIES 4
>>   #define NETWORK_TIMEOUT 332
>>
>> +#define SMS_TX_NEXT 500
>> +
>>   static gboolean tx_next(gpointer user_data);
>>
>>   static GSList *g_drivers =3D NULL;
>> @@ -2072,7 +2074,7 @@ int __ofono_sms_txq_submit(struct ofono_sms =

>> *sms, GSList *list,
>>       g_queue_push_tail(sms->txq, entry);
>>
>>       if (sms->registered&& g_queue_get_length(sms->txq) =3D=3D 1)
>> -        sms->tx_source =3D g_timeout_add(0, tx_next, sms);
>> +        sms->tx_source =3D g_timeout_add(SMS_TX_NEXT, tx_next, sms);
>>
>
> Umm, I don't even know how to respond to this.  Lets just say that =

> this isn't going to be accepted upstream ;)  Why don't you use =

> multi-segment SMS, or queue the messages offline.

We can forget about queuing messages offline because the simulator needs =

to check we are registered to the network before asking to send the 3 =

multiple SMS.
So this will break the sequences expected by the test.
Concerning Multi-segment message, we already knew it was working for GSM =

test cases 34.2.9.1 and 34.2.9.1 because message content is not checked.
However for WCDMA test case we have a message specified by the test to =

send and I was expecting the simulator to check the content of each =

multiple messages. That's why I chose to use a delay. Fortunately for =

practical purposes, the test is passing in sending multi-segment =

messages even with a text not corresponding to the one specified by the =

test.
Unfortunately I come to the conclusion that if I want to send one same =

SMS to 3/4/5/... recipients with an application using oFono middleware, =

I will not be able to send them through the same RRC channel, unless I =

queue them offline.

>
>
>>       if (uuid)
>>           memcpy(uuid,&entry->uuid, sizeof(*uuid));
>
> Regards,
> -Denis

Kind regards,
Guillaume

--===============2039489730936689937==--

