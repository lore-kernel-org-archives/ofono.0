Content-Type: multipart/mixed; boundary="===============3609245887034430945=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] install data file
Date: Wed, 10 Mar 2010 08:58:56 -0800
Message-ID: <1268240336.3712.87.camel@localhost.localdomain>
In-Reply-To: <1268193069-15830-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3609245887034430945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

>  Makefile.am |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index fcee5e6..007d5b9 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -45,7 +45,7 @@ INCLUDES =3D -I$(top_srcdir)/src -I$(top_builddir)/src
>  =

>  CLEANFILES =3D src/control.moc $(nodist_src_phonesim_SOURCES)
>  =

> -EXTRA_DIST =3D src/controlbase.ui src/default.xml src/GSMSpecification.x=
ml
> +dist_pkgdata_DATA =3D src/controlbase.ui src/moblin.xml src/GSMSpecifica=
tion.xml
>  =


this looks wrong. You should not be installing src/controlbase.ui and
don't bother installing GSMSpecification.xml. I just put that into the
source code for reference.

Also if you wanna install default.xml, then it needs to be installed
in /etc/phonesim/ and not just somewhere.

Please run a "make install DESTDIR=3D$PWD/x" as normal user from the build
directory of phonesim. Then "find x" will show you the directory layout
of the installation.

Regards

Marcel



--===============3609245887034430945==--

