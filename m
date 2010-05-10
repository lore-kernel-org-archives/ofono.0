Content-Type: multipart/mixed; boundary="===============8220553263785681927=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Mon, 10 May 2010 14:55:06 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351E79EEC1@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <COL106-W4521589C7EBB620DF7AE3BF6F90@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8220553263785681927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

	From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of krishna k
	Sent: Monday, May 10, 2010 2:43 PM
	To: ofono(a)ofono.org
	Subject: How to start ofono-phonesim in ubuntu-10.04 -reg
	=

	=

	=

	Hi Zhenhua,
	=

	Thanks for your reply..
	=

	I added the following code in /usr/share/alsa/pcm/modem.conf file...

[Zhenhua] Please put modem.conf under /etc/ofono. You should see phonesim0 =
from list_modems output like your E71 modem.
	=

	1.
	#
	#Sample for using phone simulator
	#
	[phonesim]
	Driver=3Dphonesim
	Address=3D127.0.0.1
	port=3D12345
	=

	--------------------------------------------------------------------------=
---------------------------------------------------------------
	I tried to ./list_modems. I got nothing on command prompt. According to my=
 knowledge i should get the available modems (atleast phonesim0)
	I tried to enable  the modem using the following command..
	=

	./enable-modem /phonesim0
	=

	I got =

	output as follows...
	=

	--------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------------------------------
	=

	Connecting
	 modem /phonesim0...
	=

	Traceback =

	(most recent call last):
	=

	  File =

	"./enable-modem", line 20, in <module>
	=

	    =

	modem.SetProperty("Powered", dbus.Boolean(1))
	=

	  File =

	"/usr/lib/pymodules/python2.6/dbus/proxies.py", line 68, in __call__
	=

	    return
	 self._proxy_method(*args, **keywords)
	=

	  File =

	"/usr/lib/pymodules/python2.6/dbus/proxies.py", line 140, in __call__
	=

	    =

	**keywords)
	=

	  File =

	"/usr/lib/pymodules/python2.6/dbus/connection.py", line 620, in =

	call_blocking
	=

	    =

	message, timeout)
	=

	dbus.exceptions.DBusException:
	 org.freedesktop.DBus.Error.UnknownMethod: Method "SetProperty" with =

	signature "sb" on interface "org.ofono.Modem" doesn't exist
	=

	--------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------
	=

	=

	Have a nice time.
	=

	Regards,
	Krishna K Kandula
	=

	=

	=

________________________________

	The battle for the FIH Hockey World Cup Drag n' drop <http://specials.msn.=
co.in/sp10/hockey/index.aspx>  =



--===============8220553263785681927==--

