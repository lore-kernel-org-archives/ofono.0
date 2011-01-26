Content-Type: multipart/mixed; boundary="===============1254926541977483533=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/1] remove ofono_cug_option
Date: Wed, 26 Jan 2011 14:17:52 -0800
Message-ID: <1296080272-19253-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296080272-19253-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1254926541977483533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/voicecall.c      |   12 ++----------
 drivers/calypsomodem/voicecall.c |    9 ---------
 drivers/hfpmodem/voicecall.c     |    4 ++--
 drivers/huaweimodem/voicecall.c  |    9 ---------
 drivers/ifxmodem/voicecall.c     |   12 ++----------
 drivers/isimodem/voicecall.c     |   14 ++------------
 drivers/stemodem/voicecall.c     |   12 ++----------
 include/types.h                  |    6 ------
 include/voicecall.h              |    4 ++--
 src/voicecall.c                  |    5 ++---
 10 files changed, 14 insertions(+), 73 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 9e56999..10cac42 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -367,8 +367,8 @@ out:
 =

 static void at_dial(struct ofono_voicecall *vc,
 			const struct ofono_phone_number *ph,
-			enum ofono_clir_option clir, enum ofono_cug_option cug,
-			ofono_voicecall_cb_t cb, void *data)
+			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+			void *data)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
@@ -395,14 +395,6 @@ static void at_dial(struct ofono_voicecall *vc,
 		break;
 	}
 =

