Content-Type: multipart/mixed; boundary="===============4227148731806313953=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH 0/3] oFono rules update
Date: Thu, 25 Aug 2011 15:48:57 +0200
Message-ID: <4E5652C9.8000909@linux.intel.com>
In-Reply-To: <1314202864.3373.219.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4227148731806313953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 08/24/2011 06:21 PM, Marcel Holtmann wrote:
> Hi Philippe,
>
>> Actually, with this dongle, we have 6 TTY (usb0 ->  usb5) and usb-devices
>> gives:
>>
>> T:  Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D00 Cnt=3D01 Dev#=3D 32 Spd=3D480 =
MxCh=3D 0
>> D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
>> P:  Vendor=3D19d2 ProdID=3D0124 Rev=3D00.00
>> S:  Manufacturer=3DZTE,Incorporated
>> S:  Product=3DZTE WCDMA Technologies MSM
>> S:  SerialNumber=3DP671A2TMED010000
>> C:  #Ifs=3D 7 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
>> I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Drive=
r=3Doption
>> I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Drive=
r=3Doption
>> I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Drive=
r=3Doption
>> I:  If#=3D 3 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Drive=
r=3Doption
>> I:  If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Drive=
r=3Doption
>> I:  If#=3D 5 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Drive=
r=3Doption
>> I:  If#=3D 6 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50 Drive=
r=3Dusb-storage
>>
>> Now, ttyUSB5 is not responsive. So, for this particular dongle, the
>> modem interface won't be on the last interface. Anyway, as I'm just
>> looking to add the condition related to the interface number 04, it
>> doesn't really matter.
>
> so on which interfaces do we actually have the modem and the aux channel
> now.
>
Actually, with current udevng.c, aux channel is on ttyUSB1 and modem is =

on ttyUSB3. But in practice, modem should be on ttyUSB4.

> And more important now, do we use the right usb_modeswitch magic to
> switch it into this mode.

My configuration:
usb modeswitch Version 1.1.8, 2011/06/19
usb modeswitch data package 2011/07/14

Or is Windows using something different?

Windows Device Manager gives the following results:

Vendor Id: 19d2 / Product Id: 0124 (same as after usb_modeswitch)

ZTE Diagnostic port		 	- 00
ZTE AT port			 	- 01
ZTE ATExt2 port 			- 02
ZTE USB SmartCard Reader 		- 03
ZTE Proprietary USB Modem 		- 04
ZTE Mobile broadband Network manager 	- 05

So, it confirms that the modem port com is on ttyUSB4.
For ZTE, the proposed change (add the condition related to the interface =

number 04) seems relevant.


Now, I found an other mismatch with Speedup dongles:
In practice, enabling the dongle speedup SU-7300 fails actually in timeout.

Looking to the oFono traces, we have:
...
ofonod[32238]: plugins/udevng.c:setup_speedup() =

/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1
ofonod[32238]: plugins/udevng.c:setup_speedup() /dev/ttyUSB0 255/255/255 =

00 (null)
ofonod[32238]: plugins/udevng.c:setup_speedup() /dev/ttyUSB1 255/255/255 =

01 (null)
ofonod[32238]: plugins/udevng.c:setup_speedup() /dev/ttyUSB2 255/255/255 =

02 (null)
ofonod[32238]: plugins/udevng.c:setup_speedup() /dev/ttyUSB3 255/255/255 =

03 (null)
ofonod[32238]: plugins/udevng.c:setup_speedup() /dev/ttyUSB4 255/255/255 =

04 (null)
ofonod[32238]: plugins/udevng.c:setup_speedup() aux=3D/dev/ttyUSB1 =

modem=3D/dev/ttyUSB3

...

ofonod[32238]: plugins/speedupcdma.c:open_device() Modem /dev/ttyUSB3
ofonod[32238]: src/modem.c:get_modem_property() modem 0x9a0bc00 property Aux
ofonod[32238]: plugins/speedupcdma.c:open_device() Aux /dev/ttyUSB1
ofonod[32238]: Modem: > ATE0 &C0 +CMEE=3D1\r
ofonod[32238]: Aux: > ATE0 &C0 +CMEE=3D1\r
ofonod[32238]: Modem: < ATE0 &C0 +CMEE=3D1\r\r\nOK\r\n
ofonod[32238]: src/modem.c:set_powered_timeout() modem: 0x9a0bc00


Aux channel is not responsive.
As you can see, aux channel is now set to ttyUSB1 whereas it was set =

previously to ttyUSB3 (as stated by the rules below).

# SpeedUp 7300
ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", =

ENV{ID_USB_INTERFACE_NUM}=3D=3D"00", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", =

ENV{ID_USB_INTERFACE_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"

Looking to the previous ofono rules related to speedup dongles, aux =

channel was always assigned to the last interface. Now, with udevng.c, =

aux channel is always assigned to ttyUSB1 and modem is set on the last =

interface.
So, currently, aux channel and modem channel are switched.

But in practice, this seems wrong.
I tried indeed with a Speedup 9800 and I could notice that the network =

registration unsolicited result codes (+CREG, +CGREG) were received on =

the modem channel instead of the aux channel. This issue is raised =

already by the bug #20553 (Meego)

Now, if the aux channel is set properly on the last interface, the =

remaining issue is that the modem channel can't be always assigned on =

ttyUSB1.
At least for speedup 7300 (and generally for speedup cdma dongles ?), =

modem channel should be assigned to ttyUSB0.

So, I propose the following change in udevng.c:

@@ -311,12 +311,17 @@ static gboolean setup_speedup(struct modem_info =

*modem)
  			if (aux !=3D NULL)
  				break;
  		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "01") =3D=3D 0)
-				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "02") =3D=3D 0)
+			if (g_strcmp0(info->number, "00") =3D=3D 0 &&
+					g_strcmp0(modem->driver,
+							"speedupcdma") =3D=3D 0)
  				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "03") =3D=3D 0)
+			else if (g_strcmp0(info->number, "01") =3D=3D 0 &&
+					mdm =3D=3D NULL)
  				mdm =3D info->devnode;
+			else if (g_strcmp0(info->number, "02") =3D=3D 0)
+				aux =3D info->devnode;
+			else if (g_strcmp0(info->number, "03") =3D=3D 0)
+				aux =3D info->devnode;
  		}
  	}

Please, let me know if I can go ahead with a proper patch.
Thanks,

Regards,

Philippe.







--===============4227148731806313953==--

