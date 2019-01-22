Content-Type: multipart/mixed; boundary="===============3937541307135752210=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] document getting of ell, point people at useful docs
Date: Tue, 22 Jan 2019 17:50:34 +0100
Message-ID: <4ED57398-61D8-4F54-865A-9CCD09E9ED55@holtmann.org>
In-Reply-To: <20181229224704.GA4451@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3937541307135752210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> Currently there's README and HACKING... each describing part of what
> needs to be done to build ofono.
> =

> Provide some cross-links and fix build example.
> =

> diff --git a/HACKING b/HACKING
> index 15ea291..b1bd599 100644
> --- a/HACKING
> +++ b/HACKING
> @@ -45,7 +45,8 @@ bootstrap-configure since it could export development s=
pecific settings.
> So the normal steps to checkout, build and install such a repository is
> like this:
> =

> -  Checkout repository
> +  Checkout repositories
> +    # git clone git://git.kernel.org/pub/scm/libs/ell/ell.git
>     # git clone git://git.kernel.org/pub/scm/network/ofono/ofono.git
>     # cd ofono
> =


so coming to think about it, I would actually make this a pre-step.

	Checkout Embedded Linux Library
	  # git clone ..

Also this documentation is primarily for maintainers and the few that deal =
with making the tarballs. Which is pretty much just me.

> diff --git a/README b/README
> index 45bb2e9..04a50a5 100644
> --- a/README
> +++ b/README
> @@ -16,11 +16,14 @@ To configure run:
> 	./configure --prefix=3D/usr --mandir=3D/usr/share/man \
> 				--sysconfdir=3D/etc --localstatedir=3D/var
> =

> -Configure automatically searches for all required components and package=
s.
> +Configure automatically searches for all required components and
> +packages, except ell, mentioned below.
> =


Nope. Since ELL is actually optional. It is clearly described just a few li=
nes below.

> To compile and install run:
> 	make && make install
> =

> +See "HACKING" file for details and step-by-step examples.
> +

And that is wrong as well. HACKING is for the developers and people just in=
stalling oFono should not look at that. In addition HACKING is not included=
 in the tarballs (while README is) and so you not reference a file from REA=
DME that is not in the tarballs.

Regards

Marcel


--===============3937541307135752210==--

