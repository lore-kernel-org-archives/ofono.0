Content-Type: multipart/mixed; boundary="===============9023740369623313375=="
MIME-Version: 1.0
From: Pau Espin Pedrol <pespin@sysmocom.de>
Subject: [PATCH] gobi/qmi: Fix invalid memory access
Date: Thu, 11 May 2017 18:50:06 +0200
Message-ID: <20170511165006.24333-1-pespin@sysmocom.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9023740369623313375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes following issue announced by valgrind:

ofonod[2870]: plugins/gobi.c:shutdown_cb()
ofonod[2870]: src/modem.c:modem_change_state() old state: 0, new state: 0
=3D=3D2870=3D=3D Invalid read of size 8
=3D=3D2870=3D=3D    at 0x453ADE: shutdown_destroy (qmi.c:1254)
=3D=3D2870=3D=3D    by 0x508A717: ??? (in /lib/x86_64-linux-gnu/libglib-2.0=
.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x508DB8B: g_main_context_dispatch (in /lib/x86_64-l=
inux-gnu/libglib-2.0.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x508DF47: ??? (in /lib/x86_64-linux-gnu/libglib-2.0=
.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x508E271: g_main_loop_run (in /lib/x86_64-linux-gnu=
/libglib-2.0.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x4C680B: main (main.c:256)
=3D=3D2870=3D=3D  Address 0x6a07518 is 152 bytes inside a block of size 168=
 free'd
=3D=3D2870=3D=3D    at 0x4C29E90: free (vg_replace_malloc.c:473)
=3D=3D2870=3D=3D    by 0x4532FF: qmi_device_unref (qmi.c:1003)
=3D=3D2870=3D=3D    by 0x45E09B: shutdown_cb (gobi.c:120)
=3D=3D2870=3D=3D    by 0x453B68: shutdown_callback (qmi.c:1268)
=3D=3D2870=3D=3D    by 0x508E612: ??? (in /lib/x86_64-linux-gnu/libglib-2.0=
.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x508DB6C: g_main_context_dispatch (in /lib/x86_64-l=
inux-gnu/libglib-2.0.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x508DF47: ??? (in /lib/x86_64-linux-gnu/libglib-2.0=
.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x508E271: g_main_loop_run (in /lib/x86_64-linux-gnu=
/libglib-2.0.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x4C680B: main (main.c:256)
=3D=3D2870=3D=3D
=3D=3D2870=3D=3D Invalid write of size 4
=3D=3D2870=3D=3D    at 0x453B09: shutdown_destroy (qmi.c:1257)
=3D=3D2870=3D=3D    by 0x508A717: ??? (in /lib/x86_64-linux-gnu/libglib-2.0=
.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x508DB8B: g_main_context_dispatch (in /lib/x86_64-l=
inux-gnu/libglib-2.0.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x508DF47: ??? (in /lib/x86_64-linux-gnu/libglib-2.0=
.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x508E271: g_main_loop_run (in /lib/x86_64-linux-gnu=
/libglib-2.0.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x4C680B: main (main.c:256)
=3D=3D2870=3D=3D  Address 0x6a07520 is 160 bytes inside a block of size 168=
 free'd
=3D=3D2870=3D=3D    at 0x4C29E90: free (vg_replace_malloc.c:473)
=3D=3D2870=3D=3D    by 0x4532FF: qmi_device_unref (qmi.c:1003)
=3D=3D2870=3D=3D    by 0x45E09B: shutdown_cb (gobi.c:120)
=3D=3D2870=3D=3D    by 0x453B68: shutdown_callback (qmi.c:1268)
=3D=3D2870=3D=3D    by 0x508E612: ??? (in /lib/x86_64-linux-gnu/libglib-2.0=
.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x508DB6C: g_main_context_dispatch (in /lib/x86_64-l=
inux-gnu/libglib-2.0.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x508DF47: ??? (in /lib/x86_64-linux-gnu/libglib-2.0=
.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x508E271: g_main_loop_run (in /lib/x86_64-linux-gnu=
/libglib-2.0.so.0.4200.1)
=3D=3D2870=3D=3D    by 0x4C680B: main (main.c:256)
=3D=3D2870=3D=3D
---
 drivers/qmimodem/qmi.c | 3 ++-
 plugins/gobi.c         | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 80c6adef..07daee9b 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1251,10 +1251,11 @@ static void shutdown_destroy(gpointer user_data)
 {
 	struct qmi_device *device =3D user_data;
 =

+	device->shutdown_source =3D 0;
+
 	if (device->shutdown_destroy)
 		device->shutdown_destroy(device->shutdown_user_data);
 =

-	device->shutdown_source =3D 0;
 }
 =

 static gboolean shutdown_callback(gpointer user_data)
diff --git a/plugins/gobi.c b/plugins/gobi.c
index a4985990..44c9c3ec 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -132,7 +132,7 @@ static void shutdown_device(struct ofono_modem *modem)
 	qmi_service_unref(data->dms);
 	data->dms =3D NULL;
 =

-	qmi_device_shutdown(data->device, shutdown_cb, modem, NULL);
+	qmi_device_shutdown(data->device, NULL, modem, shutdown_cb);
 }
 =

 static void power_reset_cb(struct qmi_result *result, void *user_data)
-- =

2.12.2


--===============9023740369623313375==--

