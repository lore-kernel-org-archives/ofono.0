Content-Type: multipart/mixed; boundary="===============4498624336850596495=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] This patch enables the pin number and type of pin to
 be sent to daemon to unlock the sim card.
Date: Thu, 29 Oct 2009 23:00:50 +0900
Message-ID: <1256824850.5768.43.camel@localhost.localdomain>
In-Reply-To: <1256824474-31389-3-git-send-email-ryan.raasch@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4498624336850596495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

> ---
>  test/enable-sim |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
>  create mode 100755 test/enable-sim
> =

> diff --git a/test/enable-sim b/test/enable-sim
> new file mode 100755
> index 0000000..bbfd34f
> --- /dev/null
> +++ b/test/enable-sim
> @@ -0,0 +1,18 @@
> +#!/usr/bin/python
> +
> +import dbus
> +import sys
> +
> +bus =3D dbus.SystemBus()
> +
> +manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
> +						'org.ofono.Manager')
> +
> +properties =3D manager.GetProperties()
> +
> +path =3D properties["Modems"][0]
> +
> +modem =3D dbus.Interface(bus.get_object('org.ofono', path),
> +						'org.ofono.SimManager')
> +
> +modem.EnterPin(sys.argv[1], sys.argv[2])

call this script enter-pin and have it check if a PIN is actually
required.

Regards

Marcel



--===============4498624336850596495==--

