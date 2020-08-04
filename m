Content-Type: multipart/mixed; boundary="===============7879612216755283835=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 1/5] Add a vendor OFONO_VENDOR_QUECTEL_EC2X
Date: Tue, 04 Aug 2020 14:38:45 +0200
Message-ID: <20200804123849.909105-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7879612216755283835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

The distinction between OFONO_VENDOR_QUECTEL and
OFONO_VENDOR_QUECTEL_SERIAL does not suffice for EC21/EC25 in some
places, so introduce and use a new vendor:
OFONO_VENDOR_QUECTEL_EC2X
---
 drivers/atmodem/lte.c       | 2 +-
 drivers/atmodem/sim.c       | 1 +
 drivers/atmodem/sms.c       | 2 ++
 drivers/atmodem/vendor.h    | 1 +
 drivers/atmodem/voicecall.c | 3 ++-
 plugins/quectel.c           | 2 +-
 6 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/lte.c b/drivers/atmodem/lte.c
index 4c21f822..b55b03c8 100644
--- a/drivers/atmodem/lte.c
+++ b/drivers/atmodem/lte.c
@@ -118,7 +118,7 @@ static void at_lte_set_default_attach_info(const struct=
 ofono_lte *lte,
 =

 	ldd->cid =3D 0;
 =

-	if (ldd->vendor =3D=3D OFONO_VENDOR_QUECTEL) {
+	if (ldd->vendor =3D=3D OFONO_VENDOR_QUECTEL_EC2X) {
 		atom =3D __ofono_modem_find_atom(ofono_lte_get_modem(lte), OFONO_ATOM_TY=
PE_GPRS);
 		if (atom !=3D NULL) {
 			struct ofono_gprs *gprs =3D __ofono_atom_get_data(atom);
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
index 871c7af2..feddb378 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -1060,7 +1060,7 @@ static void cgmm_cb(int ok, GAtResult *result, void *=
user_data)
 		data->model =3D QUECTEL_MC60;
 	} else if (strcmp(model, "EC21") =3D=3D 0) {
 		DBG("%p model EC21", modem);
-		data->vendor =3D OFONO_VENDOR_QUECTEL;
+		data->vendor =3D OFONO_VENDOR_QUECTEL_EC2X;
 		data->model =3D QUECTEL_EC21;
 		/*
 		data->mux_order =3D mux_order_ec21;
-- =

2.27.0

--===============7879612216755283835==--

