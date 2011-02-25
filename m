Content-Type: multipart/mixed; boundary="===============6765062778448360496=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/4] cbs: rename EmergencyBroadcast property
Date: Fri, 25 Feb 2011 08:32:21 -0800
Message-ID: <1298651543-9752-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1298651543-9752-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6765062778448360496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cbs.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/cbs.c b/src/cbs.c
index 36cca48..8bbae21 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -97,8 +97,9 @@ static void cbs_dispatch_base_station_id(struct ofono_cbs=
 *cbs, const char *id)
 	__ofono_netreg_set_base_station_name(cbs->netreg, id);
 }
 =

-static void cbs_dispatch_emergency(struct ofono_cbs *cbs, const char *mess=
age,
-					gboolean alert, gboolean popup)
+static void cbs_dispatch_warningsystem(struct ofono_cbs *cbs,
+					const char *message, gboolean alert,
+					gboolean popup)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(cbs->atom);
@@ -108,7 +109,7 @@ static void cbs_dispatch_emergency(struct ofono_cbs *cb=
s, const char *message,
 	dbus_bool_t boolean;
 =

 	signal =3D dbus_message_new_signal(path, OFONO_CELL_BROADCAST_INTERFACE,
-						"EmergencyBroadcast");
+						"WarningSystemBroadcast");
 	if (signal =3D=3D NULL)
 		return;
 =

@@ -237,7 +238,7 @@ void ofono_cbs_notify(struct ofono_cbs *cbs, const unsi=
gned char *pdu,
 		if (c.message_code & (1 << 8))
 			popup =3D TRUE;
 =

-		cbs_dispatch_emergency(cbs, message, alert, popup);
+		cbs_dispatch_warningsystem(cbs, message, alert, popup);
 		goto out;
 	}
 =

@@ -532,7 +533,7 @@ static GDBusMethodTable cbs_methods[] =3D {
 static GDBusSignalTable cbs_signals[] =3D {
 	{ "PropertyChanged",	"sv"		},
 	{ "IncomingBroadcast",	"sq"		},
-	{ "EmergencyBroadcast", "sa{sv}"	},
+	{ "WarningSystemBroadcast", "sa{v}"	},
 	{ }
 };
 =

-- =

1.7.0.4


--===============6765062778448360496==--

