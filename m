Content-Type: multipart/mixed; boundary="===============5490788148966228312=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv2 1/2] atmodem: add Quectel M95 special case for PIN query
Date: Tue, 28 Aug 2018 09:45:39 +0200
Message-ID: <20180828074540.21858-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5490788148966228312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The AT command reference for Quectel M95 specifies that remaining SIM
pin retires can be queried using AT+QTRPIN, which responds with one
count for each pin-type:

+QTRPIN: 3,3,10,10

After entering the PIN code, enable an extra AT+CPIN? for the M95
vendor.

---
Changes since v1:

 * Add quirk to resend AT+CPIN? after sending pin code

 drivers/atmodem/sim.c    | 50 ++++++++++++++++++++++++++++++++++++++++
 drivers/atmodem/vendor.h |  1 +
 2 files changed, 51 insertions(+)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 10dc8009..0907635d 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -70,6 +70,7 @@ static const char *cinterion_spic_prefix[] =3D { "^SPIC:"=
, NULL };
 static const char *pct_prefix[] =3D { "#PCT:", NULL };
 static const char *pnnm_prefix[] =3D { "+PNNM:", NULL };
 static const char *qpinc_prefix[] =3D { "+QPINC:", NULL };
+static const char *qtrpin_prefix[] =3D { "+QTRPIN:", NULL };
 static const char *upincnt_prefix[] =3D { "+UPINCNT:", NULL };
 static const char *cuad_prefix[] =3D { "+CUAD:", NULL };
 static const char *ccho_prefix[] =3D { "+CCHO:", NULL };
@@ -982,6 +983,49 @@ error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 }
 =

+static void at_qtrpin_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
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
+
+	while (g_at_result_iter_next(&iter, "+QTRPIN:")) {
+		int pin, pin2, puk, puk2;
+
+		if (!g_at_result_iter_next_number(&iter, &pin))
+			continue;
+		if (!g_at_result_iter_next_number(&iter, &pin2))
+			continue;
+		if (!g_at_result_iter_next_number(&iter, &puk))
+			continue;
+		if (!g_at_result_iter_next_number(&iter, &puk2))
+			continue;
+
+		retries[OFONO_SIM_PASSWORD_SIM_PIN] =3D pin;
+		retries[OFONO_SIM_PASSWORD_SIM_PUK] =3D puk;
+		retries[OFONO_SIM_PASSWORD_SIM_PIN2] =3D pin2;
+		retries[OFONO_SIM_PASSWORD_SIM_PUK2] =3D puk2;
+	}
+
+	cb(&error, retries, cbd->data);
+}
+
 static void at_qpinc_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -1172,6 +1216,11 @@ static void at_pin_retries_query(struct ofono_sim *s=
im,
 					at_qpinc_cb, cbd, g_free) > 0)
 			return;
 		break;
+	case OFONO_VENDOR_QUECTEL_M95:
+		if (g_at_chat_send(sd->chat, "AT+QTRPIN", qtrpin_prefix,
+					at_qtrpin_cb, cbd, g_free) > 0)
+			return;
+		break;
 	case OFONO_VENDOR_UBLOX:
 	case OFONO_VENDOR_UBLOX_TOBY_L2:
 		if (g_at_chat_send(sd->chat, "AT+UPINCNT", upincnt_prefix,
@@ -1305,6 +1354,7 @@ static void at_pin_send_cb(gboolean ok, GAtResult *re=
sult,
 	case OFONO_VENDOR_HUAWEI:
 	case OFONO_VENDOR_SIMCOM:
 	case OFONO_VENDOR_SIERRA:
+	case OFONO_VENDOR_QUECTEL_M95:
 		/*
 		 * On ZTE modems, after pin is entered, SIM state is checked
 		 * by polling CPIN as their modem doesn't provide unsolicited
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index d52ad521..721796e4 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -44,6 +44,7 @@ enum ofono_vendor {
 	OFONO_VENDOR_WAVECOM_Q2XXX,
 	OFONO_VENDOR_ALCATEL,
 	OFONO_VENDOR_QUECTEL,
+	OFONO_VENDOR_QUECTEL_M95,
 	OFONO_VENDOR_UBLOX,
 	OFONO_VENDOR_UBLOX_TOBY_L2,
 	OFONO_VENDOR_CINTERION,
-- =

2.18.0


--===============5490788148966228312==--

