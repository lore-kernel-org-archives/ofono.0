Content-Type: multipart/mixed; boundary="===============8793607904722579343=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v1] Readout technology from Option HSO modems
Date: Mon, 07 Jun 2010 17:09:16 +0200
Message-ID: <20100607150916.GA12037@pc0043.bmw-carit.intra>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8793607904722579343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To find out which the current technology is on
we have to issue OCTI and OWCTI. OCTI returns
2G information and OWCTI returns 3G information.
OWCTI overrules OCTI.

The OSSYSI unsolicited command tells which
of information should be considered. Unfortunately,
AT_OSSYSI? only returns error.

OSSYSI 0 -> TECH_GPRS (use OCTI for details)
OSSYSI 2 -> TECH_UMTS (use OWCTI for details)

OCTI 1 -> GSM
OCTI 2 -> GPRS
OCTI 3 -> EDGE

OWCTI 1 -> UMTS
OWCTI 2 -> HSDPA
OWCTI 3 -> HSUPA
OWCTI 4 -> HSPA
---
I have uploaded the log ouput here http://pastebin.com/gfK1Adih
There are quite a few ofono_netreg_status_notify, because
OCTI & OWCTI are updated quite often.

Also I don't know what OSSYSI =3D 3 means.

v1: fire OCTI, OWCTI in cregs callback. =

v0: initial version

 drivers/atmodem/network-registration.c |  224 ++++++++++++++++++++++++++++=
----
 1 files changed, 197 insertions(+), 27 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index d0fa039..226081b 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -54,10 +54,85 @@ struct netreg_data {
 	int signal_index; /* If strength is reported via CIND */
 	int signal_min; /* min strength reported via CIND */
 	int signal_max; /* max strength reported via CIND */
+	int status;
+	int lac;
+	int ci;
 	int tech;
+	int octi; /* option hso 2G info details */
+	int owcti; /* otpion hso 3G info details */
+	int ossysi; /* option hso 2G/3G info */
 	unsigned int vendor;
 };
 =

+static int option_octi_to_tech(struct netreg_data *nd)
+{
+	int tech =3D -1;
+	switch (nd->octi) {
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
+	return tech;
+}
+
+static int option_owcti_to_tech(struct netreg_data *nd)
+{
+	int tech =3D -1;
+
+	switch (nd->owcti) {
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
+	}
+	=

+	return tech;
+}
+
+static void option_octi_owcti_to_tech(struct netreg_data *nd)
+{
+	int tech =3D -1;
+	int tech_2g, tech_3g;
+
+	switch (nd->ossysi) {
+	case -1:
+		tech_2g =3D option_octi_to_tech(nd);
+		tech_3g =3D option_owcti_to_tech(nd);
+
+		/* 3G tech takes precedence over 2G tech */
+		if (tech_3g =3D=3D -1) =

+			tech =3D tech_2g;
+		else
+			tech =3D tech_3g;
+		break;
+	case 0: /* 2G */
+		tech =3D option_octi_to_tech(nd);
+		break;
+	case 2: /* 3G */
+		tech =3D option_owcti_to_tech(nd);
+		break;
+	case 3: /* Unknown */
+		break;
+	}
+
+	DBG("ossysi %d octi %d owcti %d tech %d", nd->ossysi, nd->octi, nd->owcti=
, tech);
+
+	nd->tech =3D tech;
+}
+
 static void extract_mcc_mnc(const char *str, char *mcc, char *mnc)
 {
 	/* Three digit country code */
@@ -69,6 +144,56 @@ static void extract_mcc_mnc(const char *str, char *mcc,=
 char *mnc)
 	mnc[OFONO_MAX_MNC_LENGTH] =3D '\0';
 }
 =

+static void at_octi_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netreg_status_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	struct netreg_data *nd =3D cbd->user;
+	GAtResultIter iter;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, -1, -1, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "_OCTI:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &nd->octi))
+		return;
+
+	/* ofono_netreg_status_notify will be called in at_owcti_cb */
+}
+
+static void at_owcti_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netreg_status_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	struct netreg_data *nd =3D cbd->user;
+	GAtResultIter iter;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, -1, -1, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "_OWCTI:"))
+		g_at_result_iter_next_number(&iter, &nd->owcti);
+
+	option_octi_owcti_to_tech(nd);
+	cb(&error, nd->status, nd->lac, nd->ci, nd->tech, cbd->data);
+}
+
 static void at_creg_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -93,7 +218,19 @@ static void at_creg_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	if ((status =3D=3D 1 || status =3D=3D 5) && (tech =3D=3D -1))
 		tech =3D nd->tech;
 =

