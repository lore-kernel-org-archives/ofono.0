Content-Type: multipart/mixed; boundary="===============1312514631567137229=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test: add disable-call-forwarding
Date: Tue, 11 Jan 2011 09:08:07 -0600
Message-ID: <4D2C7257.4060307@gmail.com>
In-Reply-To: <1294661182-31036-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1312514631567137229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

On 01/10/2011 06:06 AM, Jarko Poutiainen wrote:
> ---
>  Makefile.am                  |    3 +-
>  test/disable-call-forwarding |   55 ++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 57 insertions(+), 1 deletions(-)
>  create mode 100755 test/disable-call-forwarding
> =

> diff --git a/Makefile.am b/Makefile.am
> index 8ad01cd..7908467 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -440,7 +440,8 @@ test_scripts =3D test/backtrace \
>  		test/set-tty \
>  		test/set-gsm-band \
>  		test/set-umts-band \
> -		test/lockdown-modem
> +		test/lockdown-modem \
> +		test/disable-call-forwarding
>  =

>  if TEST
>  testdir =3D $(pkglibdir)/test
> diff --git a/test/disable-call-forwarding b/test/disable-call-forwarding
> new file mode 100755
> index 0000000..3c51d06
> --- /dev/null
> +++ b/test/disable-call-forwarding
> @@ -0,0 +1,55 @@
> +#!/usr/bin/python
> +
> +import sys
> +import gobject
> +
> +import dbus
> +import dbus.mainloop.glib
> +
> +def property_changed(property, value):
> +

Please remove this empty line.

> +	if len(value.__str__()) > 0:
> +		print "CallForwarding property %s changed to %s" % (property, value)
> +	else:
> +		print "CallForwarding property %s changed to disabled" % (property)
> +

Please don't go over 80 characters / line here

> +	if canexit:
> +		mainloop.quit();
> +
> +if __name__ =3D=3D "__main__":
> +

Please remove this empty line.

> +	if len(sys.argv) < 2:
> +		print "Usage: %s <type>" % (sys.argv[0])
> +		print "Type can be: all, conditional"
> +		sys.exit(1)
> +
> +	canexit =3D False
> +
> +	type =3D sys.argv[1]
> +
> +	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
> +
> +	bus =3D dbus.SystemBus()
> +
> +	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
> +							'org.ofono.Manager')
> +
> +	modems =3D manager.GetModems()
> +
> +	cf =3D dbus.Interface(bus.get_object('org.ofono', modems[0][0]),
> +				'org.ofono.CallForwarding')
> +
> +	cf.connect_to_signal("PropertyChanged", property_changed)
> +
> +	try:
> +		cf.DisableAll(type, timeout =3D 100)
> +	except dbus.DBusException, e:
> +		print "Unable to DisableAll", e
> +		sys.exit(1);
> +
> +	print "DisableAll successful"
> +
> +	canexit =3D True
> +
> +	mainloop =3D gobject.MainLoop()
> +	mainloop.run()

Regards,
-Denis

--===============1312514631567137229==--

