Content-Type: multipart/mixed; boundary="===============7428741517830849107=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 2/5] netreg: Add CPHS CSP PLMN mode implementation
Date: Tue, 18 Jan 2011 15:19:04 +0200
Message-ID: <1295356747-29758-3-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1295356747-29758-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7428741517830849107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 84 insertions(+), 1 deletions(-)

diff --git a/src/network.c b/src/network.c
index ae0f334..927f7ce 100644
--- a/src/network.c
+++ b/src/network.c
@@ -66,6 +66,7 @@ struct ofono_netreg {
 	int cellid;
 	int technology;
 	int mode;
+	gboolean forced_auto;
 	char *base_station;
 	struct network_operator_data *current_operator;
 	GSList *operator_list;
@@ -174,6 +175,36 @@ static void set_registration_mode(struct ofono_netreg =
*netreg, int mode)
 					"Mode", DBUS_TYPE_STRING, &strmode);
 }
 =

+static void set_registration_forced_auto(struct ofono_netreg *netreg, gboo=
lean value)
+{
+	DBusConnection *conn;
+	const char *strmode;
+	const char *path;
+
+	if (netreg->forced_auto =3D=3D value)
+		return;
+
+	netreg->forced_auto =3D value;
+
+	if (netreg->settings) {
+		g_key_file_set_boolean(netreg->settings, SETTINGS_GROUP,
+					"ForcedAuto", netreg->forced_auto);
+		storage_sync(netreg->imsi, SETTINGS_STORE, netreg->settings);
+	}
+
+	if (value)
+		strmode =3D "forced-auto";
+	else
+		strmode =3D registration_mode_to_string(netreg->mode);
+
+	conn =3D ofono_dbus_get_connection();
+	path =3D __ofono_atom_get_path(netreg->atom);
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_NETWORK_REGISTRATION_INTERFACE,
+					"Mode", DBUS_TYPE_STRING, &strmode);
+}
+
 static void registration_status_callback(const struct ofono_error *error,
 					int status, int lac, int ci, int tech,
 					void *data)
@@ -588,6 +619,9 @@ static DBusMessage *network_operator_register(DBusConne=
ction *conn,
 	struct network_operator_data *opd =3D data;
 	struct ofono_netreg *netreg =3D opd->netreg;
 =

+	if (netreg->forced_auto)
+		return __ofono_error_access_denied(msg);
+
 	if (netreg->pending)
 		return __ofono_error_busy(msg);
 =

@@ -757,7 +791,12 @@ static DBusMessage *network_get_properties(DBusConnect=
ion *conn,
 =

 	const char *status =3D registration_status_to_string(netreg->status);
 	const char *operator;
-	const char *mode =3D registration_mode_to_string(netreg->mode);
+	const char *mode;
+
+	if (netreg->forced_auto)
+		mode =3D "forced-auto";
+	else
+		mode =3D registration_mode_to_string(netreg->mode);
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
@@ -1598,6 +1637,43 @@ static void sim_spn_read_cb(int ok, int length, int =
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
+	 * Acording to CPHS 4.2, EFcsp is an array of two-byte service
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
+		gboolean forced_auto;
+
+		if (data[i * 2] !=3D SIM_CSP_ENTRY_VALUE_ADDED_SERVICES)
+			continue;
+
+		forced_auto =3D (data[i * 2 + 1] & 0x80) =3D=3D 0;
+
+		set_registration_forced_auto(netreg, forced_auto);
+	}
+}
+
 int ofono_netreg_get_location(struct ofono_netreg *netreg)
 {
 	if (netreg =3D=3D NULL)
@@ -1803,6 +1879,10 @@ static void netreg_load_settings(struct ofono_netreg=
 *netreg)
 =

 	g_key_file_set_integer(netreg->settings, SETTINGS_GROUP,
 				"Mode", netreg->mode);
+
+	netreg->forced_auto =3D g_key_file_get_boolean(netreg->settings,
+							SETTINGS_GROUP,
+							"ForcedAuto", NULL);
 }
 =

 void ofono_netreg_register(struct ofono_netreg *netreg)
@@ -1845,6 +1925,9 @@ void ofono_netreg_register(struct ofono_netreg *netre=
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


--===============7428741517830849107==--

