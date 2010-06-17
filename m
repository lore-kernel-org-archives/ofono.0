Content-Type: multipart/mixed; boundary="===============7265193506216058896=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 10/12] stk: Add parser for timing advance objects
Date: Thu, 17 Jun 2010 09:44:32 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731ED17929@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <AANLkTilCbhxMpJeulCWXzveOWEeUnRoZVR3BwfblqyjG@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7265193506216058896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>andrzej zaborowski
>Sent: Thursday, June 17, 2010 7:19 AM
>To: ofono(a)ofono.org
>Subject: Re: [PATCH 10/12] stk: Add parser for timing advance objects
>
>Hi,
>
>On 13 June 2010 11:43, Yang Gu <yang.gu@intel.com> wrote:
>> +enum stk_me_status {
>> + =C2=A0 =C2=A0 =C2=A0 STK_ME_STATUS_IDLE =3D =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x00,
>> + =C2=A0 =C2=A0 =C2=A0 STK_ME_STATUS_NOT_IDLE =3D =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x01
>> +};
>> +
>> =C2=A0/* For data object that only has a byte array with undetermined le=
ngth */
>> =C2=A0struct stk_common_byte_array {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char *array;
>> @@ -671,6 +676,18 @@ struct stk_timer_value {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char second;
>> =C2=A0};
>>
>> +/* Defined in TS 31.111 Section 8.46 */
>> +struct stk_timing_advance {
>> + =C2=A0 =C2=A0 =C2=A0 ofono_bool_t has_value;
>> + =C2=A0 =C2=A0 =C2=A0 unsigned char status;
>
>Why change the status to char here?  I think using an enum here is
>nicer because it gives a hint to users about what values are expected
>and the compiler can emit warnings if needed.

Agree and I will change this to enum. =


>
>Regards
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

Regards,
-Yang

--===============7265193506216058896==--

