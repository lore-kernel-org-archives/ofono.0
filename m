Content-Type: multipart/mixed; boundary="===============3997205181704545880=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/4] cbs: remove EmergencyType property
Date: Fri, 25 Feb 2011 08:32:20 -0800
Message-ID: <1298651543-9752-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1298651543-9752-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3997205181704545880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cbs.c |   35 ++++++-----------------------------
 1 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/src/cbs.c b/src/cbs.c
index d99f250..36cca48 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -98,7 +98,6 @@ static void cbs_dispatch_base_station_id(struct ofono_cbs=
 *cbs, const char *id)
 }
 =

 static void cbs_dispatch_emergency(struct ofono_cbs *cbs, const char *mess=
age,
-					enum etws_topic_type topic,
 					gboolean alert, gboolean popup)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -107,29 +106,6 @@ static void cbs_dispatch_emergency(struct ofono_cbs *c=
bs, const char *message,
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	dbus_bool_t boolean;
-	const char *emergency_str;
-
-	if (topic =3D=3D ETWS_TOPIC_TYPE_TEST) {
-		ofono_error("Explicitly ignoring ETWS Test messages");
-		return;
-	}
-
-	switch (topic) {
-	case ETWS_TOPIC_TYPE_EARTHQUAKE:
-		emergency_str =3D "Earthquake";
-		break;
-	case ETWS_TOPIC_TYPE_TSUNAMI:
-		emergency_str =3D "Tsunami";
-		break;
-	case ETWS_TOPIC_TYPE_EARTHQUAKE_TSUNAMI:
-		emergency_str =3D "Earthquake+Tsunami";
-		break;
-	case ETWS_TOPIC_TYPE_EMERGENCY:
-		emergency_str =3D "Other";
-		break;
-	default:
-		return;
-	};
 =

 	signal =3D dbus_message_new_signal(path, OFONO_CELL_BROADCAST_INTERFACE,
 						"EmergencyBroadcast");
@@ -144,9 +120,6 @@ static void cbs_dispatch_emergency(struct ofono_cbs *cb=
s, const char *message,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 						&dict);
 =

-	ofono_dbus_dict_append(&dict, "EmergencyType",
-				DBUS_TYPE_STRING, &emergency_str);
-
 	boolean =3D alert;
 	ofono_dbus_dict_append(&dict, "EmergencyAlert",
 				DBUS_TYPE_BOOLEAN, &boolean);
@@ -251,6 +224,11 @@ void ofono_cbs_notify(struct ofono_cbs *cbs, const uns=
igned char *pdu,
 		gboolean alert =3D FALSE;
 		gboolean popup =3D FALSE;
 =

+		if (c.message_identifier =3D=3D ETWS_TOPIC_TYPE_TEST) {
+			ofono_error("Explicitly ignoring ETWS Test messages");
+			goto out;
+		}
+
 		/* 3GPP 23.041 9.4.1.2.1: Alert is encoded in bit 9 */
 		if (c.message_code & (1 << 9))
 			alert =3D TRUE;
@@ -259,8 +237,7 @@ void ofono_cbs_notify(struct ofono_cbs *cbs, const unsi=
gned char *pdu,
 		if (c.message_code & (1 << 8))
 			popup =3D TRUE;
 =

-		cbs_dispatch_emergency(cbs, message,
-					c.message_identifier, alert, popup);
+		cbs_dispatch_emergency(cbs, message, alert, popup);
 		goto out;
 	}
 =

-- =

1.7.0.4


--===============3997205181704545880==--

