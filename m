Content-Type: multipart/mixed; boundary="===============5300027970659928204=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH 3/3] sim: support PIN retry counters for telit modems
Date: Thu, 16 Aug 2012 09:37:20 +0200
Message-ID: <1345102640-8465-3-git-send-email-christopher.vogl@hale.at>
In-Reply-To: <50292E2D.8040403@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5300027970659928204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: August Mayer <august.mayer@hale.at>

---
 drivers/atmodem/sim.c |   61 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 7b48cd9..8823ee7 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -65,6 +65,7 @@ static const char *oercn_prefix[] =3D { "_OERCN:", NULL };
 static const char *cpinr_prefixes[] =3D { "+CPINR:", "+CPINRE:", NULL };
 static const char *epin_prefix[] =3D { "*EPIN:", NULL };
 static const char *spic_prefix[] =3D { "+SPIC:", NULL };
+static const char *pct_prefix[] =3D { "#PCT:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -841,12 +842,67 @@ error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 }
 =

+#define AT_PCT_SET_RETRIES(retries, pin_type, value) \
+	retries[pin_type] =3D value; \
+	DBG("retry counter id=3D%d, val=3D%d", pin_type, value);
+	=

+static void at_pct_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
+	struct ofono_sim *sim =3D cbd->user;
+	const char *final =3D g_at_result_final_response(result);
+	GAtResultIter iter;
+	struct ofono_error error;
+	int retries[OFONO_SIM_PASSWORD_INVALID];
+	size_t i;
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
+	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
+		retries[i] =3D -1;
+
+	enum ofono_sim_password_type pin_type =3D ofono_sim_get_password_type(sim=
);
+	if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE) {
+		DBG("Note: No password required, returning maximum retries:");
+		AT_PCT_SET_RETRIES(retries, OFONO_SIM_PASSWORD_SIM_PIN, 3);
+		AT_PCT_SET_RETRIES(retries, OFONO_SIM_PASSWORD_SIM_PIN2, 3);
+		AT_PCT_SET_RETRIES(retries, OFONO_SIM_PASSWORD_SIM_PUK, 10);
+		AT_PCT_SET_RETRIES(retries, OFONO_SIM_PASSWORD_SIM_PUK2, 10);
+		goto callback;
+	}
+
+	if (g_at_result_iter_next(&iter, "#PCT:") =3D=3D FALSE)
+		goto error;
+	=

+	if (g_at_result_iter_next_number(&iter, &retries[pin_type]) =3D=3D FALSE)
+		goto error; =

+
+	DBG("retry counter id=3D%d, val=3D%d", pin_type, retries[pin_type]);
+
+callback:
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
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
+	cbd->user =3D sim;
 =

 	DBG("");
 =

@@ -891,6 +947,11 @@ static void at_pin_retries_query(struct ofono_sim *sim,
 					at_spic_cb, cbd, g_free) > 0)
 			return;
 		break;
+	case OFONO_VENDOR_TELIT:
+		if (g_at_chat_send(sd->chat, "AT#PCT", pct_prefix,
+					at_pct_cb, cbd, g_free) > 0)
+			return;
+		break;
 	default:
 		if (g_at_chat_send(sd->chat, "AT+CPINR", cpinr_prefixes,
 					at_cpinr_cb, cbd, g_free) > 0)
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============5300027970659928204==--

