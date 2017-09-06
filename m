Content-Type: multipart/mixed; boundary="===============6431364263103227137=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: [PATCH] qmimodem: report failure in case of invalid pin type
Date: Wed, 06 Sep 2017 10:31:45 +0200
Message-ID: <7c7b8ac1-7d43-81a9-9634-e894815e0d9f@kerlink.fr>
In-Reply-To: <06e68a31-785e-fac2-4c1a-8ff1417cc9fb@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6431364263103227137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I wasn't able to reproduce yesterday.
 From traces I kept, with problematic SIM card, I had this trace when =

problem appeared:
../git/drivers/qmimodem/sim.c:get_card_status() info1->app_state:0x6: =

OFONO_SIM_PASSWORD_INVALID

I had a look at QMI lib and app_state to 0x6 means =

QMI_UIM_CARD_APPLICATION_STATE_ILLEGAL. Other unhandled states are :
  - QMI_UIM_CARD_APPLICATION_STATE_UNKNOWN
  - QMI_UIM_CARD_APPLICATION_STATE_DETECTED
  - QMI_UIM_CARD_APPLICATION_STATE_PIN1_BLOCKED

With current driver code, all these states will lead to =

OFONO_SIM_PASSWORD_INVALID. I don't know if a retry will help if we have =

any of these states. It would be easy to make a retry for these states =

as this is already implemented for =

QMI_UIM_CARD_APPLICATION_STATE_CHECK_PERSONALIZATION_STATE state.

Do you want me to change the patch to implement that?

On my side, my concern is more: what "PinRequired" property (in =

SimManager properties) should be if we fail to get PIN state (in QMI =

driver or any other driver (with AT+CPIN? replying ERROR for example))? =

I think that with current code it will be "none" and I would prefer =

something like "unknown", "error" or "invalid" to distinguish a SIM with =

entered or disabled PIN from a SIM where driver is not able to get PIN =

state. What do you think?

Best Regards,

Christophe Ronco


On 08/30/2017 08:29 PM, Denis Kenzior wrote:
> Hi Christophe,
>
> On 08/29/2017 07:29 AM, Christophe Ronco wrote:
>> This will avoid a crash seen in sim_pin_query_cb (src/sim.c) if pin type
>> is OFONO_SIM_PASSWORD_INVALID.
>> ---
>>   drivers/qmimodem/sim-legacy.c | 5 ++++-
>>   drivers/qmimodem/sim.c        | 6 +++++-
>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/qmimodem/sim-legacy.c =

>> b/drivers/qmimodem/sim-legacy.c
>> index 318b1ae..d16b2eb 100644
>> --- a/drivers/qmimodem/sim-legacy.c
>> +++ b/drivers/qmimodem/sim-legacy.c
>> @@ -211,7 +211,10 @@ static void get_pin_status_cb(struct qmi_result =

>> *result, void *user_data)
>>       data->retries[OFONO_SIM_PASSWORD_SIM_PUK2] =3D pin->unblock_retrie=
s;
>>     done:
>> -    CALLBACK_WITH_SUCCESS(cb, pin_type, cbd->data);
>> +    if (pin_type =3D=3D OFONO_SIM_PASSWORD_INVALID)
>> +        CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
>> +    else
>> +        CALLBACK_WITH_SUCCESS(cb, pin_type, cbd->data);
>>   }
>>     static void qmi_query_passwd_state(struct ofono_sim *sim,
>> diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
>> index 8d40028..7425d5e 100644
>> --- a/drivers/qmimodem/sim.c
>> +++ b/drivers/qmimodem/sim.c
>> @@ -483,7 +483,11 @@ static void query_passwd_state_cb(struct =

>> qmi_result *result,
>>       case GET_CARD_STATUS_RESULT_OK:
>>           DBG("passwd state %d", sim_stat.passwd_state);
>>           data->retry_count =3D 0;
>> -        CALLBACK_WITH_SUCCESS(cb, sim_stat.passwd_state, cbd->data);
>> +        if (sim_stat.passwd_state =3D=3D OFONO_SIM_PASSWORD_INVALID)
>> +            CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
>> +        else
>> +            CALLBACK_WITH_SUCCESS(cb, sim_stat.passwd_state,
>> +                                cbd->data);
>
> So we get back a CARD_STATUS_RESULT_OK, yet the password state is not =

> valid.  It would seem there's a more serious issue here?  Is is that =

> we need to keep retrying to get the password state? Is this related to =

> Personalization state?
>
>>           break;
>>       case GET_CARD_STATUS_RESULT_TEMP_ERROR:
>>           data->retry_count++;
>>
>
> Regards,
> -Denis
>


--===============6431364263103227137==--

