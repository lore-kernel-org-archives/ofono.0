Content-Type: multipart/mixed; boundary="===============4300654723395592944=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Present list of preferred languages on SimManager interface.
Date: Mon, 14 Sep 2009 18:37:49 +0200
Message-ID: <1252946269-5745-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4300654723395592944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It does not look like the list can be used directly for filtering CBs
because for that, the ME should choose one language, if there is one
that is supported by the UI (aka MMI).

Patch made on top of [PATCH] Do the PIN check in SIMManager.
---
 src/sim.c     |  128 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simutil.h |    2 +
 2 files changed, 130 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 3886485..3ebb9e8 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -80,10 +80,13 @@ struct ofono_sim {
 	gboolean ready;
 	gboolean pin_ready;
 	int pin_type;
+	char **language_prefs;
 	GQueue *simop_q;
 	gint simop_source;
 	unsigned char efmsisdn_length;
 	unsigned char efmsisdn_records;
+	unsigned char *efli;
+	unsigned char efli_length;
 	unsigned int next_ready_watch_id;
 	GSList *ready_watches;
 	const struct ofono_sim_driver *driver;
@@ -224,6 +227,11 @@ static DBusMessage *sim_get_properties(DBusConnection =
*conn,
 					(void *) &pin_name);
 	}
 =

+	if (sim->language_prefs)
+		ofono_dbus_dict_append_array(&dict, "PreferredLanguages",
+						DBUS_TYPE_STRING,
+						&sim->language_prefs);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -746,6 +754,120 @@ static void sim_pin_check(struct ofono_sim *sim)
 	sim->driver->query_passwd_state(sim, sim_pin_query_cb, sim);
 }
 =

+static void sim_efli_read_cb(int ok,
+				enum ofono_sim_file_structure structure,
+				int length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+
+	if (!ok || structure !=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT)
+		return;
+
+	if (length < 2)
+		return;
+
+	sim->efli =3D g_memdup(data, length);
+	sim->efli_length =3D length;
+}
+
+static int parse_language_list(char **out_list, const unsigned char *sim_l=
ist,
+				int length)
+{
+	unsigned char code[3];
+	int count, i;
+	long written;
+
+	count =3D 0;
+	length--;
+
+	for (i =3D 0; i < length; i +=3D 2) {
+		code[0] =3D sim_list[i + 0];
+		code[1] =3D sim_list[i + 1];
+		code[2] =3D 0;
+
+		if (code[0] =3D=3D 0xff || code[1] =3D=3D 0xff)
+			continue;
+
+		out_list[count] =3D convert_gsm_to_utf8(code, 2,
+							NULL, &written, 0);
+		if (out_list[count] && written =3D=3D 2)
+			count++;
+	}
+
+	return count;
+}
+
+static void sim_efpl_read_cb(int ok,
+				enum ofono_sim_file_structure structure,
+				int length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+	unsigned char *efli =3D sim->efli;
+	const unsigned char *efpl =3D data;
+	int efli_length =3D sim->efli_length;
+	int efpl_length =3D length;
+	int count;
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (!ok || structure !=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT)
+		efpl =3D NULL;
+
+	if (length < 2)
+		efpl =3D NULL;
+
+	sim->language_prefs =3D g_malloc(((efli_length + efpl_length) / 2 + 1) *
+			sizeof(char *));
+
+	count =3D 0;
+
+	/* Make a list of languages in both files in order of preferences
+	 * following 31.102.
+	 */
+
+	if (efli && efpl && efli[0] =3D=3D 0xff && efli[1] =3D=3D 0xff) {
+		count +=3D parse_language_list(sim->language_prefs + count,
+						efpl, efpl_length);
+		efpl =3D NULL;
+	}
+
+	if (efli) {
+		count +=3D parse_language_list(sim->language_prefs + count,
+						efli, efli_length);
+		g_free(efli);
+		sim->efli =3D NULL;
+	}
+
+	if (efpl)
+		count +=3D parse_language_list(sim->language_prefs + count,
+						efpl, efpl_length);
+
+	sim->language_prefs[count] =3D NULL;
+
+	ofono_dbus_signal_array_property_changed(conn, path,
+							SIM_MANAGER_INTERFACE,
+							"PreferredLanguages",
+							DBUS_TYPE_STRING,
+							&sim->language_prefs);
+}
+
+static void sim_retrieve_efli(struct ofono_sim *sim)
+{
+	/* According to 31.102 the EFli is read first and EFpl is then
+	 * only read if none of the EFli languages are supported by user
+	 * interface.  51.011 mandates the exact opposite, making EFpl/EFelp
+	 * preferred over EFlp (same ID as EFli, different format).
+	 * However we don't depend on the user interface and so
+	 * need to read both files now.
+	 */
+	ofono_sim_read(sim, SIM_EFLI_FILEID, sim_efli_read_cb, sim);
+	ofono_sim_read(sim, SIM_EFPL_FILEID, sim_efpl_read_cb, sim);
+}
+
 static void sim_op_error(struct ofono_sim *sim)
 {
 	struct sim_file_op *op =3D g_queue_pop_head(sim->simop_q);
@@ -1357,6 +1479,11 @@ static void sim_remove(struct ofono_atom *atom)
 		sim->service_numbers =3D NULL;
 	}
 =

+	if (sim->language_prefs) {
+		g_strfreev(sim->language_prefs);
+		sim->language_prefs =3D NULL;
+	}
+
 	if (sim->simop_source) {
 		g_source_remove(sim->simop_source);
 		sim->simop_source =3D 0;
@@ -1446,6 +1573,7 @@ void ofono_sim_register(struct ofono_sim *sim)
 	 * arbitrary files to be written or read, assuming their presence
 	 * in the EFust
 	 */
+	sim_retrieve_efli(sim);
 	sim_pin_check(sim);
 }
 =

diff --git a/src/simutil.h b/src/simutil.h
index fc4f063..d1517ed 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -20,6 +20,8 @@
  */
 =

 enum sim_fileid {
+	SIM_EFPL_FILEID =3D 0x2f05,
+	SIM_EFLI_FILEID =3D 0x6f05,
 	SIM_EFMSISDN_FILEID =3D 0x6f40,
 	SIM_EFSPN_FILEID =3D 0x6f46,
 	SIM_EFSDN_FILEID =3D 0x6f49,
-- =

1.6.1


--===============4300654723395592944==--

