Content-Type: multipart/mixed; boundary="===============9209744353539242616=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RESEND] [PATCH] Mark ofono/*.h symbolink links as built sources
Date: Sat, 04 Dec 2010 01:06:06 +0100
Message-ID: <1291421166.4795.115.camel@aeonflux>
In-Reply-To: <1291404982-13459-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9209744353539242616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> This forces automake/make to build them first if needed (as before).
> But it avoids marking every single header as a dependency of every
> single object. Thus we do not need a bogus full rebuild of the tree
> everytime a header is added.

I have run some tests on this and seems fine to me.

> ---
>  Makefile.am |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index a4c47e8..ee7949d 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -326,7 +326,8 @@ src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @D=
BUS_LIBS@ @CAPNG_LIBS@ -ldl
>  src_ofonod_LDFLAGS =3D -Wl,--export-dynamic \
>  				-Wl,--version-script=3D$(srcdir)/src/ofono.ver
>  =

> -CLEANFILES =3D src/builtin.h $(local_headers) $(rules_DATA)
> +BUILT_SOURCES =3D $(local_headers)
> +CLEANFILES =3D src/builtin.h $(BUILT_SOURCES) $(rules_DATA)

But can you please add an empty line between these two variable
assignments. Just for consistency with the rest of the Makefile.am code.

Regards

Marcel



--===============9209744353539242616==--

