Content-Type: multipart/mixed; boundary="===============7800563376814819798=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] test: Add a test script to get service properties
Date: Thu, 09 Aug 2012 01:44:58 -0500
Message-ID: <50235C6A.8030308@gmail.com>
In-Reply-To: <1344527503-9965-4-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7800563376814819798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

On 08/09/2012 10:51 AM, Ronald Tessier wrote:
> ---
>   test/get-properties |   26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>   create mode 100755 test/get-properties
>
> diff --git a/test/get-properties b/test/get-properties
> new file mode 100755
> index 0000000..8887fcb
> --- /dev/null
> +++ b/test/get-properties
> @@ -0,0 +1,26 @@
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
> +properties =3D service.GetProperties()
> +
> +for p in properties:
> +	if len(properties[p].__str__())>  0:
> +		print "%s Service Manager rule is: %s" %\
> +				(p, properties[p])
> +		print "------------------------------------------" \
> +			"-----------------"
> +	else:
> +		print "%s Service Manager rule disabled" % (p)

Please model this script after list-modems in ofono.  Name it list-services.

Regards,
-Denis

--===============7800563376814819798==--

