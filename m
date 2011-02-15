Content-Type: multipart/mixed; boundary="===============0397871408494340920=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 7/9] message-waiting: Watch for changes to relevant SIM files.
Date: Tue, 15 Feb 2011 08:58:57 +0100
Message-ID: <1297756739-2958-7-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1297756739-2958-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0397871408494340920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/message-waiting.c |   88 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 87 insertions(+), 1 deletions(-)

diff --git a/src/message-waiting.c b/src/message-waiting.c
index 72cf582..f5406ca 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -576,6 +576,33 @@ static void mw_mbdn_read_cb(int ok, int total_length, =
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
@@ -604,6 +631,8 @@ static void mw_mbi_read_cb(int ok, int total_length, in=
t record,
 	err =3D ofono_sim_read(mw->sim_context, SIM_EFMBDN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				mw_mbdn_read_cb, mw);
+	ofono_sim_add_file_watch(mw->sim_context, SIM_EFMBDN_FILEID,
+					mw_mbdn_changed, mw, NULL);
 =

 	if (err !=3D 0)
 		ofono_error("Unable to read EF-MBDN from SIM");
@@ -615,10 +644,14 @@ out:
 	 */
 	st =3D ofono_sim_get_cphs_service_table(mw->sim);
 =

-	if (st && bit_field(st[0], 4, 2) =3D=3D 3)
+	if (st && bit_field(st[0], 4, 2) =3D=3D 3) {
 		ofono_sim_read(mw->sim_context, SIM_EF_CPHS_MBDN_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				mw_cphs_mbdn_read_cb, mw);
+		ofono_sim_add_file_watch(mw->sim_context,
+						SIM_EF_CPHS_MBDN_FILEID,
+						mw_cphs_mbdn_changed, mw, NULL);
+	}
 }
 =

 static void mw_mwis_write_cb(int ok, void *userdata)
@@ -935,6 +968,46 @@ static void message_waiting_unregister(struct ofono_at=
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
+	ofono_sim_remove_file_watch(mw->sim_context, SIM_EFMBDN_FILEID);
+	ofono_sim_remove_file_watch(mw->sim_context, SIM_EF_CPHS_MBDN_FILEID);
+
+	ofono_sim_read(mw->sim_context, SIM_EFMBI_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED,
+			mw_mbi_read_cb, mw);
+}
+
 void ofono_message_waiting_register(struct ofono_message_waiting *mw)
 {
 	DBusConnection *conn;
@@ -980,6 +1053,19 @@ void ofono_message_waiting_register(struct ofono_mess=
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


--===============0397871408494340920==--

