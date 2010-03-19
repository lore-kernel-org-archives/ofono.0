Content-Type: multipart/mixed; boundary="===============7213628620824102365=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] Checking PIN length based on its type (PIN / PUK / NET).
Date: Fri, 19 Mar 2010 19:50:35 +0200
Message-ID: <80fd4e751003191050j42ef6b96ld6912ffb0ae3da7a@mail.gmail.com>
In-Reply-To: <201003191025.32736.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7213628620824102365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Uh-oh. I'll fix those and try to test it without checks in isidriver...

--Pekka

2010/3/19 Denis Kenzior <denkenz@gmail.com>:
> Hi Pekka,
>
>> -gboolean is_valid_pin(const char *pin)
>> +gboolean is_valid_pin(const char *pin, enum pin_type type)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 unsigned int i;
>>
>> @@ -588,14 +588,30 @@ gboolean is_valid_pin(const char *pin)
>> =C2=A0 =C2=A0 =C2=A0 if (pin =3D=3D NULL || pin[0] =3D=3D '\0')
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
>>
>> - =C2=A0 =C2=A0 for (i =3D 0; i < strlen(pin); i++)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pin[i] < '0' || pin[i] >=
 '9')
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return FALSE;
>> -
>> - =C2=A0 =C2=A0 if (i > 8)
>> + =C2=A0 =C2=A0 i =3D strlen(pin);
>> + =C2=A0 =C2=A0 if (i !=3D strspn(pin, "012345679"))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
>>
>> - =C2=A0 =C2=A0 return TRUE;
>> + =C2=A0 =C2=A0 switch (type)
>> + =C2=A0 =C2=A0 {
>> + =C2=A0 =C2=A0 case PIN_TYPE_PIN:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 11.11 Section 9.3 ("CHV")=
: 4..8 IA-5 digits */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (4 <=3D i && i <=3D 8)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return TRUE;
>
> This looks wrong, 'break' is missing.
>
>> + =C2=A0 =C2=A0 case PIN_TYPE_PUK:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 11.11 Section 9.3 ("UNBLO=
CK CHV"), 8 IA-5 digits */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 8)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return TRUE;
>
> Same here
>
>> + =C2=A0 =C2=A0 case PIN_TYPE_NET:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 22.004 Section 5.2, 4 IA-=
5 digits */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 4)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return TRUE;
>
> And here
>
>> + =C2=A0 =C2=A0 case PIN_TYPE_NONE:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i < 8)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return TRUE;
>> + =C2=A0 =C2=A0 }
>
> and here
>
>> +
>> + =C2=A0 =C2=A0 return FALSE;
>> =C2=A0}
>
>>
>> -gboolean is_valid_pin(const char *pin);
>> +
>> +
>> +gboolean is_valid_pin(const char *pin, enum pin_type type);
>
> Why the extra lines?
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>



-- =

Pekka.Pessi mail at nokia.com

--===============7213628620824102365==--

