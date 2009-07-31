Content-Type: multipart/mixed; boundary="===============8887552801268240646=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: ofono build error on ARM
Date: Fri, 31 Jul 2009 11:13:10 -0400
Message-ID: <20090731111310.177802f7@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8887552801268240646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm seeing the following build error when building ofono on an HTC G1
phone:

gcc -DHAVE_CONFIG_H -I. -I.. -I/usr/include/glib-2.0
-I/usr/lib/glib-2.0/include -g -O2 -g -Werror -Wextra
-Wno-unused-parameter -Wno-missing-field-initializers
-Wdeclaration-after-statement -Wmissing-declarations -Wredundant-decls
-Wcast-align -MT netlink.lo -MD -MP -MF .deps/netlink.Tpo -c netlink.c
-fPIC -DPIC -o .libs/netlink.o

cc1: warnings being treated as errors
netlink.c: In function =E2=80=98g_pn_nl_process=E2=80=99:
netlink.c:75: error: cast increases required alignment of target type
netlink.c:107: error: cast increases required alignment of target type
netlink.c:109: error: cast increases required alignment of target type
make[2]: *** [netlink.lo] Error 1

This is on a Debian lenny system.  The code in question is (for
example):

                for (rta =3D IFA_RTA(ifa);

Which expands to:

for (rta =3D =

((struct rtattr*)  ( ((char*)(ifa)) + ( ((sizeof(struct ifaddrmsg))+4 -1) &=
 ~(4 -1) )))
;

I believe the compiler is not liking the cast from char* to rtattr*,
but I'm not certain.

gcc info:

localhost:~/ofono#  gcc -v
Using built-in specs.
Target: arm-linux-gnueabi
Configured with: ../src/configure -v --with-pkgversion=3D'Debian 4.3.2-1.1'=
 --with-bugurl=3Dfile:///usr/share/doc/gcc-4.3/README.Bugs --enable-languag=
es=3Dc,c++,fortran,objc,obj-c++ --prefix=3D/usr --enable-shared --with-syst=
em-zlib --libexecdir=3D/usr/lib --without-included-gettext --enable-threads=
=3Dposix --enable-nls --with-gxx-include-dir=3D/usr/include/c++/4.3 --progr=
am-suffix=3D-4.3 --enable-clocale=3Dgnu --enable-libstdcxx-debug --enable-o=
bjc-gc --enable-mpfr --disable-libssp --disable-sjlj-exceptions --enable-ch=
ecking=3Drelease --build=3Darm-linux-gnueabi --host=3Darm-linux-gnueabi --t=
arget=3Darm-linux-gnueabi
Thread model: posix
gcc version 4.3.2 (Debian 4.3.2-1.1) =


localhost:~/ofono# cat /proc/cpuinfo =

Processor	: ARMv6-compatible processor rev 2 (v6l)
BogoMIPS	: 383.38
Features	: swp half thumb fastmult edsp java =

CPU implementer	: 0x41
CPU architecture: 6TEJ
CPU variant	: 0x1
CPU part	: 0xb36
CPU revision	: 2
Cache type	: write-back
Cache clean	: cp15 c7 ops
Cache lockdown	: format C
Cache format	: Harvard
I size		: 32768
I assoc		: 4
I line length	: 32
I sets		: 256
D size		: 32768
D assoc		: 4
D line length	: 32
D sets		: 256

Hardware	: trout
Revision	: 0080
Serial		: 0000000000000000



--===============8887552801268240646==--

