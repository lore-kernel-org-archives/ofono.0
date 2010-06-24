Content-Type: multipart/mixed; boundary="===============7644482863673036993=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v2 1/3] Add CurrentTechnology property to DCM
Date: Thu, 24 Jun 2010 15:55:05 +0200
Message-ID: <1277387707-18928-2-git-send-email-wagi@monom.org>
In-Reply-To: <1277387707-18928-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7644482863673036993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 doc/dataconnectionmanager-api.txt |    7 ++++++
 include/gprs.h                    |    1 +
 src/gprs.c                        |   40 +++++++++++++++++++++++++++++++++=
++++
 3 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/doc/dataconnectionmanager-api.txt b/doc/dataconnectionmanager-=
api.txt
index 510bd42..cb6b699 100644
--- a/doc/dataconnectionmanager-api.txt
+++ b/doc/dataconnectionmanager-api.txt
@@ -75,6 +75,13 @@ Properties	array{object} PrimaryContexts [readonly]
 			this value to off detaches the modem from the
 			Packet Domain network.
 =

+		string CurrentTechnology [readonly, optional]
+
+			Contains the current technology used.
+
+			The possible values are: "gsm", "edge", "umts", "hspa",
+							"lte"
+
 Primary Data Context hierarchy
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

diff --git a/include/gprs.h b/include/gprs.h
index a1cbcd9..44ccb09 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -48,6 +48,7 @@ struct ofono_gprs_driver {
 };
 =

 void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status);
+void ofono_gprs_technology_notify(struct ofono_gprs *gprs, int technology);
 void ofono_gprs_detached_notify(struct ofono_gprs *gprs);
 =

 int ofono_gprs_driver_register(const struct ofono_gprs_driver *d);
diff --git a/src/gprs.c b/src/gprs.c
index 11876e2..5feac38 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -66,6 +66,7 @@ struct ofono_gprs {
 	ofono_bool_t powered;
 	int status;
 	int flags;
+	int technology;
 	struct idmap *pid_map;
 	unsigned int last_context_id;
 	struct idmap *cid_map;
@@ -879,6 +880,8 @@ static void gprs_attached_update(struct ofono_gprs *gpr=
s)
 						"Active", DBUS_TYPE_BOOLEAN,
 						&value);
 		}
+
+		gprs->technology =3D -1;
 	}
 =

 	path =3D __ofono_atom_get_path(gprs->atom);
@@ -1007,6 +1010,14 @@ static DBusMessage *gprs_get_properties(DBusConnecti=
on *conn,
 	value =3D gprs->powered;
 	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
 =

+	if (gprs->technology !=3D -1) {
+		const char *technology =3D
+			registration_tech_to_string(gprs->technology);
+
+		ofono_dbus_dict_append(&dict, "CurrentTechnology",
+				DBUS_TYPE_STRING, &technology);
+	}
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -1302,6 +1313,24 @@ static GDBusSignalTable manager_signals[] =3D {
 	{ }
 };
 =

+static void set_gprs_technology(struct ofono_gprs *gprs, int technology)
+{
+	const char *str_technology =3D
+		registration_tech_to_string(technology);
+	const char *path =3D __ofono_atom_get_path(gprs->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	gprs->technology =3D technology;
+
+	if (gprs->technology =3D=3D -1)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_DATA_CONNECTION_MANAGER_INTERFACE,
+					"CurrentTechnology", DBUS_TYPE_STRING,
+					&str_technology);
+}
+
 void ofono_gprs_detached_notify(struct ofono_gprs *gprs)
 {
 	if (gprs->driver_attached =3D=3D FALSE)
@@ -1326,6 +1355,16 @@ void ofono_gprs_status_notify(struct ofono_gprs *gpr=
s, int status)
 	gprs_attached_update(gprs);
 }
 =

+void ofono_gprs_technology_notify(struct ofono_gprs *gprs, int technology)
+{
+	/* If we are not attached, ignore */
+	if (gprs->attached =3D=3D FALSE)
+		return;
+
+	if (gprs->technology !=3D technology)
+		set_gprs_technology(gprs, technology);
+}
+
 void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
 				unsigned int min, unsigned int max)
 {
@@ -1602,6 +1641,7 @@ struct ofono_gprs *ofono_gprs_create(struct ofono_mod=
em *modem,
 	gprs->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
 	gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
 	gprs->pid_map =3D idmap_new(MAX_CONTEXTS);
+	gprs->technology =3D -1;
 =

 	return gprs;
 }
-- =

1.6.6.1


--===============7644482863673036993==--

