Content-Type: multipart/mixed; boundary="===============1800699610627097995=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Return SIM file access conditions from read_file_info.
Date: Mon, 20 Jul 2009 18:11:39 +0200
Message-ID: <1248106299-5861-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1800699610627097995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c |   28 +++++++++++++++++++++++-----
 src/driver.h          |   23 ++++++++++++++++++++++-
 src/sim.c             |    3 ++-
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 01b5719..81b566a 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -40,6 +40,13 @@
 =

 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
 =

+static inline enum ofono_sim_file_access file_access_condition_decode(int =
bcd)
+{
+	if (bcd >=3D 4 && bcd <=3D 14)
+		return OFONO_SIM_FILE_ACCESS_ADM;
+	return bcd;
+}
+
 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -50,12 +57,13 @@ static void at_crsm_info_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	gint sw1, sw2, len;
 	int flen, rlen;
 	enum ofono_sim_file_structure str;
+	enum ofono_sim_file_access access[__OFONO_SIM_FILE_CONDITION_NUM];
 =

 	dump_response("at_crsm_info_cb", ok, result);
 	decode_at_error(&error, g_at_result_final_response(result));
 =

 	if (!ok) {
-		cb(&error, -1, -1, -1, cbd->data);
+		cb(&error, -1, -1, -1, NULL, cbd->data);
 		return;
 	}
 =

@@ -64,7 +72,7 @@ static void at_crsm_info_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	if (!g_at_result_iter_next(&iter, "+CRSM:")) {
 		DECLARE_FAILURE(e);
 =

-		cb(&e, -1, -1, -1, cbd->data);
+		cb(&e, -1, -1, -1, NULL, cbd->data);
 		return;
 	}
 =

@@ -78,7 +86,7 @@ static void at_crsm_info_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 		(response[13] =3D=3D 0x01 && len < 15)) {
 		DECLARE_FAILURE(e);
 =

-		cb(&e, -1, -1, -1, cbd->data);
+		cb(&e, -1, -1, -1, NULL, cbd->data);
 		return;
 	}
 =

@@ -86,13 +94,23 @@ static void at_crsm_info_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

 	flen =3D (response[2] << 8) | response[3];
 	str =3D response[13];
+	access[OFONO_SIM_FILE_CONDITION_UPDATE] =3D
+		file_access_condition_decode((response[9] >> 4) & 0xf);
+	access[OFONO_SIM_FILE_CONDITION_READ] =3D
+		file_access_condition_decode((response[9] >> 0) & 0xf);
+	access[OFONO_SIM_FILE_CONDITION_INCREASE] =3D
+		file_access_condition_decode((response[10] >> 0) & 0xf);
+	access[OFONO_SIM_FILE_CONDITION_INVALIDATE] =3D
+		file_access_condition_decode((response[11] >> 4) & 0xf);
+	access[OFONO_SIM_FILE_CONDITION_REHABILITATE] =3D
+		file_access_condition_decode((response[11] >> 0) & 0xf);
 =

 	if (str =3D=3D 0x01)
 		rlen =3D response[14];
 	else
 		rlen =3D 0;
 =

-	cb(&error, flen, str, rlen, cbd->data);
+	cb(&error, flen, str, rlen, access, cbd->data);
 }
 =

 static void at_sim_read_info(struct ofono_modem *modem, int fileid,
@@ -118,7 +136,7 @@ error:
 =

 	{
 		DECLARE_FAILURE(error);
-		cb(&error, -1, -1, -1, data);
+		cb(&error, -1, -1, -1, NULL, data);
 	}
 }
 =

diff --git a/src/driver.h b/src/driver.h
index f324c1c..c730eea 100644
--- a/src/driver.h
+++ b/src/driver.h
@@ -101,6 +101,25 @@ enum ofono_sim_file_structure {
 	OFONO_SIM_FILE_STRUCTURE_CYCLIC =3D 3
 };
 =

+/* 51.011 Section 9.3 */
+enum ofono_sim_file_access {
+	OFONO_SIM_FILE_ACCESS_ALWAYS =3D 0,
+	OFONO_SIM_FILE_ACCESS_CHV1 =3D 1,
+	OFONO_SIM_FILE_ACCESS_CHV2 =3D 2,
+	OFONO_SIM_FILE_ACCESS_RESERVED =3D 3,
+	OFONO_SIM_FILE_ACCESS_ADM =3D 4,
+	OFONO_SIM_FILE_ACCESS_NEVER =3D 15,
+};
+
+enum ofono_sim_file_condition {
+	OFONO_SIM_FILE_CONDITION_READ =3D 0,
+	OFONO_SIM_FILE_CONDITION_UPDATE,
+	OFONO_SIM_FILE_CONDITION_INCREASE,
+	OFONO_SIM_FILE_CONDITION_INVALIDATE,
+	OFONO_SIM_FILE_CONDITION_REHABILITATE,
+	__OFONO_SIM_FILE_CONDITION_NUM,
+};
+
 /* Notification functions, the integer values here should map to
  * values obtained from the modem.  The enumerations are the same
  * as the values for the fields found in 3GPP TS 27.007
@@ -162,7 +181,9 @@ typedef void (*ofono_call_barring_cb_t)(const struct of=
ono_error *error,
 typedef void (*ofono_sim_file_info_cb_t)(const struct ofono_error *error,
 					int filelength,
 					enum ofono_sim_file_structure structure,
-					int recordlength, void *data);
+					int recordlength,
+					enum ofono_sim_file_access *access,
+					void *data);
 =

 typedef void (*ofono_sim_read_cb_t)(const struct ofono_error *error,
 					const unsigned char *sdata, int length,
diff --git a/src/sim.c b/src/sim.c
index 86f2e98..787ebc7 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -356,7 +356,8 @@ static gboolean sim_op_retrieve_next(gpointer user)
 =

 static void sim_op_info_cb(const struct ofono_error *error, int length,
 				enum ofono_sim_file_structure structure,
-				int record_length, void *data)
+				int record_length,
+				enum ofono_sim_file_access *access, void *data)
 {
 	struct ofono_modem *modem =3D data;
 	struct sim_manager_data *sim =3D modem->sim_manager;
-- =

1.6.0


--===============1800699610627097995==--

