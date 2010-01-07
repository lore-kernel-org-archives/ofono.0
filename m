Content-Type: multipart/mixed; boundary="===============0485672311003532807=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/3] Use CPHS version of mailbox numbers on SIM if 3GPP
 version not available.
Date: Thu, 07 Jan 2010 12:39:00 +0100
Message-ID: <1262864340-32125-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0485672311003532807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise just try to keep the CPHS version of the files in sync.
---
 include/sim.h         |    4 ++
 src/message-waiting.c |  130 +++++++++++++++++++++++++++++++++++++++++++--=
---
 src/simutil.h         |    1 +
 3 files changed, 121 insertions(+), 14 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 7a61269..5daa50b 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -69,6 +69,10 @@ enum ofono_sim_cphs_phase {
 	OFONO_SIM_CPHS_PHASE2,
 };
 =

+enum ofono_sim_cphs_support_masks {
+	OFONO_SIM_CPHS_ST_MAILBOX_NUMBERS_MASK =3D 0x30,
+};
+
 typedef void (*ofono_sim_file_info_cb_t)(const struct ofono_error *error,
 					int filelength,
 					enum ofono_sim_file_structure structure,
diff --git a/src/message-waiting.c b/src/message-waiting.c
index 104e327..283c5e2 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -51,6 +51,7 @@ struct ofono_message_waiting {
 	unsigned char efmwis_length;
 	unsigned char efmbdn_length;
 	unsigned char efmbdn_record_id[5];
+	unsigned char ef_cphs_mbdn_length;
 	gboolean mbdn_not_provided;
 	struct ofono_phone_number mailbox_number[5];
 	struct ofono_sim *sim;
@@ -94,6 +95,18 @@ static const char *mw_mailbox_property_name[5] =3D {
 #endif
 };
 =

+static const int mw_mailbox_to_cphs_record[5] =3D {
+	1, /* Line 1 mailbox */
+#if 0
+	4, /* Fax mailbox */
+	0,
+	3, /* Data mailbox */
+	0,
+#endif
+};
+
+static void mbdn_set_cb(int ok, void *data);
+
 static DBusMessage *mw_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -146,6 +159,47 @@ static DBusMessage *mw_get_properties(DBusConnection *=
conn,
 	return reply;
 }
 =

+static DBusMessage *set_cphs_mbdn(struct ofono_message_waiting *mw,
+				int mailbox,
+				const char *number,
+				DBusMessage *msg)
+{
+	struct mbdn_set_request *req;
+	unsigned char efmbdn[255];
+
+	if (mw_mailbox_to_cphs_record[mailbox] =3D=3D 0 ||
+			mw->ef_cphs_mbdn_length =3D=3D 0) {
+		if (!msg)
+			return NULL;
+
+		if (mw->mbdn_not_provided =3D=3D TRUE)
+			return __ofono_error_not_supported(msg);
+		else
+			return __ofono_error_sim_not_ready(msg);
+	}
+
+	req =3D g_new0(struct mbdn_set_request, 1);
+
+	req->mw =3D mw;
+	req->mailbox =3D mailbox;
+	string_to_phone_number(number, &req->number);
+	req->msg =3D msg ? dbus_message_ref(msg) : NULL;
+
+	sim_adn_build(efmbdn, req->mw->ef_cphs_mbdn_length,
+			&req->number, NULL);
+
+	if (ofono_sim_write(mw->sim, SIM_EF_CPHS_MBDN_FILEID, mbdn_set_cb,
+			OFONO_SIM_FILE_STRUCTURE_FIXED,
+			mw_mailbox_to_cphs_record[mailbox],
+			efmbdn, mw->ef_cphs_mbdn_length, NULL) =3D=3D -1) {
+
+		if (msg)
+			return __ofono_error_failed(msg);
+	}
+
+	return NULL;
+}
+
 static void mbdn_set_cb(int ok, void *data)
 {
 	struct mbdn_set_request *req =3D data;
@@ -160,6 +214,9 @@ static void mbdn_set_cb(int ok, void *data)
 		goto out;
 	}
 =

+	if (req->msg)
+		reply =3D dbus_message_new_method_return(req->msg);
+
 	if (g_str_equal(req->number.number, old->number) &&
 			req->number.type =3D=3D old->type)
 		goto out;
@@ -181,8 +238,10 @@ static void mbdn_set_cb(int ok, void *data)
 						&number);
 	}
 =

-	if (req->msg)
-		reply =3D dbus_message_new_method_return(req->msg);
+	/* Make a single attempt at keeping the CPHS version of the file
+	 * in sync.  */
+	set_cphs_mbdn(req->mw, req->mailbox,
+			phone_number_to_string(&req->number), NULL);
 =

 out:
 	if (req->msg && reply)
