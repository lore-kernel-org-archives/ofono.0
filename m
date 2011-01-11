Content-Type: multipart/mixed; boundary="===============1269440059369188111=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] test: add change-pin test case
Date: Tue, 11 Jan 2011 10:23:09 -0800
Message-ID: <1294770189.3873.29.camel@aeonflux>
In-Reply-To: <20A4FB08D632914F9C09B9F05CBDF258192D753023@EXMB02.eu.tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1269440059369188111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

>  Makefile.am     |    3 ++-
>  test/change-pin |   29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 1 deletions(-)
>  create mode 100755 test/change-pin
> =

> diff --git a/Makefile.am b/Makefile.am
> index cc30624..4c9add4 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -446,7 +446,8 @@ test_scripts =3D test/backtrace \
>          test/set-tty \
>          test/set-gsm-band \
>          test/set-umts-band \
> -        test/lockdown-modem
> +        test/lockdown-modem \
> +        test/change-pin
>  =

>  if TEST
>  testdir =3D $(pkglibdir)/test
> diff --git a/test/change-pin b/test/change-pin new file mode 100755 index=
 0000000..a2444d6
> --- /dev/null
> +++ b/test/change-pin
> @@ -0,0 +1,29 @@
> +#!/usr/bin/python
> +
> +import dbus
> +import sys
> +
> +bus =3D dbus.SystemBus()
> +
> +if len(sys.argv) =3D=3D 5:
> +    path =3D sys.argv[1]
> +    pin_type =3D sys.argv[2]
> +    orig_pin =3D sys.argv[3]
> +    new_pin =3D sys.argv[4]

I know that we are not really strict with any coding style in the test
scripts, but at least try to follow the using tabs rule ;)

Regards

Marcel



--===============1269440059369188111==--

