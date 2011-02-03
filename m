Content-Type: multipart/mixed; boundary="===============0035181527386620171=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 1/2] netreg: Add CPHS CSP implementation
Date: Thu, 03 Feb 2011 15:28:07 +0200
Message-ID: <1296739688-26585-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0035181527386620171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |  121 ++++++++++++++++++++++++++++++++++++++++++++---------=
---
 1 files changed, 95 insertions(+), 26 deletions(-)

diff --git a/src/network.c b/src/network.c
index bf61472..ef0b37f 100644
--- a/src/network.c
+++ b/src/network.c
@@ -42,7 +42,8 @@
 =

 enum network_registration_mode {
 	NETWORK_REGISTRATION_MODE_AUTO =3D	0,
-	NETWORK_REGISTRATION_MODE_MANUAL =3D	1,
+	NETWORK_REGISTRATION_MODE_AUTO_ONLY =3D	1,
+	NETWORK_REGISTRATION_MODE_MANUAL =3D	2,
 };
 =

 #define SETTINGS_STORE "netreg"
@@ -98,6 +99,8 @@ static const char *registration_mode_to_string(int mode)
 	switch (mode) {
 	case NETWORK_REGISTRATION_MODE_AUTO:
 		return "auto";
+	case NETWORK_REGISTRATION_MODE_AUTO_ONLY:
+		return "auto-only";
 	case NETWORK_REGISTRATION_MODE_MANUAL:
 		return "manual";
 	}
@@ -143,6 +146,42 @@ static char **network_operator_technologies(struct net=
work_operator_data *opd)
 	return techs;
 }
 =

+static void registration_status_callback(const struct ofono_error *error,
+					int status, int lac, int ci, int tech,
+					void *data)
+{
+	struct ofono_netreg *netreg =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error during registration status query");
+		return;
+	}
+
+	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
+}
+
+static void init_register(const struct ofono_error *error, void *data)
+{
+	struct ofono_netreg *netreg =3D data;
+
+	if (netreg->driver->registration_status =3D=3D NULL)
+		return;
+
+	netreg->driver->registration_status(netreg,
+					registration_status_callback, netreg);
+}
+
+static void enforce_auto_only(struct ofono_netreg *netreg)
+{
+	if (netreg->mode !=3D NETWORK_REGISTRATION_MODE_MANUAL)
+		return;
+
+	if (netreg->driver->register_auto =3D=3D NULL)
+		return;
+
+	netreg->driver->register_auto(netreg, init_register, netreg);
+}
+
 static void set_registration_mode(struct ofono_netreg *netreg, int mode)
 {
 	DBusConnection *conn;
@@ -152,6 +191,9 @@ static void set_registration_mode(struct ofono_netreg *=
netreg, int mode)
 	if (netreg->mode =3D=3D mode)
 		return;
 =

+	if (mode =3D=3D NETWORK_REGISTRATION_MODE_AUTO_ONLY)
+		enforce_auto_only(netreg);
+
 	netreg->mode =3D mode;
 =

 	if (netreg->settings) {
@@ -170,20 +212,6 @@ static void set_registration_mode(struct ofono_netreg =
*netreg, int mode)
 					"Mode", DBUS_TYPE_STRING, &strmode);
 }
 =

-static void registration_status_callback(const struct ofono_error *error,
-					int status, int lac, int ci, int tech,
-					void *data)
-{
-	struct ofono_netreg *netreg =3D data;
-
-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("Error during registration status query");
-		return;
-	}
-
-	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
-}
-
 static void register_callback(const struct ofono_error *error, void *data)
 {
 	struct ofono_netreg *netreg =3D data;
@@ -211,15 +239,6 @@ out:
 					registration_status_callback, netreg);
 }
 =

