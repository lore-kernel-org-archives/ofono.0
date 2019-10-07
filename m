Content-Type: multipart/mixed; boundary="===============9152742812607401603=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv2] gatmux: take reference to mux object while processing
 incoming data
Date: Mon, 07 Oct 2019 23:29:45 +0200
Message-ID: <20191007212945.19850-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9152742812607401603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When closing down a cmux object, the address sanitizer detects a
use-after-free in gatmux.c (see below).

Avoid this by taking a reference to the mux object during the processing
in received_data().

ofonod[3640549]: ../git/plugins/quectel.c:cfun_disable() 0x610000000b40
ofonod[3640549]: ../git/plugins/quectel.c:close_serial() 0x610000000b40
ofonod[3640549]: ../git/plugins/quectel.c:close_mux() 0x610000000b40
ofonod[3640549]: ../git/examples/emulator.c:powered_watch() Removing modem =
0x610000000b40 from the list
ofonod[3640549]: ../git/examples/emulator.c:powered_watch() Removing server=
 watch: 106
ofonod[3640549]: ../git/src/modem.c:modem_change_state() old state: 0, new =
state: 0

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D3640549=3D=3DERROR: AddressSanitizer: heap-use-after-free on address =
0x62100073dd28 at pc 0x5566b6402a21 bp 0x7ffe7a2db0e0 sp 0x7ffe7a2db0d0
READ of size 8 at 0x62100073dd28 thread T0
    #0 0x5566b6402a20 in debug ../git/gatchat/gatmux.c:109
    #1 0x5566b6404bd7 in channel_close ../git/gatchat/gatmux.c:525
    #2 0x7fa0516e44a6 in g_io_channel_shutdown (/usr/lib/libglib-2.0.so.0+0=
x774a6)
    #3 0x7fa0516e4644 in g_io_channel_unref (/usr/lib/libglib-2.0.so.0+0x77=
644)
    #4 0x5566b64048a4 in watch_finalize ../git/gatchat/gatmux.c:474
    #5 0x7fa0516d6f6f  (/usr/lib/libglib-2.0.so.0+0x69f6f)
    #6 0x7fa0516ac6a7 in g_slist_foreach (/usr/lib/libglib-2.0.so.0+0x3f6a7)
    #7 0x7fa0516b277b in g_slist_free_full (/usr/lib/libglib-2.0.so.0+0x457=
7b)
    #8 0x5566b6403413 in dispatch_sources ../git/gatchat/gatmux.c:224
    #9 0x5566b64039ea in received_data ../git/gatchat/gatmux.c:268
    #10 0x7fa0516d727e in g_main_context_dispatch (/usr/lib/libglib-2.0.so.=
0+0x6a27e)
    #11 0x7fa0516d91c0  (/usr/lib/libglib-2.0.so.0+0x6c1c0)
    #12 0x7fa0516da0d2 in g_main_loop_run (/usr/lib/libglib-2.0.so.0+0x6d0d=
2)
    #13 0x5566b6429b1b in main ../git/src/main.c:286
    #14 0x7fa05147fee2 in __libc_start_main (/usr/lib/libc.so.6+0x26ee2)
    #15 0x5566b62531ad in _start (/home/martin/projects/ofono/x86/src/ofono=
d+0xfc1ad)

0x62100073dd28 is located 40 bytes inside of 4672-byte region [0x62100073dd=
00,0x62100073ef40)
freed by thread T0 here:
    #0 0x7fa0519256c0 in __interceptor_free /build/gcc/src/gcc/libsanitizer=
/asan/asan_malloc_linux.cc:122
    #1 0x5566b64052d7 in g_at_mux_unref ../git/gatchat/gatmux.c:645
    #2 0x5566b63d6d19 in close_mux ../git/plugins/quectel.c:199
    #3 0x5566b63d7047 in close_serial ../git/plugins/quectel.c:223
    #4 0x5566b63db62a in cfun_disable ../git/plugins/quectel.c:1056
    #5 0x5566b63f6ae1 in at_chat_finish_command ../git/gatchat/gatchat.c:459
    #6 0x5566b63f701b in at_chat_handle_command_response ../git/gatchat/gat=
