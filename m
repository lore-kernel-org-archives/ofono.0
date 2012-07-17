Content-Type: multipart/mixed; boundary="===============2376511333381105155=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH] util: Fix GSM to UTF8 conversion mechanism
Date: Tue, 17 Jul 2012 10:41:46 +0200
Message-ID: <5005254A.6000309@linux.intel.com>
In-Reply-To: <50036521.4030005@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2376511333381105155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 16/07/2012 02:49, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 07/16/2012 09:34 AM, Guillaume Zajac wrote:
>> ---
>>   src/util.c |   17 ++++++++++++++---
>>   1 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/util.c b/src/util.c
>> index aecc790..41ef3d4 100644
>> --- a/src/util.c
>> +++ b/src/util.c
>> @@ -628,8 +628,16 @@ char *convert_gsm_to_utf8_with_lang(const =

>> unsigned char *text, long len,
>>
>>               c =3D gsm_single_shift_lookup(&t, text[i]);
>>
>> +            /*
>> +             * According to the 3GPP specifications 23.038
>> +             * section 6.2.1.1:
>> +             * In the case there is no character in the extension
>> +             * table, the character of the main default alphabet
>> +             * table or the character from the National Language
>> +             * Locking Shift Table should be displayed.
>> +             */
>
> What version of 23.038 are you using? I cannot find such wording in R9 =

> or R10 specs.

It is not the exact wording, I have just rephrased the comment.
The exact wording it just below the GSM 7 bits default alphabet =

extension table in section 6.2.1.1
Generally, do you prefer having an exact extract of the 3GPP spec or =

just an explanation of what is happening?

>
>>               if (c =3D=3D GUND)
>> -                goto error;
>> +                c =3D gsm_locking_shift_lookup(&t, text[i]);
>>           } else {
>>               c =3D gsm_locking_shift_lookup(&t, text[i]);
>>           }
>> @@ -647,9 +655,12 @@ char *convert_gsm_to_utf8_with_lang(const =

>> unsigned char *text, long len,
>>       while (out<  res + res_length) {
>>           unsigned short c;
>>
>> -        if (text[i] =3D=3D 0x1b)
>> +        if (text[i] =3D=3D 0x1b) {
>>               c =3D gsm_single_shift_lookup(&t, text[++i]);
>> -        else
>> +            /* See 3GPP 23.038 section 6.2.1.1 */
>> +            if (c =3D=3D GUND)
>> +                c =3D gsm_locking_shift_lookup(&t, text[i]);
>> +        } else
>>               c =3D gsm_locking_shift_lookup(&t, text[i]);
>>
>>           out +=3D g_unichar_to_utf8(c, out);
>
> Regards,
> -Denis
>

Kind regards,
Guillaume


--===============2376511333381105155==--

