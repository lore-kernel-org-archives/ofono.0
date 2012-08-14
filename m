Content-Type: multipart/mixed; boundary="===============8678760940228748634=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: [PATCH 6/8] gprs: data bearer for telit with PSNT
Date: Tue, 14 Aug 2012 17:39:31 +0200
Message-ID: <502A7133.1010307@hale.at>
In-Reply-To: <502913AF.5020603@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8678760940228748634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 13/08/12 16:48, Denis Kenzior wrote:
> Hi Christopher,
>
> On 08/13/2012 08:23 AM, Christopher Vogl wrote:
>> From: August Mayer<august.mayer@hale.at>
>>
>> Telit neither supports '+CPSB' nor reports the data bearer through
>> '+CGREG'. It has its own +PSNT command.
>> ---
>>   drivers/atmodem/gprs.c |   76 =

>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 76 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
>> index f87548e..ffb8dfe 100644
>> --- a/drivers/atmodem/gprs.c
>> +++ b/drivers/atmodem/gprs.c
>> @@ -44,6 +44,7 @@
>>
>>   static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
>>   static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
>> +static const char *psnt_prefix[] =3D { "#PSNT:", NULL };
>>   static const char *none_prefix[] =3D { NULL };
>>
>>   struct gprs_data {
>> @@ -247,6 +248,73 @@ static void huawei_mode_notify(GAtResult =

>> *result, gpointer user_data)
>>       ofono_gprs_bearer_notify(gprs, bearer);
>>   }
>>
>> +static gint psnt_to_bearer(gint network_type)
>> +{
>> +    gint bearer;
>> +
>> +    switch (network_type) {
>> +    case 0:
>> +        bearer =3D 1;    /* GPRS */
>> +        break;
>> +    case 1:
>> +        bearer =3D 2;    /* EDGE */
>> +        break;
>> +    case 2:
>> +        bearer =3D 3;    /* UMTS */
>> +        break;
>> +    case 3:
>> +        bearer =3D 5;    /* HSDPA */
>> +        break;
>> +    default:
>> +        bearer =3D 0;
>> +        break;
>> +    }
>> +
>> +    return bearer;
>> +}
>> +
>> +static void at_psnt_test_cb(gboolean ok, GAtResult *result,
>> +                gpointer user_data)
>
> Just a minor nitpick, but we usually call this '_query'.
>
>> +{
>> +    struct ofono_gprs *gprs =3D user_data;
>> +    GAtResultIter iter;
>> +    gint nt, bearer;
>> +
>> +    g_at_result_iter_init(&iter, result);
>> +
>> +    if (!g_at_result_iter_next(&iter, "#PSNT:"))
>> +        return;
>> +
>> +    if (!g_at_result_iter_next_number(&iter, NULL))
>> +        return;
>> +
>> +    if (!g_at_result_iter_next_number(&iter,&nt))
>> +        return;
>> +
>> +    bearer =3D psnt_to_bearer(nt);
>> +
>> +    ofono_gprs_bearer_notify(gprs, bearer);
>> +}
>> +
>> +static void telit_mode_notify(GAtResult *result, gpointer user_data)
>> +{
>> +    struct ofono_gprs *gprs =3D user_data;
>> +    GAtResultIter iter;
>> +    gint nt, bearer;
>> +
>> +    g_at_result_iter_init(&iter, result);
>> +
>> +    if (!g_at_result_iter_next(&iter, "#PSNT:"))
>> +        return;
>> +
>> +    if (!g_at_result_iter_next_number(&iter,&nt))
>> +        return;
>> +
>> +    bearer =3D psnt_to_bearer(nt);
>> +
>> +    ofono_gprs_bearer_notify(gprs, bearer);
>> +}
>> +
>>   static void cpsb_notify(GAtResult *result, gpointer user_data)
>>   {
>>       struct ofono_gprs *gprs =3D user_data;
>> @@ -281,6 +349,14 @@ static void gprs_initialized(gboolean ok, =

>> GAtResult *result, gpointer user_data)
>>           g_at_chat_register(gd->chat, "^MODE:", huawei_mode_notify,
>>                           FALSE, gprs, NULL);
>>           break;
>> +    case OFONO_VENDOR_TELIT:
>> +        g_at_chat_register(gd->chat, "#PSNT:", telit_mode_notify,
>> +                        FALSE, gprs, NULL);
>> +        g_at_chat_send(gd->chat, "AT#PSNT=3D1", none_prefix,
>> +                        NULL, NULL, NULL);
>> +        g_at_chat_send(gd->chat, "AT#PSNT?", psnt_prefix,
>> +            at_psnt_test_cb, gprs, NULL);
>
> Do you really need to query this?  In theory if we are turning off =

> auto-attach, we should never be in a state where the bearer should be =

> queried.
Once '#PSNT=3D1' is sent, the modem emits #PSNT URCs even just after =

enabling the modem (e.g. after changing the SIM or setting the modem =

online again).
So if the value does not change incidentally in gprs phase, the modem =

will not send an URC. That's why I added the query. Is this ok in this case?

>
>> +        break;
>>       default:
>>           g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify,
>>                           FALSE, gprs, NULL);
>
>

Regards,
Christopher

--
Scanned by MailScanner.


--===============8678760940228748634==--

