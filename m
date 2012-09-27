Content-Type: multipart/mixed; boundary="===============2423891120834209021=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/3] gdbus: Fix crash when getting disconnected from the bus
Date: Thu, 27 Sep 2012 08:58:57 -0300
Message-ID: <1348747139-1881-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1348747139-1881-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2423891120834209021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Johan Hedberg <johan.hedberg@intel.com>

When getting disconnected from the bus sometimes (maybe always?)
dbus_watch_handle() can cause the "info" context to be free'd meaning
that we should not try to access it after the call. The only member we
need access to is the connection pointer and as the code already has a
ref() call for it it's only natural to solve the issue by adding a local
variable not dependent on "info".

The backtrace of the crash fixed looks as follows:

 Invalid read of size 8
   at 0x121085: watch_func (mainloop.c:105)
   by 0x4C72694: g_main_context_dispatch (gmain.c:2539)
   by 0x4C729C7: g_main_context_iterate.isra.23 (gmain.c:3146)
   by 0x4C72DC1: g_main_loop_run (gmain.c:3340)
   by 0x120541: main (main.c:551)
 Address 0x5bbcd90 is 16 bytes inside a block of size 24 free'd
   at 0x4A079AE: free (vg_replace_malloc.c:427)
   by 0x4C7837E: g_free (gmem.c:252)
   by 0x4F708BF: dbus_watch_set_data (dbus-watch.c:614)
   by 0x4F70938: _dbus_watch_unref (dbus-watch.c:132)
   by 0x4F6E9A7: _dbus_transport_handle_watch (dbus-transport.c:884)
   by 0x4F59AFB: _dbus_connection_handle_watch (dbus-connection.c:1497)
   by 0x4F70AF9: dbus_watch_handle (dbus-watch.c:683)
   by 0x121084: watch_func (mainloop.c:103)
   by 0x4C72694: g_main_context_dispatch (gmain.c:2539)
   by 0x4C729C7: g_main_context_iterate.isra.23 (gmain.c:3146)
   by 0x4C72DC1: g_main_loop_run (gmain.c:3340)
   by 0x120541: main (main.c:551)
---
 gdbus/mainloop.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
index cff326f..099b67f 100644
--- a/gdbus/mainloop.c
+++ b/gdbus/mainloop.c
@@ -92,8 +92,9 @@ static gboolean watch_func(GIOChannel *chan, GIOCondition=
 cond, gpointer data)
 	struct watch_info *info =3D data;
 	unsigned int flags =3D 0;
 	DBusDispatchStatus status;
+	DBusConnection *conn;
 =

-	dbus_connection_ref(info->conn);
+	conn =3D dbus_connection_ref(info->conn);
 =

 	if (cond & G_IO_IN)  flags |=3D DBUS_WATCH_READABLE;
 	if (cond & G_IO_OUT) flags |=3D DBUS_WATCH_WRITABLE;
@@ -102,10 +103,10 @@ static gboolean watch_func(GIOChannel *chan, GIOCondi=
tion cond, gpointer data)
 =

 	dbus_watch_handle(info->watch, flags);
 =

-	status =3D dbus_connection_get_dispatch_status(info->conn);
-	queue_dispatch(info->conn, status);
+	status =3D dbus_connection_get_dispatch_status(conn);
+	queue_dispatch(conn, status);
 =

-	dbus_connection_unref(info->conn);
+	dbus_connection_unref(conn);
 =

 	return TRUE;
 }
-- =

1.7.12.1


--===============2423891120834209021==--

