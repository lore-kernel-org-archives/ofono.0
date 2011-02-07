Content-Type: multipart/mixed; boundary="===============5933749527423157363=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/4] nettime: Documentation
Date: Mon, 07 Feb 2011 11:00:16 -0800
Message-ID: <1297105216.1520.429.camel@aeonflux>
In-Reply-To: <1296571771-26513-4-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5933749527423157363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

>  doc/network-time-api.txt |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
>  create mode 100644 doc/network-time-api.txt
> =

> diff --git a/doc/network-time-api.txt b/doc/network-time-api.txt
> new file mode 100644
> index 0000000..9133a73
> --- /dev/null
> +++ b/doc/network-time-api.txt
> @@ -0,0 +1,36 @@
> +Network time hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Interface	com.meego.NetworkTime
> +Object path	[variable]

the object path is not really variable. However this part of the
documentation should be really inside timed. Since timed is exposing
this interface in the first place.

And we are moving from com.nokia.timed towards com.meego.timed?

Regards

Marcel



--===============5933749527423157363==--

