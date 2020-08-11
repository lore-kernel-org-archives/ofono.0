Content-Type: multipart/mixed; boundary="===============2124393277942884450=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH v2 1/3] Add a vendor OFONO_VENDOR_QUECTEL_EC2X
Date: Tue, 11 Aug 2020 13:42:15 +0200
Message-ID: <20200811114217.370049-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2124393277942884450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

The distinction between OFONO_VENDOR_QUECTEL and
OFONO_VENDOR_QUECTEL_SERIAL does not suffice for EC21/EC25 in some
places, so introduce and use a new vendor:
OFONO_VENDOR_QUECTEL_EC2X
---
 drivers/atmodem/sim.c       | 1 +
 drivers/atmodem/sms.c       | 2 ++
 drivers/atmodem/vendor.h    | 1 +
 drivers/atmodem/voicecall.c | 3 ++-
 plugins/quectel.c           | 2 +-
 5 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index e750a139..6ab91655 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1213,6 +1213,7 @@ static void at_pin_retries_query(struct ofono_sim *si=
m,
 			return;
 		break;
 	case OFONO_VENDOR_QUECTEL:
+	case OFONO_VENDOR_QUECTEL_EC2X:
 		if (g_at_chat_send(sd->chat, "AT+QPINC?", qpinc_prefix,
 					at_qpinc_cb, cbd, g_free) > 0)
 			return;
diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index d502da72..ed3b1370 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -337,6 +337,7 @@ static inline void at_ack_delivery(struct ofono_sms *sm=
s)
 	if (data->cnma_ack_pdu) {
 		switch (data->vendor) {
 		case OFONO_VENDOR_GEMALTO:
+		case OFONO_VENDOR_QUECTEL_EC2X:
 			snprintf(buf, sizeof(buf), "AT+CNMA=3D1");
 			break;
 		case OFONO_VENDOR_QUECTEL_SERIAL:
@@ -845,6 +846,7 @@ static gboolean build_cnmi_string(char *buf, int *cnmi_=
opts,
 	case OFONO_VENDOR_ZTE:
 	case OFONO_VENDOR_SIMCOM:
 	case OFONO_VENDOR_QUECTEL:
+	case OFONO_VENDOR_QUECTEL_EC2X:
 		/* MSM devices advertise support for mode 2, but return an
 		 * error if we attempt to actually use it. */
 		mode =3D "1";
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index d839d1e0..6bac7f89 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -44,6 +44,7 @@ enum ofono_vendor {
 	OFONO_VENDOR_WAVECOM_Q2XXX,
 	OFONO_VENDOR_ALCATEL,
 	OFONO_VENDOR_QUECTEL,
+	OFONO_VENDOR_QUECTEL_EC2X,
 	OFONO_VENDOR_QUECTEL_SERIAL,
 	OFONO_VENDOR_UBLOX,
 	OFONO_VENDOR_XMM,
diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index e7f24b60..4797227e 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -1114,7 +1114,8 @@ static int at_voicecall_probe(struct ofono_voicecall =
*vc, unsigned int vendor,
 	g_at_chat_send(vd->chat, "AT+CLIP=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(vd->chat, "AT+CDIP=3D1", NULL, NULL, NULL, NULL);
 =

-	if (vd->vendor !=3D OFONO_VENDOR_QUECTEL)
+	if ((vd->vendor !=3D OFONO_VENDOR_QUECTEL) &&
+		(vd->vendor !=3D OFONO_VENDOR_QUECTEL_EC2X))
 		g_at_chat_send(vd->chat, "AT+CNAP=3D1", NULL, NULL, NULL, NULL);
 =

 	switch (vd->vendor) {
diff --git a/plugins/quectel.c b/plugins/quectel.c
index 203b702e..8ca901f2 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -1032,7 +1032,7 @@ static void cgmm_cb(int ok, GAtResult *result, void *=
user_data)
 		data->model =3D QUECTEL_MC60;
 	} else if (strcmp(model, "EC21") =3D=3D 0) {
 		DBG("%p model EC21", modem);
-		data->vendor =3D OFONO_VENDOR_QUECTEL;
+		data->vendor =3D OFONO_VENDOR_QUECTEL_EC2X;
 		data->model =3D QUECTEL_EC21;
 	} else {
 		ofono_warn("%p unknown model: '%s'", modem, model);
-- =

2.27.0

--===============2124393277942884450==--

