Content-Type: multipart/mixed; boundary="===============3719567014675930883=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] test: Add a script to set the delivery-report flag
Date: Tue, 07 Aug 2012 02:22:58 -0500
Message-ID: <5020C252.6000800@gmail.com>
In-Reply-To: <1344267060-5541-5-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3719567014675930883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

On 08/06/2012 10:31 AM, Ronald Tessier wrote:
> ---
>   test/set-dr |   25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>   create mode 100755 test/set-dr
>

Add this to Makefile.am as well.

> diff --git a/test/set-dr b/test/set-dr
> new file mode 100755
> index 0000000..99c72b1
> --- /dev/null
> +++ b/test/set-dr
> @@ -0,0 +1,25 @@
> +#!/usr/bin/python
> +
> +import sys
> +import dbus
> +
> +bus =3D dbus.SessionBus()
> +
> +manager =3D dbus.Interface(bus.get_object('org.ofono.mms', '/org/ofono/m=
ms'),
> +					'org.ofono.mms.Manager')
> +
> +services =3D manager.GetServices()
> +path =3D services[0][0]
> +
> +service =3D dbus.Interface(bus.get_object('org.ofono.mms', path),
> +						'org.ofono.mms.Service')
> +
> +if len(sys.argv)>  1:
> +	allowed =3D dbus.Boolean(int(sys.argv[1]))
> +else:
> +	allowed =3D dbus.Boolean(1)
> +
> +service.SetProperty("UseDeliveryReports", allowed)
> +
> +print "Setting delivery report use for %s...(UseDeliveryReports=3D%d)" %\
> +	(path, allowed)

Should this be printed prior to calling SetProperty?  Otherwise it =

should be 'Set' not 'Setting'.

Regards,
-Denis

--===============3719567014675930883==--

