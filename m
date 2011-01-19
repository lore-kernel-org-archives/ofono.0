Content-Type: multipart/mixed; boundary="===============2368794146689673073=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v3 2/2] atmodem: add ifx support for pin retries query
Date: Wed, 19 Jan 2011 16:03:02 +0200
Message-ID: <1295445782-31136-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1295445782-31136-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2368794146689673073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch also makes use of the helper function
introduce in atutil for parsing the huawei and ifx
pin retry count at command result.
---
 drivers/atmodem/sim.c |   79 +++++++++++++++------------------------------=
---
 1 files changed, 25 insertions(+), 54 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 8d89d53..73b0178 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -56,6 +56,7 @@ static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 static const char *clck_prefix[] =3D { "+CLCK:", NULL };
 static const char *huawei_cpin_prefix[] =3D { "^CPIN:", NULL };
+static const char *xpincnt_prefix[] =3D { "+XPINCNT:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -463,21 +464,14 @@ static struct {
 	{ OFONO_SIM_PASSWORD_PHCORP_PUK,	"PH-CORP PUK"	},
 };
 =

-static void huawei_cpin_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+static void pin_retry_cnt_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
 	const char *final =3D g_at_result_final_response(result);
-	GAtResultIter iter;
 	struct ofono_error error;
+	struct sim_data *sd =3D cbd->user;
 	int retries[OFONO_SIM_PASSWORD_INVALID];
-	size_t i;
-	static enum ofono_sim_password_type password_types[] =3D {
-		OFONO_SIM_PASSWORD_SIM_PUK,
-		OFONO_SIM_PASSWORD_SIM_PIN,
-		OFONO_SIM_PASSWORD_SIM_PUK2,
-		OFONO_SIM_PASSWORD_SIM_PIN2,
-	};
 =

 	decode_at_error(&error, final);
 =

@@ -486,34 +480,10 @@ static void huawei_cpin_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 		return;
 	}
 =

-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "^CPIN:"))
-		goto error;
-
-	/* Skip status since we are not interested in this */
-	if (!g_at_result_iter_skip_next(&iter))
-		goto error;
-
-	/* Skip "overall counter" since we'll grab each one individually */
-	if (!g_at_result_iter_skip_next(&iter))
+	if(at_util_parse_pin_retries(result, retries, ARRAY_SIZE(retries),
+					sd->vendor) =3D=3D FALSE)
 		goto error;
 =

-	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
-		retries[i] =3D -1;
-
-	for (i =3D 0; i < ARRAY_SIZE(password_types); i++) {
-		int val;
-
-		if (!g_at_result_iter_next_number(&iter, &val))
-			goto error;
-
-		retries[password_types[i]] =3D val;
-
-		DBG("retry counter id=3D%d, val=3D%d", password_types[i],
-						retries[password_types[i]]);
-	}
-
 	cb(&error, retries, cbd->data);
 =

 	return;
@@ -523,39 +493,40 @@ error:
 }
 =

 static void at_pin_retries_query(struct ofono_sim *sim,
-				ofono_sim_pin_retries_cb_t cb, void *data)
+					ofono_sim_pin_retries_cb_t cb,
+					void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
-	struct cb_data *cbd;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
-	int i;
+	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	DBG("");
 =

-	switch (sd->vendor) {
-	case OFONO_VENDOR_HUAWEI:
-		cbd =3D cb_data_new(cb, data);
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	cbd->user =3D sd;
 =

-		if (cbd =3D=3D NULL) {
-			CALLBACK_WITH_FAILURE(cb, NULL, data);
+	switch (sd->vendor) {
+	case OFONO_VENDOR_IFX:
+		if (g_at_chat_send(sd->chat, "AT+XPINCNT", xpincnt_prefix,
+					pin_retry_cnt_cb, cbd, g_free) > 0)
 			return;
-		}
 =

+		break;
+	case OFONO_VENDOR_HUAWEI:
 		if (g_at_chat_send(sd->chat, "AT^CPIN?", huawei_cpin_prefix,
-					huawei_cpin_cb, cbd, g_free) > 0)
+					pin_retry_cnt_cb, cbd, g_free) > 0)
 			return;
 =

-		g_free(cbd);
-
-		CALLBACK_WITH_FAILURE(cb, NULL, data);
 		break;
-
 	default:
-		for(i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
-			retries[i] =3D -1;
-
-		CALLBACK_WITH_SUCCESS(cb, retries, data);
+		break;
 	}
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
 }
 =

 static void at_cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
-- =

1.7.0.4


--===============2368794146689673073==--

