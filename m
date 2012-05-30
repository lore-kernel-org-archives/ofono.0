Content-Type: multipart/mixed; boundary="===============4327495622756868749=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test: Add new script for SS GCF test cases
Date: Tue, 29 May 2012 23:54:13 -0500
Message-ID: <4FC5A7F5.2020109@gmail.com>
In-Reply-To: <1337762521-5210-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4327495622756868749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 05/23/2012 03:42 AM, Guillaume Zajac wrote:
> This script uses dynamic SS codes in input and
> displays answers to the different requests.
> It handles all SS: call barring, call forwarding,
> call waiting, CLIP, CLIR, ...
> ---
>   test/test-ss |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
>   1 files changed, 55 insertions(+), 0 deletions(-)
>   create mode 100755 test/test-ss
>
> diff --git a/test/test-ss b/test/test-ss
> new file mode 100755
> index 0000000..adeff33
> --- /dev/null
> +++ b/test/test-ss
> @@ -0,0 +1,55 @@
> +#!/usr/bin/python
> +
> +import sys
> +import gobject

What is gobject for?
> +
> +import dbus
> +import dbus.mainloop.glib

Why do you need the mainloop?

> +
> +if __name__ =3D=3D "__main__":
> +	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
> +
> +	bus =3D dbus.SystemBus()
> +
> +	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
> +							'org.ofono.Manager')
> +
> +	modems =3D manager.GetModems()
> +	modem =3D modems[0][0]
> +
> +	if (len(sys.argv) =3D=3D 2):
> +		ss_code =3D sys.argv[1]
> +	else:
> +		modem =3D sys.argv[1]
> +		ss_code =3D sys.argv[2]
> +
> +	ss =3D dbus.Interface(bus.get_object('org.ofono', modem),
> +					'org.ofono.SupplementaryServices')
> +
> +	try:
> +		ss_type, properties =3D ss.Initiate(ss_code, timeout=3D100)
> +	except dbus.DBusException, e:
> +		print "Unable to perform operation: ", e
> +		sys.exit(1);
> +
> +	if (ss_type =3D=3D "CallBarring"):
> +		print "%s : Operation [ %s ] Service Type [ %s ]" % (ss_type, properti=
es[0], properties[1])
> +		for key in properties[2]:
> +			print "%s : %s" % (key, properties[2][key])
> +		sys.exit(1);

This sys.exit seems unnecessary, and since the operation succeeded you =

should be returning 0 anyway.

> +	elif (ss_type =3D=3D "CallForwarding"):
> +		print "%s : Operation [ %s ] Service Type [ %s ]" % (ss_type, properti=
es[0], properties[1])
> +		for key in properties[2]:
> +			print "%s : %s" % (key, properties[2][key])
> +		sys.exit(1);

ditto

> +	elif (ss_type =3D=3D "CallWaiting"):
> +		print "%s : Operation [ %s ]" % (ss_type, properties[0])
> +		for key in properties[1]:
> +			print "%s : %s" % (key, properties[1][key])
> +		sys.exit(1);

ditto

> +	else:
> +		print "%s : Operation [ %s ] Status [ %s ]" % (ss_type, properties[0],=
 properties[1])
> +		sys.exit(1);

ditto
> +
> +	mainloop =3D gobject.MainLoop()
> +	mainloop.run()

This seems unnecessary as well since you're not actually using a main loop.

Regards,
-Denis

--===============4327495622756868749==--

