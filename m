Content-Type: multipart/mixed; boundary="===============8726495767364461955=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH] udev: assign "huaweicdma" OFONO_DRIVER for E156 dongle
Date: Fri, 29 Jul 2011 09:39:37 +0200
Message-ID: <4E3263B9.1060601@linux.intel.com>
In-Reply-To: <1311883944.8920.118.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8726495767364461955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 28/07/2011 22:12, Marcel Holtmann wrote:
> Hi Guillaume,
>
>>   plugins/ofono.rules |  217 +++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>>   1 files changed, 216 insertions(+), 1 deletions(-)
>>
>> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
>> index f8e485b..94eb061 100644
>> --- a/plugins/ofono.rules
>> +++ b/plugins/ofono.rules
>> @@ -412,7 +412,222 @@ ATTRS{idVendor}=3D=3D"1199", ENV{OFONO_DRIVER}=3D"=
sierra"
>>   ATTRS{idVendor}=3D=3D"1199", ATTRS{serial}=3D=3D"1234567890ABCDEF", EN=
V{ID_SERIAL_SHORT}=3D""
>>
>>   # HUAWEI Technology
>> -ATTRS{idVendor}=3D=3D"12d1", ENV{OFONO_DRIVER}=3D"huawei"
>> +
>> +# Generic 0x1001
>> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1001", ENV{OFONO_DR=
IVER}=3D"huawei"
>> +
>> +# Generic 0x1003
>> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1003", ENV{OFONO_DR=
IVER}=3D"huawei"
>> +
>> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_DR=
IVER}=3D"huawei"
>> +
>> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1401", ENV{OFONO_DR=
IVER}=3D"huawei"
>> +
>> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1402", ENV{OFONO_DR=
IVER}=3D"huawei"
>> +
>> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_DR=
IVER}=3D"huawei"
>> +
>> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1405", ENV{OFONO_DR=
IVER}=3D"huawei"
>> +
>> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1406", ENV{OFONO_DR=
IVER}=3D"huawei"
>> +
>> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1408", ENV{OFONO_DR=
IVER}=3D"huawei"
>> +
>> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1409", ENV{OFONO_DR=
IVER}=3D"huawei"
>> +
>> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"140a", ENV{OFONO_DR=
IVER}=3D"huawei"
>> +
>> +# E156
>> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"140b", ENV{OFONO_DR=
IVER}=3D"huaweicdma"
> just make this one special and have it overwrite the previous one. No
> need for touching everything.
>

It seems Denis has just done it.

Kind regards,
Guillaume

--===============8726495767364461955==--

