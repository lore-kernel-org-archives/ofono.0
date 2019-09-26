Content-Type: multipart/mixed; boundary="===============5872272591667733937=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [RFC] gatmux: don't free cmux data until watchers are destroyed
Date: Thu, 26 Sep 2019 23:17:59 +0200
Message-ID: <20190926211759.242770-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5872272591667733937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When closing down a cmux object, the address sanitizer detects a
use-after-free in gatmux.c (see below). It is caused by glib sources not be=
ing
entirely removed in g_at_mux_shutdown(), an so their callbacks can be
called with a freed mux object.

Avoid this by deferring the free of the mux object until the sources are
destroyed by the glib mainloop.

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

My theory is this:
 * The main loop has (at least) two pending sources:
     1) a gatchat callback to e.g. a plugin CFUN=3D0 command
     2) rx data ready on the cmux uart channel
 * The main loop calls the plugin callback first, where g_at_mux_unref()
   is called
 * The main loop then calls the mux->read_watch callback, where the
   (freed) cmux object is dereferrenced.

The patch below defers the cmux free until the read/write sources are
destroyed.

 gatchat/gatmux.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/gatchat/gatmux.c b/gatchat/gatmux.c
index 757a5123..02f688f9 100644
--- a/gatchat/gatmux.c
+++ b/gatchat/gatmux.c
@@ -235,6 +235,9 @@ static gboolean received_data(GIOChannel *channel, GIOC=
ondition cond,
 	if (cond & G_IO_NVAL)
 		return FALSE;
 =

+	if (mux->shutdown)
+		return FALSE;
+
 	debug(mux, "received data");
 =

 	bytes_read =3D 0;
@@ -286,6 +289,9 @@ static void write_watcher_destroy_notify(gpointer user_=
data)
 	GAtMux *mux =3D user_data;
 =

 	mux->write_watch =3D 0;
+
+	if (mux->read_watch <=3D 0 && mux->write_watch <=3D 0)
+		g_free(mux);
 }
 =

 static gboolean can_write_data(GIOChannel *chan, GIOCondition cond,
@@ -297,6 +303,9 @@ static gboolean can_write_data(GIOChannel *chan, GIOCon=
dition cond,
 	if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR))
 		return FALSE;
 =

+	if (mux->shutdown)
+		return FALSE;
+
 	debug(mux, "can write data");
 =

 	for (dlc =3D 0; dlc < MAX_CHANNELS; dlc +=3D 1) {
@@ -607,6 +616,7 @@ GAtMux *g_at_mux_new(GIOChannel *channel, const GAtMuxD=
river *driver)
 	if (mux =3D=3D NULL)
 		return NULL;
 =

+
 	mux->ref_count =3D 1;
 	mux->driver =3D driver;
 	mux->shutdown =3D TRUE;
@@ -642,7 +652,8 @@ void g_at_mux_unref(GAtMux *mux)
 		if (mux->driver->remove)
 			mux->driver->remove(mux);
 =

-		g_free(mux);
+		if (mux->read_watch <=3D 0 && mux->write_watch <=3D 0)
+			g_free(mux);
 	}
 }
 =

@@ -651,6 +662,9 @@ static void read_watcher_destroy_notify(gpointer user_d=
ata)
 	GAtMux *mux =3D user_data;
 =

 	mux->read_watch =3D 0;
+
+	if (mux->read_watch <=3D 0 && mux->write_watch <=3D 0)
+		g_free(mux);
 }
 =

 gboolean g_at_mux_start(GAtMux *mux)
@@ -695,6 +709,7 @@ gboolean g_at_mux_shutdown(GAtMux *mux)
 			continue;
 =

 		channel_close((GIOChannel *) mux->dlcs[i], NULL);
+		mux->dlcs[i] =3D NULL;
 	}
 =

 	if (mux->driver->shutdown)
-- =

2.23.0


--===============5872272591667733937==--

