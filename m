Content-Type: multipart/mixed; boundary="===============5385153221595429582=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v3] Report cell technology capability for Option HSO
Date: Fri, 11 Jun 2010 20:48:03 +0200
Message-ID: <20100611184802.GA4666@cesium.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5385153221595429582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Option modem use OCTI and OUWCTI commands
for reporting the cell capability.
---

Not run or testest because of missing modem.

v3: simplify even more.
v2: simplify v1 and use two callbacks instead of one
v1: do not depend on unsoliced message. use only octi & ouwcti, no ossysi
v0: based on "[RFC v3] Readout technology form Option HSO modems"

 drivers/atmodem/network-registration.c |  205 ++++++++++++++++++++++------=
----
 1 files changed, 142 insertions(+), 63 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index f5ccbb1..f125ba6 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -46,6 +46,7 @@ static const char *creg_prefix[] =3D { "+CREG:", NULL };
 static const char *cops_prefix[] =3D { "+COPS:", NULL };
 static const char *csq_prefix[] =3D { "+CSQ:", NULL };
 static const char *cind_prefix[] =3D { "+CIND:", NULL };
+static const char *option_tech_prefix[] =3D { "_OCTI:", "_OUWCTI:", NULL };
 =

 struct netreg_data {
 	GAtChat *chat;
@@ -58,6 +59,13 @@ struct netreg_data {
 	unsigned int vendor;
 };
 =

+struct tech_query {
+	int status;
+	int lac;
+	int ci;
+	struct ofono_netreg *netreg;
+};
+
 static void extract_mcc_mnc(const char *str, char *mcc, char *mnc)
 {
 	/* Three digit country code */
@@ -69,6 +77,64 @@ static void extract_mcc_mnc(const char *str, char *mcc, =
char *mnc)
 	mnc[OFONO_MAX_MNC_LENGTH] =3D '\0';
 }
 =

+static int option_parse_tech(GAtResult *result)
+{
+	GAtResultIter iter;
+	int s, octi, ouwcti;
+	int tech =3D -1;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "_OCTI:"))
+		return -1;
+
+	if (!g_at_result_iter_next_number(&iter, &s))
+		return -1;
+
+	if (!g_at_result_iter_next_number(&iter, &octi))
+		return -1;
+
+	if (!g_at_result_iter_next(&iter, "_OUWCTI:"))
+		return -1;
+
+	if (!g_at_result_iter_next_number(&iter, &s))
+		return -1;
+
+	if (!g_at_result_iter_next_number(&iter, &ouwcti))
+		return -1;
+
+	switch (octi) {
+	case 1:	/* GSM */
+		tech =3D 0;
+		break;
+	case 2: /* GPRS */
+		tech =3D 1;
+		break;
+	case 3:	/* EDGE */
+		tech =3D 3;
+		break;
+	}
+
+	switch (ouwcti) {
+	case 1: /* UMTS */
+		tech =3D 2;
+		break;
+	case 2: /* HSDPA */
+		tech =3D 4;
+		break;
+	case 3: /* HSUPA */
+		tech =3D 5;
+		break;
+	case 4: /* HSPA */
+		tech =3D 6;
+		break;
+	}
+
+	DBG("octi %d ouwcti %d tech %d", octi, ouwcti, tech);
+
+	return tech;
+}
+
 static void at_creg_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -96,6 +162,28 @@ static void at_creg_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	cb(&error, status, lac, ci, tech, cbd->data);
 }
 =

+static void option_tech_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_netreg *netreg =3D cbd->data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		return;
+
+	nd->tech =3D option_parse_tech(result);
+
+	if (g_at_chat_send(nd->chat, "AT+CREG?", creg_prefix,
+				at_creg_cb, cbd, g_free) > 0)
+		return;
+
+	if (cbd)
+		g_free(cbd);
+}
+
 static void at_registration_status(struct ofono_netreg *netreg,
 					ofono_netreg_status_cb_t cb,
 					void *data)
