Content-Type: multipart/mixed; boundary="===============3139441622362730291=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH_v3 2/2] test: Add hangup-call script for GCF testing
Date: Fri, 03 Aug 2012 09:58:07 -0700
Message-ID: <1344013087.2083.25.camel@aeonflux>
In-Reply-To: <1344005402-15253-3-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3139441622362730291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>  Makefile.am      |    3 ++-
>  test/hangup-call |   36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 1 deletions(-)
>  create mode 100755 test/hangup-call
> =

> diff --git a/Makefile.am b/Makefile.am
> index 7e8f12c..8cf6920 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -625,7 +625,8 @@ test_scripts =3D test/backtrace \
>  		test/swap-calls \
>  		test/release-and-answer \
>  		test/hold-and-answer \
> -		test/hangup-multiparty
> +		test/hangup-multiparty \
> +		test/hangup-call
>  =

>  if TEST
>  testdir =3D $(pkglibdir)/test
> diff --git a/test/hangup-call b/test/hangup-call
> new file mode 100755
> index 0000000..bc77acf
> --- /dev/null
> +++ b/test/hangup-call
> @@ -0,0 +1,36 @@
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
> +modems =3D manager.GetModems()
> +path =3D modems[0][0]
> +
> +manager =3D dbus.Interface(bus.get_object('org.ofono', path),
> +						'org.ofono.VoiceCallManager')
> +
> +calls =3D manager.GetCalls()
> +if (len(calls) =3D=3D 0):
> +	print "No calls available"
> +	sys.exit(1)
> +
> +if (len(sys.argv) < 2):
> +	i =3D 0
> +	for path, properties in calls:
> +		multi =3D properties["Multiparty"]
> +		print "Call Path [ %s ] Multiparty %d" % (path, multi)
> +		print
> +		i +=3D 1
> +
> +	print "Usage: %s [ Call Path ]" % (sys.argv[0])
> +	print
> +	sys.exit(1)

we have list-calls for this. So why not make this really simple and and
require the call object path as input.

Regards

Marcel



--===============3139441622362730291==--

