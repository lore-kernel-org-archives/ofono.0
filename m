Content-Type: multipart/mixed; boundary="===============9124390688708989712=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v1] Report cell technology capability for Option HSO modems
Date: Fri, 11 Jun 2010 17:16:09 +0200
Message-ID: <20100611151609.GA24970@pc0043.bmw-carit.intra>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9124390688708989712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Option modem use OCTI and OUWCTI commands
for reporting the cell capability.
---

This patch needs some more testing. =


v1: do not depend on unsoliced message. use only octi & ouwcti, no ossysi
v0: based on "[RFC v3] Readout technology form Option HSO modems"

 drivers/atmodem/atutil.c               |   29 +++++
 drivers/atmodem/atutil.h               |    3 +-
 drivers/atmodem/network-registration.c |  179 ++++++++++++++++++----------=
---
 3 files changed, 135 insertions(+), 76 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index e238f45..4971acd 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -287,3 +287,32 @@ out:
 =

 	return FALSE;
 }
+
+gboolean at_util_parse_option_tech(GAtResult *result,
+				int *octi, int *ouwcti)
+{
+	GAtResultIter iter;
+	int s;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "_OCTI:") =3D=3D FALSE)
+		return FALSE;
+
+	if (g_at_result_iter_next_number(&iter, &s) =3D=3D FALSE)
+		return FALSE;
+
+	if (g_at_result_iter_next_number(&iter, octi) =3D=3D FALSE)
+		return FALSE;
+
+	if (g_at_result_iter_next(&iter, "_OUWCTI:") =3D=3D FALSE)
+		return FALSE;
+
+	if (g_at_result_iter_next_number(&iter, &s) =3D=3D FALSE)
+		return FALSE;
+
+	if (g_at_result_iter_next_number(&iter, ouwcti) =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 265a5ad..d181ad2 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -33,6 +33,8 @@ gboolean at_util_parse_reg_unsolicited(GAtResult *result,=
 const char *prefix,
 					int *status, int *lac,
 					int *ci, int *tech,
 					unsigned int vendor);
+gboolean at_util_parse_option_tech(GAtResult *result,
+				int *octi, int *ouwcti);
 =

 struct cb_data {
 	void *cb;
@@ -88,4 +90,3 @@ static inline int at_util_convert_signal_strength(int str=
ength)
 		e.error =3D 0;				\
 		f(&e, ##args);				\
 	} while(0)					\
-
diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index f5ccbb1..a5b2389 100644
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
@@ -54,6 +55,9 @@ struct netreg_data {
 	int signal_index; /* If strength is reported via CIND */
 	int signal_min; /* min strength reported via CIND */
 	int signal_max; /* max strength reported via CIND */
+	int status;
+	int lac;
+	int ci;
 	int tech;
 	unsigned int vendor;
 };
@@ -69,11 +73,68 @@ static void extract_mcc_mnc(const char *str, char *mcc,=
 char *mnc)
 	mnc[OFONO_MAX_MNC_LENGTH] =3D '\0';
 }
 =

+static void option_status_notify_cb(const struct ofono_error *error,
+					int status, int lac, int ci, int tech,
+					void *data)
+{
+	struct ofono_netreg *netreg =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		return;
+
+	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
+}
+
+static void option_tech_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netreg_status_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	struct netreg_data *nd =3D cbd->user;
+	int octi, ouwcti;
+	int tech =3D -1;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, -1, -1, -1, cbd->data);
+		return;
+	}
+
+	if (at_util_parse_option_tech(result, &octi, &ouwcti) =3D=3D FALSE) {
+		CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, cbd->data);
+		return;
+	}
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
+	}
+
+	switch (ouwcti) {
+	case 1: /* UMTS */
+	case 2: /* HSDPA */
+	case 3: /* HSUPA */
+	case 4: /* HSPA */
+		tech =3D 2;
+		break;
+	}
+
+	DBG("octi %d ouwcti %d tech %d", octi, ouwcti, tech);
+	cb(&error, nd->status, nd->lac, nd->ci, tech, cbd->data);
+}
+
 static void at_creg_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_netreg_status_cb_t cb =3D cbd->cb;
