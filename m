Content-Type: multipart/mixed; boundary="===============1700182262813375051=="
MIME-Version: 1.0
From: Zheng, Wu <wu.zheng@intel.com>
Subject: RE: [PATCH v6 03/16] dundee: Add test scripts
Date: Mon, 23 Apr 2012 10:13:35 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E0FD1CDB4@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <1333383614-4921-4-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1700182262813375051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

I try to test your patches.

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beh=
alf
> Of Daniel Wagner
> Sent: Tuesday, April 03, 2012 12:20 AM
> To: ofono(a)ofono.org
> Cc: Daniel Wagner
> Subject: [PATCH v6 03/16] dundee: Add test scripts
> =

> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
> =

> ---
>  test/dundee-connect    |   20 +++++++++
>  test/dundee-disconnect |   20 +++++++++
>  test/monitor-dundee    |  109
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+)
>  create mode 100755 test/dundee-connect
>  create mode 100755 test/dundee-disconnect  create mode 100755
> test/monitor-dundee
> =

> diff --git a/test/dundee-connect b/test/dundee-connect new file mode 1007=
55
> index 0000000..6cbc629
> --- /dev/null
> +++ b/test/dundee-connect
> @@ -0,0 +1,20 @@
> +#!/usr/bin/python
> +
> +import dbus
> +import sys
> +
> +bus =3D dbus.SystemBus()
> +
> +if len(sys.argv) =3D=3D 2:
> +	path =3D sys.argv[1]
> +else:
> +	manager =3D dbus.Interface(bus.get_object('org.ofono.dundee', '/'),
> +			'org.ofono.dundee.Manager')
> +	devices =3D manager.GetDevices()
> +	path =3D devices[0][0]
> +
> +print "Connect device %s..." % path
> +device =3D dbus.Interface(bus.get_object('org.ofono.dundee', path),
> +						'org.ofono.dundee.Device')
> +
> +device.Connect()

The dbus method connect() does not exist on org.ofono.dundee.Device, it can=
not be found in device.c and doc/dundee-api.txt.
Why?

Best regards

> diff --git a/test/dundee-disconnect b/test/dundee-disconnect new file mode
> 100755 index 0000000..e67d8cd
> --- /dev/null
> +++ b/test/dundee-disconnect
> @@ -0,0 +1,20 @@
> +#!/usr/bin/python
> +
> +import dbus
> +import sys
> +
> +bus =3D dbus.SystemBus()
> +
> +if len(sys.argv) =3D=3D 2:
> +	path =3D sys.argv[1]
> +else:
> +	manager =3D dbus.Interface(bus.get_object('org.ofono.dundee', '/'),
> +			'org.ofono.dundee.Manager')
> +	devices =3D manager.GetDevices()
> +	path =3D devices[0][0]
> +
> +print "Disonnect device %s..." % path
> +device =3D dbus.Interface(bus.get_object('org.ofono.dundee', path),
> +						'org.ofono.dundee.Device')
> +
> +device.Disconnect()

The dbus method Disconnect() does not exist on org.ofono.dundee.Device, it =
cannot be found in device.c and doc/dundee-api.txt.
Why?

Best regards

> diff --git a/test/monitor-dundee b/test/monitor-dundee new file mode 1007=
55
> index 0000000..cf96ceb
> --- /dev/null
> +++ b/test/monitor-dundee
> @@ -0,0 +1,109 @@
> +#!/usr/bin/python
> +
> +import gobject
> +
> +import dbus
> +import dbus.mainloop.glib
> +
> +_dbus2py =3D {
> +	dbus.String : unicode,
> +	dbus.UInt32 : int,
> +	dbus.Int32 : int,
> +	dbus.Int16 : int,
> +	dbus.UInt16 : int,
> +	dbus.UInt64 : int,
> +	dbus.Int64 : int,
> +	dbus.Byte : int,
> +	dbus.Boolean : bool,
> +	dbus.ByteArray : str,
> +	dbus.ObjectPath : str
> +    }
> +
> +def dbus2py(d):
> +	t =3D type(d)
> +	if t in _dbus2py:
> +		return _dbus2py[t](d)
> +	if t is dbus.Dictionary:
> +		return dict([(dbus2py(k), dbus2py(v)) for k, v in d.items()])
> +	if t is dbus.Array and d.signature =3D=3D "y":
> +		return "".join([chr(b) for b in d])
> +	if t is dbus.Array or t is list:
> +		return [dbus2py(v) for v in d]
> +	if t is dbus.Struct or t is tuple:
> +		return tuple([dbus2py(v) for v in d])
> +	return d
> +
> +def pretty(d):
> +	d =3D dbus2py(d)
> +	t =3D type(d)
> +
> +	if t in (dict, tuple, list) and len(d) > 0:
> +		if t is dict:
> +			d =3D ", ".join(["%s =3D %s" % (k, pretty(v))
> +					for k, v in d.items()])
> +			return "{ %s }" % d
> +
> +		d =3D " ".join([pretty(e) for e in d])
> +
> +		if t is tuple:
> +			return "( %s )" % d
> +
> +	return str(d)
> +
> +def property_changed(name, value, path, interface):
> +	iface =3D interface[interface.rfind(".") + 1:]
> +	print "{%s} [%s] %s =3D %s" % (iface, path, name, pretty(value))
> +
> +def added(name, value, member, path, interface):
> +	iface =3D interface[interface.rfind(".") + 1:]
> +	print "{%s} [%s] %s %s" % (iface, member, name, pretty(value))
> +
> +def removed(name, member, path, interface):
> +	iface =3D interface[interface.rfind(".") + 1:]
> +	print "{%s} [%s] %s" % (iface, member, name)
> +
> +def event(member, path, interface):
> +	iface =3D interface[interface.rfind(".") + 1:]
> +	print "{%s} [%s] %s" % (iface, path, member)
> +
> +def message(msg, args, member, path, interface):
> +	iface =3D interface[interface.rfind(".") + 1:]
> +	print "{%s} [%s] %s %s (%s)" % (iface, path, member,
> +					str(msg), pretty(args))
> +
> +def ussd(msg, member, path, interface):
> +	iface =3D interface[interface.rfind(".") + 1:]
> +	print "{%s} [%s] %s %s" % (iface, path, member, str(msg))
> +
> +def value(value, member, path, interface):
> +	iface =3D interface[interface.rfind(".") + 1:]
> +	print "{%s} [%s] %s %s" % (iface, path, member, str(value))
> +
> +if __name__ =3D=3D '__main__':
> +	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
> +
> +	bus =3D dbus.SystemBus()
> +
> +	bus.add_signal_receiver(property_changed,
> +					bus_name=3D"org.ofono.dundee",
> +					signal_name =3D "PropertyChanged",
> +						path_keyword=3D"path",
> +						interface_keyword=3D"interface")
> +
> +	bus.add_signal_receiver(added,
> +					bus_name=3D"org.ofono.dundee",
> +					signal_name =3D "DeviceAdded",
> +						member_keyword=3D"member",
> +						path_keyword=3D"path",
> +						interface_keyword=3D"interface")
> +
> +	bus.add_signal_receiver(removed,
> +					bus_name=3D"org.ofono.dundee",
> +					signal_name =3D "DeviceRemoved",
> +						member_keyword=3D"member",
> +						path_keyword=3D"path",
> +						interface_keyword=3D"interface")
> +
> +
> +	mainloop =3D gobject.MainLoop()
> +	mainloop.run()
> --
> 1.7.10.rc3.1.gb3065
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============1700182262813375051==--

