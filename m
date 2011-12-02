Content-Type: multipart/mixed; boundary="===============4157222103563902596=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 2/9] network: Refactor sim_spn_read_cb()
Date: Fri, 02 Dec 2011 13:10:30 +0200
Message-ID: <1322824237-10039-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322824237-10039-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4157222103563902596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Refactor sim_spn_read_cb() for CPHS SPN, short-SPN inclusion
---
 src/network.c |   82 +++++++++++++++++++++++++++++++++--------------------=
---
 1 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/src/network.c b/src/network.c
index e6636bb..677b936 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1656,18 +1656,30 @@ static void sim_spdi_read_cb(int ok, int length, in=
t record,
 	}
 }
 =

-static void sim_spn_read_cb(int ok, int length, int record,
-				const unsigned char *data,
-				int record_length, void *user_data)
+static void ofono_netreg_operator_display_name_notify(
+						struct ofono_netreg *netreg)
 {
-	struct ofono_netreg *netreg =3D user_data;
-	unsigned char dcbyte;
-	char *spn;
+	const char *operator =3D get_operator_display_name(netreg);
 =

-	if (!ok)
-		return;
+	ofono_dbus_signal_property_changed(ofono_dbus_get_connection(),
+					__ofono_atom_get_path(netreg->atom),
+					OFONO_NETWORK_REGISTRATION_INTERFACE,
+					"Name", DBUS_TYPE_STRING, &operator);
+}
 =

-	dcbyte =3D data[0];
+static void sim_spn_display_condition_parse(struct ofono_netreg *netreg,
+						guint8 dcbyte)
+{
+	if (dcbyte & SIM_EFSPN_DC_HOME_PLMN_BIT)
+		netreg->flags |=3D NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN;
+
+	if (!(dcbyte & SIM_EFSPN_DC_ROAMING_SPN_BIT))
+		netreg->flags |=3D NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN;
+}
+
+static gboolean sim_spn_parse(const void *data, int length, char **dst)
+{
+	char *spn;
 =

 	/*
 	 * TS 31.102 says:
@@ -1685,40 +1697,42 @@ static void sim_spn_read_cb(int ok, int length, int=
 record,
 	 * itself which is not there either.  11.11 contains the same
 	 * paragraph as 51.101 and has an Annex B which we implement.
 	 */
-	spn =3D sim_string_to_utf8(data + 1, length - 1);
-	if (spn =3D=3D NULL) {
-		ofono_error("EFspn read successfully, but couldn't parse");
-		return;
+	spn =3D sim_string_to_utf8(data, length);
+	if (spn =3D=3D NULL || strlen(spn) =3D=3D 0) {
+		if (spn =3D=3D NULL)
+			ofono_error("EFspn read successfully, "
+					"but couldn't parse");
+		g_free(spn);
+		return FALSE;
 	}
 =

-	if (strlen(spn) =3D=3D 0) {
-		g_free(spn);
+	*dst =3D spn;
+	return TRUE;
+}
+
+static void sim_spn_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	unsigned char dcbyte;
+
+	if (!ok)
+		return;
+
+	dcbyte =3D data[0];
+
+	if (!sim_spn_parse(data + 1, length - 1, &netreg->spname))
 		return;
-	}
 =

-	netreg->spname =3D spn;
 	ofono_sim_read(netreg->sim_context, SIM_EFSPDI_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_spdi_read_cb, netreg);
 =

-	if (dcbyte & SIM_EFSPN_DC_HOME_PLMN_BIT)
-		netreg->flags |=3D NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN;
+	sim_spn_display_condition_parse(netreg, dcbyte);
 =

-	if (!(dcbyte & SIM_EFSPN_DC_ROAMING_SPN_BIT))
-		netreg->flags |=3D NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN;
-
-	if (netreg->current_operator) {
-		DBusConnection *conn =3D ofono_dbus_get_connection();
-		const char *path =3D __ofono_atom_get_path(netreg->atom);
-		const char *operator;
-
-		operator =3D get_operator_display_name(netreg);
-
-		ofono_dbus_signal_property_changed(conn, path,
-					OFONO_NETWORK_REGISTRATION_INTERFACE,
-					"Name", DBUS_TYPE_STRING,
-					&operator);
-	}
+	if (netreg->current_operator)
+		ofono_netreg_operator_display_name_notify(netreg);
 }
 =

 int ofono_netreg_get_location(struct ofono_netreg *netreg)
-- =

1.7.5.4


--===============4157222103563902596==--

