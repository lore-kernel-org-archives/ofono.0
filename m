Content-Type: multipart/mixed; boundary="===============8770938648749152397=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 07/11] added stk_response_text_string for USSD result
Date: Thu, 02 Sep 2010 02:22:31 +0200
Message-ID: <AANLkTim+N9mXH81UDsMmT2r6twrG2SiUaa-12uUFe9tW@mail.gmail.com>
In-Reply-To: <4C7E724D.8000106@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8770938648749152397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 1 September 2010 17:33, Denis Kenzior <denkenz@gmail.com> wrote:
> On 09/01/2010 06:00 AM, Jeevaka Badrappan wrote:
>> ---
>> =C2=A0src/stkutil.h | =C2=A0 =C2=A08 ++++++++
>> =C2=A01 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/stkutil.h b/src/stkutil.h
>> index 44d167a..66d2e55 100644
>> --- a/src/stkutil.h
>> +++ b/src/stkutil.h
>> @@ -237,6 +237,7 @@ enum stk_result_type {
>> =C2=A0 =C2=A0 =C2=A0 STK_RESULT_TYPE_GO_BACK =3D =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x11,
>> =C2=A0 =C2=A0 =C2=A0 STK_RESULT_TYPE_NO_RESPONSE =3D =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x12,
>> =C2=A0 =C2=A0 =C2=A0 STK_RESULT_TYPE_HELP_REQUESTED =3D =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x13,
>> + =C2=A0 =C2=A0 STK_RESULT_TYPE_USSD_OR_SS_USER_TERMINATION =3D =C2=A0 0=
x14,
>>
>> =C2=A0 =C2=A0 =C2=A0 /* 0x20 to 0x2F are used to indicate that SIM shoul=
d retry */
>> =C2=A0 =C2=A0 =C2=A0 STK_RESULT_TYPE_TERMINAL_BUSY =3D =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x20,
>> @@ -254,6 +255,7 @@ enum stk_result_type {
>> =C2=A0 =C2=A0 =C2=A0 STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD =3D =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x32,
>> =C2=A0 =C2=A0 =C2=A0 STK_RESULT_TYPE_COMMAND_ID_UNKNOWN =3D =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x33,
>> =C2=A0 =C2=A0 =C2=A0 STK_RESULT_TYPE_MINIMUM_NOT_MET =3D =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x36,
>> + =C2=A0 =C2=A0 STK_RESULT_TYPE_USSD_RETURN_ERROR =3D =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x37,
>> =C2=A0 =C2=A0 =C2=A0 STK_RESULT_TYPE_CALL_CONTROL_PERMANENT =3D =C2=A0 =
=C2=A0 =C2=A0 =C2=A00x39,
>> =C2=A0 =C2=A0 =C2=A0 STK_RESULT_TYPE_BIP_ERROR =3D =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3A,
>> =C2=A0 =C2=A0 =C2=A0 STK_RESULT_TYPE_ACCESS_TECHNOLOGY_ERROR =3D =C2=A0 =
=C2=A0 =C2=A0 0x3B,
>> @@ -1445,6 +1447,11 @@ struct stk_response_run_at_command {
>> =C2=A0 =C2=A0 =C2=A0 const char *at_response;
>> =C2=A0};
>>
>> +struct stk_response_text_string {
>> + =C2=A0 =C2=A0 unsigned char dcs;
>> + =C2=A0 =C2=A0 const unsigned char *text;
>> +};
>> +
>
> 3GPP 31.111 says that the terminal response to Send USSD should contain
> a simple Text String. =C2=A0The DCS of the text string in STK is different
> from DCS that is returned by USSD. =C2=A0Copying it directly from the USSD
> DCS seems incorrect. =C2=A0Or is there something I'm missing?

On irc we figured that the best hint about what is expected to be
returned is in the tests in 31.124.  +CUSD returns sms-like DCS, while
STK expects Cell Broadcast-like DCS and recommends using only the
values 00, 04, 08, so there needs to be a translation from one to the
other (perhaps in stk.c in the ussd callback).  I think you'll also
need a length field in this struct as the data can contain 0s.

Best regards

--===============8770938648749152397==--

