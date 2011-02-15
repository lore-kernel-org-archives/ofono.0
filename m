Content-Type: multipart/mixed; boundary="===============8088941864881939646=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Makefile: rerun genbuiltin on reconfigure.
Date: Tue, 15 Feb 2011 12:55:29 -0800
Message-ID: <1297803329.2519.6.camel@aeonflux>
In-Reply-To: <1297760152-19815-2-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8088941864881939646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Make builtin.h depend on config.status to force regeneration when
> plugins may have been enabled or disabled.  There may be a better
> way to do that.  The dependency on builtin_sources is not needed.
> ---
>  Makefile.am |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index 42ad86f..3182fbb 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -571,7 +571,7 @@ MAINTAINERCLEANFILES =3D Makefile.in \
>  =

>  src/plugin.$(OBJEXT): src/builtin.h
>  =

> -src/builtin.h: src/genbuiltin $(builtin_sources)
> +src/builtin.h: src/genbuiltin config.status
>  	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@

so depending on config.status is fine, but why no longer on
$(builtin_sources)?

Regards

Marcel



--===============8088941864881939646==--

