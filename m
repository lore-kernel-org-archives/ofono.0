Content-Type: multipart/mixed; boundary="===============0607920913750536552=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How to talk with FreeRunner?
Date: Mon, 19 Oct 2009 12:13:01 -0500
Message-ID: <200910191213.02239.denkenz@gmail.com>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001B113BAEF@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0607920913750536552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> 	I just got a Openmoko FreeRunner and I wonder how oFono can talk with it.
> Use ser2net, but how? Can someone help on some simple steps or
> instructions? Thanks a lot! By the way, the OS installed in it is Android
> Cupcake. Need I change to other OS?

There are a couple of ways:
	- Cross compile oFono itself to run directly on the device using the calyp=
so =

driver.
	- Cross compile ser2net, but run oFono on the desktop using the phonesim =

driver.

Either way you will need the cross compiler and toolchain here: =

http://wiki.openmoko.org/wiki/Toolchain

Note that my device came stock with the OpenMoko rootfs, so I have no =

experience with Android.

For ser2net:
  - Cross compile ser2net using the supplied toolchain, I don't remember =

exactly, but I think this will get you there: ./configure --prefix=3D/usr --
sysconfdir=3D/etc --host=3Darm-angstrom-linux-gnueabi

- Copy ser2net to the device.

- Create /etc/ser2net.conf with the following line:
2000:raw:600:/dev/ttySAC0:115200 NONE 1STOPBIT 8DATABITS XONXOFF LOCAL RTSC=
TS

- Kill whatever daemon is managing the serial port, in my case =

/etc/init.d/gsmd stop

- Reset the modem.  For my rootfs here is the script I use:
PATH=3D/bin:/usr/bin:/sbin:/usr/sbin

[ -f /etc/default/gsmd ] && . /etc/default/gsmd

[ -n "$GSM_POW" ] && ( echo "0" >$GSM_POW; sleep 1 )
[ -n "$GSM_POW" ] && ( echo "1" >$GSM_POW; sleep 1 )
[ -n "$GSM_RES" ] && ( echo "1" >$GSM_RES; sleep 1 )
[ -n "$GSM_RES" ] && ( echo "0" >$GSM_RES; sleep 2 )

- start ser2net

You can test by telneting to your device on port 2000.  Hitting enter a few =

times should give you several OKs.

Setup your modem.conf as follows:
[freerunner]
Driver=3Dphonesim
Address=3D<your device address>
Port=3D2000
Modem=3Dcalypso

Regards,
-Denis

--===============0607920913750536552==--

