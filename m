Content-Type: multipart/mixed; boundary="===============5226315398656590751=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 04/11] ConnectionManager: expose packet service technology
Date: Tue, 11 Jan 2011 16:08:32 +0200
Message-ID: <1294754919-9687-4-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1294754919-9687-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5226315398656590751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is more precise than the network access technology. On the other
hand, it is only available when attached to the packet service
(when the connection manager atom is powered).
---
 drivers/atmodem/gprs.c  |   18 +++++++++---------
 drivers/isimodem/gprs.c |    6 +++---
 include/gprs.h          |    4 ++--
 src/gprs.c              |   31 ++++++++++++++++++++++++++++---
 4 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 8cff35b..a38c6b4 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -89,23 +89,23 @@ static void at_cgreg_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	struct cb_data *cbd =3D user_data;
 	ofono_gprs_status_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
-	int status;
+	int status, tech;
 	struct gprs_data *gd =3D cbd->user;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
 =

 	if (!ok) {
-		cb(&error, -1, cbd->data);
+		cb(&error, -1, -1, cbd->data);
 		return;
 	}
 =

 	if (at_util_parse_reg(result, "+CGREG:", NULL, &status,
-				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE) {
-		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+				NULL, NULL, &tech, gd->vendor) =3D=3D FALSE) {
+		CALLBACK_WITH_FAILURE(cb, -1, -1, cbd->data);
 		return;
 	}
 =

-	cb(&error, status, cbd->data);
+	cb(&error, status, tech, cbd->data);
 }
 =

 static void at_gprs_registration_status(struct ofono_gprs *gprs,
@@ -138,20 +138,20 @@ static void at_gprs_registration_status(struct ofono_=
gprs *gprs,
 error:
 	g_free(cbd);
 =

-	CALLBACK_WITH_FAILURE(cb, -1, data);
+	CALLBACK_WITH_FAILURE(cb, -1, -1, data);
 }
 =

 static void cgreg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
-	int status;
+	int status, tech;
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 =

 	if (at_util_parse_reg_unsolicited(result, "+CGREG:", &status,
-				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE)
+				NULL, NULL, &tech, gd->vendor) =3D=3D FALSE)
 		return;
 =

-	ofono_gprs_status_notify(gprs, status);
+	ofono_gprs_status_notify(gprs, status, tech);
 }
 =

 static void cgev_notify(GAtResult *result, gpointer user_data)
diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index e614ac9..5f22618 100644
--- a/drivers/isimodem/gprs.c
+++ b/drivers/isimodem/gprs.c
@@ -456,11 +456,11 @@ static void status_resp_cb(const GIsiMessage *msg, vo=
id *opaque)
 =

 	suspend_notify(gprs, data[10], data[11]);
 =

-	CALLBACK_WITH_SUCCESS(cb, status, cbd->data);
+	CALLBACK_WITH_SUCCESS(cb, status, -1, cbd->data);
 	return;
 =

 error:
-	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, -1, -1, cbd->data);
 }
 =

 static void isi_gprs_attached_status(struct ofono_gprs *gprs,
@@ -482,7 +482,7 @@ static void isi_gprs_attached_status(struct ofono_gprs =
*gprs,
 		return;
 =

 error:
-	CALLBACK_WITH_FAILURE(cb, -1, data);
+	CALLBACK_WITH_FAILURE(cb, -1, -1, data);
 	g_free(cbd);
 }
 =

diff --git a/include/gprs.h b/include/gprs.h
index ad7925c..1c1d116 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -32,7 +32,7 @@ struct ofono_gprs;
 struct ofono_gprs_context;
 =

 typedef void (*ofono_gprs_status_cb_t)(const struct ofono_error *error,
-						int status, void *data);
+					int status, int tech, void *data);
 =

 typedef void (*ofono_gprs_cb_t)(const struct ofono_error *error, void *dat=
a);
 =

@@ -55,7 +55,7 @@ enum gprs_suspend_cause {
 	GPRS_SUSPENDED_UNKNOWN_CAUSE,
 };
 =

-void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status);
+void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status, int tec=
h);
 void ofono_gprs_detached_notify(struct ofono_gprs *gprs);
 void ofono_gprs_suspend_notify(struct ofono_gprs *gprs, int cause);
 void ofono_gprs_resume_notify(struct ofono_gprs *gprs);
diff --git a/src/gprs.c b/src/gprs.c
index 0e86bdf..7de8ec0 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -67,6 +67,7 @@ struct ofono_gprs {
 	ofono_bool_t suspended;
 	int status;
 	int flags;
+	int tech;
 	guint suspend_timeout;
 	struct idmap *pid_map;
 	unsigned int last_context_id;
@@ -1328,8 +1329,25 @@ static void gprs_attached_update(struct ofono_gprs *=
gprs)
 				"Attached", DBUS_TYPE_BOOLEAN, &value);
 }
 =

+static void gprs_tech_update(struct ofono_gprs *gprs, int tech)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path, *value;
+
+	if (tech =3D=3D gprs->tech)
+		return;
+
+	gprs->tech =3D tech;
+
+	path =3D __ofono_atom_get_path(gprs->atom);
+	value =3D data_tech_to_string(tech);
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CONNECTION_MANAGER_INTERFACE,
+				"Technology", DBUS_TYPE_STRING, &value);
+}
+
 static void registration_status_cb(const struct ofono_error *error,
-					int status, void *data)
+					int status, int tech, void *data)
 {
 	struct ofono_gprs *gprs =3D data;
 =

@@ -1337,7 +1355,7 @@ static void registration_status_cb(const struct ofono=
_error *error,
 		error->type, status);
 =

 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
-		ofono_gprs_status_notify(gprs, status);
+		ofono_gprs_status_notify(gprs, status, tech);
 =

 	if (gprs->flags & GPRS_FLAG_RECHECK) {
 		gprs->flags &=3D ~GPRS_FLAG_RECHECK;
@@ -1441,6 +1459,11 @@ static DBusMessage *gprs_get_properties(DBusConnecti=
on *conn,
 	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
 =

 	if (gprs->attached) {
+		const char *tech =3D data_tech_to_string(gprs->tech);
+
+		ofono_dbus_dict_append(&dict, "Technology",
+				DBUS_TYPE_STRING, &tech);
+
 		value =3D gprs->suspended;
 		ofono_dbus_dict_append(&dict, "Suspended",
 				DBUS_TYPE_BOOLEAN, &value);
@@ -1913,7 +1936,7 @@ void ofono_gprs_detached_notify(struct ofono_gprs *gp=
rs)
 	 */
 }
 =

-void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status)
+void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status, int tec=
h)
 {
 	DBG("%s status %d", __ofono_atom_get_path(gprs->atom), status);
 =

@@ -1935,6 +1958,7 @@ void ofono_gprs_status_notify(struct ofono_gprs *gprs=
, int status)
 =

 	gprs->driver_attached =3D TRUE;
 	gprs_attached_update(gprs);
+	gprs_tech_update(gprs, tech);
 =

 	return;
 =

@@ -2237,6 +2261,7 @@ struct ofono_gprs *ofono_gprs_create(struct ofono_mod=
em *modem,
 	}
 =

 	gprs->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
+	gprs->tech =3D -1;
 	gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
 	gprs->pid_map =3D idmap_new(MAX_CONTEXTS);
 =

-- =

1.7.1


--===============5226315398656590751==--

