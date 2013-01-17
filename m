Content-Type: multipart/mixed; boundary="===============0061023662448541079=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 1/8] hfp_hf: Add NewConnection arguments parsing
Date: Thu, 17 Jan 2013 14:58:43 -0300
Message-ID: <CAKT1EBd5iqcMHNtWE2EQEtUQWkm2cezFsTNqAhevqShZ=z-o7g@mail.gmail.com>
In-Reply-To: <50F83088.2080502@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0061023662448541079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis:

> Please separate this into three patches, one for bluez5.[ch] changes, one
> for media.[ch] changes and one for the hfp_hf_bluez5.c changes. Also, is
> there a compelling reason to not roll media.[ch] into bluez5.[ch]?  It is
> being put into plugins directory and it is not really a plugin.  We made a
> couple exceptions (e.g. for mbpi.c) but I do not really want to make this
> into a habit.

We will analyze if it is better to move media.[ch] functions to
bluez5.[ch] or hfp_hf_bluez5.[ch]

media.[ch]  contains HF related functions, and bluez5.[ch] should
contain common functions used by hfp and others BlueZ 5 based plugins:
sap, dun, ...

>>
>> +typedef void (*PropertyHandler)(DBusMessageIter *iter, gpointer
>> user_data);
>
>
> In general we prefer not to use CamelCase outside of GLib-like code.

Declaration copied from bluez4.c, I will fix this declaration.

>> +
>> +void bluetooth_iter_parse_properties(DBusMessageIter *array,
>> +                                               const char *property, ..=
.)
>
> Is this a copy-paste job out of bluez4.c?

Yes. It is a *partial* copy of bluez4.c with minor changes. If the
plan is to drop BlueZ 4 support, we need avoid including bluez4.h
header.

>> +       *garray =3D g_array_sized_new(TRUE, TRUE, sizeof(guint8), n);
>
> Please just use g_memdup instead and stay away from GArray.  oFono does n=
ot
> use GArray anywhere else and I do not really want to start.  The long-term
> plan is to get rid of GLib.  So whenever you can use basic types.

OK. I will fix it.

>> +
>> +               bluetooth_iter_parse_properties(&variant,
>> +                               "Path", parse_string,&path,
>> +                               "Codec", parse_byte,&codec,
>> +                               "Capabilities",
>> parse_byte_array,&capabilities,
>> +                               NULL);
>
>
> Sounds like you should be passing in the endpoint structure here instead
>

Media endpoint structure is opaque, the field are not accessible here
unless we move media.[ch] functions to this file.

Regards,
Claudio

--===============0061023662448541079==--