-static void init_register(const struct ofono_error *error, void *data)
-{
-	struct ofono_netreg *netreg =3D data;
-
-	if (netreg->driver->registration_status)
-		netreg->driver->registration_status(netreg,
-					registration_status_callback, netreg);
-}
-
 static struct network_operator_data *
 	network_operator_create(const struct ofono_network_operator *op)
 {
@@ -586,6 +605,9 @@ static DBusMessage *network_operator_register(DBusConne=
ction *conn,
 	struct network_operator_data *opd =3D data;
 	struct ofono_netreg *netreg =3D opd->netreg;
 =

+	if (netreg->mode =3D=3D NETWORK_REGISTRATION_MODE_AUTO_ONLY)
+		return __ofono_error_access_denied(msg);
+
 	if (netreg->pending)
 		return __ofono_error_busy(msg);
 =

@@ -838,6 +860,9 @@ static DBusMessage *network_register(DBusConnection *co=
nn,
 =

 	netreg->driver->register_auto(netreg, register_callback, netreg);
 =

+	if (netreg->mode =3D=3D NETWORK_REGISTRATION_MODE_AUTO_ONLY)
+		return NULL;
+
 	set_registration_mode(netreg, NETWORK_REGISTRATION_MODE_AUTO);
 =

 	return NULL;
@@ -947,6 +972,9 @@ static DBusMessage *network_scan(DBusConnection *conn,
 {
 	struct ofono_netreg *netreg =3D data;
 =

+	if (netreg->mode =3D=3D NETWORK_REGISTRATION_MODE_AUTO_ONLY)
+		return __ofono_error_access_denied(msg);
+
 	if (netreg->pending)
 		return __ofono_error_busy(msg);
 =

@@ -1364,7 +1392,7 @@ static void init_registration_status(const struct ofo=
no_error *error,
 					signal_strength_callback, netreg);
 	}
 =

-	if (netreg->mode =3D=3D NETWORK_REGISTRATION_MODE_AUTO &&
+	if (netreg->mode !=3D NETWORK_REGISTRATION_MODE_MANUAL &&
 		(status =3D=3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED ||
 			status =3D=3D NETWORK_REGISTRATION_STATUS_DENIED ||
 			status =3D=3D NETWORK_REGISTRATION_STATUS_UNKNOWN)) {
@@ -1574,6 +1602,44 @@ static void sim_spn_read_cb(int ok, int length, int =
record,
 	}
 }
 =

+static void sim_csp_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	int i;
+
+	if (!ok)
+		return;
+
+	if (length < 18 || record_length < 18 || length < record_length)
+		return;
+
+	/*
+	 * According to CPHS 4.2, EFcsp is an array of two-byte service
+	 * entries, each consisting of a one byte service group
+	 * identifier followed by 8 bits; each bit is indicating
+	 * availability of a specific service or feature.
+	 *
+	 * The PLMN mode bit, if present, indicates whether manual
+	 * operator selection should be disabled or enabled. When
+	 * unset, the device is forced to automatic mode; when set,
+	 * manual selection is to be enabled. The latter is also the
+	 * default.
+	 */
+	for (i =3D 0; i < record_length / 2; i++) {
+
+		if (data[i * 2] !=3D SIM_CSP_ENTRY_VALUE_ADDED_SERVICES)
+			continue;
+
+		if ((data[i * 2 + 1] & 0x80) !=3D 0)
+			return;
+
+		set_registration_mode(netreg,
+					NETWORK_REGISTRATION_MODE_AUTO_ONLY);
+	}
+}
+
 int ofono_netreg_get_location(struct ofono_netreg *netreg)
 {
 	if (netreg =3D=3D NULL)
@@ -1769,7 +1835,7 @@ static void netreg_load_settings(struct ofono_netreg =
*netreg)
 	mode =3D g_key_file_get_integer(netreg->settings, SETTINGS_GROUP,
 					"Mode", NULL);
 =

-	if (mode >=3D 0 && mode <=3D 1)
+	if (mode !=3D NETWORK_REGISTRATION_MODE_AUTO_ONLY)
 		netreg->mode =3D mode;
 =

 	g_key_file_set_integer(netreg->settings, SETTINGS_GROUP,
@@ -1816,6 +1882,9 @@ void ofono_netreg_register(struct ofono_netreg *netre=
g)
 		ofono_sim_read(netreg->sim, SIM_EFSPN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_spn_read_cb, netreg);
+		ofono_sim_read(netreg->sim, SIM_EF_CPHS_CSP_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+				sim_csp_read_cb, netreg);
 	}
 =

 	__ofono_atom_register(netreg->atom, netreg_unregister);
-- =

1.7.1


--===============0035181527386620171==--

