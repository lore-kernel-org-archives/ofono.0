Content-Type: multipart/mixed; boundary="===============3842930394339589303=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: Ofono 0.20 compilation failed.
Date: Fri, 21 May 2010 17:30:18 +0300
Message-ID: <87sk5lmio5.fsf@potku.valot.fi>
In-Reply-To: <AANLkTincL_xVyyAMyfedgO2kag5Ifh5kAOJtfE9kasFE@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3842930394339589303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Arun Ravindran <arunlee@gmail.com> writes:

> I am trying to compile and install ofono to my unbuntu 9.10.
> I get the following error...
>
> root(a)arun-laptop:/home/arun/ofono-0.20# ./configure --prefix=3D/usr --m=
andir=3D/usr
> /share/man --sysconfdir=3D/etc --localstatedir=3D/var
>
> .........................................................................=
..........
> .........................................................................=
..........
> .........................................................................=
..........
> checking whether to build shared libraries... yes
> checking whether to build static libraries... no
> checking for BSD- or MS-compatible name lister (nm)... (cached) /usr/bin/=
nm -B
> checking the name lister (/usr/bin/nm -B) interface... (cached) BSD nm
> checking for signalfd in -lc... yes
> checking for dlopen in -ldl... yes
> checking for GLIB... yes
> checking for DBUS... no
> configure: error: D-Bus >=3D 1.0 is required

You need libdbus-1-dev.

Check the build dependencies from a ofono debian/ubuntu package, for
example 'apt-get build-dep <package>' command is really handy. But I
think ofono is not in 9.10, you need 10.04 for the command to work
properly.

-- =

Kalle Valo

--===============3842930394339589303==--

