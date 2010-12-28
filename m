Content-Type: multipart/mixed; boundary="===============3622961717806553668=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] doc: New file about using the calypso modem
Date: Tue, 28 Dec 2010 09:01:20 -0800
Message-ID: <1293555680.9439.63.camel@aeonflux>
In-Reply-To: <1293539145-32734-1-git-send-email-neil@ossau.uklinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3622961717806553668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Neil,

>  doc/calypso-modem.txt |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
>  create mode 100644 doc/calypso-modem.txt
> =

> diff --git a/doc/calypso-modem.txt b/doc/calypso-modem.txt
> new file mode 100644
> index 0000000..ea3e0bb
> --- /dev/null
> +++ b/doc/calypso-modem.txt
> @@ -0,0 +1,22 @@
> +Calypso modem usage
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +On the Openmoko Freerunner phone, the Calypso modem is presented by
> +the kernel as serial device /dev/ttySAC0.  To allow Ofono to

it is spelled oFono.

> +autodetect and use this, a simple udev rule is needed:
> +
> +KERNEL=3D=3D"ttySAC0", ENV{OFONO_DRIVER}=3D"calypso"
> +
> +You can put this in any file in /lib/udev/rules.d.  A logical choice
> +is the "55-openmoko-gta01-gta02.rules" file, if it exists in your
> +Freerunner distribution.
> +
> +With this rule in place:
> +
> +- ofono will detect the Calypso modem when it starts up, and the

Same here. It is oFono.

> +  `list-modems' test script will show this, but will not power it up
> +
> +- the `enable-modem' test script can be used to power it up
> +
> +- a subsequent `list-modems' will show lots of information, including
> +  network registration.

Since we had this discussion on IRC. Has this rule been proven to do the
right thing? Even in case of the weird renaming of the original serial
port?

Regards

Marcel



--===============3622961717806553668==--

