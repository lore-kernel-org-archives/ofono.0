Content-Type: multipart/mixed; boundary="===============6979187674785363640=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 4/6] Core support for packet switched bearer reporting
Date: Wed, 19 Jan 2011 11:19:23 +0200
Message-ID: <1295428765-8683-4-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1295428765-8683-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6979187674785363640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 0e86bdf..7ef81d5 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -67,6 +67,7 @@ struct ofono_gprs {
 	ofono_bool_t suspended;
 	int status;
 	int flags;
+	int bearer;
 	guint suspend_timeout;
 	struct idmap *pid_map;
 	unsigned int last_context_id;
@@ -1319,6 +1320,8 @@ static void gprs_attached_update(struct ofono_gprs *g=
prs)
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
 					"Active", DBUS_TYPE_BOOLEAN, &value);
 		}
+
+		gprs->bearer =3D -1;
 	}
 =

 	path =3D __ofono_atom_get_path(gprs->atom);
@@ -1433,6 +1436,13 @@ static DBusMessage *gprs_get_properties(DBusConnecti=
on *conn,
 	value =3D gprs->attached;
 	ofono_dbus_dict_append(&dict, "Attached", DBUS_TYPE_BOOLEAN, &value);
 =

+	if (gprs->bearer !=3D -1) {
+		const char *bearer =3D packet_bearer_to_string(gprs->bearer);
+
+		ofono_dbus_dict_append(&dict, "Bearer",
+					DBUS_TYPE_STRING, &bearer);
+	}
+
 	value =3D gprs->roaming_allowed;
 	ofono_dbus_dict_append(&dict, "RoamingAllowed",
 				DBUS_TYPE_BOOLEAN, &value);
@@ -1979,6 +1989,23 @@ void ofono_gprs_add_context(struct ofono_gprs *gprs,
 	__ofono_atom_register(gc->atom, gprs_context_unregister);
 }
 =

+void ofono_gprs_bearer_notify(struct ofono_gprs *gprs, int bearer)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	const char *value;
+
+	if (gprs->bearer =3D=3D bearer)
+		return;
+
+	gprs->bearer =3D bearer;
+	path =3D __ofono_atom_get_path(gprs->atom);
+	value =3D packet_bearer_to_string(bearer);
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Bearer", DBUS_TYPE_STRING, &value);
+}
+
 void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
 					unsigned int cid)
 {
-- =

1.7.1


--===============6979187674785363640==--

