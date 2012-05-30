Content-Type: multipart/mixed; boundary="===============6335070247800836219=="
MIME-Version: 1.0
From: Jens Rehsack <jr_extern@vfnet.de>
Subject: Re: [PATCH] Add WSP_VALUE_TYPE_TEXT support in
 wsp_decode_application_id()
Date: Wed, 30 May 2012 09:11:37 +0200
Message-ID: <4FC5C829.1040900@vfnet.de>
In-Reply-To: <4FBB49C5.70508@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6335070247800836219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 22.05.2012 10:09, Jens Rehsack wrote:
> On 21.05.2012 18:23, Ronald Tessier wrote:
>> Hi Jens,
>>
>> On 05/21/2012 12:54 PM, Jens Rehsack wrote:
>>> From: Jens Rehsack<sno@NetBSD.org>
>>>
>>> ---
>>>   src/wsputil.c |   43 ++++++++++++++++++++++++++-----------------
>>>   1 Datei ge=C3=A4ndert, 26 Zeilen hinzugef=C3=BCgt(+), 17 Zeilen entfe=
rnt(-)
>>>
>>> diff --git a/src/wsputil.c b/src/wsputil.c
>>> index 1b2b2b7..5611ed2 100644
>>> --- a/src/wsputil.c
>>> +++ b/src/wsputil.c
>>> @@ -486,28 +486,37 @@ gboolean wsp_decode_application_id(struct
>>> wsp_header_iter *iter,
>>>                               const void **out_value)
>>>   {
>>>       const unsigned char *pdu_val =3D wsp_header_iter_get_val(iter);
>>> -    unsigned int val;
>>> -    unsigned int val_len;
>>> -    unsigned int i;
>>>
>>> -    /*
>>> -     * Well-known field values MUST be encoded using the
>>> -     * compact binary formats
>>> -     */
>>> -    if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_SHORT=
) {
>>> -        val =3D *pdu_val&  0x7f;
>>> +    if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_TEXT)=
 {
>>> +        wsp_header_iter_get_val_len(iter);
>>> +
>>> +        if (out_value)
>>> +            *out_value =3D pdu_val;
>>
>> Why not just returning if the type is TEXT ?
>> Something like :
>>
>>     const unsigned char *pdu_val =3D wsp_header_iter_get_val(iter);
>>     unsigned int val;
>>     unsigned int val_len;
>>     unsigned int i;
>>
>> +    if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_TEXT) {
>> +        if (out_value)
>> +            *out_value =3D pdu_val;
>> +
>> +        return TRUE;
>> +    }
>> +
>>     /*
>>      * Well-known field values MUST be encoded using the
>>      * compact binary formats
>>      */
>>     if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_SHORT) {
>>
> =

> I do not like several returns in a longer subroutine. The way
> you format code makes code longer - fair enough, but for me to
> long to introduce early return statements.
> =

>> I think it does the same thing but more readable (you don't break the 80
>> col. limit).
> =

> I'm fine with your way to do it, too. But I wouldn't want my name being
> assigned with it (because of the early return ...). I strongly
> distinguish between readable and understandable, and I prefer the
> understandable way.
> =

> How about:
> =

> diff --git a/src/wsputil.c b/src/wsputil.c
> index 1b2b2b7..385acaa 100644
> --- a/src/wsputil.c
> +++ b/src/wsputil.c
> @@ -490,13 +490,26 @@ gboolean wsp_decode_application_id(struct
> wsp_header_iter *iter,
>         unsigned int val_len;
>         unsigned int i;
> =

> +       switch (wsp_header_iter_get_val_type(iter)) {
> +       case WSP_VALUE_TYPE_TEXT:
> +               if (out_value)
> +                       *out_value =3D pdu_val;
> +
> +               break;
> +
>         /*
>          * Well-known field values MUST be encoded using the
>          * compact binary formats
>          */
> -       if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_SHOR=
T) {
> +       case WSP_VALUE_TYPE_SHORT:
>                 val =3D *pdu_val & 0x7f;
> -       } else {
> +
> +               if (out_value)
> +                       *out_value =3D get_text_entry(val, app_id);
> +
> +               break;
> +
> +       default:
>                 val_len =3D wsp_header_iter_get_val_len(iter);
> =

>                 if (val_len > 2)
> @@ -504,10 +517,13 @@ gboolean wsp_decode_application_id(struct
> wsp_header_iter *iter,
> =

>                 for (i =3D 0, val =3D 0; i < val_len && i < sizeof(val); =
i++)
>                         val =3D (val << 8) | pdu_val[i];
> +
> +               if (out_value)
> +                       *out_value =3D get_text_entry(val, app_id);
> +
> +               break;
>         }
> =

> -       if (out_value)
> -               *out_value =3D get_text_entry(val, app_id);
> =

>         return TRUE;
>  }
> =

> =

>> Best regards,
>>
>> Ronald
> =

> Best regards,
> Jens
> =

>>>       } else {
>>> -        val_len =3D wsp_header_iter_get_val_len(iter);
>>> +        unsigned int val;
>>>
>>> -        if (val_len>  2)
>>> -            return FALSE;
>>> +        /*
>>> +         * Well-known field values MUST be encoded using the
>>> +         * compact binary formats
>>> +         */
>>> +        if (wsp_header_iter_get_val_type(iter) =3D=3D
>>> WSP_VALUE_TYPE_SHORT) {
>>> +            val =3D *pdu_val&  0x7f;
>>> +        } else  {
>>> +            unsigned int val_len;
>>> +            unsigned int i;
>>>
>>> -        for (i =3D 0, val =3D 0; i<  val_len&&  i<  sizeof(val); i++)
>>> -            val =3D (val<<  8) | pdu_val[i];
>>> -    }
>>> +            val_len =3D wsp_header_iter_get_val_len(iter);
>>>
>>> -    if (out_value)
>>> -        *out_value =3D get_text_entry(val, app_id);
>>> +            if (val_len>  2)
>>> +                return FALSE;
>>> +
>>> +            for (i =3D 0, val =3D 0; i<  val_len&&  i<  sizeof(val); i=
++)
>>> +                val =3D (val<<  8) | pdu_val[i];
>>> +        }
>>> +
>>> +        if (out_value)
>>> +            *out_value =3D get_text_entry(val, app_id);
>>> +    }
>>>
>>>       return TRUE;
>>>   }

What's the state?

/Jens


--===============6335070247800836219==--

