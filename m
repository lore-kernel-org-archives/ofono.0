Content-Type: multipart/mixed; boundary="===============1985306670352272842=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 4/4] sim: query Quectel UC15 PIN retries with AT+QPINQ
Date: Tue, 24 Jun 2014 12:08:42 +0200
Message-ID: <1403604522-22645-5-git-send-email-philip@paeps.cx>
In-Reply-To: <1403604522-22645-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1985306670352272842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c |   49 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index f8e0472..4a91798 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -67,6 +67,7 @@ static const char *epin_prefix[] =3D { "*EPIN:", NULL };
 static const char *spic_prefix[] =3D { "+SPIC:", NULL };
 static const char *pct_prefix[] =3D { "#PCT:", NULL };
 static const char *pnnm_prefix[] =3D { "+PNNM:", NULL };
+static const char *qpinc_prefix[] =3D { "+QPINC:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -967,6 +968,49 @@ error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 }
 =

+static void at_qpinc_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
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
+	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
+		retries[i] =3D -1;
+
+	g_at_result_iter_init(&iter, result);
+	while (g_at_result_iter_next(&iter, "+QPINC:")) {
+		const char *name;
+		int pin, puk;
+
+		if (!g_at_result_iter_next_string(&iter, &name))
+			continue;
+		if (!g_at_result_iter_next_number(&iter, &pin))
+			continue;
+		if (!g_at_result_iter_next_number(&iter, &puk))
+			continue;
+
+		if (!strcmp(name, "SC")) {
+			retries[OFONO_SIM_PASSWORD_SIM_PIN] =3D pin;
+			retries[OFONO_SIM_PASSWORD_SIM_PUK] =3D puk;
+		} else if (!strcmp(name, "P2")) {
+			retries[OFONO_SIM_PASSWORD_SIM_PIN2] =3D pin;
+			retries[OFONO_SIM_PASSWORD_SIM_PUK2] =3D puk;
+		}
+	}
+	cb(&error, retries, cbd->data);
+}
+
 static void at_pin_retries_query(struct ofono_sim *sim,
 					ofono_sim_pin_retries_cb_t cb,
 					void *data)
@@ -1028,6 +1072,11 @@ static void at_pin_retries_query(struct ofono_sim *s=
im,
 					at_pnnm_cb, cbd, g_free) > 0)
 			return;
 		break;
+	case OFONO_VENDOR_QUECTEL:
+		if (g_at_chat_send(sd->chat, "AT+QPINC?", qpinc_prefix,
+					at_qpinc_cb, cbd, g_free) > 0)
+			return;
+		break;
 	default:
 		if (g_at_chat_send(sd->chat, "AT+CPINR", cpinr_prefixes,
 					at_cpinr_cb, cbd, g_free) > 0)
-- =

1.7.10.4


--===============1985306670352272842==--

