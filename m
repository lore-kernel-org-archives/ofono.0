Content-Type: multipart/mixed; boundary="===============6798024628233108727=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Use g_dbus_emit_signal in call-{barring,meter}.c
Date: Mon, 15 Feb 2010 08:02:56 +0100
Message-ID: <1266217376-26692-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6798024628233108727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-barring.c |   13 ++-----------
 src/call-meter.c   |   12 ++----------
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index e4c39f3..2a04b25 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -991,18 +991,9 @@ static void call_barring_incoming_enabled_notify(int i=
dx, void *userdata)
 	struct ofono_call_barring *cb =3D userdata;
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(cb->atom);
-	DBusMessage *signal;
-
-	signal =3D dbus_message_new_signal(path, OFONO_CALL_BARRING_INTERFACE,
-						"IncomingBarringInEffect");
 =

-	if (!signal) {
-		ofono_error("Unable to allocate new %s.IncomingBarringInEffect"
-				" signal", OFONO_CALL_BARRING_INTERFACE);
-		return;
-	}
-
-	g_dbus_send_message(conn, signal);
+	g_dbus_emit_signal(conn, path, OFONO_CALL_BARRING_INTERFACE,
+			"IncomingBarringInEffect", DBUS_TYPE_INVALID);
 }
 =

 static void call_barring_outgoing_enabled_notify(int idx, void *userdata)
diff --git a/src/call-meter.c b/src/call-meter.c
index 0275778..2b1e6a5 100644
--- a/src/call-meter.c
+++ b/src/call-meter.c
@@ -652,18 +652,10 @@ void ofono_call_meter_changed_notify(struct ofono_cal=
l_meter *cm, int new_value)
 void ofono_call_meter_maximum_notify(struct ofono_call_meter *cm)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
-	DBusMessage *signal;
 	const char *path =3D __ofono_atom_get_path(cm->atom);
 =

-	signal =3D dbus_message_new_signal(path, OFONO_CALL_METER_INTERFACE,
-						"NearMaximumWarning");
-	if (!signal) {
-		ofono_error("Unable to allocate new %s.NearMaximumWarning "
-				"signal", OFONO_CALL_METER_INTERFACE);
-		return;
-	}
-
-	g_dbus_send_message(conn, signal);
+	g_dbus_emit_signal(conn, path, OFONO_CALL_METER_INTERFACE,
+			"NearMaximumWarning", DBUS_TYPE_INVALID);
 }
 =

 int ofono_call_meter_driver_register(const struct ofono_call_meter_driver =
*d)
-- =

1.6.1


--===============6798024628233108727==--

