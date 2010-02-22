Content-Type: multipart/mixed; boundary="===============2588899548533719909=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] Use g_dbus_emit_signal in call-barring.c
Date: Mon, 22 Feb 2010 14:23:20 +0800
Message-ID: <1266819800-29454-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2588899548533719909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To make it consistent with call_barring_incoming_enabled_notify.
---
 src/call-barring.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 2a04b25..e72d522 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -1001,18 +1001,9 @@ static void call_barring_outgoing_enabled_notify(int=
 idx, void *userdata)
 	struct ofono_call_barring *cb =3D userdata;
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(cb->atom);
-	DBusMessage *signal;
 =

-	signal =3D dbus_message_new_signal(path, OFONO_CALL_BARRING_INTERFACE,
-						"OutgoingBarringInEffect");
-
-	if (!signal) {
-		ofono_error("Unable to allocate new %s.OutgoingBarringInEffect"
-				" signal", OFONO_CALL_BARRING_INTERFACE);
-		return;
-	}
-
-	g_dbus_send_message(conn, signal);
+	g_dbus_emit_signal(conn, path, OFONO_CALL_BARRING_INTERFACE,
+			"OutgoingBarringInEffect", DBUS_TYPE_INVALID);
 }
 =

 int ofono_call_barring_driver_register(const struct ofono_call_barring_dri=
ver *d)
-- =

1.6.6.1


--===============2588899548533719909==--

