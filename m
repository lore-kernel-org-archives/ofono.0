Content-Type: multipart/mixed; boundary="===============5978058612992378049=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-ready-v2 PATCH 3/3] atmodem/sim: use ofono_sim_ready_notify
Date: Mon, 08 Nov 2010 22:27:45 +0200
Message-ID: <1289248065-3078-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1289248065-3078-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5978058612992378049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Retry with ofono_sim_ready_notify after a timeout if CPIN? returns CME
error 14 (SIM busy).

If there is a ready notification registered but no such notification has
been received, return the CME error 14. If ready notification has been
received, return normally.
---
 drivers/atmodem/sim.c |  182 +++++++++++++++++++++++++++++++++++++++------=
----
 src/simutil.h         |    2 +
 2 files changed, 147 insertions(+), 37 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 9cfdc65..3ea8f87 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -44,10 +44,17 @@
 #define EF_STATUS_INVALIDATED 0
 #define EF_STATUS_VALID 1
 =

+/* Timeout in milliseconds when there is ready notification */
+#define READY_TIMEOUT		5000
+/* Timeout in milliseconds without ready notification */
+#define BUSY_TIMEOUT       500
+
 struct sim_data {
 	GAtChat *chat;
 	unsigned int vendor;
+	ofono_bool_t ready;
 	guint ready_id;
+	guint ready_source;
 };
 =

 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
@@ -456,10 +463,65 @@ static struct {
 	{ OFONO_SIM_PASSWORD_PHCORP_PUK,	"PH-CORP PUK"	},
 };
 =

+static void ready_unregister_and_notify(struct ofono_sim *sim)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	DBG("enter");
+
+	if (sd->ready_source > 0)
+		g_source_remove(sd->ready_source);
+	sd->ready_source =3D 0;
+
+	if (sd->ready_id > 0)
+		g_at_chat_unregister(sd->chat, sd->ready_id);
+	sd->ready_id =3D 0;
+
+	ofono_sim_ready_notify(sim);
+}
+
+static gboolean ready_timeout(gpointer user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	DBG("enter");
+
+	sd->ready_source =3D 0;
+	ready_unregister_and_notify(sim);
+
+	return FALSE;
+}
+
+static void at_check_sim_busy(struct ofono_sim *sim,
+				struct ofono_error *error)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	if (error->type !=3D OFONO_ERROR_TYPE_CME)
+		return;
+	if (error->error !=3D 14)
+		return;
+
+	if (sd->ready_source > 0)
+		return;
+
+	sd->ready_source =3D g_timeout_add(BUSY_TIMEOUT, ready_timeout, sim);
+}
+
+#define CALLBACK_WITH_SIM_BUSY(f, args...)		\
+	do {						\
+		struct ofono_error e;			\
+		e.type =3D OFONO_ERROR_TYPE_CME;		\
+		e.error =3D 14;				\
+		f(&e, ##args);				\
+	} while (0)
+
 static void at_cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
-	struct sim_data *sd =3D ofono_sim_get_data(cbd->user);
+	struct ofono_sim *sim =3D cbd->user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	GAtResultIter iter;
 	ofono_sim_passwd_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
@@ -475,6 +537,7 @@ static void at_cpin_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 		decode_at_error(&error, final);
 =

 	if (!ok) {
+		at_check_sim_busy(sim, &error);
 		cb(&error, -1, cbd->data);
 		return;
 	}
@@ -506,8 +569,18 @@ static void at_cpin_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		return;
 	}
 =

-	DBG("crsm_pin_cb: %s", pin_required);
+	if (!sd->ready && sd->ready_id > 0 && sd->ready_source > 0) {
+		CALLBACK_WITH_SIM_BUSY(cb, -1, cbd->data);
+		return;
+	}
 =

+	switch (pin_type) {
+	case OFONO_SIM_PASSWORD_SIM_PIN:
+	case OFONO_SIM_PASSWORD_SIM_PUK:
+		sd->ready =3D FALSE;
+	}
+
+	DBG("crsm_pin_cb: %s", pin_required);
 	cb(&error, pin_type, cbd->data);
 }
 =

@@ -534,10 +607,8 @@ error:
 =

 static void at_xsim_notify(GAtResult *result, gpointer user_data)
 {
-	struct cb_data *cbd =3D user_data;
-	struct sim_data *sd =3D cbd->user;
-	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
-	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_NO_ERROR };
+	struct ofono_sim *sim =3D user_data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	GAtResultIter iter;
 	int state;
 =

@@ -557,37 +628,29 @@ static void at_xsim_notify(GAtResult *result, gpointe=
r user_data)
 		return;
 	}
 =

-	cb(&error, cbd->data);
+	sd->ready =3D TRUE;
 =

-	g_at_chat_unregister(sd->chat, sd->ready_id);
-	sd->ready_id =3D 0;
+	if (sd->ready_source > 0)
+		ready_unregister_and_notify(sim);
 }
 =

 static void at_epev_notify(GAtResult *result, gpointer user_data)
 {
-	struct cb_data *cbd =3D user_data;
-	struct sim_data *sd =3D cbd->user;
-	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
-	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_NO_ERROR };
+	struct ofono_sim *sim =3D user_data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 =

