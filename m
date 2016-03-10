Content-Type: multipart/mixed; boundary="===============9139402269763439440=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: Re: [PATCH 08/19] atmodem: add support for U-Blox TOBY L2 modems
Date: Thu, 10 Mar 2016 15:38:50 +0100
Message-ID: <56E186FA.5020207@endocode.com>
In-Reply-To: <56E18610.5060206@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9139402269763439440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/10/2016 03:34 PM, Denis Kenzior wrote:
> Hi Dragos,
> =

> On 03/09/2016 09:44 AM, Dragos Tatulea wrote:
>> Besides exceptions below, act like normal U-Blox devices.
>>
>> gprs-context: don't set auth for TOBY L2. U-Blox Toby L2
>> doesn't support PAP/CHAP APN auth method.
>>
>> atmodem: TOBY L2 supports only CMER mode 1. Also chaged original
>> mode variable to ind, which is a more appropriate name.
>> mode is what is being set first.
>> ---
>>   drivers/atmodem/gprs-context.c         |  2 ++
>>   drivers/atmodem/gprs.c                 |  1 +
>>   drivers/atmodem/network-registration.c | 12 +++++++-----
>>   drivers/atmodem/sim.c                  |  1 +
>>   4 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-conte=
xt.c
>> index f6e6c2e..ab47b25 100644
>> --- a/drivers/atmodem/gprs-context.c
>> +++ b/drivers/atmodem/gprs-context.c
>> @@ -304,6 +304,8 @@ static void at_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
>>                   break;
>>               }
>>               break;
>> +        case OFONO_VENDOR_UBLOX_TOBY_L2:
>> +            /* Above not true for Toby L2 family, default is ok. */
> =

> Why is this needed?
> =

It was needed in an older version of the code. Not needed anymore.

>>           default:
>>               snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
>>                       ctx->apn);
>> diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
>> index 0165253..4505477 100644
>> --- a/drivers/atmodem/gprs.c
>> +++ b/drivers/atmodem/gprs.c
>> @@ -351,6 +351,7 @@ static void gprs_initialized(gboolean ok, GAtResult =
*result, gpointer user_data)
>>                           FALSE, gprs, NULL);
>>           break;
>>       case OFONO_VENDOR_UBLOX:
>> +    case OFONO_VENDOR_UBLOX_TOBY_L2:
>>           g_at_chat_register(gd->chat, "+UREG:", ublox_ureg_notify,
>>                           FALSE, gprs, NULL);
>>           g_at_chat_send(gd->chat, "AT+UREG=3D1", none_prefix,
>> diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/ne=
twork-registration.c
>> index 7cfd6b2..81e8b8d 100644
>> --- a/drivers/atmodem/network-registration.c
>> +++ b/drivers/atmodem/network-registration.c
>> @@ -1580,8 +1580,10 @@ static inline ofono_bool_t append_cmer_element(ch=
ar *buf, int *len, int cap,
>>   static ofono_bool_t build_cmer_string(char *buf, int *cmer_opts,
>>                       struct netreg_data *nd)
>>   {
>> -    const char *mode;
>> +    const char *ind;
>>       int len =3D sprintf(buf, "AT+CMER=3D");
>> +    /* UBX-13002752 R33: TOBY L2 doesn't support mode 2 and 3 */
>> +    const char *mode =3D nd->vendor =3D=3D OFONO_VENDOR_UBLOX_TOBY_L2 ?=
 "1":"3";
> =

> Lets make this into a switch/case statement.
> =

> e.g. const char *mode;
> =

>>
>>       DBG("");
> =

> switch (nd->vendor) {
> case OFONO_VENDOR_UBLOX_TOBY_L2:
>     mode =3D 1;
>     break;
> default:
>     mode =3D 3;
>     break;
> }
> =

Will do.

>>
>> @@ -1590,7 +1592,7 @@ static ofono_bool_t build_cmer_string(char *buf, i=
nt *cmer_opts,
>>        * TA=E2=80=91TE link specific inband technique used to embed resu=
lt codes and
>>        * data when TA is in on=E2=80=91line data mode
>>        */
>> -    if (!append_cmer_element(buf, &len, cmer_opts[0], "3", FALSE))
>> +    if (!append_cmer_element(buf, &len, cmer_opts[0], mode, FALSE))
>>           return FALSE;
>>
>>       /* No keypad event reporting */
>> @@ -1607,14 +1609,14 @@ static ofono_bool_t build_cmer_string(char *buf,=
 int *cmer_opts,
>>            * Telit does not support mode 1.
>>            * All indicator events shall be directed from TA to TE.
>>            */
>> -        mode =3D "2";
>> +        ind =3D "2";
>>           break;
>>       default:
>>           /*
>>            * Only those indicator events, which are not caused by +CIND
>>            * shall be indicated by the TA to the TE.
>>            */
>> -        mode =3D "1";
>> +        ind =3D "1";
>>           break;
>>       }
>>
>> @@ -1623,7 +1625,7 @@ static ofono_bool_t build_cmer_string(char *buf, i=
nt *cmer_opts,
>>        * <ind> indicates the indicator order number (as specified for +C=
IND)
>>        * and <value> is the new value of indicator.
>>        */
>> -    if (!append_cmer_element(buf, &len, cmer_opts[3], mode, TRUE))
>> +    if (!append_cmer_element(buf, &len, cmer_opts[3], ind, TRUE))
>>           return FALSE;
>>
>>       return TRUE;
>> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
>> index d6a0dcf..081d342 100644
>> --- a/drivers/atmodem/sim.c
>> +++ b/drivers/atmodem/sim.c
>> @@ -1120,6 +1120,7 @@ static void at_pin_retries_query(struct ofono_sim =
*sim,
>>               return;
>>           break;
>>       case OFONO_VENDOR_UBLOX:
>> +    case OFONO_VENDOR_UBLOX_TOBY_L2:
>>           if (g_at_chat_send(sd->chat, "AT+UPINCNT", upincnt_prefix,
>>                       upincnt_cb, cbd, g_free) > 0)
>>               return;
>>
> =

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

Thanks
-- =

Dragos Tatulea
Software Developer @ Endocode AG
dragos(a)endocode.com

Endocode AG, Br=C3=BCckenstra=C3=9Fe 5A, 10179 Berlin
+49 30 1206 4472 | info(a)endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Thomas Fricke, Sebastian Sucker
Aufsichtsratsvorsitzende: Alexandra Boehm

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B

--===============9139402269763439440==--

