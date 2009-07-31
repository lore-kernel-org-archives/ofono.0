Content-Type: multipart/mixed; boundary="===============0339793640539651485=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: Re: ofono build error on ARM
Date: Fri, 31 Jul 2009 11:30:51 -0400
Message-ID: <20090731113051.5cb59832@mycelium.queued.net>
In-Reply-To: <20090731111310.177802f7@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0339793640539651485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Jul 2009 11:13:10 -0400
Andres Salomon <dilinger@collabora.co.uk> wrote:

> Hi,
> =

> I'm seeing the following build error when building ofono on an HTC G1
> phone:
> =

> gcc -DHAVE_CONFIG_H -I. -I.. -I/usr/include/glib-2.0
> -I/usr/lib/glib-2.0/include -g -O2 -g -Werror -Wextra
> -Wno-unused-parameter -Wno-missing-field-initializers
> -Wdeclaration-after-statement -Wmissing-declarations -Wredundant-decls
> -Wcast-align -MT netlink.lo -MD -MP -MF .deps/netlink.Tpo -c netlink.c
> -fPIC -DPIC -o .libs/netlink.o
> =

> cc1: warnings being treated as errors
> netlink.c: In function =E2=80=98g_pn_nl_process=E2=80=99:
> netlink.c:75: error: cast increases required alignment of target type
> netlink.c:107: error: cast increases required alignment of target type
> netlink.c:109: error: cast increases required alignment of target type
> make[2]: *** [netlink.lo] Error 1
> =


Note that building the file without -Wcast-align fixes the
issue.  Perhaps just that single file should be built without cast
alignment checking?

--===============0339793640539651485==--