@@ -197,12 +256,10 @@ static DBusMessage *set_mbdn(struct ofono_message_wai=
ting *mw, int mailbox,
 	struct mbdn_set_request *req;
 	unsigned char efmbdn[255];
 =

-	if (mw->efmbdn_record_id[mailbox] =3D=3D 0) {
-		if (msg)
-			return __ofono_error_sim_not_ready(msg);
-
-		return NULL;
-	}
+	if (mw->efmbdn_length =3D=3D 0 || mw->efmbdn_record_id[mailbox] =3D=3D 0)
+		/* If we have no 3GPP EFmbdn on the card, maybe the
+		 * CPHS version is available */
+		return set_cphs_mbdn(mw, mailbox, number, msg);
 =

 	req =3D g_new0(struct mbdn_set_request, 1);
 =

@@ -235,12 +292,6 @@ static DBusMessage *mw_set_property(DBusConnection *co=
nn, DBusMessage *msg,
 	const char *name, *value;
 	int i;
 =

-	if (mw->mbdn_not_provided =3D=3D TRUE)
-		return __ofono_error_not_supported(msg);
-
-	if (mw->efmbdn_length =3D=3D 0)
-		return __ofono_error_sim_not_ready(msg);
-
 	if (!dbus_message_iter_init(msg, &iter))
 		return __ofono_error_invalid_args(msg);
 =

@@ -427,6 +478,51 @@ static void mw_mbi_read_cb(int ok, int total_length, i=
nt record,
 		ofono_error("Unable to read EF-MBDN from SIM");
 }
 =

+static void mw_cphs_mbdn_read_cb(int ok, int total_length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct ofono_message_waiting *mw =3D userdata;
+	int i;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *value;
+
+	if (!ok || record_length < 14 || total_length < record_length) {
+		ofono_error("Unable to read mailbox dialling numbers "
+			"from SIM");
+
+		mw->ef_cphs_mbdn_length =3D 0;
+		return;
+	}
+
+	for (i =3D 0; i < 5; i++)
+		if (record =3D=3D mw_mailbox_to_cphs_record[i])
+			break;
+
+	if (i =3D=3D 5)
+		return;
+
+	mw->ef_cphs_mbdn_length =3D record_length;
+
+	if (mw->mbdn_not_provided !=3D TRUE)
+		return;
+
+	if (sim_adn_parse(data, record_length, &mw->mailbox_number[i], NULL) =3D=
=3D
+			FALSE)
+		mw->mailbox_number[i].number[0] =3D '\0';
+
+	if (mw_mailbox_property_name[i]) {
+		const char *path =3D __ofono_atom_get_path(mw->atom);
+
+		value =3D phone_number_to_string(&mw->mailbox_number[i]);
+
+		ofono_dbus_signal_property_changed(conn, path,
+				MESSAGE_WAITING_INTERFACE,
+				mw_mailbox_property_name[i],
+				DBUS_TYPE_STRING, &value);
+	}
+}
+
 static void mw_mwis_write_cb(int ok, void *userdata)
 {
 	if (!ok)
@@ -739,6 +835,12 @@ void ofono_message_waiting_register(struct ofono_messa=
ge_waiting *mw)
 		ofono_sim_read(mw->sim, SIM_EFMBI_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
 				mw_mbi_read_cb, mw);
+		if ((ofono_sim_get_cphs_support(mw->sim) &
+				OFONO_SIM_CPHS_ST_MAILBOX_NUMBERS_MASK) =3D=3D
+			OFONO_SIM_CPHS_ST_MAILBOX_NUMBERS_MASK)
+			ofono_sim_read(mw->sim, SIM_EF_CPHS_MBDN_FILEID,
+					OFONO_SIM_FILE_STRUCTURE_FIXED,
+					mw_cphs_mbdn_read_cb, mw);
 	}
 =

 	__ofono_atom_register(mw->atom, message_waiting_unregister);
diff --git a/src/simutil.h b/src/simutil.h
index 66e684a..0fedab9 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -23,6 +23,7 @@ enum sim_fileid {
 	SIM_EFPL_FILEID =3D 0x2f05,
 	SIM_EFLI_FILEID =3D 0x6f05,
 	SIM_EF_CPHS_INFORMATION_FILEID =3D 0x6f16,
+	SIM_EF_CPHS_MBDN_FILEID =3D 0x6f17,
 	SIM_EFMSISDN_FILEID =3D 0x6f40,
 	SIM_EFSPN_FILEID =3D 0x6f46,
 	SIM_EFSDN_FILEID =3D 0x6f49,
-- =

1.6.1


--===============0485672311003532807==--

