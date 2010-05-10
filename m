Content-Type: multipart/mixed; boundary="===============3400005278963456129=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Mon, 10 May 2010 16:27:15 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351E79EF98@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <COL106-W4038AFB0D06866E8DA5DA2F6F90@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3400005278963456129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

	From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of krishna k
	Sent: Monday, May 10, 2010 4:13 PM
	To: ofono(a)ofono.org
	Subject: How to start ofono-phonesim in ubuntu-10.04 -reg
	=

	=

	Hi Yoon, =

	=

	I placed modem.conf file under /etc/ofono, and i tried with ./test/list-mo=
dems script. Still it is not showing any =

	thing on command line.  I tried to enable the phonesim0 modem with followi=
ng command and i am getting the same o/p

[Zhenhua] Do you build oFono with bootscrap-configure? If does, you will ha=
ve '--prefix=3D/usr --sysconfdir=3D/etc ...' configuration. So oFono reads =
configuration from /etc/ofono. Without that, you might put modem.conf under=
 /usr/local/etc/ofono. Btw, you could raise your question on our IRC room #=
ofono at irc.freenode.net as well.
	=

	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	=

	./enable-modem /phonesim0
	=

	******************etc.....
	=

	dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod: M=
ethod "SetProperty" =

	with signature "sb" on interface "org.ofono.Modem" doesn't exist.
	=

	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	=

	The same error as below. It is not able to detect the phonesim0?
	=

	regards,
	Krishna K Kandula.
	=

	Hi Krishna,
	=

	You should put your modem.conf file under /etc/ofono/.
	=

	Thanks,
	Yoon
	=

	From: ofono-bounces at ofono.org <http://lists.ofono.org/listinfo/ofono>  =
[mailto:ofono-bounces at ofono.org <http://lists.ofono.org/listinfo/ofono> =
] On Behalf Of krishna k
	Sent: Monday, May 10, 2010 3:43 PM
	To: ofono at ofono.org <http://lists.ofono.org/listinfo/ofono> =

	Subject: How to start ofono-phonesim in ubuntu-10.04 -reg
	=

	=

	Hi Zhenhua,
	=

	Thanks for your reply..
	=

	I added the following code in /usr/share/alsa/pcm/modem.conf file...
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
	Have a nice time.
	=

	Regards,
	Krishna K Kandula
	=


________________________________

	The battle for the FIH Hockey World Cup Drag n' drop <http://specials.msn.=
co.in/sp10/hockey/index.aspx>  =



--===============3400005278963456129==--

