Content-Type: multipart/mixed; boundary="===============0451480812492888509=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/3] If EF-MWIS is not available use the CPHS version.
Date: Thu, 07 Jan 2010 12:39:21 +0100
Message-ID: <1262864361-32154-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0451480812492888509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/message-waiting.c |   81 +++++++++++++++++++++++++++++++++++++++++++++=
++--
 src/simutil.h         |    1 +
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/src/message-waiting.c b/src/message-waiting.c
index 283c5e2..05d05ed 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -51,6 +51,7 @@ struct ofono_message_waiting {
 	unsigned char efmwis_length;
 	unsigned char efmbdn_length;
 	unsigned char efmbdn_record_id[5];
+	unsigned char ef_cphs_mwis_length;
 	unsigned char ef_cphs_mbdn_length;
 	gboolean mbdn_not_provided;
 	struct ofono_phone_number mailbox_number[5];
@@ -478,6 +479,60 @@ static void mw_mbi_read_cb(int ok, int total_length, i=
nt record,
 		ofono_error("Unable to read EF-MBDN from SIM");
 }
 =

+static void mw_cphs_mwis_read_cb(int ok, int total_length, int record,
+					const unsigned char *data,
+					int record_length, void *userdata)
+{
+	struct ofono_message_waiting *mw =3D userdata;
+	int i;
+	struct mailbox_state info;
+	dbus_bool_t indication;
+	unsigned char count;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(mw->atom);
+
+	if (!ok || total_length < 1) {
+		ofono_error("Unable to read waiting messages indicator "
+			"status from SIM");
+
+		mw->ef_cphs_mwis_length =3D 0;
+
+		return;
+	}
+
+	mw->ef_cphs_mwis_length =3D total_length;
+
+	if (mw->efmwis_length !=3D 0)
+		return;
+
+	for (i =3D 0; i < 5 && i < total_length; i++) {
+		info.indication =3D (data[i] =3D=3D 0xa);
+		info.message_count =3D 0;
+
+		if (mw->messages[i].indication !=3D info.indication ||
+				mw->messages[i].message_count !=3D
+				info.message_count) {
+			memcpy(&mw->messages[i], &info, sizeof(info));
+
+			indication =3D info.indication;
+			count =3D info.message_count;
+
+			if (!mw_message_waiting_property_name[i])
+				continue;
+
+			ofono_dbus_signal_property_changed(conn, path,
+					MESSAGE_WAITING_INTERFACE,
+					mw_message_waiting_property_name[i],
+					DBUS_TYPE_BOOLEAN, &indication);
+
+			ofono_dbus_signal_property_changed(conn, path,
+					MESSAGE_WAITING_INTERFACE,
+					mw_message_count_property_name[i],
+					DBUS_TYPE_BYTE, &count);
+		}
+	}
+}
+
 static void mw_cphs_mbdn_read_cb(int ok, int total_length, int record,
 				const unsigned char *data,
 				int record_length, void *userdata)
@@ -526,7 +581,7 @@ static void mw_cphs_mbdn_read_cb(int ok, int total_leng=
th, int record,
 static void mw_mwis_write_cb(int ok, void *userdata)
 {
 	if (!ok)
-		ofono_error("Writing new EF-MBDN failed");
+		ofono_error("Writing new EF-MWIS failed");
 }
 =

 static void mw_set_indicator(struct ofono_message_waiting *mw, int profile,
@@ -575,7 +630,10 @@ static void mw_set_indicator(struct ofono_message_wait=
ing *mw, int profile,
 	}
 =

 	/* Writes MWI states and/or MBDN back to SIM */
-	if ((mw->efmwis_length < 5)) {
+	if (mw->efmwis_length < 5) {
+		if (mw->ef_cphs_mwis_length >=3D 1)
+			goto try_cphs;
+
 		ofono_error("Unable to update MWIS indicator");
 		return;
 	}
@@ -594,6 +652,18 @@ static void mw_set_indicator(struct ofono_message_wait=
ing *mw, int profile,
 				efmwis, mw->efmwis_length, mw) !=3D 0) {
 		ofono_error("Queuing a EF-MWI write to SIM failed");
 	}
+
+	if (mw->ef_cphs_mwis_length =3D=3D 0)
+		return;
+
+try_cphs:
+	for (i =3D 0; i < 5 && i < mw->ef_cphs_mwis_length; i++)
+		efmwis[i] =3D mw->messages[i].indication ? 0xa : 0x5;
+
+	if (ofono_sim_write(mw->sim, SIM_EF_CPHS_MWIS_FILEID, mw_mwis_write_cb,
+				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT, 0,
+				efmwis, mw->ef_cphs_mwis_length, mw) !=3D 0)
+		ofono_error("Queuing a EF-MWIS write to SIM failed (CPHS)");
 }
 =

 static void handle_special_sms_iei(struct ofono_message_waiting *mw,
@@ -835,12 +905,17 @@ void ofono_message_waiting_register(struct ofono_mess=
age_waiting *mw)
 		ofono_sim_read(mw->sim, SIM_EFMBI_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				mw_mbi_read_cb, mw);
+
 		if ((ofono_sim_get_cphs_support(mw->sim) &
 				OFONO_SIM_CPHS_ST_MAILBOX_NUMBERS_MASK) =3D=3D
-			OFONO_SIM_CPHS_ST_MAILBOX_NUMBERS_MASK)
+			OFONO_SIM_CPHS_ST_MAILBOX_NUMBERS_MASK) {
+			ofono_sim_read(mw->sim, SIM_EF_CPHS_MWIS_FILEID,
+					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+					mw_cphs_mwis_read_cb, mw);
 			ofono_sim_read(mw->sim, SIM_EF_CPHS_MBDN_FILEID,
 					OFONO_SIM_FILE_STRUCTURE_FIXED,
 					mw_cphs_mbdn_read_cb, mw);
+		}
 	}
 =

 	__ofono_atom_register(mw->atom, message_waiting_unregister);
diff --git a/src/simutil.h b/src/simutil.h
index 0fedab9..5c28512 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -22,6 +22,7 @@
 enum sim_fileid {
 	SIM_EFPL_FILEID =3D 0x2f05,
 	SIM_EFLI_FILEID =3D 0x6f05,
+	SIM_EF_CPHS_MWIS_FILEID =3D 0x6f11,
 	SIM_EF_CPHS_INFORMATION_FILEID =3D 0x6f16,
 	SIM_EF_CPHS_MBDN_FILEID =3D 0x6f17,
 	SIM_EFMSISDN_FILEID =3D 0x6f40,
-- =

1.6.1


--===============0451480812492888509==--

