Content-Type: multipart/mixed; boundary="===============0667507071125287561=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/2] common: add long dial string support
Date: Mon, 22 Nov 2010 05:00:24 -0600
Message-ID: <4CEA4D48.3000301@gmail.com>
In-Reply-To: <4CE5104B.9080305@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0667507071125287561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

On 11/18/2010 05:38 AM, Arun Ravindran wrote:
> Hi Denis, Marcel, Andras,
> =

>>   include/types.h |    2 +-
>>   src/common.c    |   12 ++++++------
>>   2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/types.h b/include/types.h
>> index ba2481f..b3d2247 100644
>> --- a/include/types.h
>> +++ b/include/types.h
>> @@ -76,7 +76,7 @@ struct ofono_error {
>>       int error;
>>   };
>>
>> -#define OFONO_MAX_PHONE_NUMBER_LENGTH 20
>> +#define OFONO_MAX_PHONE_NUMBER_LENGTH 120
>>
>>   struct ofono_phone_number {
>>       char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
>> diff --git a/src/common.c b/src/common.c
>> index b5b9a6f..de5a508 100644
>> --- a/src/common.c
>> +++ b/src/common.c
>> @@ -253,7 +253,7 @@ gboolean valid_phone_number_format(const char
>> *number)
>>           if (number[i]>=3D '0'&&  number[i]<=3D '9')
>>               continue;
>>
>> -        if (number[i] =3D=3D '*' || number[i] =3D=3D '#')
>> +        if (number[i] =3D=3D '*' || number[i] =3D=3D '#' || number[i] =
=3D=3D 'p')
>>               continue;
>>    =

> This function is used to check the phone number as valid in other places
> too.
> =

> Is it right to allow sms sending to numbers with '*', '#' and 'p' in it?
> I think ofono should return an error for the sms case.
> =


Arun has nailed it, hacking valid_phone_number_format is not the right
way to go.  You need to separate this out a bit for the particular usecase.

Regards,
-Denis

--===============0667507071125287561==--

