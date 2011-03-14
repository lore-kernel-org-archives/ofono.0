Content-Type: multipart/mixed; boundary="===============2054730323391990590=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] Isimodem: Crash while setting SCA
Date: Mon, 14 Mar 2011 13:49:35 +0200
Message-ID: <AANLkTin7-R=A6K5me6pGNnx2gaLAVjW04nTsmk1Nx0jY@mail.gmail.com>
In-Reply-To: <4D7A7F32.5040408@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2054730323391990590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2011/3/11 Denis Kenzior <denkenz@gmail.com>:
>> diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
>> index 957b342..c90c06d 100644
>> --- a/drivers/isimodem/sms.c
>> +++ b/drivers/isimodem/sms.c
>> @@ -292,7 +292,7 @@ static void isi_sca_set(struct ofono_sms *sms,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { &sd->params, sizeof(s=
d->params) },
>> =C2=A0 =C2=A0 =C2=A0 };
>>
>> - =C2=A0 =C2=A0 if (cbd =3D=3D NULL || sd =3D=3D NULL)
>> + =C2=A0 =C2=A0 if (cbd =3D=3D NULL || sd =3D=3D NULL || sd->sim =3D=3D =
NULL)
>
> The check for sd =3D=3D NULL is too late since sd->params is being used up
> above for initialization of iov...

That's right. However, the only way for sd =3D=3D NULL would be that core
first called remove() and then sca_set(), which should not happen.

So I think I will just remove that check.

Cheers,
Aki

--===============2054730323391990590==--

