Content-Type: multipart/mixed; boundary="===============6317471429706735574=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v7 6/7] gemalto/lte: Gemalto vendor lte atom
Date: Sat, 20 Oct 2018 11:13:47 -0500
Message-ID: <6a0eb589-2ac3-ea34-db34-0ad1a5999101@gmail.com>
In-Reply-To: <cb95ecab-da1e-878d-89d9-a6d3d5a3d321@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6317471429706735574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

> Using an enumeration to name flags feels awkward.=C2=A0 I would #define t=
hese:
> =

> #define AUTH_F_USE_SGATH (1<<0)
> #define AUTH_F_SWAP_CREDENTIALS (1<<1)
> #define AUTH_F_ALWAYS_ALL_PARAMS (1<<2)

Actually we prefer enums for enumerations with multiple related values =

or ones that can be extended.  It is fine to use a #define if you have a =

single random value, but if you have a series of related flags, just use =

an enum.  This also forces one to keep naming consistent per item M11 of =

doc/coding-style.txt.

The compiler can also treat enums as first class citizens, making them =

available in the debugger, etc.

> =

> Abbreviating ALWAYS to ALW is awkward...

+1

>> +
>> +struct ofono_modem;
> =

> I think you might as well just pull in modem.h here.
> =


This is bad advice.  If the header file is only using a pointer to a =

structure, a forward declaration is enough.  Including the entire =

modem.h file here would just be extra work for the preprocessor and =

compiler, nothing more.  I prefer my compilation times to be fast ;)

>> +static int gemalto_lte_probe(struct ofono_lte *lte, unsigned int vendor,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 GAtChat *chat =3D data;
>> +=C2=A0=C2=A0=C2=A0 struct gemalto_lte_driver_data *ldd;
>> +
>> +=C2=A0=C2=A0=C2=A0 ldd =3D g_new0(struct gemalto_lte_driver_data, 1);
>> +
>> +=C2=A0=C2=A0=C2=A0 ldd->chat =3D g_at_chat_clone(chat);
>> +
>> +=C2=A0=C2=A0=C2=A0 ofono_lte_set_data(lte, ldd);
>> +
>> +=C2=A0=C2=A0=C2=A0 g_idle_add(gemalto_lte_delayed_register, lte);
> =

> Why do you need to delay the registration?

It is not allowed to call register from within the probe method.  That =

is because register might trigger driver method calls, but until probe() =

returns the driver isn't set.  Some atoms do not do this (yet) and you =

can get away with it, but it is bad practice in general.

Regards,
-Denis

--===============6317471429706735574==--

