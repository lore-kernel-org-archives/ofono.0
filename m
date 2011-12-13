Content-Type: multipart/mixed; boundary="===============7667458723393216554=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 1/3] network: Use netreg_emit_operator_display_name()
Date: Tue, 13 Dec 2011 13:36:22 +0200
Message-ID: <1323776184-27086-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1323776184-27086-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7667458723393216554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Redundant in place code removed, netreg_emit_operator_display_name()
is now used consistently everywhere in network.c
---
 src/network.c |   76 ++++++++++++++++-------------------------------------=
---
 1 files changed, 22 insertions(+), 54 deletions(-)

diff --git a/src/network.c b/src/network.c
index e190389..cc708a2 100644
--- a/src/network.c
+++ b/src/network.c
@@ -419,13 +419,22 @@ static char *get_operator_display_name(struct ofono_n=
etreg *netreg)
 	return name;
 }
 =

+static void netreg_emit_operator_display_name(struct ofono_netreg *netreg)
+{
+	const char *operator =3D get_operator_display_name(netreg);
+
+	ofono_dbus_signal_property_changed(ofono_dbus_get_connection(),
+					__ofono_atom_get_path(netreg->atom),
+					OFONO_NETWORK_REGISTRATION_INTERFACE,
+					"Name", DBUS_TYPE_STRING, &operator);
+}
+
 static void set_network_operator_name(struct network_operator_data *opd,
 					const char *name)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_netreg *netreg =3D opd->netreg;
 	const char *path;
-	const char *operator;
 =

 	if (name[0] =3D=3D '\0')
 		return;
@@ -443,16 +452,8 @@ static void set_network_operator_name(struct network_o=
perator_data *opd,
 	if (opd->eons_info && opd->eons_info->longname)
 		return;
 =

-	if (opd =3D=3D netreg->current_operator) {
-		const char *path =3D __ofono_atom_get_path(netreg->atom);
-
-		operator =3D get_operator_display_name(netreg);
-
-		ofono_dbus_signal_property_changed(conn, path,
-					OFONO_NETWORK_REGISTRATION_INTERFACE,
-					"Name", DBUS_TYPE_STRING,
-					&operator);
-	}
+	if (opd =3D=3D netreg->current_operator)
+		netreg_emit_operator_display_name(netreg);
 =

 	/* Don't emit when only operator name is reported */
 	if (opd->mcc[0] =3D=3D '\0' && opd->mnc[0] =3D=3D '\0')
@@ -498,16 +499,8 @@ static void set_network_operator_eons_info(struct netw=
ork_operator_data *opd,
 					OFONO_NETWORK_OPERATOR_INTERFACE,
 					"Name", DBUS_TYPE_STRING, &newname);
 =

-		if (opd =3D=3D netreg->current_operator) {
-			const char *npath =3D __ofono_atom_get_path(netreg->atom);
-			const char *operator =3D
-				get_operator_display_name(netreg);
-
-			ofono_dbus_signal_property_changed(conn, npath,
-					OFONO_NETWORK_REGISTRATION_INTERFACE,
-					"Name", DBUS_TYPE_STRING,
-					&operator);
-		}
+		if (opd =3D=3D netreg->current_operator)
+			netreg_emit_operator_display_name(netreg);
 	}
 =

 	if (old_eons_info && old_eons_info->info)
@@ -1209,7 +1202,6 @@ static void current_operator_callback(const struct of=
ono_error *error,
 	struct ofono_netreg *netreg =3D data;
 	const char *path =3D __ofono_atom_get_path(netreg->atom);
 	GSList *op =3D NULL;
-	const char *operator;
 =

 	DBG("%p, %p", netreg, netreg->current_operator);
 =

@@ -1279,12 +1271,7 @@ static void current_operator_callback(const struct o=
fono_error *error,
 	}
 =

 emit:
-	operator =3D get_operator_display_name(netreg);
-
-	ofono_dbus_signal_property_changed(conn, path,
-					OFONO_NETWORK_REGISTRATION_INTERFACE,
-					"Name", DBUS_TYPE_STRING,
-					&operator);
+	netreg_emit_operator_display_name(netreg);
 =

 	if (netreg->current_operator) {
 		if (netreg->current_operator->mcc[0] !=3D '\0') {
@@ -1628,42 +1615,23 @@ static void sim_spdi_read_cb(int ok, int length, in=
t record,
 				int record_length, void *user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct network_operator_data *current =3D netreg->current_operator;
 =

 	if (!ok)
 		return;
 =

 	netreg->spdi =3D sim_spdi_new(data, length);
 =

-	if (current =3D=3D NULL)
+	if (netreg->current_operator =3D=3D NULL)
 		return;
 =

-	if (netreg->status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
-		DBusConnection *conn =3D ofono_dbus_get_connection();
-		const char *path =3D __ofono_atom_get_path(netreg->atom);
-		const char *operator;
-
-		if (!sim_spdi_lookup(netreg->spdi,
-					current->mcc, current->mnc))
-			return;
-
-		operator =3D get_operator_display_name(netreg);
-
-		ofono_dbus_signal_property_changed(conn, path,
-					OFONO_NETWORK_REGISTRATION_INTERFACE,
-					"Name", DBUS_TYPE_STRING,
-					&operator);
-	}
-}
+	if (netreg->status !=3D NETWORK_REGISTRATION_STATUS_ROAMING)
+		return;
 =

-static void netreg_emit_operator_display_name(struct ofono_netreg *netreg)
-{
-	const char *operator =3D get_operator_display_name(netreg);
+	if (!sim_spdi_lookup(netreg->spdi, netreg->current_operator->mcc,
+				netreg->current_operator->mnc))
+		return;
 =

-	ofono_dbus_signal_property_changed(ofono_dbus_get_connection(),
-					__ofono_atom_get_path(netreg->atom),
-					OFONO_NETWORK_REGISTRATION_INTERFACE,
-					"Name", DBUS_TYPE_STRING, &operator);
+	netreg_emit_operator_display_name(netreg);
 }
 =

 static void sim_spn_display_condition_parse(struct ofono_netreg *netreg,
-- =

1.7.5.4


--===============7667458723393216554==--

