Content-Type: multipart/mixed; boundary="===============1211748834629057032=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] gemalto: support ALS3 in gemalto's plugin
Date: Mon, 19 Mar 2018 08:50:23 -0500
Message-ID: <da322612-43b7-b3c8-9113-1c552c2f3015@gmail.com>
In-Reply-To: <04d0b76b-3c78-1ec7-9b20-f74c41713f36@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1211748834629057032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

>>> +=C2=A0=C2=A0=C2=A0 if(app =3D=3D NULL)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>
>> Not our coding style.=C2=A0 Also, the "Application" property should not =

>> disappear under you, so I would leave this check out.
> Is it like this :
> /* foo bar
>  =C2=A0* bar
> */
> or
> /*
>  =C2=A0* foo bar
>  =C2=A0* bar
> */
> ?

For multi-line comments it the latter. See doc/coding-style.txt item M2. =

  For single line comments:
/* foo bar */ is acceptable.

However, I meant there's no space between if and () I believe.

>>> +
>>> +=C2=A0=C2=A0=C2=A0 app =3D ofono_modem_get_string(modem, "Application"=
);
>>> +=C2=A0=C2=A0=C2=A0 mdm =3D ofono_modem_get_string(modem, "Modem");
> Here, I've realized I'm getting the "Modem" property but I'm not
> opening it. Should I still get it here such that I could check that it
> isn't NULL ? Or do you prefer it to be handled in gemalto_initialize() ?

I would check it here since the error path is easier.

Regards,
-Denis

--===============1211748834629057032==--

