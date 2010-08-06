Content-Type: multipart/mixed; boundary="===============4748795355288907643=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [SMS D-Bus v5 14/17] automake: fix generation of symlinks for
 headers
Date: Fri, 06 Aug 2010 04:22:23 +0200
Message-ID: <1281061343.12579.119.camel@localhost.localdomain>
In-Reply-To: <d1fab71b92d743e419cc05f18c4286deb5b9a447.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4748795355288907643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> When running 'make distcheck' from a vpath build directory (ie: one
> that is not where the source lives), the target headers in
> include/ofono are not generated properly due to a typo in the
> Makefile.am, that is using _srcdir where _buildir should be being
> used.
> ---
>  Makefile.am |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index b64ce8e..28d1e77 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -446,7 +446,7 @@ include/ofono/version.h: include/version.h
>  =

>  include/ofono/%.h: include/%.h
>  	$(AM_V_at)$(MKDIR_P) include/ofono
> -	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
> +	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@

are we having the same problem in ConnMan. I am seeing only builddir be
used for the version.h generation.

Regards

Marcel



--===============4748795355288907643==--

