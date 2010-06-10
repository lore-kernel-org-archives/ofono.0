Content-Type: multipart/mixed; boundary="===============2031427833661223814=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0] Report cell technology capability for Option HSO modems
Date: Thu, 10 Jun 2010 15:19:57 +0200
Message-ID: <20100610131957.GA29387@pc0043.bmw-carit.intra>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2031427833661223814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Option modem use OCTI and OSSYSI commands
for reporting the cell capability.
---
The log to this patch: http://pastebin.com/xrbrUGeL

Unfortunalty, I couldn't get away without OSSYSI updating the netreg
info. =


v0: based on "[RFC v3] Readout technology form Option HSO modems"

 drivers/atmodem/network-registration.c |  121 +++++++++++++++++++++-------=
----
 1 files changed, 81 insertions(+), 40 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index f5ccbb1..d7617b1 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -54,7 +54,12 @@ struct netreg_data {
 	int signal_index; /* If strength is reported via CIND */
 	int signal_min; /* min strength reported via CIND */
 	int signal_max; /* max strength reported via CIND */
+	int status;
+	int lac;
+	int ci;
 	int tech;
+	int ossysi; /* option hso 2G/3G info */
+	int octi; /* option hso 2G info */
 	unsigned int vendor;
 };
 =

@@ -73,7 +78,7 @@ static void at_creg_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_netreg_status_cb_t cb =3D cbd->cb;
-	int status, lac, ci, tech;
+	int tech;
 	struct ofono_error error;
 	struct netreg_data *nd =3D cbd->user;
 =

@@ -84,16 +89,16 @@ static void at_creg_cb(gboolean ok, GAtResult *result, =
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
+	if ((nd->status =3D=3D 1 || nd->status =3D=3D 5) && (tech =3D=3D -1))
 		tech =3D nd->tech;
 =

-	cb(&error, status, lac, ci, tech, cbd->data);
+	cb(&error, nd->status, nd->lac, nd->ci, tech, cbd->data);
 }
 =

 static void at_registration_status(struct ofono_netreg *netreg,
@@ -533,36 +538,88 @@ static void option_osigq_notify(GAtResult *result, gp=
ointer user_data)
 				at_util_convert_signal_strength(strength));
 }
 =

-static void option_ouwcti_notify(GAtResult *result, gpointer user_data)
+static void option_ossysi_octi_to_tech(struct netreg_data *nd)
 {
-	int mode;
+	int tech =3D -1;
+	switch (nd->ossysi) {
+	case 0: /* 2G */
+		switch (nd->octi) {
+		case 1:	/* GSM */
+			tech =3D 0;
+			break;
+		case 2: /* GPRS */
+			tech =3D 1;
+			break;
+		case 3:	/* EDGE */
+			tech =3D 3;
+		}
+		break;
+	case 2: /* 3G */
+		/* UMTS */
+		tech =3D 2;
+		break;
+	case 3: /* Unknown */
+		/* reset all ossysi and octi */
+		nd->octi =3D -1;
+		nd->ossysi =3D -1;
+		break;
+	}
+
+	nd->tech =3D tech;
+
+	DBG("ossysi %d octi %d tech %d",
+		nd->ossysi, nd->octi, nd->tech);
+}
+
+static void option_ossysi_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 =

 	g_at_result_iter_init(&iter, result);
 =

-	if (!g_at_result_iter_next(&iter, "_OUWCTI:"))
+	if (!g_at_result_iter_next(&iter, "_OSSYSI:"))
 		return;
 =

-	if (!g_at_result_iter_next_number(&iter, &mode))
+	if (!g_at_result_iter_next_number(&iter, &nd->ossysi))
 		return;
 =

