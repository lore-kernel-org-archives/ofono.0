Content-Type: multipart/mixed; boundary="===============0025376698303153952=="
MIME-Version: 1.0
From: Xu, Martin <martin.xu@intel.com>
Subject: RE: [PATCH 1/1] install data file
Date: Wed, 10 Mar 2010 13:49:40 +0800
Message-ID: <FC2FB65B4D919844ADE4BE3C2BB739AD1DB5D35C@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1268193069-15830-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0025376698303153952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Please ignore the patch. =

I just found that Denis has changed moblin.xml to default.xml. ;-) I will s=
end modified patch soon.

> -----Original Message-----
> From: Xu, Martin
> Sent: Wednesday, March 10, 2010 11:51 AM
> To: ofono(a)ofono.org
> Cc: Xu, Martin
> Subject: [PATCH 1/1] install data file
> =

> ---
>  Makefile.am |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index fcee5e6..007d5b9 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -45,7 +45,7 @@ INCLUDES =3D -I$(top_srcdir)/src -I$(top_builddir)/src
> =

>  CLEANFILES =3D src/control.moc $(nodist_src_phonesim_SOURCES)
> =

> -EXTRA_DIST =3D src/controlbase.ui src/default.xml src/GSMSpecification.x=
ml
> +dist_pkgdata_DATA =3D src/controlbase.ui src/moblin.xml
> src/GSMSpecification.xml
> =

>  MAINTAINERCLEANFILES =3D Makefile.in \
>  	aclocal.m4 configure depcomp missing install-sh
> --
> 1.6.1.3


--===============0025376698303153952==--