-	switch (cug) {
-	case OFONO_CUG_OPTION_INVOCATION:
-		strcat(buf, "G");
-		break;
-	default:
-		break;
-	}
-
 	strcat(buf, ";");
 =

 	if (g_at_chat_send(vd->chat, buf, atd_prefix,
diff --git a/drivers/calypsomodem/voicecall.c b/drivers/calypsomodem/voicec=
all.c
index 837ff69..204ed14 100644
--- a/drivers/calypsomodem/voicecall.c
+++ b/drivers/calypsomodem/voicecall.c
@@ -80,7 +80,6 @@ error:
 static void calypso_dial(struct ofono_voicecall *vc,
 				const struct ofono_phone_number *ph,
 				enum ofono_clir_option clir,
-				enum ofono_cug_option cug,
 				ofono_voicecall_cb_t cb, void *data)
 {
 	char buf[256];
@@ -101,14 +100,6 @@ static void calypso_dial(struct ofono_voicecall *vc,
 		break;
 	}
 =

-	switch (cug) {
-	case OFONO_CUG_OPTION_INVOCATION:
-		strcat(buf, "G");
-		break;
-	default:
-		break;
-	}
-
 	strcat(buf, ";");
 =

 	calypso_template(vc, buf, cb, data);
diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index d4d370e..d12a5ef 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -355,8 +355,8 @@ out:
 =

 static void hfp_dial(struct ofono_voicecall *vc,
 			const struct ofono_phone_number *ph,
-			enum ofono_clir_option clir, enum ofono_cug_option cug,
-			ofono_voicecall_cb_t cb, void *data)
+			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+			void *data)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
diff --git a/drivers/huaweimodem/voicecall.c b/drivers/huaweimodem/voicecal=
l.c
index 0c0aaa1..aef2a11 100644
--- a/drivers/huaweimodem/voicecall.c
+++ b/drivers/huaweimodem/voicecall.c
@@ -115,7 +115,6 @@ error:
 static void huawei_dial(struct ofono_voicecall *vc,
 				const struct ofono_phone_number *ph,
 				enum ofono_clir_option clir,
-				enum ofono_cug_option cug,
 				ofono_voicecall_cb_t cb, void *data)
 {
 	char buf[256];
@@ -136,14 +135,6 @@ static void huawei_dial(struct ofono_voicecall *vc,
 		break;
 	}
 =

-	switch (cug) {
-	case OFONO_CUG_OPTION_INVOCATION:
-		strcat(buf, "G");
-		break;
-	default:
-		break;
-	}
-
 	strcat(buf, ";");
 =

 	huawei_template(vc, buf, cb, data);
diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index f673624..fcd0c7e 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -298,8 +298,8 @@ static void atd_cb(gboolean ok, GAtResult *result, gpoi=
nter user_data)
 =

 static void ifx_dial(struct ofono_voicecall *vc,
 			const struct ofono_phone_number *ph,
-			enum ofono_clir_option clir, enum ofono_cug_option cug,
-			ofono_voicecall_cb_t cb, void *data)
+			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+			void *data)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
@@ -326,14 +326,6 @@ static void ifx_dial(struct ofono_voicecall *vc,
 		break;
 	}
 =

-	switch (cug) {
-	case OFONO_CUG_OPTION_INVOCATION:
-		strcat(buf, "G");
-		break;
-	default:
-		break;
-	}
-
 	strcat(buf, ";");
 =

 	if (g_at_chat_send(vd->chat, buf, atd_prefix,
diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 55f4c17..6a1e582 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -927,9 +927,8 @@ static struct isi_call_req_ctx *isi_call_dtmf_send_req(=
struct ofono_voicecall *o
 =

 static void isi_dial(struct ofono_voicecall *ovc,
 			const struct ofono_phone_number *restrict number,
-			enum ofono_clir_option clir,
-			enum ofono_cug_option cug,
-			ofono_voicecall_cb_t cb, void *data)
+			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+			void *data)
 {
 	unsigned char presentation =3D CALL_GSM_PRESENTATION_DEFAULT;
 =

@@ -945,15 +944,6 @@ static void isi_dial(struct ofono_voicecall *ovc,
 		break;
 	}
 =

-	switch (cug) {
-	case OFONO_CUG_OPTION_DEFAULT:
-		break;
-	case OFONO_CUG_OPTION_INVOCATION:
-		/* Not implemented */
-		CALLBACK_WITH_FAILURE(cb, data);
-		return;
-	}
-
 	isi_call_create_req(ovc, presentation, number->type, number->number,
 				cb, data);
 }
diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index ad505ff..5210483 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -180,8 +180,8 @@ static void atd_cb(gboolean ok, GAtResult *result, gpoi=
nter user_data)
 =

 static void ste_dial(struct ofono_voicecall *vc,
 			const struct ofono_phone_number *ph,
-			enum ofono_clir_option clir, enum ofono_cug_option cug,
-			ofono_voicecall_cb_t cb, void *data)
+			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+			void *data)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
@@ -208,14 +208,6 @@ static void ste_dial(struct ofono_voicecall *vc,
 		break;
 	}
 =

-	switch (cug) {
-	case OFONO_CUG_OPTION_DEFAULT:
-		break;
-	case OFONO_CUG_OPTION_INVOCATION:
-		strcat(buf, "G");
-		break;
-	}
-
 	strcat(buf, ";");
 =

 	if (g_at_chat_send(vd->chat, buf, none_prefix,
diff --git a/include/types.h b/include/types.h
index 71d0988..0faff54 100644
--- a/include/types.h
+++ b/include/types.h
@@ -49,12 +49,6 @@ enum ofono_clir_option {
 	OFONO_CLIR_OPTION_SUPPRESSION
 };
 =

-/* 27.007 Section 6.2 */
-enum ofono_cug_option {
-	OFONO_CUG_OPTION_DEFAULT =3D 0,
-	OFONO_CUG_OPTION_INVOCATION =3D 1,
-};
-
 enum ofono_error_type {
 	OFONO_ERROR_TYPE_NO_ERROR =3D 0,
 	OFONO_ERROR_TYPE_CME,
diff --git a/include/voicecall.h b/include/voicecall.h
index f3c2bf4..f00eb08 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -63,8 +63,8 @@ struct ofono_voicecall_driver {
 	 */
 	void (*dial)(struct ofono_voicecall *vc,
 			const struct ofono_phone_number *number,
-			enum ofono_clir_option clir, enum ofono_cug_option cug,
-			ofono_voicecall_cb_t cb, void *data);
+			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+			void *data);
 	/* Answers an incoming call, this usually corresponds to ATA */
 	void (*answer)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
diff --git a/src/voicecall.c b/src/voicecall.c
index e6bfe04..6246787 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1327,8 +1327,7 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 =

 	string_to_phone_number(number, &ph);
 =

-	vc->driver->dial(vc, &ph, clir, OFONO_CUG_OPTION_DEFAULT,
-				manager_dial_callback, vc);
+	vc->driver->dial(vc, &ph, clir, manager_dial_callback, vc);
 =

 	return NULL;
 }
@@ -2463,7 +2462,7 @@ static void dial_request_cb(const struct ofono_error =
*error, void *data)
 static void dial_request(struct ofono_voicecall *vc)
 {
 	vc->driver->dial(vc, &vc->dial_req->ph, OFONO_CLIR_OPTION_DEFAULT,
-				OFONO_CUG_OPTION_DEFAULT, dial_request_cb, vc);
+				dial_request_cb, vc);
 }
 =

 static void dial_req_disconnect_cb(const struct ofono_error *error, void *=
data)
-- =

1.7.0.4


--===============1254926541977483533==--

