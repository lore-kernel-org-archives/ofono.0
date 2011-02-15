Content-Type: multipart/mixed; boundary="===============4884691589774052339=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/9] network: Watch for changes to relevant SIM files.
Date: Tue, 15 Feb 2011 08:58:55 +0100
Message-ID: <1297756739-2958-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1297756739-2958-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4884691589774052339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/src/network.c b/src/network.c
index 9d1d05f..c059906 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1784,6 +1784,59 @@ static void netreg_load_settings(struct ofono_netreg=
 *netreg)
 				"Mode", netreg->mode);
 }
 =

+static void sim_pnn_opl_changed(int id, void *userdata)
+{
+	struct ofono_netreg *netreg =3D userdata;
+	GSList *l;
+
+	/*
+	 * Free references to structures on the netreg->eons list and
+	 * update the operator info on D-bus.  If EFpnn/EFopl read succeeds,
+	 * operator info will be updated again, otherwise it won't be
+	 * updated again.
+	 */
+	for (l =3D netreg->operator_list; l; l =3D l->next)
+		set_network_operator_eons_info(l->data, NULL);
+
+	sim_eons_free(netreg->eons);
+	netreg->eons =3D NULL;
+
+	ofono_sim_read(netreg->sim_context, SIM_EFPNN_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED,
+			sim_pnn_read_cb, netreg);
+}
+
+static void sim_spn_spdi_changed(int id, void *userdata)
+{
+	struct ofono_netreg *netreg =3D userdata;
+
+	netreg->flags &=3D ~(NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN |
+			NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN);
+
+	g_free(netreg->spname);
+	netreg->spname =3D NULL;
+
+	sim_spdi_free(netreg->spdi);
+	netreg->spdi =3D NULL;
+
+	if (netreg->current_operator) {
+		DBusConnection *conn =3D ofono_dbus_get_connection();
+		const char *path =3D __ofono_atom_get_path(netreg->atom);
+		const char *operator;
+
+		operator =3D get_operator_display_name(netreg);
+
+		ofono_dbus_signal_property_changed(conn, path,
+					OFONO_NETWORK_REGISTRATION_INTERFACE,
+					"Name", DBUS_TYPE_STRING,
+					&operator);
+	}
+
+	ofono_sim_read(netreg->sim_context, SIM_EFSPN_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_spn_read_cb, netreg);
+}
+
 void ofono_netreg_register(struct ofono_netreg *netreg)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -1822,9 +1875,22 @@ void ofono_netreg_register(struct ofono_netreg *netr=
eg)
 		ofono_sim_read(netreg->sim_context, SIM_EFPNN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				sim_pnn_read_cb, netreg);
+		ofono_sim_add_file_watch(netreg->sim_context, SIM_EFPNN_FILEID,
+						sim_pnn_opl_changed, netreg,
+						NULL);
+		ofono_sim_add_file_watch(netreg->sim_context, SIM_EFOPL_FILEID,
+						sim_pnn_opl_changed, netreg,
+						NULL);
+
 		ofono_sim_read(netreg->sim_context, SIM_EFSPN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				sim_spn_read_cb, netreg);
+		ofono_sim_add_file_watch(netreg->sim_context, SIM_EFSPN_FILEID,
+						sim_spn_spdi_changed, netreg,
+						NULL);
+		ofono_sim_add_file_watch(netreg->sim_context, SIM_EFSPDI_FILEID,
+						sim_spn_spdi_changed, netreg,
+						NULL);
 	}
 =

 	__ofono_atom_register(netreg->atom, netreg_unregister);
-- =

1.7.1.86.g0e460.dirty


--===============4884691589774052339==--

