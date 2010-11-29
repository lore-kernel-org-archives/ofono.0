Content-Type: multipart/mixed; boundary="===============6637433290847614965=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 2/3] stk: Handle provide local info proactive command
Date: Mon, 29 Nov 2010 10:47:39 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A473306DF4B0@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4CF01D51.4050102@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6637433290847614965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> diff --git a/src/smsutil.c b/src/smsutil.c
>> index e6dbf5f..5394817 100644
>> --- a/src/smsutil.c
>> +++ b/src/smsutil.c
>> @@ -324,10 +324,10 @@ gboolean sms_encode_scts(const struct sms_scts *in,
>unsigned char *pdu,
>>  	if (in->year > 99)
>>  		return FALSE;
>>
>> -	if (in->month > 12)
>> +	if (in->month > 12 || in->month =3D=3D 0)
>>  		return FALSE;
>>
>> -	if (in->day > 31)
>> +	if (in->day > 31 || in->day =3D=3D 0)
>>  		return FALSE;
>>
>>  	if (in->hour > 23)
>> @@ -339,7 +339,7 @@ gboolean sms_encode_scts(const struct sms_scts *in,
>unsigned char *pdu,
>>  	if (in->second > 59)
>>  		return FALSE;
>>
>> -	if ((in->timezone > 12*4-1) || (in->timezone < -(12*4-1)))
>> +	if ((in->timezone > 12*4) || (in->timezone < -(12*4-1)))
>
>Err, why would +48 be valid?

I think all the timezone should be a circle (24 hours). If it can't be -48,=
 it needs to contain +48. =

Also please see 9.2.6.9 in http://gsm-history.org/fileadmin/user_upload/Key=
_SMS_Documents/GSM_Rec_03.40_v_2.2.0.pdf, which says "The Time Zone may be =
a number in the range -47 to +48".



Regards,
-Yang

--===============6637433290847614965==--

