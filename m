Content-Type: multipart/mixed; boundary="===============2755453661203539720=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH qmi lte v3 3/6] qmi: activate default bearer context for
 LTE networks
Date: Mon, 17 Apr 2017 21:57:17 +0200
Message-ID: <35560cf1-ac0a-6be8-785f-a173c0f7dc26@southpole.se>
In-Reply-To: <d50277a3-c92e-1419-0c96-d5ece9519d83@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2755453661203539720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 04/17/2017 07:37 PM, Denis Kenzior wrote:
> Hi Jonas,
> -static bool extract_ss_info(struct qmi_result *result, int *status)
>> +static int rat_to_tech(uint8_t rat)
>> +{
>> +    switch (rat) {
>> +    case QMI_NAS_NETWORK_RAT_GSM:
>> +        return ACCESS_TECHNOLOGY_GSM;
>> +    case QMI_NAS_NETWORK_RAT_UMTS:
>> +        return ACCESS_TECHNOLOGY_UTRAN;
>> +    case QMI_NAS_NETWORK_RAT_LTE:
>> +        return ACCESS_TECHNOLOGY_EUTRAN;
>> +    }
>> +
>> +    return -1;
>> +}
>> +
>
> You might want to put this into drivers/qmimodem/nas.c as:
>
> qmi_nas_rat_to_tech() and use it from both the netreg and gprs drivers

Good idea... will do!

>
>> -static void ss_info_notify(struct qmi_result *result, void *user_data)
>> +/*
>> + * This method handles both Serving System Info requests and
>> + * notifications.  The presence of a callback differentiates between
>> + * the two and the result is handled slightly differently accordingly.
>> + * If there's a callback, we invoke it; otherwise we send a =

>> notification
>> + * to ofono about relevant state changes.
>> + */
>
> No, please don't do this, the notification callback and the query =

> callback should be different functions.  If you need to perform some =

> common operations, then just extract those into a common function and =

> call it from both.

drivers/rilmodem/gprs-context.c, as one example, uses this pattern. =

Personally, I find it rather elegant!

>>      CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
>> @@ -163,6 +225,7 @@ static void create_nas_cb(struct qmi_service =

>> *service, void *user_data)
>>  {
>>      struct ofono_gprs *gprs =3D user_data;
>>      struct gprs_data *data =3D ofono_gprs_get_data(gprs);
>> +    struct cb_data *cbd;
>>
>>      DBG("");
>>
>> @@ -178,11 +241,15 @@ static void create_nas_cb(struct qmi_service =

>> *service, void *user_data)
>>       * First get the SS info - the modem may already be connected,
>>       * and the state-change notification may never arrive
>>       */
>> +    cbd =3D cb_data_new(NULL, NULL);
>> +    cbd->user =3D gprs;
>>      qmi_service_send(data->nas, QMI_NAS_GET_SS_INFO, NULL,
>> -                    ss_info_notify, gprs, NULL);
>> +                    handle_ss_info, cbd, g_free);
>>
>> +    cbd =3D cb_data_new(NULL, NULL);
>> +    cbd->user =3D gprs;
>>      qmi_service_register(data->nas, QMI_NAS_SS_INFO_IND,
>> -                    ss_info_notify, gprs, NULL);
>> +                    handle_ss_info, cbd, g_free);
>
> No, the original form was completely fine.

handle_ss_info takes a cbd user_data argument, not a gprs argument. But =

if handle_ss_info is not acceptable, then I guess the above is fine.

/Jonas


--===============2755453661203539720==--

