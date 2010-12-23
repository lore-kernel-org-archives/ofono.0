Content-Type: multipart/mixed; boundary="===============8719944458461671820=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3, Part1, 5/5] test: Add CDMA MO Call Support
Date: Wed, 22 Dec 2010 19:31:32 -0600
Message-ID: <4D12A674.8060107@gmail.com>
In-Reply-To: <1292895397-11573-6-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8719944458461671820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

On 12/20/2010 07:36 PM, Dara Spieker-Doyle wrote:
> ---
>  Makefile.am           |    5 ++++-
>  test/cdma-dial-number |   24 ++++++++++++++++++++++++
>  test/cdma-hangup      |   20 ++++++++++++++++++++
>  test/cdma-list-call   |   30 ++++++++++++++++++++++++++++++
>  4 files changed, 78 insertions(+), 1 deletions(-)
>  create mode 100755 test/cdma-dial-number
>  create mode 100755 test/cdma-hangup
>  create mode 100755 test/cdma-list-call
> =


Patch looks fine but does not apply cleanly without patch 4.  Can you
also fix these:

> diff --git a/Makefile.am b/Makefile.am
> index 50e893f..32ded3d 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -431,7 +431,10 @@ test_scripts =3D test/backtrace \
>  		test/test-push-notification \
>  		test/test-smart-messaging \
>  		test/send-vcard \
> -		test/set-tty
> +		test/set-tty \
> +		test/cdma-list-call \
> +		test/cdma-dial-number \
> +		test/cdma-hangup
>  =

>  if TEST
>  testdir =3D $(pkglibdir)/test
> diff --git a/test/cdma-dial-number b/test/cdma-dial-number
> new file mode 100755
> index 0000000..948d32d
> --- /dev/null
> +++ b/test/cdma-dial-number
> @@ -0,0 +1,24 @@
> +#!/usr/bin/python
> +
> +import sys
> +import dbus
> +
> +bus =3D dbus.SystemBus()
> +
> +manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
> +						'org.ofono.Manager')
> +
> +if len(sys.argv) > 2:
> +	path =3D sys.argv[1]
> +	number =3D sys.argv[2]
> +else:
> +	modems =3D manager.GetModems()
> +	path, properties =3D modems[0]
> +	number =3D sys.argv[1]
> +
> +print "Using modem %s" % path
> +
> +manager =3D dbus.Interface(bus.get_object('org.ofono', path),
> +						'org.ofono.cdma.VoiceCallManager')
> +
> +manager.Dial(number)
> \ No newline at end of file

^^^^^

> diff --git a/test/cdma-hangup b/test/cdma-hangup
> new file mode 100755
> index 0000000..f8e631e
> --- /dev/null
> +++ b/test/cdma-hangup
> @@ -0,0 +1,20 @@
> +#!/usr/bin/python
> +
> +import sys
> +import dbus
> +
> +bus =3D dbus.SystemBus()
> +
> +manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
> +						'org.ofono.Manager')
> +
> +if len(sys.argv) > 2:
> +	path =3D sys.argv[1]
> +else:
> +	modems =3D manager.GetModems()
> +	path, properties =3D modems[0]
> +
> +manager =3D dbus.Interface(bus.get_object('org.ofono', path),
> +						'org.ofono.cdma.VoiceCallManager')
> +
> +manager.Hangup()
> diff --git a/test/cdma-list-call b/test/cdma-list-call
> new file mode 100755
> index 0000000..9f9fdbc
> --- /dev/null
> +++ b/test/cdma-list-call
> @@ -0,0 +1,30 @@
> +#!/usr/bin/python
> +
> +import dbus
> +
> +bus =3D dbus.SystemBus()
> +
> +manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
> +						'org.ofono.Manager')
> +
> +modems =3D manager.GetModems()
> +
> +for path, properties in modems:
> +	print "[ %s ]" % (path)
> +
> +	if "org.ofono.cdma.VoiceCallManager" not in properties["Interfaces"]:
> +		continue
> +
> +	mgr =3D dbus.Interface(bus.get_object('org.ofono', path),
> +					'org.ofono.cdma.VoiceCallManager')
> +
> +	properties =3D mgr.GetProperties()
> +
> +	for key in properties.keys():
> +		if key in ["Interfaces", "Features"]:
> +			val =3D ""
> +			for i in properties[key]:
> +				val +=3D i + " "
> +		else:
> +			val =3D str(properties[key])
> +		print "    %s =3D %s" % (key, val)
> \ No newline at end of file

and ^^^^^^

Regards,
-Denis

--===============8719944458461671820==--

