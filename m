Content-Type: multipart/mixed; boundary="===============7776540567804684127=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC patches 11/13] automake: fix installation of udev rules in
 VPATH builds
Date: Fri, 28 May 2010 16:25:57 +0200
Message-ID: <1275056757.4706.80.camel@aeonflux.t-mobile.de>
In-Reply-To: <a759b96fc09af236d1c322199cf42cc0d423fcc4.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7776540567804684127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> When the build directory is different than the source directory, we
> need to specify the source prefix to the original file we are
> copying.
> ---
>  Makefile.am |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index ed13346..31c157c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -418,7 +418,7 @@ src/ofono.ver: src/ofono.exp
>  	$(AM_V_at)echo "local: *; };" >> $@
>  =

>  plugins/%.rules:
> -	$(AM_V_GEN)cp $(subst 97-,,$@) $@
> +	$(AM_V_GEN)cp $(srcdir)/$(subst 97-,,$@) $@
>  =

>  $(src_ofonod_OBJECTS) $(unit_objects): $(local_headers)

I tested it within my release build system and it looks fine to me. At
least nothing breaks. I leave it up to Denis to apply the patch, but
please also submit similar patches for BlueZ and ConnMan since I am
pretty sure I missed it there as well.

Regards

Marcel



--===============7776540567804684127==--

