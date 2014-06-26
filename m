Content-Type: multipart/mixed; boundary="===============2196862469327356581=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 4/6] sim: query u-blox PIN retries with AT+UPINCNT
Date: Thu, 26 Jun 2014 20:28:16 +0200
Message-ID: <1403807298-14588-5-git-send-email-philip@paeps.cx>
In-Reply-To: <1403807298-14588-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2196862469327356581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index f8e0472..9b8d176 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -67,6 +67,7 @@ static const char *epin_prefix[] =3D { "*EPIN:", NULL };
 static const char *spic_prefix[] =3D { "+SPIC:", NULL };
 static const char *pct_prefix[] =3D { "#PCT:", NULL };
 static const char *pnnm_prefix[] =3D { "+PNNM:", NULL };
+static const char *upincnt_prefix[] =3D { "+UPINCNT:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -967,6 +968,45 @@ error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 }
 =

+static void upincnt_cb(gboolean ok, GAtResult *result, gpointer user_data)
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
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+UPINCNT:"))
+		goto error;
+
+	BUILD_PIN_RETRIES_ARRAY(password_types, ARRAY_SIZE(password_types),
+				retries);
+
+	cb(&error, retries, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
 static void at_pin_retries_query(struct ofono_sim *sim,
 					ofono_sim_pin_retries_cb_t cb,
 					void *data)
@@ -1028,6 +1068,11 @@ static void at_pin_retries_query(struct ofono_sim *s=
im,
 					at_pnnm_cb, cbd, g_free) > 0)
 			return;
 		break;
+	case OFONO_VENDOR_UBLOX:
+		if (g_at_chat_send(sd->chat, "AT+UPINCNT", upincnt_prefix,
+					upincnt_cb, cbd, g_free) > 0)
+			return;
+		break;
 	default:
 		if (g_at_chat_send(sd->chat, "AT+CPINR", cpinr_prefixes,
 					at_cpinr_cb, cbd, g_free) > 0)
-- =

1.7.10.4


--===============2196862469327356581==--

