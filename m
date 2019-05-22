Content-Type: multipart/mixed; boundary="===============8757602931332485892=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Makefile.am: Don't overwrite src_ofonod_DEPENDENCIES
Date: Wed, 22 May 2019 08:49:52 -0500
Message-ID: <63cc0275-4753-7316-a1f7-9bf0ed705811@gmail.com>
In-Reply-To: <20190521113540.24373-1-bunk@kernel.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8757602931332485892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On 05/21/2019 06:35 AM, Adrian Bunk wrote:
> src_ofonod_DEPENDENCIES did overwrite the dependencies
> automatically generated from src_ofonod_LDADD with
> incomplete dependencies.
> =

> This fixes the following build error:
> ...
>    CCLD     src/ofonod
> libtool:   error: cannot find the library 'gdbus/libgdbus-internal.la' or=
 unhandled argument 'gdbus/libgdbus-internal.la'
> make: *** [Makefile:3448: src/ofonod] Error 1
> ---
>   Makefile.am | 4 ----
>   1 file changed, 4 deletions(-)
> =


Applied with a slight tweak to the commit header, thanks!

Regards,
-Denis

--===============8757602931332485892==--

