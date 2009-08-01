Content-Type: multipart/mixed; boundary="===============6877653310259091766=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: ofono build error on ARM
Date: Sat, 01 Aug 2009 08:06:49 -0700
Message-ID: <1249139209.3491.1.camel@localhost.localdomain>
In-Reply-To: <200908011114.15076.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6877653310259091766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > I'm seeing the following build error when building ofono on an HTC G1
> > phone:
> >
> > gcc -DHAVE_CONFIG_H -I. -I.. -I/usr/include/glib-2.0
> > -I/usr/lib/glib-2.0/include -g -O2 -g -Werror -Wextra
> > -Wno-unused-parameter -Wno-missing-field-initializers
> > -Wdeclaration-after-statement -Wmissing-declarations -Wredundant-decls
> > -Wcast-align -MT netlink.lo -MD -MP -MF .deps/netlink.Tpo -c netlink.c
> > -fPIC -DPIC -o .libs/netlink.o
> >
> > cc1: warnings being treated as errors
> > netlink.c: In function =E2=80=98g_pn_nl_process=E2=80=99:
> > netlink.c:75: error: cast increases required alignment of target type
> > netlink.c:107: error: cast increases required alignment of target type
> > netlink.c:109: error: cast increases required alignment of target type
> > make[2]: *** [netlink.lo] Error 1
> =

> I think there is no way to fix this. It comes from the Netlink packet for=
mat =

> and macros, which are confusing gcc. That's why I hate to enfore -Werror.

we only enforce -Werror for the developers and it is important to have
gcc help us catch mistakes that might be easily overlooked. I would have
to look into these one and how we can fix them properly.

Regards

Marcel



--===============6877653310259091766==--

