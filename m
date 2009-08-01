Content-Type: multipart/mixed; boundary="===============6624487231257088093=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: ofono build error on ARM
Date: Sat, 01 Aug 2009 11:14:13 +0300
Message-ID: <200908011114.15076.remi@remlab.net>
In-Reply-To: <20090731111310.177802f7@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6624487231257088093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le vendredi 31 juillet 2009 18:13:10 Andres Salomon, vous avez =C3=A9crit :
> Hi,
>
> I'm seeing the following build error when building ofono on an HTC G1
> phone:
>
> gcc -DHAVE_CONFIG_H -I. -I.. -I/usr/include/glib-2.0
> -I/usr/lib/glib-2.0/include -g -O2 -g -Werror -Wextra
> -Wno-unused-parameter -Wno-missing-field-initializers
> -Wdeclaration-after-statement -Wmissing-declarations -Wredundant-decls
> -Wcast-align -MT netlink.lo -MD -MP -MF .deps/netlink.Tpo -c netlink.c
> -fPIC -DPIC -o .libs/netlink.o
>
> cc1: warnings being treated as errors
> netlink.c: In function =E2=80=98g_pn_nl_process=E2=80=99:
> netlink.c:75: error: cast increases required alignment of target type
> netlink.c:107: error: cast increases required alignment of target type
> netlink.c:109: error: cast increases required alignment of target type
> make[2]: *** [netlink.lo] Error 1

I think there is no way to fix this. It comes from the Netlink packet forma=
t =

and macros, which are confusing gcc. That's why I hate to enfore -Werror.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/


--===============6624487231257088093==--

