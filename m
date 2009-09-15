Content-Type: multipart/mixed; boundary="===============3163425472299198755=="
MIME-Version: 1.0
From: Timo Juhani Lindfors <timo.lindfors@iki.fi>
Subject: netlink.c:97: error: cast increases required alignment of target type
Date: Tue, 15 Sep 2009 21:36:51 +0300
Message-ID: <84y6og3vi4.fsf@sauna.l.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3163425472299198755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

git clone git://git.kernel.org/pub/scm/network/ofono/ofono.git
cd ofono
./bootstrap
./configure --enable-debug --prefix=3D/home/lindi/install --enable-maintain=
er-mode --mandir=3D/home/lindi/install/usr/share/man --sysconfdir=3D/home/l=
indi/install/etc --localstatedir=3D/home/lindi/install/var --disable-datafi=
les
make

fails with

>   CC     gdbus/watch.o
>   CC     gisi/netlink.o
> cc1: warnings being treated as errors
> gisi/netlink.c: In function 'g_pn_nl_process':
> gisi/netlink.c:97: error: cast increases required alignment of target type
> gisi/netlink.c:129: error: cast increases required alignment of target ty=
pe
> gisi/netlink.c:130: error: cast increases required alignment of target ty=
pe

on armel (openmoko gta02) debian unstable system with gcc 4:4.3.3-9
apparently since in mainstainer mode -Wcast-align complains about

#define NLMSG_NEXT(nlh,len)      ((len) -=3D NLMSG_ALIGN((nlh)->nlmsg_len),=
 \
                                  (struct nlmsghdr*)(((char*)(nlh)) + NLMSG=
_ALIGN((nlh)->nlmsg_len)))

which is defined in /usr/include/linux/netlink. I don't know how to
best fix this. The options that I see are

1) Add

pragma GCC diagnostic warning "-Wcast-align"

to ignore the issue in the four affected files: gisi/client.c gisi/iter.c g=
isi/netlink.c gisi/socket.c

2) Disable -Wcast-alignt checks completely even in maintainer mode (not ver=
y nice)

3) Include a fixed version of NLMSG_ALIGN (and also send it usptream of cou=
rse).


best regards,
Timo Lindfors

--===============3163425472299198755==--