-	int status, lac, ci, tech;
+	int tech;
 	struct ofono_error error;
 	struct netreg_data *nd =3D cbd->user;
 =

@@ -84,16 +145,27 @@ static void at_creg_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		return;
 	}
 =

-	if (at_util_parse_reg(result, "+CREG:", NULL, &status,
-				&lac, &ci, &tech, nd->vendor) =3D=3D FALSE) {
+	if (at_util_parse_reg(result, "+CREG:", NULL, &nd->status,
+			&nd->lac, &nd->ci, &tech, nd->vendor) =3D=3D FALSE) {
 		CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, cbd->data);
 		return;
 	}
 =

-	if ((status =3D=3D 1 || status =3D=3D 5) && (tech =3D=3D -1))
-		tech =3D nd->tech;
+	switch (nd->vendor) {
+	case OFONO_VENDOR_OPTION_HSO:
+		/*
+		 * Send _OCTI?;_OUWCTI? to find out the cell cabalities.
+		 */
+		g_at_chat_send(nd->chat, "AT_OCTI?;_OUWCTI?",
+			option_tech_prefix, option_tech_cb, cbd, g_free);
+		break;
+	default:
+		if ((nd->status =3D=3D 1 || nd->status =3D=3D 5) && (tech =3D=3D -1))
+			tech =3D nd->tech;
 =

-	cb(&error, status, lac, ci, tech, cbd->data);
+		cb(&error, nd->status, nd->lac, nd->ci, tech, cbd->data);
+		g_free(cbd);
+	}
 }
 =

 static void at_registration_status(struct ofono_netreg *netreg,
@@ -128,7 +200,7 @@ static void at_registration_status(struct ofono_netreg =
*netreg,
 	}
 =

 	if (g_at_chat_send(nd->chat, "AT+CREG?", creg_prefix,
-				at_creg_cb, cbd, g_free) > 0)
+				at_creg_cb, cbd, NULL) > 0)
 		return;
 =

 error:
@@ -533,38 +605,6 @@ static void option_osigq_notify(GAtResult *result, gpo=
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
@@ -624,22 +664,6 @@ static void cind_cb(gboolean ok, GAtResult *result, gp=
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
@@ -806,17 +830,33 @@ static void nw_cnti_notify(GAtResult *result, gpointe=
r user_data)
 static void creg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	int status, lac, ci, tech;
+	int tech;
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct cb_data *cbd;
 =

-	if (at_util_parse_reg_unsolicited(result, "+CREG:", &status,
-				&lac, &ci, &tech, nd->vendor) =3D=3D FALSE)
+	if (at_util_parse_reg_unsolicited(result, "+CREG:", &nd->status,
+				&nd->lac, &nd->ci, &tech, nd->vendor) =3D=3D FALSE)
 		return;
 =

-	if ((status =3D=3D 1 || status =3D=3D 5) && tech =3D=3D -1)
-		tech =3D nd->tech;
 =

-	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
+	switch (nd->vendor) {
+	case OFONO_VENDOR_OPTION_HSO:
+		cbd =3D cb_data_new(option_status_notify_cb, netreg);
+		if (!cbd)
+			return;
+
+		cbd->user =3D nd;
+
+		g_at_chat_send(nd->chat, "AT_OCTI?;_OUWCTI?",
+			option_tech_prefix, option_tech_cb, cbd, g_free);
+		break;
+	default:
+		if ((nd->status =3D=3D 1 || nd->status =3D=3D 5) && tech =3D=3D -1)
+			tech =3D nd->tech;
+
+		ofono_netreg_status_notify(netreg,
+			nd->status, nd->lac, nd->ci, tech);
+	}
 }
 =

 static void cind_support_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -909,27 +949,13 @@ static void at_creg_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
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
@@ -1021,6 +1047,9 @@ static int at_netreg_probe(struct ofono_netreg *netre=
g, unsigned int vendor,
 =

 	nd->chat =3D chat;
 	nd->vendor =3D vendor;
+	nd->status =3D -1;
+	nd->lac =3D -1;
+	nd->ci =3D -1;
 	nd->tech =3D -1;
 	ofono_netreg_set_data(netreg, nd);
 =

-- =

1.6.6.1


--===============9124390688708989712==--

