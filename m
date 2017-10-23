Content-Type: multipart/mixed; boundary="===============4949484209224580887=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] gatmux: Remove write watch source at shutdown
Date: Tue, 24 Oct 2017 00:05:36 +0300
Message-ID: <1508792736-29720-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4949484209224580887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise write_watcher_destroy_notify can be invoked after
GAtMux has been deallocated which results in write after free:

=3D=3D3952=3D=3D Invalid write of size 4
=3D=3D3952=3D=3D    at 0xABF54: write_watcher_destroy_notify (gatmux.c:285)
=3D=3D3952=3D=3D    by 0x4AF21E7: g_source_callback_unref (gmain.c:1561)
=3D=3D3952=3D=3D    by 0x4AF2E53: g_source_destroy_internal.constprop.8 (gm=
ain.c:1207)
=3D=3D3952=3D=3D    by 0x4AF61CF: g_main_dispatch (gmain.c:3177)
=3D=3D3952=3D=3D    by 0x4AF61CF: g_main_context_dispatch (gmain.c:3769)
=3D=3D3952=3D=3D    by 0x4AF658F: g_main_loop_run (gmain.c:4034)
=3D=3D3952=3D=3D    by 0xBDDBB: main (main.c:261)
=3D=3D3952=3D=3D  Address 0x50c6cb0 is 8 bytes inside a block of size 4,396=
 free'd
=3D=3D3952=3D=3D    at 0x4840B28: free (vg_replace_malloc.c:530)
=3D=3D3952=3D=3D    by 0xACB53: g_at_mux_unref (gatmux.c:642)
=3D=3D3952=3D=3D  Block was alloc'd at
=3D=3D3952=3D=3D    at 0x4841BF0: calloc (vg_replace_malloc.c:711)
=3D=3D3952=3D=3D    by 0xAC9DF: g_at_mux_new (gatmux.c:603)
=3D=3D3952=3D=3D    by 0xADF2F: g_at_mux_new_gsm0710_basic (gatmux.c:1160)
---
 gatchat/gatmux.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gatchat/gatmux.c b/gatchat/gatmux.c
index 909eca6..d492edb 100644
--- a/gatchat/gatmux.c
+++ b/gatchat/gatmux.c
@@ -684,6 +684,9 @@ gboolean g_at_mux_shutdown(GAtMux *mux)
 	if (mux->read_watch > 0)
 		g_source_remove(mux->read_watch);
 =

+	if (mux->write_watch > 0)
+		g_source_remove(mux->write_watch);
+
 	for (i =3D 0; i < MAX_CHANNELS; i++) {
 		if (mux->dlcs[i] =3D=3D NULL)
 			continue;
-- =

1.9.1


--===============4949484209224580887==--

