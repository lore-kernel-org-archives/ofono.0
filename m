Content-Type: multipart/mixed; boundary="===============1556329056057991807=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH 0/3] oFono rules update
Date: Wed, 24 Aug 2011 12:34:01 +0200
Message-ID: <4E54D399.9010306@linux.intel.com>
In-Reply-To: <1314115995.3373.211.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1556329056057991807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 08/23/2011 06:13 PM, Marcel Holtmann wrote:
> Hi Phillipe,
>
>>>> Based on the latest usb_modeswitch rules, some 3G dongles require
>>>> to modify the ofono rules to be supported correctly (tests done in Ind=
ia)
>>>>
>>>>
>>>> Philippe Nunes (3):
>>>>     udev: use ttyUSB3 for ZTE K3570 modem port.
>>>>     udev:  add support for Olive HSDPA modem
>>>>     udev: Use ttyUSB4 for Huawei E367 Pcui port
>>>>
>>>>    plugins/ofono.rules |   17 ++++++++++-------
>>>>    1 files changed, 10 insertions(+), 7 deletions(-)
>>>
>>> I think you are way too late with these changes. We are not using
>>> plugins/udev.c for Huawei and ZTE device detection anymore. I fixed this
>>> all up and plugins/udevng.c should do proper automatic detection.
>>>
>>> Please check if this works properly for you or if you have problems.
>>>
>>
>>
>> Hi Marcel,
>>
>> I just experienced a case where the automatic detection brings a
>> difference with the previous implementation.
>>
>> Using the dongle ZTE MF190 (DefaultProduct=3D 0x0149 TargetProduct=3D
>> 0x0124), udevng.c is assigning the modem port to ttyUSB3 whereas ttyUSB4
>> was assigned with the previous udev.c based on the previous ofono.rules.
>>
>> In practice, the port com ttyUSB3 is not responsive (I checked also with
>> minicom) so we can't manage to connect a data call (see ofono logs in
>> attachment). Using the previous combination udev.c  + ofono.rules, if
>> the modem port assigned to ttyUSB4 is responsive, we are however facing
>> with an other issue:
>>
>> ofonod[23908]: plugins/zte.c:zte_post_online() 0x9e2a470
>> ofonod[23908]: Aux:>  AT+CREG=3D?\r
>> ofonod[23908]: Aux:<  \r\nOK\r\n
>> ofonod[23908]: Unable to initialize Network Registration
>> ofonod[23908]: src/network.c:netreg_remove() atom: 0x9e29cf0
>>
>>
>> So, we can't go ahead for the data call since the network is not
>> registered. But this is an other issue we would need to fix I guess
>> specifically for this dongle.
>>
>> Here, I just wanted to raise a potential issue regarding the modem port
>> com assignment for ZTE dongles:
>>
>> Indeed, according the previous ofono.rules, we were assigning ttyUSB4 as
>> modem port for 2 product Ids:
>>
>> ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0121",
>> ENV{ID_USB_INTERFACE_NUM}=3D=3D"04", ENV{OFONO_ZTE_TYPE}=3D"modem"
>> ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0121",
>> ENV{ID_USB_INTERFACE_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
>>
>> ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124",
>> ENV{ID_USB_INTERFACE_NUM}=3D=3D"04", ENV{OFONO_ZTE_TYPE}=3D"modem"
>> ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124",
>> ENV{ID_USB_INTERFACE_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
>>
>> but looking to udevng.c and particularly the function 'setup_zte', the
>> modem port can't be assigned anymore to ttyUSB4.
>>
>> static gboolean setup_zte(struct modem_info *modem)
>> {
>> 	...
>>
>> 	if (g_strcmp0(info->number, "00") =3D=3D 0)
>> 		qcdm =3D info->devnode;
>> 	else if (g_strcmp0(info->number, "01") =3D=3D 0)
>> 		aux =3D info->devnode;
>> 	else if (g_strcmp0(info->number, "02") =3D=3D 0)
>> 		mdm =3D info->devnode;
>> 	else if (g_strcmp0(info->number, "03") =3D=3D 0)
>> 		mdm =3D info->devnode;
>> 	}
>> }
>>
>> So, I wonder if the condition:
>> 	=

>> 	else if (g_strcmp0(info->number, "04") =3D=3D 0)
>>
>> is voluntarily missing or not.
>
> it might be missing. What does usb-devices say and how many TTY is this
> one actually creating. If it creates indeed 5 TTY and the fourth TTY is
> on interface number 04, then yes this should be added.
>
> The general rule for ZTE is that the modem interface is suppose to be on
> the last interface. Not sure if this is always true, but with all my
> devices it was. And we could still overwrite this with a udev rule if we
> have to.
>
> Regards
>
> Marcel
>
>
>

Hi Marcel,

Actually, with this dongle, we have 6 TTY (usb0 -> usb5) and usb-devices =

gives:

T:  Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D00 Cnt=3D01 Dev#=3D 32 Spd=3D480 MxC=
h=3D 0
D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D19d2 ProdID=3D0124 Rev=3D00.00
S:  Manufacturer=3DZTE,Incorporated
S:  Product=3DZTE WCDMA Technologies MSM
S:  SerialNumber=3DP671A2TMED010000
C:  #Ifs=3D 7 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
I:  If#=3D 3 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
I:  If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
I:  If#=3D 5 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
I:  If#=3D 6 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50 Driver=
=3Dusb-storage

Now, ttyUSB5 is not responsive. So, for this particular dongle, the =

modem interface won't be on the last interface. Anyway, as I'm just =

looking to add the condition related to the interface number 04, it =

doesn't really matter.

Regards,

Philippe.









--===============1556329056057991807==--

