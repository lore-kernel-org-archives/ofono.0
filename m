Content-Type: multipart/mixed; boundary="===============0117963650510872369=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: failed to start ofonod....
Date: Thu, 24 Sep 2009 09:10:37 -0700
Message-ID: <1253808637.2931.14.camel@localhost.localdomain>
In-Reply-To: <61563CE63B4F854986A895DA7AD3C17709DE9071F1@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0117963650510872369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lihan,

> I also face the problem when I install ofono on a new machine.
> =

>  =

> =

> Unable to hop onto D-Bus
> =

>  =

> =

> I run as root, but the same error as WuYongbo and no configure
> directory =E2=80=9Cofono=E2=80=9D under /etc
> =

>  =

> =

> By the way, I manually installed dbus-1-dev and dbus-glib-1-dev,
> unless ./bootstrap-configure reminds that DBUS>=3D1.0 is required.

you need to copy the D-Bus security policy before it will work.

Regards

Marcel



--===============0117963650510872369==--

