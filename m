Content-Type: multipart/mixed; boundary="===============3495221036688180402=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Memory corruption when submitting a huge number of SMS
Date: Mon, 12 Nov 2012 13:29:10 -0600
Message-ID: <50A14E06.5020204@gmail.com>
In-Reply-To: <20121111084408.GA10708@xiaoyu.lan>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3495221036688180402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Holger,

> gdb backtrace:
> #0  0xb7e51c02 in dbus_connection_get_dispatch_status ()
>     from /lib/i386-linux-gnu/libdbus-1.so.3
> #1  0x08054be6 in watch_func (chan=3D0x8712e78, cond=3D0, data=3D0x871359=
0) at gdbus/mainloop.c:105
> #2  0xb7f1b6fe in ?? () from /lib/i386-linux-gnu/libglib-2.0.so.0
> #3  0xb7eda6d3 in g_main_context_dispatch () from /lib/i386-linux-gnu/lib=
glib-2.0.so.0
> #4  0xb7edaa70 in ?? () from /lib/i386-linux-gnu/libglib-2.0.so.0
> #5  0xb7edaecb in g_main_loop_run () from /lib/i386-linux-gnu/libglib-2.0=
.so.0
> #6  0x080d378a in main (argc=3D1, argv=3D0xbffff764) at src/main.c:247
>

Not a whole lot to go on.  Looks like the crash happens in gdbus.  Is =

the dbus daemon crashing or bumping ofono off the bus by any chance?

>
> valgrind:
> =3D=3D10495=3D=3D Invalid read of size 4
> =3D=3D10495=3D=3D    at 0x8054BDB: watch_func (mainloop.c:105)
> =3D=3D10495=3D=3D    by 0x410C6FD: ??? (in /lib/i386-linux-gnu/libglib-2.=
0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x40CB6D2: g_main_context_dispatch (in /lib/i386-=
linux-gnu/libglib-2.0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x40CBA6F: ??? (in /lib/i386-linux-gnu/libglib-2.=
0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x40CBECA: g_main_loop_run (in /lib/i386-linux-gn=
u/libglib-2.0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x4208E45: (below main) (libc-start.c:228)
> =3D=3D10495=3D=3D  Address 0x47ba830 is 8 bytes inside a block of size 12=
 free'd
> =3D=3D10495=3D=3D    at 0x402768C: free (vg_replace_malloc.c:446)
> =3D=3D10495=3D=3D    by 0x40D177A: ??? (in /lib/i386-linux-gnu/libglib-2.=
0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x41A81AC: ??? (in /lib/i386-linux-gnu/libdbus-1.=
so.3.7.2)
> =3D=3D10495=3D=3D    by 0x418AD21: ??? (in /lib/i386-linux-gnu/libdbus-1.=
so.3.7.2)
> =3D=3D10495=3D=3D    by 0x41A6BEC: ??? (in /lib/i386-linux-gnu/libdbus-1.=
so.3.7.2)
> =3D=3D10495=3D=3D    by 0x41A7901: ??? (in /lib/i386-linux-gnu/libdbus-1.=
so.3.7.2)
> =3D=3D10495=3D=3D    by 0x41A6028: ??? (in /lib/i386-linux-gnu/libdbus-1.=
so.3.7.2)
> =3D=3D10495=3D=3D    by 0x418DA0A: ??? (in /lib/i386-linux-gnu/libdbus-1.=
so.3.7.2)
> =3D=3D10495=3D=3D    by 0x410C6FD: ??? (in /lib/i386-linux-gnu/libglib-2.=
0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x40CB6D2: g_main_context_dispatch (in /lib/i386-=
linux-gnu/libglib-2.0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x40CBA6F: ??? (in /lib/i386-linux-gnu/libglib-2.=
0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x40CBECA: g_main_loop_run (in /lib/i386-linux-gn=
u/libglib-2.0.so.0.3200.4)
> =3D=3D10495=3D=3D
> =3D=3D10495=3D=3D Invalid read of size 4
> =3D=3D10495=3D=3D    at 0x8054BE6: watch_func (mainloop.c:106)
> =3D=3D10495=3D=3D    by 0x410C6FD: ??? (in /lib/i386-linux-gnu/libglib-2.=
0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x40CB6D2: g_main_context_dispatch (in /lib/i386-=
linux-gnu/libglib-2.0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x40CBA6F: ??? (in /lib/i386-linux-gnu/libglib-2.=
0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x40CBECA: g_main_loop_run (in /lib/i386-linux-gn=
u/libglib-2.0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x4208E45: (below main) (libc-start.c:228)
> =3D=3D10495=3D=3D  Address 0x47ba830 is 8 bytes inside a block of size 12=
 free'd
> =3D=3D10495=3D=3D    at 0x402768C: free (vg_replace_malloc.c:446)
> =3D=3D10495=3D=3D    by 0x40D177A: ??? (in /lib/i386-linux-gnu/libglib-2.=
0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x41A81AC: ??? (in /lib/i386-linux-gnu/libdbus-1.=
so.3.7.2)
> =3D=3D10495=3D=3D    by 0x418AD21: ??? (in /lib/i386-linux-gnu/libdbus-1.=
so.3.7.2)
> =3D=3D10495=3D=3D    by 0x41A6BEC: ??? (in /lib/i386-linux-gnu/libdbus-1.=
so.3.7.2)
> =3D=3D10495=3D=3D    by 0x41A7901: ??? (in /lib/i386-linux-gnu/libdbus-1.=
so.3.7.2)
> =3D=3D10495=3D=3D    by 0x41A6028: ??? (in /lib/i386-linux-gnu/libdbus-1.=
so.3.7.2)
> =3D=3D10495=3D=3D    by 0x418DA0A: ??? (in /lib/i386-linux-gnu/libdbus-1.=
so.3.7.2)
> =3D=3D10495=3D=3D    by 0x410C6FD: ??? (in /lib/i386-linux-gnu/libglib-2.=
0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x40CB6D2: g_main_context_dispatch (in /lib/i386-=
linux-gnu/libglib-2.0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x40CBA6F: ??? (in /lib/i386-linux-gnu/libglib-2.=
0.so.0.3200.4)
> =3D=3D10495=3D=3D    by 0x40CBECA: g_main_loop_run (in /lib/i386-linux-gn=
u/libglib-2.0.so.0.3200.4)
> =3D=3D10495=3D=3D

Have you tried making a debug build and seeing if you get slightly =

better debug information?  Just set CFLAGS to -O0 and --enable-debug =

when configuring.

Regards,
-Denis

--===============3495221036688180402==--

