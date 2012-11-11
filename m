Content-Type: multipart/mixed; boundary="===============1242181169308465879=="
MIME-Version: 1.0
From: Holger Hans Peter Freyther <holger@freyther.de>
Subject: Memory corruption when submitting a huge number of SMS
Date: Sun, 11 Nov 2012 09:44:08 +0100
Message-ID: <20121111084408.GA10708@xiaoyu.lan>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1242181169308465879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am using our modem bank with four SIM cards and send 1000 per
SIM card and ofono is segfaulting in the process of doing so. The
crash appears to be due a memory corruption and I wonder if you
have experience in debugging those. This is ofono-1.11 with some
patches to build on debian stable.

kind regards
	holger


gdb backtrace:
#0  0xb7e51c02 in dbus_connection_get_dispatch_status ()
   from /lib/i386-linux-gnu/libdbus-1.so.3
#1  0x08054be6 in watch_func (chan=3D0x8712e78, cond=3D0, data=3D0x8713590)=
 at gdbus/mainloop.c:105
#2  0xb7f1b6fe in ?? () from /lib/i386-linux-gnu/libglib-2.0.so.0
#3  0xb7eda6d3 in g_main_context_dispatch () from /lib/i386-linux-gnu/libgl=
ib-2.0.so.0
#4  0xb7edaa70 in ?? () from /lib/i386-linux-gnu/libglib-2.0.so.0
#5  0xb7edaecb in g_main_loop_run () from /lib/i386-linux-gnu/libglib-2.0.s=
o.0
#6  0x080d378a in main (argc=3D1, argv=3D0xbffff764) at src/main.c:247


valgrind:
=3D=3D10495=3D=3D Invalid read of size 4
=3D=3D10495=3D=3D    at 0x8054BDB: watch_func (mainloop.c:105)
=3D=3D10495=3D=3D    by 0x410C6FD: ??? (in /lib/i386-linux-gnu/libglib-2.0.=
so.0.3200.4)
=3D=3D10495=3D=3D    by 0x40CB6D2: g_main_context_dispatch (in /lib/i386-li=
nux-gnu/libglib-2.0.so.0.3200.4)
=3D=3D10495=3D=3D    by 0x40CBA6F: ??? (in /lib/i386-linux-gnu/libglib-2.0.=
so.0.3200.4)
=3D=3D10495=3D=3D    by 0x40CBECA: g_main_loop_run (in /lib/i386-linux-gnu/=
libglib-2.0.so.0.3200.4)
=3D=3D10495=3D=3D    by 0x4208E45: (below main) (libc-start.c:228)
=3D=3D10495=3D=3D  Address 0x47ba830 is 8 bytes inside a block of size 12 f=
ree'd
=3D=3D10495=3D=3D    at 0x402768C: free (vg_replace_malloc.c:446)
=3D=3D10495=3D=3D    by 0x40D177A: ??? (in /lib/i386-linux-gnu/libglib-2.0.=
so.0.3200.4)
=3D=3D10495=3D=3D    by 0x41A81AC: ??? (in /lib/i386-linux-gnu/libdbus-1.so=
.3.7.2)
=3D=3D10495=3D=3D    by 0x418AD21: ??? (in /lib/i386-linux-gnu/libdbus-1.so=
.3.7.2)
=3D=3D10495=3D=3D    by 0x41A6BEC: ??? (in /lib/i386-linux-gnu/libdbus-1.so=
.3.7.2)
=3D=3D10495=3D=3D    by 0x41A7901: ??? (in /lib/i386-linux-gnu/libdbus-1.so=
.3.7.2)
=3D=3D10495=3D=3D    by 0x41A6028: ??? (in /lib/i386-linux-gnu/libdbus-1.so=
.3.7.2)
=3D=3D10495=3D=3D    by 0x418DA0A: ??? (in /lib/i386-linux-gnu/libdbus-1.so=
.3.7.2)
=3D=3D10495=3D=3D    by 0x410C6FD: ??? (in /lib/i386-linux-gnu/libglib-2.0.=
so.0.3200.4)
=3D=3D10495=3D=3D    by 0x40CB6D2: g_main_context_dispatch (in /lib/i386-li=
nux-gnu/libglib-2.0.so.0.3200.4)
=3D=3D10495=3D=3D    by 0x40CBA6F: ??? (in /lib/i386-linux-gnu/libglib-2.0.=
so.0.3200.4)
=3D=3D10495=3D=3D    by 0x40CBECA: g_main_loop_run (in /lib/i386-linux-gnu/=
libglib-2.0.so.0.3200.4)
=3D=3D10495=3D=3D =

=3D=3D10495=3D=3D Invalid read of size 4
=3D=3D10495=3D=3D    at 0x8054BE6: watch_func (mainloop.c:106)
=3D=3D10495=3D=3D    by 0x410C6FD: ??? (in /lib/i386-linux-gnu/libglib-2.0.=
so.0.3200.4)
=3D=3D10495=3D=3D    by 0x40CB6D2: g_main_context_dispatch (in /lib/i386-li=
nux-gnu/libglib-2.0.so.0.3200.4)
=3D=3D10495=3D=3D    by 0x40CBA6F: ??? (in /lib/i386-linux-gnu/libglib-2.0.=
so.0.3200.4)
=3D=3D10495=3D=3D    by 0x40CBECA: g_main_loop_run (in /lib/i386-linux-gnu/=
libglib-2.0.so.0.3200.4)
=3D=3D10495=3D=3D    by 0x4208E45: (below main) (libc-start.c:228)
=3D=3D10495=3D=3D  Address 0x47ba830 is 8 bytes inside a block of size 12 f=
ree'd
=3D=3D10495=3D=3D    at 0x402768C: free (vg_replace_malloc.c:446)
=3D=3D10495=3D=3D    by 0x40D177A: ??? (in /lib/i386-linux-gnu/libglib-2.0.=
so.0.3200.4)
=3D=3D10495=3D=3D    by 0x41A81AC: ??? (in /lib/i386-linux-gnu/libdbus-1.so=
.3.7.2)
=3D=3D10495=3D=3D    by 0x418AD21: ??? (in /lib/i386-linux-gnu/libdbus-1.so=
.3.7.2)
=3D=3D10495=3D=3D    by 0x41A6BEC: ??? (in /lib/i386-linux-gnu/libdbus-1.so=
.3.7.2)
=3D=3D10495=3D=3D    by 0x41A7901: ??? (in /lib/i386-linux-gnu/libdbus-1.so=
.3.7.2)
=3D=3D10495=3D=3D    by 0x41A6028: ??? (in /lib/i386-linux-gnu/libdbus-1.so=
.3.7.2)
=3D=3D10495=3D=3D    by 0x418DA0A: ??? (in /lib/i386-linux-gnu/libdbus-1.so=
.3.7.2)
=3D=3D10495=3D=3D    by 0x410C6FD: ??? (in /lib/i386-linux-gnu/libglib-2.0.=
so.0.3200.4)
=3D=3D10495=3D=3D    by 0x40CB6D2: g_main_context_dispatch (in /lib/i386-li=
nux-gnu/libglib-2.0.so.0.3200.4)
=3D=3D10495=3D=3D    by 0x40CBA6F: ??? (in /lib/i386-linux-gnu/libglib-2.0.=
so.0.3200.4)
=3D=3D10495=3D=3D    by 0x40CBECA: g_main_loop_run (in /lib/i386-linux-gnu/=
libglib-2.0.so.0.3200.4)
=3D=3D10495=3D=3D=20

--===============1242181169308465879==--

