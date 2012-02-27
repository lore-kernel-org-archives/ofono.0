Content-Type: multipart/mixed; boundary="===============0666615886655884497=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] configure/make basics
Date: Mon, 27 Feb 2012 09:23:31 -0800
Message-ID: <1330363411.3392.53.camel@aeonflux>
In-Reply-To: <4F4B9E8C.3080809@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0666615886655884497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

> while hacking on a plugin for mmsd to deal with supl push
> messages, I ran into a few "not so nice" solved things
> in configure.ac / Makefile.am
> =

> 1) libtool handling
>    libtool configuration is meanwhile done using LT_INIT(options)
>    instead of AC_PROC_LIBTOOL and alike
>    =3D=3D> because of libtool stores some of the configuration
>        in the generated libtool shell script, it's reasonable
>        to run LT_INIT as late as possible (painfully learned
>        while writing and porting c++ software for many OS)
> 2) additional libraries
>    do no require explicit libraries (like -lresolv), always
>    let a devop in doubt invoke configure with
>    LIBS=3D"-lmyspecialwrapper" to wrap between available
>    libs/functions and requirements
>    See pkgsrc's nbcompat library for example

one patch per email please and all inline. Thanks.

Regards

Marcel



--===============0666615886655884497==--

