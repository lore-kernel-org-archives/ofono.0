Content-Type: multipart/mixed; boundary="===============1106771773539925435=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 07/13] dundee: Listen to devices property changes
Date: Tue, 12 Mar 2013 10:56:21 +0100
Message-ID: <513EFBC5.6070307@monom.org>
In-Reply-To: <513E11C0.40304@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1106771773539925435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>> +        uuid =3D has_dun_uuid(iter);
>> +
>> +        if (bt_device !=3D NULL && uuid =3D=3D FALSE)
>> +            bluetooth_device_unregister(path);
>> +
>> +        else if (bt_device =3D=3D NULL && uuid =3D=3D TRUE)
>> +            bluetooth_device_register(proxy);
>> +    }
>
> I find this a bit hard to read. What about
>
>      if (uuid)
>          if (bt_device !=3D NULL)
>              bluetooth_device_unregister(path);
>      else
>          if (bt_device =3D=3D NULL)
>              bluetooth_device_regster(path);

Obviously, some braces are needed :)


--===============1106771773539925435==--

