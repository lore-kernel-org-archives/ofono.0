Content-Type: multipart/mixed; boundary="===============3172552289390835198=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH 2/5] udev: Add rules to support ZTE MF190 dongle
Date: Mon, 19 Dec 2011 18:45:53 +0100
Message-ID: <4EEF7851.6000209@linux.intel.com>
In-Reply-To: <1324273817.1965.101.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3172552289390835198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/19/2011 06:50 AM, Marcel Holtmann wrote:
> Hi Philippe,
>
>>   plugins/ofono.rules |    3 +++
>>   1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
>> index c7fac57..079db07 100644
>> --- a/plugins/ofono.rules
>> +++ b/plugins/ofono.rules
>> @@ -22,6 +22,9 @@ KERNEL!=3D"ttyUSB[0-9]*", GOTO=3D"ofono_tty_end"
>>   ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{ID_USB_=
INTERFACE_NUM}=3D=3D"02", ENV{OFONO_LABEL}=3D"modem"
>>   ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{ID_USB_=
INTERFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"aux"
>>
>> +ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{ID_USB_I=
NTERFACE_NUM}=3D=3D"04", ENV{OFONO_LABEL}=3D"modem"
>> +ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{ID_USB_I=
NTERFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"aux"
>> +
>>   LABEL=3D"ofono_tty_end"
>>
>>   SUBSYSTEM!=3D"usb", GOTO=3D"ofono_end"
>
> same here. The modem AUX port is always the second TTY and the modem TTY
> is always the last one. Where is this not true?


Actually, with this dongle ZTE MF190, we have 6 TTY (usb0 -> usb5) and =

usb-devices gives:

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

Now, ttyUSB5 is not responsive. So, for this particular dongle, the
modem won't be on the latest interface. In practice, we shall use the =

interface ttyUSB4 for PPP.

Windows Device Manager gives the following results:
Vendor Id: 19d2 / Product Id: 0124 (same as after usb_modeswitch)

ZTE Diagnostic port             - 00
ZTE AT port                 - 01
ZTE ATExt2 port             - 02
ZTE USB SmartCard Reader         - 03
ZTE Proprietary USB Modem         - 04
ZTE Mobile broadband Network manager     - 05

So, it confirms that the modem port com is on ttyUSB4.

To not break the support of ZTE modems with 5 interfaces (which are =

using the 4th one for PPP, like K3570), I can't extend the current logic =

in udevng to take into account the ttyUSB4. So, I added a specific rule =

for ZTE MF190.

Regards,

Philippe.

>
> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>


--===============3172552289390835198==--