chat.c:521
    #7 0x5566b63f785b in have_line ../git/gatchat/gatchat.c:600
    #8 0x5566b63f87f1 in new_bytes ../git/gatchat/gatchat.c:759
    #9 0x5566b640174c in received_data ../git/gatchat/gatio.c:122
    #10 0x5566b64047b4 in watch_dispatch ../git/gatchat/gatmux.c:464
    #11 0x5566b640313b in dispatch_sources ../git/gatchat/gatmux.c:183
    #12 0x5566b64039ea in received_data ../git/gatchat/gatmux.c:268
    #13 0x7fa0516d727e in g_main_context_dispatch (/usr/lib/libglib-2.0.so.=
0+0x6a27e)

previously allocated by thread T0 here:
    #0 0x7fa051925ce8 in __interceptor_calloc /build/gcc/src/gcc/libsanitiz=
er/asan/asan_malloc_linux.cc:153
    #1 0x5566b6405009 in g_at_mux_new ../git/gatchat/gatmux.c:606
    #2 0x5566b6407f6b in g_at_mux_new_gsm0710_basic ../git/gatchat/gatmux.c=
:1165
    #3 0x5566b63da9ba in cmux_cb ../git/plugins/quectel.c:882
    #4 0x5566b63f6ae1 in at_chat_finish_command ../git/gatchat/gatchat.c:459
    #5 0x5566b63f701b in at_chat_handle_command_response ../git/gatchat/gat=
chat.c:521
    #6 0x5566b63f785b in have_line ../git/gatchat/gatchat.c:600
    #7 0x5566b63f87f1 in new_bytes ../git/gatchat/gatchat.c:759
    #8 0x5566b640174c in received_data ../git/gatchat/gatio.c:122
    #9 0x7fa0516d727e in g_main_context_dispatch (/usr/lib/libglib-2.0.so.0=
+0x6a27e)

SUMMARY: AddressSanitizer: heap-use-after-free ../git/gatchat/gatmux.c:109 =
in debug
Shadow bytes around the buggy address:
  0x0c42800dfb50: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c42800dfb60: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c42800dfb70: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c42800dfb80: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c42800dfb90: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
=3D>0x0c42800dfba0: fd fd fd fd fd[fd]fd fd fd fd fd fd fd fd fd fd
  0x0c42800dfbb0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c42800dfbc0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c42800dfbd0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c42800dfbe0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c42800dfbf0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
=3D=3D3640549=3D=3DABORTING
---

Changes since v1:
 * fix return with reference in received_data()
 * remove destroy_notify callback for read_watch
 * remove leftovers from RFC

 gatchat/gatmux.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/gatchat/gatmux.c b/gatchat/gatmux.c
index 757a5123..88623807 100644
--- a/gatchat/gatmux.c
+++ b/gatchat/gatmux.c
@@ -227,13 +227,13 @@ static void dispatch_sources(GAtMuxChannel *channel, =
GIOCondition condition)
 static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 							gpointer data)
 {
-	GAtMux *mux =3D data;
+	GAtMux *mux =3D g_at_mux_ref(data);
 	int i;
 	GIOStatus status;
 	gsize bytes_read;
 =

 	if (cond & G_IO_NVAL)
-		return FALSE;
+		goto done;
 =

 	debug(mux, "received data");
 =

@@ -270,15 +270,22 @@ static gboolean received_data(GIOChannel *channel, GI=
OCondition cond,
 	}
 =

 	if (cond & (G_IO_HUP | G_IO_ERR))
-		return FALSE;
+		goto done;
 =

 	if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN)
-		return FALSE;
+		goto done;
 =

 	if (mux->buf_used =3D=3D sizeof(mux->buf))
-		return FALSE;
+		goto done;
+
+	g_at_mux_unref(mux);
 =

 	return TRUE;
+
+done:
+	g_at_mux_unref(mux);
+
+	return FALSE;
 }
 =

 static void write_watcher_destroy_notify(gpointer user_data)
@@ -646,13 +653,6 @@ void g_at_mux_unref(GAtMux *mux)
 	}
 }
 =

-static void read_watcher_destroy_notify(gpointer user_data)
-{
-	GAtMux *mux =3D user_data;
-
-	mux->read_watch =3D 0;
-}
-
 gboolean g_at_mux_start(GAtMux *mux)
 {
 	if (mux->channel =3D=3D NULL)
@@ -666,8 +666,7 @@ gboolean g_at_mux_start(GAtMux *mux)
 =

 	mux->read_watch =3D g_io_add_watch_full(mux->channel, G_PRIORITY_DEFAULT,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-						received_data, mux,
-						read_watcher_destroy_notify);
+						received_data, mux, NULL);
 =

 	mux->shutdown =3D FALSE;
 =

-- =

2.23.0

--===============9152742812607401603==--

