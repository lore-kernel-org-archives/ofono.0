Content-Type: multipart/mixed; boundary="===============8464996412849761654=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Fix: clean-local target
Date: Fri, 23 Apr 2010 18:25:18 +0200
Message-ID: <1272039918.22838.89.camel@localhost.localdomain>
In-Reply-To: <1271935576-8472-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8464996412849761654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

>  Makefile.am |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index 86ccf1b..db7e33e 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -426,5 +426,5 @@ include/ofono/%.h: include/%.h
>  	$(AM_V_at)$(MKDIR_P) include/ofono
>  	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
>  =

> -clean-local: include/ofono
> -	@$(RM) -r $<
> +clean-local:
> +	$(RM) -rf include/ofono

what is this trying to fix?

And you removed the @ in front of the command.

Regards

Marcel



--===============8464996412849761654==--

