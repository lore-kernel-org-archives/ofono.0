Content-Type: multipart/mixed; boundary="===============5526836329454339128=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v4 1/1] atmodem: add ifx support for pin retry count
Date: Wed, 19 Jan 2011 10:34:53 -0800
Message-ID: <1295462093-9537-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1295462093-9537-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5526836329454339128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c |   96 +++++++++++++++++++++++++++++++++++----------=
----
 1 files changed, 69 insertions(+), 27 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 8d89d53..7617d99 100644
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
@@ -463,6 +464,22 @@ static struct {
 	{ OFONO_SIM_PASSWORD_PHCORP_PUK,	"PH-CORP PUK"	},
 };
 =

+#define BUILD_PIN_RETRIES_ARRAY(passwd_types, passwd_types_cnt, retry)	\
+	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)		\
+		retry[i] =3D -1;						\
+									\
+	for (i =3D 0; i < passwd_types_cnt; i++) {			\
+		int val;						\
+									\
+		if (!g_at_result_iter_next_number(&iter, &val))		\
+			goto error;					\
+									\
+		retry[passwd_types[i]] =3D val;				\
+									\
+		DBG("retry counter id=3D%d, val=3D%d", passwd_types[i],	\
+					retry[passwd_types[i]]);	\
+	}								\
+
 static void huawei_cpin_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct cb_data *cbd =3D user_data;
@@ -499,21 +516,48 @@ static void huawei_cpin_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	if (!g_at_result_iter_skip_next(&iter))
 		goto error;
 =

-	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
-		retries[i] =3D -1;
+	BUILD_PIN_RETRIES_ARRAY(password_types, ARRAY_SIZE(password_types),
+				retries);
 =

-	for (i =3D 0; i < ARRAY_SIZE(password_types); i++) {
-		int val;
+	cb(&error, retries, cbd->data);
 =

-		if (!g_at_result_iter_next_number(&iter, &val))
-			goto error;
+	return;
 =

-		retries[password_types[i]] =3D val;
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
 =

-		DBG("retry counter id=3D%d, val=3D%d", password_types[i],
-						retries[password_types[i]]);
+static void xpincnt_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
+	const char *final =3D g_at_result_final_response(result);
+	GAtResultIter iter;
+	struct ofono_error error;
+	int retries[OFONO_SIM_PASSWORD_INVALID];
+	size_t i;
+	static enum ofono_sim_password_type password_types[] =3D {
+		OFONO_SIM_PASSWORD_SIM_PIN,
+		OFONO_SIM_PASSWORD_SIM_PIN2,
+		OFONO_SIM_PASSWORD_SIM_PUK,
+		OFONO_SIM_PASSWORD_SIM_PUK2,
+	};
+
+	decode_at_error(&error, final);
+
+	if (!ok) {
+		cb(&error, NULL, cbd->data);
+		return;
 	}
 =

+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XPINCNT:"))
+		goto error;
+
+	BUILD_PIN_RETRIES_ARRAY(password_types, ARRAY_SIZE(password_types),
+				retries);
+
 	cb(&error, retries, cbd->data);
 =

 	return;
@@ -523,39 +567,37 @@ error:
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
 =

-		if (cbd =3D=3D NULL) {
-			CALLBACK_WITH_FAILURE(cb, NULL, data);
+	switch (sd->vendor) {
+	case OFONO_VENDOR_IFX:
+		if (g_at_chat_send(sd->chat, "AT+XPINCNT", xpincnt_prefix,
+					xpincnt_cb, cbd, g_free) > 0)
 			return;
-		}
 =

+		break;
+	case OFONO_VENDOR_HUAWEI:
 		if (g_at_chat_send(sd->chat, "AT^CPIN?", huawei_cpin_prefix,
 					huawei_cpin_cb, cbd, g_free) > 0)
 			return;
 =

-		g_free(cbd);
-
-		CALLBACK_WITH_FAILURE(cb, NULL, data);
+	default:
 		break;
+	}
 =

-	default:
-		for(i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
-			retries[i] =3D -1;
+error:
+	g_free(cbd);
 =

-		CALLBACK_WITH_SUCCESS(cb, retries, data);
-	}
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
 }
 =

 static void at_cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
-- =

1.7.0.4


--===============5526836329454339128==--

