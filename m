Content-Type: multipart/mixed; boundary="===============9046590365928279002=="
MIME-Version: 1.0
From: Sebastian Arnd <sebastian.arnd@gemalto.com>
Subject: [PATCH v2 3/3] gemalto: add PLS8 support
Date: Wed, 30 Aug 2017 18:30:05 +0200
Message-ID: <1504110605-22509-3-git-send-email-sebastian.arnd@gemalto.com>
In-Reply-To: <1504110605-22509-1-git-send-email-sebastian.arnd@gemalto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9046590365928279002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 7c33c22..17d0be9 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -64,7 +64,7 @@ static const char *pinnum_prefix[] =3D { "%PINNUM:", NULL=
 };
 static const char *oercn_prefix[] =3D { "_OERCN:", NULL };
 static const char *cpinr_prefixes[] =3D { "+CPINR:", "+CPINRE:", NULL };
 static const char *epin_prefix[] =3D { "*EPIN:", NULL };
-static const char *spic_prefix[] =3D { "+SPIC:", NULL };
+static const char *spic_prefix[] =3D { "+SPIC:", "^SPIC:", NULL };
 static const char *pct_prefix[] =3D { "#PCT:", NULL };
 static const char *pnnm_prefix[] =3D { "+PNNM:", NULL };
 static const char *qpinc_prefix[] =3D { "+QPINC:", NULL };
@@ -875,6 +875,62 @@ error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 }
 =

+static void at_spic_gemalto_cb(gboolean ok, GAtResult *result,
+							gpointer user_data)
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
+		OFONO_SIM_PASSWORD_PHSIM_PIN,
+		OFONO_SIM_PASSWORD_PHFSIM_PUK,
+		OFONO_SIM_PASSWORD_SIM_PIN2,
+		OFONO_SIM_PASSWORD_SIM_PUK2,
+		OFONO_SIM_PASSWORD_PHNET_PIN,
+		OFONO_SIM_PASSWORD_PHNET_PUK,
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
+	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
+		retries[i] =3D -1;
+
+	for (i =3D 0; i <  ARRAY_SIZE(password_types); i++) {
+		int val;
+
+		if (!g_at_result_iter_next(&iter, "^SPIC:"))
+			goto error;
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			goto error;
+
+		retries[password_types[i]] =3D val;
+
+		DBG("retry counter id=3D%d, val=3D%d", password_types[i],
+						retries[password_types[i]]);
+	}
+
+	cb(&error, retries, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
 #define AT_PCT_SET_RETRIES(retries, pin_type, value) \
 	retries[pin_type] =3D value; \
 	DBG("retry counter id=3D%d, val=3D%d", pin_type, value);
@@ -1104,6 +1160,18 @@ static void at_pin_retries_query(struct ofono_sim *s=
im,
 					at_spic_cb, cbd, g_free) > 0)
 			return;
 		break;
+	case OFONO_VENDOR_CINTERION:
+		if (g_at_chat_send(sd->chat, "AT^SPIC=3D\"SC\",0;"
+					 " ^SPIC=3D\"SC\",1;"
+					 " ^SPIC=3D\"PS\",0;"
+					 " ^SPIC=3D\"PS\",1;"
+					 " ^SPIC=3D\"P2\",0;"
+					 " ^SPIC=3D\"P2\",1;"
+					 " ^SPIC=3D\"PN\",0;"
+					 " ^SPIC=3D\"PN\",1",
+			     spic_prefix, at_spic_gemalto_cb, cbd, g_free) > 0)
+			return;
+		break;
 	case OFONO_VENDOR_TELIT:
 		if (g_at_chat_send(sd->chat, "AT#PCT", pct_prefix,
 					at_pct_cb, cbd, g_free) > 0)
-- =

2.1.4


--===============9046590365928279002==--

