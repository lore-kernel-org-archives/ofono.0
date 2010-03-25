Content-Type: multipart/mixed; boundary="===============8255913469834341059=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Issue with PPP auth and empty username/password
Date: Wed, 24 Mar 2010 17:00:25 -0700
Message-ID: <1269475225.11714.151.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8255913469834341059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

I started tested the PPP code and run into a simple crash when not
providing username and password. This should be possible.

Program terminated with signal 11, Segmentation fault.
#0  0x0000003457e7f2f2 in __strlen_sse2 () from /lib64/libc.so.6
(gdb) bt
#0  0x0000003457e7f2f2 in __strlen_sse2 () from /lib64/libc.so.6
#1  0x000000000040ca9b in chap_process_challenge (priv=3D0x15a6bf0, new_pac=
ket=3D0x15a5164 "\001\001")
    at gatchat/ppp_auth.c:86
#2  chap_process_packet (priv=3D0x15a6bf0, new_packet=3D0x15a5164 "\001\001=
") at gatchat/ppp_auth.c:143
#3  0x000000000040a66f in ppp_recv (channel=3D<value optimized out>, cond=
=3D<value optimized out>, data=3D0x15a6d50)
    at gatchat/ppp.c:205
#4  ppp_feed (channel=3D<value optimized out>, cond=3D<value optimized out>=
, data=3D0x15a6d50) at gatchat/ppp.c:286
#5  ppp_cb (channel=3D<value optimized out>, cond=3D<value optimized out>, =
data=3D0x15a6d50) at gatchat/ppp.c:340
#6  0x0000003598a3923e in g_main_context_dispatch () from /lib64/libglib-2.=
0.so.0
#7  0x0000003598a3cc28 in ?? () from /lib64/libglib-2.0.so.0
#8  0x0000003598a3d075 in g_main_loop_run () from /lib64/libglib-2.0.so.0
#9  0x0000000000403918 in main (argc=3D1, argv=3D0x7fff7b97eb28) at gatchat=
/gsmdial.c:624

Regards

Marcel



--===============8255913469834341059==--