-	cb(&error, status, lac, ci, tech, cbd->data);
+	if (nd->vendor =3D=3D OFONO_VENDOR_OPTION_HSO) {
+		nd->status =3D status;
+		nd->lac =3D lac;
+		nd->ci =3D ci;
+
+		g_at_chat_send(nd->chat, "AT_OCTI?", creg_prefix,
+			at_octi_cb, cbd, NULL);
+		g_at_chat_send(nd->chat, "AT_OWCTI?", creg_prefix,
+			at_owcti_cb, cbd, g_free);
+	} else {
+		cb(&error, status, lac, ci, tech, cbd->data);
+		g_free(cbd);
+	}
 }
 =

 static void at_registration_status(struct ofono_netreg *netreg,
@@ -117,7 +254,7 @@ static void at_registration_status(struct ofono_netreg =
*netreg,
 				NULL, NULL, NULL);
 =

 	if (g_at_chat_send(nd->chat, "AT+CREG?", creg_prefix,
-				at_creg_cb, cbd, g_free) > 0)
+				at_creg_cb, cbd, NULL) > 0)
 		return;
 =

 error:
@@ -519,7 +656,8 @@ static void option_osigq_notify(GAtResult *result, gpoi=
nter user_data)
 =

 static void option_owcti_notify(GAtResult *result, gpointer user_data)
 {
-	int mode;
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 =

 	g_at_result_iter_init(&iter, result);
@@ -527,15 +665,19 @@ static void option_owcti_notify(GAtResult *result, gp=
ointer user_data)
 	if (!g_at_result_iter_next(&iter, "_OWCTI:"))
 		return;
 =

-	if (!g_at_result_iter_next_number(&iter, &mode))
+	if (!g_at_result_iter_next_number(&iter, &nd->owcti))
 		return;
 =

-	ofono_info("OWCTI mode: %d", mode);
+	option_octi_owcti_to_tech(nd);
+	ofono_netreg_status_notify(netreg,
+				nd->status, nd->lac, nd->ci, nd->tech);
+
 }
 =

 static void option_octi_notify(GAtResult *result, gpointer user_data)
 {
-	int mode;
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 =

 	g_at_result_iter_init(&iter, result);
@@ -543,10 +685,39 @@ static void option_octi_notify(GAtResult *result, gpo=
inter user_data)
 	if (!g_at_result_iter_next(&iter, "_OCTI:"))
 		return;
 =

-	if (!g_at_result_iter_next_number(&iter, &mode))
+	if (!g_at_result_iter_next_number(&iter, &nd->octi))
+		return;
+
+	option_octi_owcti_to_tech(nd);
+	ofono_netreg_status_notify(netreg,
+				nd->status, nd->lac, nd->ci, nd->tech);
+
+}
+
+static void option_ossysi_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "_OSSYSI:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &nd->ossysi))
 		return;
 =

-	ofono_info("OCTI mode: %d", mode);
+	switch (nd->ossysi) {
+	case 0:
+		g_at_chat_send(nd->chat, "AT_OCTI?", none_prefix,
+			NULL, NULL, NULL);
+		break;
+	case 2:
+		g_at_chat_send(nd->chat, "AT_OWCTI?", none_prefix,
+			NULL, NULL, NULL);
+		break;
+	}
 }
 =

 static void ciev_notify(GAtResult *result, gpointer user_data)
@@ -608,22 +779,6 @@ static void cind_cb(gboolean ok, GAtResult *result, gp=
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
 static void csq_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -757,7 +912,18 @@ static void creg_notify(GAtResult *result, gpointer us=
er_data)
 	if ((status =3D=3D 1 || status =3D=3D 5) && tech =3D=3D -1)
 		tech =3D nd->tech;
 =

-	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
+	if (nd->vendor =3D=3D OFONO_VENDOR_OPTION_HSO) {
+		nd->status =3D status;
+		nd->lac =3D lac;
+		nd->ci =3D ci;
+
+		g_at_chat_send(nd->chat, "AT_OCTI?", none_prefix,
+				NULL, NULL, NULL);
+		g_at_chat_send(nd->chat, "AT_OWCTI?", none_prefix,
+				NULL, NULL, NULL);
+	} else {
+		ofono_netreg_status_notify(netreg, status, lac, ci, tech);
+	}
 }
 =

 static void cind_support_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -871,8 +1037,6 @@ static void at_creg_set_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

 		g_at_chat_send(nd->chat, "AT_OSSYS?", none_prefix,
 				NULL, NULL, NULL);
-		g_at_chat_send(nd->chat, "AT_OCTI?", none_prefix,
-				NULL, NULL, NULL);
 		g_at_chat_send(nd->chat, "AT_OSQI?", none_prefix,
 				NULL, NULL, NULL);
 =

@@ -974,7 +1138,13 @@ static int at_netreg_probe(struct ofono_netreg *netre=
g, unsigned int vendor,
 =

 	nd->chat =3D chat;
 	nd->vendor =3D vendor;
+	nd->status =3D -1;
+	nd->lac =3D -1;
+	nd->ci =3D -1;
 	nd->tech =3D -1;
+	nd->octi =3D -1;
+	nd->owcti =3D -1;
+	nd->ossysi =3D -1;
 	ofono_netreg_set_data(netreg, nd);
 =

 	g_at_chat_send(chat, "AT+CREG=3D?", creg_prefix,
-- =

1.6.6.1


--===============8793607904722579343==--

