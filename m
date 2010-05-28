Content-Type: multipart/mixed; boundary="===============2155668943729191952=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC patches 01/13] Update .gitignore to ignore cscope databases
 and backup files
Date: Fri, 28 May 2010 16:08:11 +0200
Message-ID: <1275055691.4706.70.camel@aeonflux.t-mobile.de>
In-Reply-To: <c46927ad93ad4b85ce6ace5c44af1bdc13414b68.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2155668943729191952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> diff --git a/.gitignore b/.gitignore
> index 1ce7067..d7e9254 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,3 +1,4 @@
> +*~

believe it or not, I always left that out on purpose. I like having git
status show me all the stupid backup files my editor creates.

>  *.o
>  *.lo
>  *.la
> @@ -16,6 +17,8 @@ config.sub
>  configure
>  depcomp
>  compile
> +cscope.files
> +cscope.out
>  install-sh
>  libtool
>  ltmain.sh

Please put the cscope stuff behind autom4te.cache since it is not part
of autoconf/automake.

Regards

Marcel




--===============2155668943729191952==--