@@ -125,6 +213,15 @@ static void at_registration_status(struct ofono_netreg=
 *netreg,
 		g_at_chat_send(nd->chat, "AT$CNTI=3D0", none_prefix,
 				NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_OPTION_HSO:
+		/*
+		 * Send AT_OCTI?;_OUWCTI? to find out the current tech,
+		 * option_tech_cb will call fire CREG? to do the rest.
+		 */
+		if (g_at_chat_send(nd->chat, "AT_OCTI?;_OUWCTI?",
+			option_tech_prefix, option_tech_cb, cbd, NULL) > 0)
+			return;
+		goto error;
 	}
 =

 	if (g_at_chat_send(nd->chat, "AT+CREG?", creg_prefix,
@@ -533,38 +630,6 @@ static void option_osigq_notify(GAtResult *result, gpo=
inter user_data)
 				at_util_convert_signal_strength(strength));
 }
 =

-static void option_ouwcti_notify(GAtResult *result, gpointer user_data)
-{
-	int mode;
-	GAtResultIter iter;
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "_OUWCTI:"))
-		return;
-
-	if (!g_at_result_iter_next_number(&iter, &mode))
-		return;
-
-	ofono_info("OWCTI mode: %d", mode);
-}
-
-static void option_octi_notify(GAtResult *result, gpointer user_data)
-{
-	int mode;
-	GAtResultIter iter;
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "_OCTI:"))
-		return;
-
-	if (!g_at_result_iter_next_number(&iter, &mode))
-		return;
-
-	ofono_info("OCTI mode: %d", mode);
-}
-
 static void ciev_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -624,22 +689,6 @@ static void cind_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 	cb(&error, strength, cbd->data);
 }
 =

-static void option_ossysi_notify(GAtResult *result, gpointer user_data)
-{
-	int mode;
-	GAtResultIter iter;
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "_OSSYSI:"))
-		return;
-
-	if (!g_at_result_iter_next_number(&iter, &mode))
-		return;
-
-	ofono_info("OSSYSI mode: %d", mode);
-}
-
 static void huawei_rssi_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -803,15 +852,59 @@ static void nw_cnti_notify(GAtResult *result, gpointe=
r user_data)
 	ofono_info("CNTI: %s", tech);
 }
 =

+static void option_query_tech_cb(gboolean ok,
+			GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct tech_query *tq =3D cbd->data;
+	struct ofono_error error;
+	int tech;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		return;
+
+	tech =3D option_parse_tech(result);
+	ofono_netreg_status_notify(tq->netreg,
+			tq->status, tq->lac, tq->ci, tech);
+
+	g_free(tq);
+}
+
 static void creg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
 	int status, lac, ci, tech;
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct cb_data *cbd;
+	struct tech_query *tq;
 =

 	if (at_util_parse_reg_unsolicited(result, "+CREG:", &status,
-				&lac, &ci, &tech, nd->vendor) =3D=3D FALSE)
+			&lac, &ci, &tech, nd->vendor) =3D=3D FALSE)
+		return;
+
+	switch (nd->vendor) {
+	case OFONO_VENDOR_OPTION_HSO:
+		tq =3D g_new0(struct tech_query, 1);
+		if (!tq)
+			return;
+
+		tq->status =3D status;
+		tq->lac =3D lac;
+		tq->ci =3D ci;
+		tq->netreg =3D netreg;
+
+		cbd =3D cb_data_new(NULL, tq);
+		if (!cbd) {
+			g_free(tq);
+			return;
+		}
+
+		g_at_chat_send(nd->chat, "AT_OCTI?;_OUWCTI?",
+			option_tech_prefix, option_query_tech_cb, cbd, g_free);
 		return;
+	}
 =

 	if ((status =3D=3D 1 || status =3D=3D 5) && tech =3D=3D -1)
 		tech =3D nd->tech;
@@ -909,27 +1002,13 @@ static void at_creg_set_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	case OFONO_VENDOR_OPTION_HSO:
 		g_at_chat_send(nd->chat, "AT_OSSYS=3D1", none_prefix,
 				NULL, NULL, NULL);
-		g_at_chat_send(nd->chat, "AT_OUWCTI=3D1", none_prefix,
-				NULL, NULL, NULL);
-		g_at_chat_send(nd->chat, "AT_OCTI=3D1", none_prefix,
-				NULL, NULL, NULL);
 		g_at_chat_send(nd->chat, "AT_OSQI=3D1", none_prefix,
 				NULL, NULL, NULL);
 		g_at_chat_register(nd->chat, "_OSIGQ:", option_osigq_notify,
 					FALSE, netreg, NULL);
-		g_at_chat_register(nd->chat, "_OUWCTI:", option_ouwcti_notify,
-					FALSE, netreg, NULL);
-		g_at_chat_register(nd->chat, "_OCTI:", option_octi_notify,
-					FALSE, netreg, NULL);
-		g_at_chat_register(nd->chat, "_OSSYSI:", option_ossysi_notify,
-					FALSE, netreg, NULL);
 =

 		g_at_chat_send(nd->chat, "AT_OSSYS?", none_prefix,
 				NULL, NULL, NULL);
-		g_at_chat_send(nd->chat, "AT_OWCTI?", none_prefix,
-				NULL, NULL, NULL);
-		g_at_chat_send(nd->chat, "AT_OCTI?", none_prefix,
-				NULL, NULL, NULL);
 		g_at_chat_send(nd->chat, "AT_OSQI?", none_prefix,
 				NULL, NULL, NULL);
 		break;
-- =

1.6.6.1


--===============5385153221595429582==--

