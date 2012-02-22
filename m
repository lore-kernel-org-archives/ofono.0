Content-Type: multipart/mixed; boundary="===============2585512875978381766=="
MIME-Version: 1.0
From: r.r.zaripov@gmail.com
Subject: [PATCH] sim900: Using AT+SPIC for obtaining times remains input SIM
 PIN/PUK
Date: Wed, 22 Feb 2012 16:18:37 +0400
Message-ID: <1329913117-19530-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2585512875978381766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Renat Zaripov <r.r.zaripov@gmail.com>

In SIMCOM SIM900 not implemented AT+CPINR, but possible use AT+SPIC
instead this one.

AT+SPIC Times Remained to Input SIM PIN/PUK

+SPIC: <pin1>,<pin2>,<puk1>,<puk2>

Parameters
<pin1> Times remained to input chv1
<pin2> Times remained to input chv2
<puk1> Times remained to input puk1
<puk2> Times remained to input puk2
---
 drivers/atmodem/sim.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 plugins/sim900.c      |    2 +-
 2 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 8edd582..8ee9822 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -62,6 +62,7 @@ static const char *zpinpuk_prefix[] =3D { "+ZPINPUK:", NU=
LL };
 static const char *oercn_prefix[] =3D { "_OERCN:", NULL };
 static const char *cpinr_prefixes[] =3D { "+CPINR:", "+CPINRE:", NULL };
 static const char *epin_prefix[] =3D { "*EPIN:", NULL };
+static const char *spic_prefix[] =3D { "+SPIC:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -800,6 +801,45 @@ static void at_cpinr_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	cb(&error, retries, cbd->data);
 }
 =

+static void at_spic_cb(gboolean ok, GAtResult *result, gpointer user_data)
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
+		OFONO_SIM_PASSWORD_SIM_PIN2,
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
+	if (!g_at_result_iter_next(&iter, "+SPIC:"))
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
@@ -840,6 +880,11 @@ static void at_pin_retries_query(struct ofono_sim *sim,
 					at_epin_cb, cbd, g_free) > 0)
 			return;
 		break;
+	case OFONO_VENDOR_SIMCOM:
+		if (g_at_chat_send(sd->chat, "AT+SPIC", spic_prefix,
+					at_spic_cb, cbd, g_free) > 0)
+			return;
+		break;
 	default:
 		if (g_at_chat_send(sd->chat, "AT+CPINR", cpinr_prefixes,
 					at_cpinr_cb, cbd, g_free) > 0)
diff --git a/plugins/sim900.c b/plugins/sim900.c
index bc5f9c5..87d640f 100644
--- a/plugins/sim900.c
+++ b/plugins/sim900.c
@@ -210,7 +210,7 @@ static void sim900_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->modem);
-	sim =3D ofono_sim_create(modem, 0, "atmodem", data->modem);
+	sim =3D ofono_sim_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->mod=
em);
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
-- =

1.7.7.3


--===============2585512875978381766==--

