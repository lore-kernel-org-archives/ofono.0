Content-Type: multipart/mixed; boundary="===============6760149687943867687=="
MIME-Version: 1.0
From: Yoon, Youngsik <youngsik.yoon@intel.com>
Subject: RE: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Mon, 10 May 2010 14:55:00 +0800
Message-ID: <E63C5DDBF9FA424AB501A4C5647901434C1CBD3B71@pgsmsx506.gar.corp.intel.com>
In-Reply-To: <COL106-W4521589C7EBB620DF7AE3BF6F90@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6760149687943867687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

You should put your modem.conf file under /etc/ofono/.

Thanks,
Yoon

From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of krishna k
Sent: Monday, May 10, 2010 3:43 PM
To: ofono(a)ofono.org
Subject: How to start ofono-phonesim in ubuntu-10.04 -reg


Hi Zhenhua,

Thanks for your reply..

I added the following code in /usr/share/alsa/pcm/modem.conf file...

1.
#
#Sample for using phone simulator
#
[phonesim]
Driver=3Dphonesim
Address=3D127.0.0.1
port=3D12345

---------------------------------------------------------------------------=
--------------------------------------------------------------
I tried to ./list_modems. I got nothing on command prompt. According to my =
knowledge i should get the available modems (atleast phonesim0)
I tried to enable  the modem using the following command..

./enable-modem /phonesim0

I got =

output as follows...

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------------------------

Connecting
 modem /phonesim0...

Traceback =

(most recent call last):

=C2=A0 File =

"./enable-modem", line 20, in <module>

=C2=A0=C2=A0=C2=A0 =

modem.SetProperty("Powered", dbus.Boolean(1))

=C2=A0 File =

"/usr/lib/pymodules/python2.6/dbus/proxies.py", line 68, in __call__

=C2=A0=C2=A0=C2=A0 return
 self._proxy_method(*args, **keywords)

=C2=A0 File =

"/usr/lib/pymodules/python2.6/dbus/proxies.py", line 140, in __call__

=C2=A0=C2=A0=C2=A0 =

**keywords)

=C2=A0 File =

"/usr/lib/pymodules/python2.6/dbus/connection.py", line 620, in =

call_blocking

=C2=A0=C2=A0=C2=A0 =

message, timeout)

dbus.exceptions.DBusException:
 org.freedesktop.DBus.Error.UnknownMethod: Method "SetProperty" with =

signature "sb" on interface "org.ofono.Modem" doesn't exist

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------------------------------
Have a nice time.

Regards,
Krishna K Kandula

________________________________________
The battle for the FIH Hockey World Cup Drag n' drop

--===============6760149687943867687==--

