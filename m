Content-Type: multipart/mixed; boundary="===============3652360044411519637=="
MIME-Version: 1.0
From: Andreas WESTIN <andreas.westin@stericsson.com>
Subject: Re: [PATCH 16/18] isimodem: sms updated with wgmodem2.5
Date: Wed, 16 Feb 2011 15:47:33 +0100
Message-ID: <4D5BE385.9030906@stericsson.com>
In-Reply-To: <AANLkTikD+LKAcNdbc33haZdBKVZ1q3xAikNK4y=M=5Bq@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3652360044411519637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 2011-02-16 15:22, Aki Niemi wrote:
> Hi,
>
> 2011/2/15 Andreas Westin<andreas.westin@stericsson.com>:
>> From: Jessica Nilsson<jessica.j.nilsson@stericsson.com>
>>
>> ---
>>   drivers/isimodem/debug.c |   56 +++
>>   drivers/isimodem/debug.h |    1 +
>>   drivers/isimodem/sms.c   |  972 ++++++++++++++++++++++++++++++++++++++=
+-------
>>   drivers/isimodem/sms.h   |   34 ++
>>   4 files changed, 927 insertions(+), 136 deletions(-)
>>
>> diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
>> index 33e4dcb..1fd2226 100644
>> --- a/drivers/isimodem/debug.c
>> +++ b/drivers/isimodem/debug.c
>> @@ -53,6 +53,7 @@ const char *pn_resource_name(int value)
>>                 _(PN_GSS);
>>                 _(PN_GPDS);
>>                 _(PN_WRAN);
>> +               _(PN_UICC);
>>         }
>>         return "PN_<UNKNOWN>";
>>   }
>> @@ -218,6 +219,47 @@ const char *mce_rf_state_name(enum mce_rf_state val=
ue)
>>         return "MCE_RF<UNKNOWN>";
>>   }
>>
>> +const char *uicc_message_id_name(enum uicc_message_id value)
>> +{
>> +       switch (value) {
>> +               _(UICC_REQ);
>> +               _(UICC_RESP);
>> +               _(UICC_IND);
>> +               _(UICC_CARD_REQ);
>> +               _(UICC_CARD_RESP);
>> +               _(UICC_CARD_IND);
>> +               _(UICC_APPLICATION_REQ);
>> +               _(UICC_APPLICATION_RESP);
>> +               _(UICC_APPLICATION_IND);
>> +               _(UICC_PIN_REQ);
>> +               _(UICC_PIN_RESP);
>> +               _(UICC_PIN_IND);
>> +               _(UICC_APPL_CMD_REQ);
>> +               _(UICC_APPL_CMD_RESP);
>> +               _(UICC_APPL_CMD_IND);
>> +               _(UICC_CONNECTOR_REQ);
>> +               _(UICC_CONNECTOR_RESP);
>> +               _(UICC_CAT_REQ);
>> +               _(UICC_CAT_RESP);
>> +               _(UICC_CAT_IND);
>> +               _(UICC_APDU_REQ);
>> +               _(UICC_APDU_RESP);
>> +               _(UICC_APDU_RESET_IND);
>> +               _(UICC_REFRESH_REQ);
>> +               _(UICC_REFRESH_RESP);
>> +               _(UICC_REFRESH_IND);
>> +               _(UICC_SIMLOCK_REQ);
>> +               _(UICC_SIMLOCK_RESP);
>> +               _(UICC_APDU_SAP_REQ);
>> +               _(UICC_APDU_SAP_RESP);
>> +               _(UICC_APDU_SAP_IND);
>> +               _(UICC_PWR_CTRL_REQ);
>> +               _(UICC_PWR_CTRL_RESP);
>> +               _(UICC_PWR_CTRL_IND);
>> +       }
>> +       return "UICC_<UNKNOWN>";
>> +}
>> +
>
> This UICC stuff seems to be leftovers form patch 8/18.

Well they are related to SMS, debug prints. But yes they are also UICC. =

Do you want them in patch 8 ?

>
>> @@ -664,28 +1334,44 @@ static int isi_sms_probe(struct ofono_sms *sms, u=
nsigned int vendor,
>>         if (sd =3D=3D NULL)
>>                 return -ENOMEM;
>>
>> -       sd->params.absent =3D 0xFF;
>> -       sd->params.alphalen =3D 1; /* Includes final UCS2-coded NUL */
>> +       sd->sim_params.absent =3D 0xFF;
>> +       sd->sim_params.alphalen =3D 1; /* Includes final UCS2-coded NUL =
*/
>> +
>> +       sd->usim_params.indicators =3D 0xFF;
>> +       sd->usim_params.alphalen =3D 0; /* Includes final UCS2-coded NUL=
 */
>> +
>>
>>         sd->client =3D g_isi_client_create(modem, PN_SMS);
>>         if (sd->client =3D=3D NULL)
>>                 goto nomem;
>>
>> -       sd->sim =3D g_isi_client_create(modem, PN_SIM);
>> +       sd->sim =3D g_isi_client_create(modem, PN_UICC);
>> +
>
> After this, the driver will no longer work with N900 or the isimodem plug=
in.

PN_SIM client is created in the UICC client verify callback if it fails, =

do we not get a response to that callback even if UICC fails ?

Regards
Andreas

--===============3652360044411519637==--

