Content-Type: multipart/mixed; boundary="===============6576747269322905936=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 1/8] hfp_hf: Add NewConnection arguments parsing
Date: Thu, 17 Jan 2013 12:38:01 -0600
Message-ID: <50F84509.8090509@gmail.com>
In-Reply-To: <CAKT1EBd5iqcMHNtWE2EQEtUQWkm2cezFsTNqAhevqShZ=z-o7g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6576747269322905936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 01/17/2013 11:58 AM, Claudio Takahasi wrote:
> Hi Denis:
>
>> Please separate this into three patches, one for bluez5.[ch] changes, one
>> for media.[ch] changes and one for the hfp_hf_bluez5.c changes. Also, is
>> there a compelling reason to not roll media.[ch] into bluez5.[ch]?  It is
>> being put into plugins directory and it is not really a plugin.  We made=
 a
>> couple exceptions (e.g. for mbpi.c) but I do not really want to make this
>> into a habit.
>
> We will analyze if it is better to move media.[ch] functions to
> bluez5.[ch] or hfp_hf_bluez5.[ch]
>
> media.[ch]  contains HF related functions, and bluez5.[ch] should
> contain common functions used by hfp and others BlueZ 5 based plugins:
> sap, dun, ...
>

The media API is also part of BlueZ 5, so it makes sense to move it to me...

<snip>

>>> +
>>> +void bluetooth_iter_parse_properties(DBusMessageIter *array,
>>> +                                               const char *property, .=
..)
>>
>> Is this a copy-paste job out of bluez4.c?
>
> Yes. It is a *partial* copy of bluez4.c with minor changes. If the
> plan is to drop BlueZ 4 support, we need avoid including bluez4.h
> header.
>

Perhaps this part needs to be moved into another utility file.  Either =

inside gdbus or into src/dbus.c.

<snip>

>>> +
>>> +               bluetooth_iter_parse_properties(&variant,
>>> +                               "Path", parse_string,&path,
>>> +                               "Codec", parse_byte,&codec,
>>> +                               "Capabilities",
>>> parse_byte_array,&capabilities,
>>> +                               NULL);
>>
>>
>> Sounds like you should be passing in the endpoint structure here instead
>>
>
> Media endpoint structure is opaque, the field are not accessible here
> unless we move media.[ch] functions to this file.

One can always implement the parser inside media.c as well.  However, it =

seems to me that long-term you do not want to store both the media =

endpoint objects and the slc_info codecs at the same time.  One or the =

other is enough, they are the same information.

Regards,
-Denis

--===============6576747269322905936==--

