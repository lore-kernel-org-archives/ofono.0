Content-Type: multipart/mixed; boundary="===============3716254365163550132=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: TI Calypso Driver
Date: Fri, 11 Sep 2009 12:01:20 -0500
Message-ID: <200909111201.20722.denkenz@gmail.com>
In-Reply-To: <4AAA767B.8090206@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3716254365163550132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Hi Denis,
>
> > Simply insert the following lines into modem.conf to enable this device:
> > [calypso]
> > Driver=3Dcalypso
> > Device=3D/dev/ttySAC0
>
> thanks for the driver. I tried to use it via network, but I dont see
> dbus object pathes for the device.

Make sure that your modem.conf is properly configured and resides int he pr=
oper =

sysconfig directory.

Also, the calypso modem driver assumes it is running natively on the =

Freerunner.  If you want to use this over the network, you can use the =

phonesim driver.  This one can be connected to any TCP socket exporting the=
 AT =

command modem. =


[calypsonet]
Driver=3Dphonesim
Address=3D192.168.0.202 # or whatever your GTA0x IP is
Port=3D2000 # or whatever GTA0X port is
Modem=3Dcalypso

Then setup netcat or ser2net to forward he raw tty over the network.

Regards,
-Denis

--===============3716254365163550132==--

