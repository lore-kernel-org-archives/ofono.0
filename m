Content-Type: multipart/mixed; boundary="===============5797294161841449625=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 2/4] gprs: add Suspended property
Date: Fri, 10 Sep 2010 16:50:57 +0300
Message-ID: <1284126659-18741-3-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1284126659-18741-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5797294161841449625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/connman-api.txt |   19 +++++++++++++
 include/gprs.h      |   10 +++++++
 src/gprs.c          |   72 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 43d8897..00d5ed7 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -77,6 +77,25 @@ Properties	boolean Attached [readonly]
 			be available, e.g. receiving SMS over packet radio
 			or network initiated PDP activation.
 =

+		boolean Suspended [readonly, optional]
+
+			Contains whether the GPRS service is suspended.
+			During suspended state the modem is attached to the
+			GPRS service and all contexts remain established,
+			however, data transfer is not possible.
+
+			The suspended state may be entered if the modem is
+			temporarily out of network coverage. GPRS class B
+			modems will suspend GPRS whenever a voice call is
+			active at the same time. GPRS may also be suspended
+			if the network does not support simultaneous packet
+			data and voice. Various signalling procedures may
+			also cause GPRS to be briefly suspended.
+
+			As the suspension may be brief, clients should wait
+			for an appropriate time for GPRS service to resume
+			before taking corrective action.
+
 		boolean RoamingAllowed [readwrite]
 =

 			Contains whether data roaming is allowed.  In the off
diff --git a/include/gprs.h b/include/gprs.h
index a1cbcd9..ad7925c 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -47,8 +47,18 @@ struct ofono_gprs_driver {
 					ofono_gprs_status_cb_t cb, void *data);
 };
 =

+enum gprs_suspend_cause {
+	GPRS_SUSPENDED_DETACHED,
+	GPRS_SUSPENDED_SIGNALLING,
+	GPRS_SUSPENDED_CALL,
+	GPRS_SUSPENDED_NO_COVERAGE,
+	GPRS_SUSPENDED_UNKNOWN_CAUSE,
+};
+
 void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status);
 void ofono_gprs_detached_notify(struct ofono_gprs *gprs);
+void ofono_gprs_suspend_notify(struct ofono_gprs *gprs, int cause);
+void ofono_gprs_resume_notify(struct ofono_gprs *gprs);
 =

 int ofono_gprs_driver_register(const struct ofono_gprs_driver *d);
 void ofono_gprs_driver_unregister(const struct ofono_gprs_driver *d);
diff --git a/src/gprs.c b/src/gprs.c
index d57115b..d85e70b 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -47,6 +47,7 @@
 #define SETTINGS_GROUP "Settings"
 #define MAX_CONTEXT_NAME_LENGTH 127
 #define MAX_CONTEXTS 256
+#define SUSPEND_TIMEOUT 8
 =

 static GSList *g_drivers =3D NULL;
 static GSList *g_context_drivers =3D NULL;
@@ -64,8 +65,10 @@ struct ofono_gprs {
 	ofono_bool_t driver_attached;
 	ofono_bool_t roaming_allowed;
 	ofono_bool_t powered;
+	ofono_bool_t suspended;
 	int status;
 	int flags;
+	guint suspend_timeout;
 	struct idmap *pid_map;
 	unsigned int last_context_id;
 	struct idmap *cid_map;
@@ -894,6 +897,66 @@ static gboolean context_dbus_unregister(struct pri_con=
text *ctx)
 					OFONO_CONNECTION_CONTEXT_INTERFACE);
 }
 =

+static void update_suspended_property(struct ofono_gprs *gprs,
+				ofono_bool_t suspended)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(gprs->atom);
+	dbus_bool_t value =3D suspended;
+
+	if (gprs->suspend_timeout) {
+		g_source_remove(gprs->suspend_timeout);
+		gprs->suspend_timeout =3D 0;
+	}
+
+	if (gprs->suspended =3D=3D suspended)
+		return;
+
+	DBG("%s GPRS service %s", __ofono_atom_get_path(gprs->atom),
+		suspended ? "suspended" : "resumed");
+
+	gprs->suspended =3D suspended;
+
+	if (gprs->attached)
+		ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CONNECTION_MANAGER_INTERFACE,
+					"Suspended", DBUS_TYPE_BOOLEAN, &value);
+}
+
+static gboolean suspend_timeout(gpointer data)
+{
+       struct ofono_gprs *gprs =3D data;
+
+       gprs->suspend_timeout =3D 0;
+       update_suspended_property(gprs, TRUE);
+       return FALSE;
+}
+
+void ofono_gprs_suspend_notify(struct ofono_gprs *gprs, int cause)
+{
+	switch (cause) {
+	case GPRS_SUSPENDED_DETACHED:
+	case GPRS_SUSPENDED_CALL:
+	case GPRS_SUSPENDED_NO_COVERAGE:
+		update_suspended_property(gprs, TRUE);
+		break;
+
+	case GPRS_SUSPENDED_SIGNALLING:
+	case GPRS_SUSPENDED_UNKNOWN_CAUSE:
+		if (gprs->suspend_timeout)
+			g_source_remove(gprs->suspend_timeout);
+		gprs->suspend_timeout =3D g_timeout_add_seconds(SUSPEND_TIMEOUT,
+							suspend_timeout,
+							gprs);
+		break;
+	}
+}
+
+void ofono_gprs_resume_notify(struct ofono_gprs *gprs)
+{
+	update_suspended_property(gprs, FALSE);
+}
+
 static void gprs_attached_update(struct ofono_gprs *gprs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -1052,6 +1115,12 @@ static DBusMessage *gprs_get_properties(DBusConnecti=
on *conn,
 	value =3D gprs->powered;
 	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
 =

+	if (gprs->attached) {
+		value =3D gprs->suspended;
+		ofono_dbus_dict_append(&dict, "Suspended",
+				DBUS_TYPE_BOOLEAN, &value);
+	}
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -1697,6 +1766,9 @@ static void gprs_remove(struct ofono_atom *atom)
 	if (gprs =3D=3D NULL)
 		return;
 =

+	if (gprs->suspend_timeout)
+		g_source_remove(gprs->suspend_timeout);
+
 	if (gprs->pid_map) {
 		idmap_free(gprs->pid_map);
 		gprs->pid_map =3D NULL;
-- =

1.7.0.4


--===============5797294161841449625==--

