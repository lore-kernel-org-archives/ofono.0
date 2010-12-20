Content-Type: multipart/mixed; boundary="===============8896684459478394761=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH v2 7/9] ofono-rules: Add cdmagen device
Date: Mon, 20 Dec 2010 10:31:55 -0800
Message-ID: <4D0FA11B.3090808@nokia.com>
In-Reply-To: <1292697065.2658.14.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8896684459478394761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel

On 12/18/2010 10:31 AM, ext Marcel Holtmann wrote:
> Hi Dara,
>
>>   plugins/ofono.rules |    4 ++++
>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
>> index da8a8ef..34698f0 100644
>> --- a/plugins/ofono.rules
>> +++ b/plugins/ofono.rules
>> @@ -429,6 +429,10 @@ ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D=
"1311", ENV{OFONO_DRIVER}=3D"mbm"
>>   # Nokia Internet Stick CS-10
>>   ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"060e", ENV{OFONO_D=
RIVER}=3D"nokia"
>>
>> +# Nokia CDMA Device
>> +ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"023e", ENV{OFONO_DR=
IVER}=3D"cdmagen"
>> +ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"00b6", ENV{OFONO_DR=
IVER}=3D"cdmagen"
>> +
>
> since this is Nokia specific device, then using nokiacdma would be a
> better name. Or using OFONO_DRIVER=3Dnokia NOKIA_MODE=3Dcdma and sharing =
the
> driver might be useful.
>
> It really all depends how much they have in common.

Nothing. All Nokia CDMA devices actually contain Qualcomm modems, so =

perhaps a better name may be along the lines of "msmcdmamodem" for CDMA =

AT modem devices in a tethered mode?

So what kind of
> hardware is this actually? A phone or a real USB dongle?
>
It is a phone.

Cheers
Dara

--===============8896684459478394761==--

