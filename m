Content-Type: multipart/mixed; boundary="===============7917865388264078799=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v2] plugins: update ofono rule and udev for
 using	speedupcdma
Date: Wed, 20 Jul 2011 13:07:41 +0200
Message-ID: <4E26B6FD.7030904@linux.intel.com>
In-Reply-To: <1311159743.21109.207.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7917865388264078799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 20/07/2011 13:02, Marcel Holtmann wrote:
> Hi Guillaume,
>
>> -# SpeedUp
>> -ATTRS{idVendor}=3D=3D"1c9e", ENV{OFONO_DRIVER}=3D"speedup"
>> +# SpeedUp 7300
>> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{OFONO_DR=
IVER}=3D"speedupcdma"
>> +
>> +# SpeedUp 9800
>> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{OFONO_DR=
IVER}=3D"speedup"
>>
>> -ATTRS{idVendor}=3D=3D"1c9e", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV=
{ID_SERIAL_SHORT}=3D""
>> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ATTRS{serial=
}=3D=3D"1234567890ABCDEF", ENV{ID_SERIAL_SHORT}=3D""
> is the serial number really fake. Adding the content of usb-devices
> script for this specific modem would help here.
>
> Or has this just been copied over from the Huawei entries and we missed
> it in the review?

Sorry I committed a wrong patch, I will send you the right version of =

this patch later.
This serial, is not a fake, in using usb-devices with the dongle I got =

before usb_modeswitch:

T:  Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D00 Cnt=3D01 Dev#=3D 84 Spd=3D480 MxC=
h=3D 0
D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D1c9e ProdID=3D9800 Rev=3D00.00
S:  Manufacturer=3DUSB Modem
S:  Product=3DUSB Modem
S:  SerialNumber=3D1234567890ABCDEF
C:  #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50 Driver=
=3Dusb-storage
I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50 Driver=
=3Dusb-storage


>
>>   ATTRS{idVendor}=3D=3D"2020", ENV{OFONO_DRIVER}=3D"speedup"
>>
>> diff --git a/plugins/udev.c b/plugins/udev.c
>> index a28bea7..b50ca2f 100644
>> --- a/plugins/udev.c
>> +++ b/plugins/udev.c
>> @@ -793,6 +793,8 @@ done:
>>   		add_linktop(modem, udev_device);
>>           else if (g_strcmp0(driver, "speedup") =3D=3D 0)
>>   		add_speedup(modem, udev_device);
>> +	else if (g_strcmp0(driver, "speedupcdma") =3D=3D 0)
>> +		add_speedup(modem, udev_device);
> Coding style mistake here. Tabs vs spaces.
>
> Regards
>
> Marcel
>

Kind regards,
Guillaume

--===============7917865388264078799==--