-	ofono_info("OWCTI mode: %d", mode);
+	option_ossysi_octi_to_tech(nd);
+
+	/*
+	 * OSSYSI can appear after a CREG and netreg isn't updated
+	 * until the next CREG which can take an undefined long time.
+	 */
+	ofono_netreg_status_notify(netreg, nd->status, nd->lac,
+				nd->ci, nd->tech);
 }
 =

 static void option_octi_notify(GAtResult *result, gpointer user_data)
 {
-	int mode;
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
+	int mode;
 =

 	g_at_result_iter_init(&iter, result);
 =

 	if (!g_at_result_iter_next(&iter, "_OCTI:"))
 		return;
 =

-	if (!g_at_result_iter_next_number(&iter, &mode))
+	if (!g_at_result_iter_next_number(&iter, &nd->octi))
 		return;
 =

-	ofono_info("OCTI mode: %d", mode);
+	/* Handle query responses too */
+	if (!g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
+		nd->octi =3D mode;
+
+	option_ossysi_octi_to_tech(nd);
+
+	/*
+	 * OCTI seem to appear always before a CREG or
+	 * is followed by a OSSYSI which will update netreg.
+	 */
 }
 =

 static void ciev_notify(GAtResult *result, gpointer user_data)
@@ -624,22 +681,6 @@ static void cind_cb(gboolean ok, GAtResult *result, gp=
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
@@ -806,17 +847,17 @@ static void nw_cnti_notify(GAtResult *result, gpointe=
r user_data)
 static void creg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	int status, lac, ci, tech;
+	int tech;
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

-	if (at_util_parse_reg_unsolicited(result, "+CREG:", &status,
-				&lac, &ci, &tech, nd->vendor) =3D=3D FALSE)
+	if (at_util_parse_reg_unsolicited(result, "+CREG:", &nd->status,
+				&nd->lac, &nd->ci, &tech, nd->vendor) =3D=3D FALSE)
 		return;
 =

-	if ((status =3D=3D 1 || status =3D=3D 5) && tech =3D=3D -1)
+	if ((nd->status =3D=3D 1 || nd->status =3D=3D 5) && tech =3D=3D -1)
 		tech =3D nd->tech;
 =

-	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
+	ofono_netreg_status_notify(netreg, nd->status, nd->lac, nd->ci, tech);
 }
 =

 static void cind_support_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -909,16 +950,12 @@ static void at_creg_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	case OFONO_VENDOR_OPTION_HSO:
 		g_at_chat_send(nd->chat, "AT_OSSYS=3D1", none_prefix,
 				NULL, NULL, NULL);
-		g_at_chat_send(nd->chat, "AT_OUWCTI=3D1", none_prefix,
-				NULL, NULL, NULL);
 		g_at_chat_send(nd->chat, "AT_OCTI=3D1", none_prefix,
 				NULL, NULL, NULL);
 		g_at_chat_send(nd->chat, "AT_OSQI=3D1", none_prefix,
 				NULL, NULL, NULL);
 		g_at_chat_register(nd->chat, "_OSIGQ:", option_osigq_notify,
 					FALSE, netreg, NULL);
-		g_at_chat_register(nd->chat, "_OUWCTI:", option_ouwcti_notify,
-					FALSE, netreg, NULL);
 		g_at_chat_register(nd->chat, "_OCTI:", option_octi_notify,
 					FALSE, netreg, NULL);
 		g_at_chat_register(nd->chat, "_OSSYSI:", option_ossysi_notify,
@@ -926,12 +963,11 @@ static void at_creg_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 		g_at_chat_send(nd->chat, "AT_OSSYS?", none_prefix,
 				NULL, NULL, NULL);
-		g_at_chat_send(nd->chat, "AT_OWCTI?", none_prefix,
-				NULL, NULL, NULL);
 		g_at_chat_send(nd->chat, "AT_OCTI?", none_prefix,
 				NULL, NULL, NULL);
 		g_at_chat_send(nd->chat, "AT_OSQI?", none_prefix,
 				NULL, NULL, NULL);
+
 		break;
 	case OFONO_VENDOR_MBM:
 		g_at_chat_send(nd->chat, "AT*ERINFO=3D1", none_prefix,
@@ -1021,7 +1057,12 @@ static int at_netreg_probe(struct ofono_netreg *netr=
eg, unsigned int vendor,
 =

 	nd->chat =3D chat;
 	nd->vendor =3D vendor;
+	nd->status =3D -1;
+	nd->lac =3D -1;
+	nd->ci =3D -1;
 	nd->tech =3D -1;
+	nd->ossysi =3D -1;
+	nd->octi =3D -1;
 	ofono_netreg_set_data(netreg, nd);
 =

 	g_at_chat_send(chat, "AT+CREG=3D?", creg_prefix,
-- =

1.6.6.1


--===============2031427833661223814==--

