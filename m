Content-Type: multipart/mixed; boundary="===============6620149163437894987=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/3] message-waiting: Watch for changes to relevant SIM files.
Date: Sat, 19 Feb 2011 04:54:28 +0100
Message-ID: <1298087669-11558-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1298087669-11558-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6620149163437894987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/message-waiting.c |   92 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 91 insertions(+), 1 deletions(-)

diff --git a/src/message-waiting.c b/src/message-waiting.c
index 72cf582..ad534d9 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -49,8 +49,10 @@ struct ofono_message_waiting {
 	unsigned char efmwis_length;
 	unsigned char efmbdn_length;
 	unsigned char efmbdn_record_id[5];
+	unsigned int efmbdn_watch;
 	unsigned char ef_cphs_mwis_length;
 	unsigned char ef_cphs_mbdn_length;
+	unsigned int ef_cphs_mbdn_watch;
 	gboolean mbdn_not_provided;
 	gboolean cphs_mbdn_not_provided;
 	struct ofono_phone_number mailbox_number[5];
@@ -576,6 +578,33 @@ static void mw_mbdn_read_cb(int ok, int total_length, =
int record,
 	mw->efmbdn_length =3D record_length;
 }
 =

+static void mw_mbdn_changed(int id, void *userdata)
+{
+	struct ofono_message_waiting *mw =3D userdata;
+	int err;
+
+	mw->efmbdn_length =3D 0;
+	mw->mbdn_not_provided =3D FALSE;
+
+	err =3D ofono_sim_read(mw->sim_context, SIM_EFMBDN_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_FIXED,
+				mw_mbdn_read_cb, mw);
+	if (err !=3D 0)
+		ofono_error("Unable to read EF-MBDN from SIM");
+}
+
+static void mw_cphs_mbdn_changed(int id, void *userdata)
+{
+	struct ofono_message_waiting *mw =3D userdata;
+
+	mw->ef_cphs_mbdn_length =3D 0;
+	mw->cphs_mbdn_not_provided =3D FALSE;
+
+	ofono_sim_read(mw->sim_context, SIM_EF_CPHS_MBDN_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED,
+			mw_cphs_mbdn_read_cb, mw);
+}
+
 static void mw_mbi_read_cb(int ok, int total_length, int record,
 				const unsigned char *data,
 				int record_length, void *userdata)
@@ -604,6 +633,9 @@ static void mw_mbi_read_cb(int ok, int total_length, in=
t record,
 	err =3D ofono_sim_read(mw->sim_context, SIM_EFMBDN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				mw_mbdn_read_cb, mw);
+	mw->efmbdn_watch =3D ofono_sim_add_file_watch(mw->sim_context,
+						SIM_EFMBDN_FILEID,
+						mw_mbdn_changed, mw, NULL);
 =

 	if (err !=3D 0)
 		ofono_error("Unable to read EF-MBDN from SIM");
@@ -615,10 +647,15 @@ out:
 	 */
 	st =3D ofono_sim_get_cphs_service_table(mw->sim);
 =

-	if (st && bit_field(st[0], 4, 2) =3D=3D 3)
+	if (st && bit_field(st[0], 4, 2) =3D=3D 3) {
 		ofono_sim_read(mw->sim_context, SIM_EF_CPHS_MBDN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				mw_cphs_mbdn_read_cb, mw);
+		mw->ef_cphs_mbdn_watch =3D ofono_sim_add_file_watch(
+						mw->sim_context,
+						SIM_EF_CPHS_MBDN_FILEID,
+						mw_cphs_mbdn_changed, mw, NULL);
+	}
 }
 =

 static void mw_mwis_write_cb(int ok, void *userdata)
@@ -935,6 +972,46 @@ static void message_waiting_unregister(struct ofono_at=
om *atom)
 	ofono_modem_remove_interface(modem, OFONO_MESSAGE_WAITING_INTERFACE);
 }
 =

+static void mw_mwis_changed(int id, void *userdata)
+{
+	struct ofono_message_waiting *mw =3D userdata;
+
+	mw->efmwis_length =3D 0;
+
+	ofono_sim_read(mw->sim_context, SIM_EFMWIS_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED,
+			mw_mwis_read_cb, mw);
+}
+
+static void mw_cphs_mwis_changed(int id, void *userdata)
+{
+	struct ofono_message_waiting *mw =3D userdata;
+
+	mw->ef_cphs_mwis_length =3D 0;
+
+	ofono_sim_read(mw->sim_context, SIM_EF_CPHS_MWIS_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			mw_cphs_mwis_read_cb, mw);
+}
+
+static void mw_mbi_changed(int id, void *userdata)
+{
+	struct ofono_message_waiting *mw =3D userdata;
+
+	mw->efmbdn_length =3D 0;
+	mw->mbdn_not_provided =3D FALSE;
+
+	mw->ef_cphs_mbdn_length =3D 0;
+	mw->cphs_mbdn_not_provided =3D FALSE;
+
+	ofono_sim_remove_file_watch(mw->sim_context, mw->efmbdn_watch);
+	ofono_sim_remove_file_watch(mw->sim_context, mw->ef_cphs_mbdn_watch);
+
+	ofono_sim_read(mw->sim_context, SIM_EFMBI_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED,
+			mw_mbi_read_cb, mw);
+}
+
 void ofono_message_waiting_register(struct ofono_message_waiting *mw)
 {
 	DBusConnection *conn;
@@ -980,6 +1057,19 @@ void ofono_message_waiting_register(struct ofono_mess=
age_waiting *mw)
 		ofono_sim_read(mw->sim_context, SIM_EF_CPHS_MWIS_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 				mw_cphs_mwis_read_cb, mw);
+
+		/*
+		 * The operator could send us SMS mwi updates, but let's be
+		 * extra careful and track the file contents too.
+		 */
+		ofono_sim_add_file_watch(mw->sim_context, SIM_EFMWIS_FILEID,
+						mw_mwis_changed, mw, NULL);
+		ofono_sim_add_file_watch(mw->sim_context,
+						SIM_EF_CPHS_MWIS_FILEID,
+						mw_cphs_mwis_changed, mw, NULL);
+
+		ofono_sim_add_file_watch(mw->sim_context, SIM_EFMBI_FILEID,
+						mw_mbi_changed, mw, NULL);
 	}
 =

 	__ofono_atom_register(mw->atom, message_waiting_unregister);
-- =

1.7.1.86.g0e460.dirty


--===============6620149163437894987==--

