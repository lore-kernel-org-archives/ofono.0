Content-Type: multipart/mixed; boundary="===============6581927747333568034=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/3] oFono rules update
Date: Wed, 24 Aug 2011 09:21:02 -0700
Message-ID: <1314202864.3373.219.camel@aeonflux>
In-Reply-To: <4E54D399.9010306@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6581927747333568034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> Actually, with this dongle, we have 6 TTY (usb0 -> usb5) and usb-devices =

> gives:
> =

> T:  Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D00 Cnt=3D01 Dev#=3D 32 Spd=3D480 M=
xCh=3D 0
> D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D19d2 ProdID=3D0124 Rev=3D00.00
> S:  Manufacturer=3DZTE,Incorporated
> S:  Product=3DZTE WCDMA Technologies MSM
> S:  SerialNumber=3DP671A2TMED010000
> C:  #Ifs=3D 7 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> I:  If#=3D 3 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> I:  If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> I:  If#=3D 5 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> I:  If#=3D 6 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50 Driver=
=3Dusb-storage
> =

> Now, ttyUSB5 is not responsive. So, for this particular dongle, the =

> modem interface won't be on the last interface. Anyway, as I'm just =

> looking to add the condition related to the interface number 04, it =

> doesn't really matter.

so on which interfaces do we actually have the modem and the aux channel
now.

And more important now, do we use the right usb_modeswitch magic to
switch it into this mode. Or is Windows using something different?

Regards

Marcel



--===============6581927747333568034==--

