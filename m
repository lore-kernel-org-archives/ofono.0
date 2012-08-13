Content-Type: multipart/mixed; boundary="===============2194395509457942155=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH 3/8] sim: support PIN retry counters for telit modems
Date: Mon, 13 Aug 2012 15:21:22 +0200
Message-ID: <1344864082-23021-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2194395509457942155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: August Mayer <august.mayer@hale.at>

---
 drivers/atmodem/sim.c |   57 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/sim.h         |    2 +
 src/sim.c             |    8 +++++++
 3 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 7b48cd9..81f4416 100644
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
@@ -841,12 +842,63 @@ error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 }
 =

+#define AT_PCT_SET_RETRIES(retries, pin_type, value) \
+	retries[pin_type] =3D value; \
+	DBG("retry counter id=3D%d, val=3D%d", pin_type, value);
+
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
+
+	} else if (g_at_result_iter_next(&iter, "#PCT:") &&
+			g_at_result_iter_next_number(&iter, &retries[pin_type])) {
+		DBG("retry counter id=3D%d, val=3D%d", pin_type, retries[pin_type]);
+	}
+	else
+		goto error;
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
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
+	cbd->user =3D sim;	=

 =

 	DBG("");
 =

@@ -891,6 +943,11 @@ static void at_pin_retries_query(struct ofono_sim *sim,
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
diff --git a/include/sim.h b/include/sim.h
index 508ff24..3e5797c 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -189,6 +189,8 @@ enum ofono_sim_phase ofono_sim_get_phase(struct ofono_s=
im *sim);
 enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(struct ofono_sim *sim);
 const unsigned char *ofono_sim_get_cphs_service_table(struct ofono_sim *si=
m);
 =

+enum ofono_sim_password_type ofono_sim_get_password_type(struct ofono_sim =
*sim);
+
 unsigned int ofono_sim_add_state_watch(struct ofono_sim *sim,
 					ofono_sim_state_event_cb_t cb,
 					void *data, ofono_destroy_func destroy);
diff --git a/src/sim.c b/src/sim.c
index 4384eb0..8059d2b 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2243,6 +2243,14 @@ enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(s=
truct ofono_sim *sim)
 	return sim->cphs_phase;
 }
 =

+enum ofono_sim_password_type ofono_sim_get_password_type(struct ofono_sim =
*sim)
+{
+	if (sim =3D=3D NULL)
+		return OFONO_SIM_PASSWORD_NONE;
+
+	return sim->pin_type;
+}
+
 const unsigned char *ofono_sim_get_cphs_service_table(struct ofono_sim *si=
m)
 {
 	if (sim =3D=3D NULL)
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============2194395509457942155==--

