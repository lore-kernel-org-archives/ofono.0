Content-Type: multipart/mixed; boundary="===============0724680286093518118=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv3 2/2] gatmux: disable destroy notification on read watcher
Date: Tue, 08 Oct 2019 20:44:41 +0200
Message-ID: <20191008184441.7410-2-martin@geanix.com>
In-Reply-To: <20191008184441.7410-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0724680286093518118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With the reference in place in received_data(), the address sanitizer
now encounters a use-after-free when the destroy notification is
dispatched for the read watcher (see below).

Fix this by remove the destroy notification callback, as it isn't really
used except in the shutdown function.

=3D=3D5797=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0x6=
21000ac5904 at pc 0x55c1243b1f14 bp 0x7ffdef001340 sp 0x7ffdef001330
WRITE of size 4 at 0x621000ac5904 thread T0
    #0 0x55c1243b1f13 in read_watcher_destroy_notify ../git/gatchat/gatmux.=
c:660
    #1 0x7f08a8676742  (/usr/lib/libglib-2.0.so.0+0x62742)
    #2 0x7f08a867e2e4 in g_main_context_dispatch (/usr/lib/libglib-2.0.so.0=
+0x6a2e4)
    #3 0x7f08a8680210  (/usr/lib/libglib-2.0.so.0+0x6c210)
    #4 0x7f08a8681122 in g_main_loop_run (/usr/lib/libglib-2.0.so.0+0x6d122)
    #5 0x55c1243d6703 in main ../git/src/main.c:286
    #6 0x7f08a8423152 in __libc_start_main (/usr/lib/libc.so.6+0x27152)
    #7 0x55c1241fe1ad in _start (/home/martin/projects/ofono/x86/src/ofonod=
+0xfd1ad)

0x621000ac5904 is located 4 bytes inside of 4672-byte region [0x621000ac590=
0,0x621000ac6b40)
freed by thread T0 here:
    #0 0x7f08a88cc6b0 in __interceptor_free /build/gcc/src/gcc/libsanitizer=
/asan/asan_malloc_linux.cc:122
    #1 0x55c1243b1ebf in g_at_mux_unref ../git/gatchat/gatmux.c:652
    #2 0x55c1243b062c in received_data ../git/gatchat/gatmux.c:276
    #3 0x7f08a867e2ce in g_main_context_dispatch (/usr/lib/libglib-2.0.so.0=
+0x6a2ce)

previously allocated by thread T0 here:
    #0 0x7f08a88cccd8 in __interceptor_calloc /build/gcc/src/gcc/libsanitiz=
er/asan/asan_malloc_linux.cc:153
    #1 0x55c1243b1bf1 in g_at_mux_new ../git/gatchat/gatmux.c:613
    #2 0x55c1243b4b53 in g_at_mux_new_gsm0710_basic ../git/gatchat/gatmux.c=
:1172
    #3 0x55c124386abd in cmux_gatmux ../git/plugins/quectel.c:871
    #4 0x55c12438779f in cmux_cb ../git/plugins/quectel.c:1023
    #5 0x55c1243a368e in at_chat_finish_command ../git/gatchat/gatchat.c:459
    #6 0x55c1243a3bc8 in at_chat_handle_command_response ../git/gatchat/gat=
chat.c:521
    #7 0x55c1243a4408 in have_line ../git/gatchat/gatchat.c:600
    #8 0x55c1243a539e in new_bytes ../git/gatchat/gatchat.c:759
    #9 0x55c1243ae2f9 in received_data ../git/gatchat/gatio.c:122
    #10 0x7f08a867e2ce in g_main_context_dispatch (/usr/lib/libglib-2.0.so.=
0+0x6a2ce)

SUMMARY: AddressSanitizer: heap-use-after-free ../git/gatchat/gatmux.c:660 =
in read_watcher_destroy_notify
Shadow bytes around the buggy address:
  0x0c4280150ad0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c4280150ae0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c4280150af0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c4280150b00: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c4280150b10: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
=3D>0x0c4280150b20:[fd]fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c4280150b30: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c4280150b40: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c4280150b50: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c4280150b60: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c4280150b70: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
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
=3D=3D5797=3D=3DABORTING
---

Changes since v2:
 * new patch to add more details

 gatchat/gatmux.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/gatchat/gatmux.c b/gatchat/gatmux.c
index d50e5361..4d89f039 100644
--- a/gatchat/gatmux.c
+++ b/gatchat/gatmux.c
@@ -653,13 +653,6 @@ void g_at_mux_unref(GAtMux *mux)
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
@@ -673,8 +666,7 @@ gboolean g_at_mux_start(GAtMux *mux)
 =

 	mux->read_watch =3D g_io_add_watch_full(mux->channel, G_PRIORITY_DEFAULT,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-						received_data, mux,
-						read_watcher_destroy_notify);
+						received_data, mux, NULL);
 =

 	mux->shutdown =3D FALSE;
 =

@@ -691,8 +683,10 @@ gboolean g_at_mux_shutdown(GAtMux *mux)
 	if (mux->channel =3D=3D NULL)
 		return FALSE;
 =

-	if (mux->read_watch > 0)
+	if (mux->read_watch > 0) {
 		g_source_remove(mux->read_watch);
+		mux->read_watch =3D 0;
+	}
 =

 	if (mux->write_watch > 0)
 		g_source_remove(mux->write_watch);
-- =

2.23.0

--===============0724680286093518118==--