-	cb(&error, cbd->data);
+	sd->ready =3D TRUE;
 =

-	g_at_chat_unregister(sd->chat, sd->ready_id);
-	sd->ready_id =3D 0;
+	if (sd->ready_source > 0)
+		ready_unregister_and_notify(sim);
 }
 =

-static void at_pin_send_cb(gboolean ok, GAtResult *result,
-				gpointer user_data)
+static void at_register_ready(struct ofono_sim *sim)
 {
-	struct cb_data *cbd =3D user_data;
-	struct sim_data *sd =3D cbd->user;
-	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
-	struct ofono_error error;
-
-	decode_at_error(&error, g_at_result_final_response(result));
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 =

-	if (!ok)
-		goto done;
+	if (sd->ready_id > 0)
+		return;
 =

 	switch (sd->vendor) {
 	case OFONO_VENDOR_IFX:
@@ -598,24 +661,64 @@ static void at_pin_send_cb(gboolean ok, GAtResult *re=
sult,
 		 */
 		sd->ready_id =3D g_at_chat_register(sd->chat, "+XSIM",
 							at_xsim_notify,
-							FALSE, cbd, g_free);
-		return;
+							FALSE, sim, NULL);
+		break;
+
 	case OFONO_VENDOR_MBM:
 		/*
 		 * On the MBM modem, AT+CPIN? keeps returning SIM PIN
 		 * for a moment after successful AT+CPIN=3D"..", but then
-		 * sends *EPEV when that changes.
+		 * sends *EPEV when that changes. Sometimes.
 		 */
 		sd->ready_id =3D g_at_chat_register(sd->chat, "*EPEV",
 							at_epev_notify,
-							FALSE, cbd, g_free);
+							FALSE, sim, NULL);
+		break;
+	}
+}
+
+static void at_wait_for_ready(struct ofono_sim *sim)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	guint timeout;
+
+	if (sd->ready)
+		return;
+
+	at_register_ready(sim);
+
+	switch (sd->vendor) {
+	case OFONO_VENDOR_IFX:
+		timeout =3D READY_TIMEOUT;
+		break;
+
+	case OFONO_VENDOR_MBM:
+		timeout =3D READY_TIMEOUT;
+		break;
+
+	default:
 		return;
 	}
 =

-done:
-	cb(&error, cbd->data);
+	if (sd->ready_source)
+		g_source_remove(sd->ready_source);
+	sd->ready_source =3D g_timeout_add(timeout, ready_timeout, sim);
+}
 =

-	g_free(cbd);
+static void at_pin_send_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_sim *sim =3D cbd->user;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (ok)
+		at_wait_for_ready(sim);
+
+	cb(&error, cbd->data);
 }
 =

 static void at_pin_send(struct ofono_sim *sim, const char *passwd,
@@ -629,12 +732,14 @@ static void at_pin_send(struct ofono_sim *sim, const =
char *passwd,
 	if (!cbd)
 		goto error;
 =

-	cbd->user =3D sd;
+	cbd->user =3D sim;
+
+	sd->ready =3D FALSE;
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\"", passwd);
 =

 	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
-				at_pin_send_cb, cbd, NULL);
+				at_pin_send_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
 =

@@ -659,12 +764,12 @@ static void at_pin_send_puk(struct ofono_sim *sim, co=
nst char *puk,
 	if (!cbd)
 		goto error;
 =

-	cbd->user =3D sd;
+	cbd->user =3D sim;
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
 =

 	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
-				at_pin_send_cb, cbd, NULL);
+				at_pin_send_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
 =

@@ -858,6 +963,9 @@ static int at_sim_probe(struct ofono_sim *sim, unsigned=
 int vendor,
 	}
 =

 	ofono_sim_set_data(sim, sd);
+
+	at_register_ready(sim);
+
 	g_idle_add(at_sim_register, sim);
 =

 	return 0;
diff --git a/src/simutil.h b/src/simutil.h
index 5b56099..7b07f16 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -24,6 +24,7 @@ enum sim_fileid {
 	SIM_EF_ICCID_FILEID =3D 0x2fe2,
 	SIM_EFIMG_FILEID =3D 0x4F20,
 	SIM_EFLI_FILEID =3D 0x6f05,
+	SIM_EFIMSI_FILEID =3D 0x6f07,
 	SIM_EF_CPHS_MWIS_FILEID =3D 0x6f11,
 	SIM_EF_CPHS_INFORMATION_FILEID =3D 0x6f16,
 	SIM_EF_CPHS_MBDN_FILEID =3D 0x6f17,
@@ -45,6 +46,7 @@ enum sim_fileid {
 	SIM_EFSPDI_FILEID =3D 0x6fcd,
 	SIM_EFECC_FILEID =3D 0x6fb7,
 	SIM_EFCBMIR_FILEID =3D 0x6f50,
+	SIM_EFNIA_FILEID =3D 0x6f51,
 	SIM_EFCBMI_FILEID =3D 0x6f45,
 	SIM_EFCBMID_FILEID =3D 0x6f48,
 };
-- =

1.7.1


--===============5978058612992378049==--

