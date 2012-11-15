Content-Type: multipart/mixed; boundary="===============8006128892589771437=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: [PATCH] atmodem: add PIN retry count for Alcatel modems.
Date: Thu, 15 Nov 2012 09:35:51 +0100
Message-ID: <1352968551-26914-1-git-send-email-cedric.jehasse@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8006128892589771437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Cedric Jehasse <cedric.jehasse@softathome.com>

---
 drivers/atmodem/sim.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 9f05f4b..7e2b373 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -66,6 +66,7 @@ static const char *cpinr_prefixes[] =3D { "+CPINR:", "+CP=
INRE:", NULL };
 static const char *epin_prefix[] =3D { "*EPIN:", NULL };
 static const char *spic_prefix[] =3D { "+SPIC:", NULL };
 static const char *pct_prefix[] =3D { "#PCT:", NULL };
+static const char *pnnm_prefix[] =3D { "+PNNM:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -899,6 +900,43 @@ error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 }
 =

+static void at_pnnm_cb(gboolean ok, GAtResult *result, gpointer user_data)
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
+		OFONO_SIM_PASSWORD_SIM_PUK,
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
+	if (!g_at_result_iter_next(&iter, "+PNNM:"))
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
@@ -955,6 +993,11 @@ static void at_pin_retries_query(struct ofono_sim *sim,
 					at_pct_cb, cbd, g_free) > 0)
 			return;
 		break;
+	case OFONO_VENDOR_ALCATEL:
+		if (g_at_chat_send(sd->chat, "AT+PNNM?", pnnm_prefix,
+					at_pnnm_cb, cbd, g_free) > 0)
+			return;
+		break;
 	default:
 		if (g_at_chat_send(sd->chat, "AT+CPINR", cpinr_prefixes,
 					at_cpinr_cb, cbd, g_free) > 0)
-- =

1.7.1


--===============8006128892589771437==--

