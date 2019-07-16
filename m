Content-Type: multipart/mixed; boundary="===============9039748521220075053=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 2/7] atmodem: rename OFONO_VENDOR_QUECTEL_M95 to
 OFONO_VENDOR_QUECTEL_SERIAL
Date: Tue, 16 Jul 2019 21:10:48 +0200
Message-ID: <20190716191053.71990-2-martin@geanix.com>
In-Reply-To: <20190716191053.71990-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9039748521220075053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Other serial connected modems (i.e the MC60 model) from is AT-compatible
with the M95 model, so rename the M95 vendor id to be common for both.
---
 drivers/atmodem/sim.c    | 4 ++--
 drivers/atmodem/sms.c    | 4 ++--
 drivers/atmodem/vendor.h | 2 +-
 plugins/quectel.c        | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 520b3dbf..dd42cac4 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1217,7 +1217,7 @@ static void at_pin_retries_query(struct ofono_sim *si=
m,
 					at_qpinc_cb, cbd, g_free) > 0)
 			return;
 		break;
-	case OFONO_VENDOR_QUECTEL_M95:
+	case OFONO_VENDOR_QUECTEL_SERIAL:
 		if (g_at_chat_send(sd->chat, "AT+QTRPIN", qtrpin_prefix,
 					at_qtrpin_cb, cbd, g_free) > 0)
 			return;
@@ -1354,7 +1354,7 @@ static void at_pin_send_cb(gboolean ok, GAtResult *re=
sult,
 	case OFONO_VENDOR_HUAWEI:
 	case OFONO_VENDOR_SIMCOM:
 	case OFONO_VENDOR_SIERRA:
-	case OFONO_VENDOR_QUECTEL_M95:
+	case OFONO_VENDOR_QUECTEL_SERIAL:
 		/*
 		 * On ZTE modems, after pin is entered, SIM state is checked
 		 * by polling CPIN as their modem doesn't provide unsolicited
diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index c3c82afb..442cfc58 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -339,7 +339,7 @@ static inline void at_ack_delivery(struct ofono_sms *sm=
s)
 		case OFONO_VENDOR_GEMALTO:
 			snprintf(buf, sizeof(buf), "AT+CNMA=3D1");
 			break;
-		case OFONO_VENDOR_QUECTEL_M95:
+		case OFONO_VENDOR_QUECTEL_SERIAL:
 			snprintf(buf, sizeof(buf), "AT+CNMA");
 			break;
 		default:
@@ -1289,7 +1289,7 @@ static void at_csms_query_cb(gboolean ok, GAtResult *=
result,
 		goto out;
 =

 	switch (data->vendor) {
-	case OFONO_VENDOR_QUECTEL_M95:
+	case OFONO_VENDOR_QUECTEL_SERIAL:
 		g_at_result_iter_next_number(&iter, &status_min);
 		g_at_result_iter_next_number(&iter, &status_max);
 		if (status_min <=3D 1 && 1 <=3D status_max)
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index 10c04315..d839d1e0 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -44,7 +44,7 @@ enum ofono_vendor {
 	OFONO_VENDOR_WAVECOM_Q2XXX,
 	OFONO_VENDOR_ALCATEL,
 	OFONO_VENDOR_QUECTEL,
-	OFONO_VENDOR_QUECTEL_M95,
+	OFONO_VENDOR_QUECTEL_SERIAL,
 	OFONO_VENDOR_UBLOX,
 	OFONO_VENDOR_XMM,
 	OFONO_VENDOR_GEMALTO,
diff --git a/plugins/quectel.c b/plugins/quectel.c
index 11b864bc..f2b765b6 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -330,7 +330,7 @@ static void cgmm_cb(int ok, GAtResult *result, void *us=
er_data)
 		data->vendor =3D OFONO_VENDOR_QUECTEL;
 	} else if (strcmp(model, "Quectel_M95") =3D=3D 0) {
 		DBG("%p model M95", modem);
-		data->vendor =3D OFONO_VENDOR_QUECTEL_M95;
+		data->vendor =3D OFONO_VENDOR_QUECTEL_SERIAL;
 	} else {
 		ofono_warn("%p unknown model: '%s'", modem, model);
 		data->vendor =3D OFONO_VENDOR_QUECTEL;
-- =

2.22.0


--===============9039748521220075053==--

