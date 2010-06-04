Content-Type: multipart/mixed; boundary="===============6286079144511077408=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC] Readout technology from Option HSO modems
Date: Fri, 04 Jun 2010 16:59:44 +0200
Message-ID: <20100604145944.GA18715@pc0043.bmw-carit.intra>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6286079144511077408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According MM the OSSYSI commands returns
the information which command has to
be considered for details.

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
 drivers/atmodem/network-registration.c |   97 ++++++++++++++++++++++++++++=
++-
 src/network.c                          |    8 +-
 2 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index d0fa039..90e1820 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -55,9 +55,50 @@ struct netreg_data {
 	int signal_min; /* min strength reported via CIND */
 	int signal_max; /* max strength reported via CIND */
 	int tech;
+	int octi; /* option hso gprs band info */
+	int owcti; /* option hso umts band info */
+	int ossysi; /* option hso main tech switch */
 	unsigned int vendor;
 };
 =

+
+static int option_octi_owcti_to_tech(struct netreg_data *nd)
+{
+	int tech =3D -1;
+
+	switch (nd->ossysi) {
+	case 0: /* GPRS */
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
+	case 2: /* UMTS */
+		switch (nd->owcti) {
+		case 1: /* UMTS */
+			tech =3D 2;
+			break;
+		case 2: /* HSDPA */
+			tech =3D 4;
+			break;
+		case 3: /* HSUPA */
+			tech =3D 5;
+			break;
+		case 4: /* HSPA */
+			tech =3D 6;
+		}
+		break;
+	}
+
+	return tech;
+}
+
 static void extract_mcc_mnc(const char *str, char *mcc, char *mnc)
 {
 	/* Three digit country code */
@@ -90,8 +131,15 @@ static void at_creg_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 		return;
 	}
 =

-	if ((status =3D=3D 1 || status =3D=3D 5) && (tech =3D=3D -1))
-		tech =3D nd->tech;
+
+	if ((status =3D=3D 1 || status =3D=3D 5) && tech =3D=3D -1) {
+		switch (nd->vendor) {
+		case OFONO_VENDOR_OPTION_HSO:
+			tech =3D option_octi_owcti_to_tech(nd);
+		default:
+			tech =3D nd->tech;
+		}
+	}
 =

 	cb(&error, status, lac, ci, tech, cbd->data);
 }
@@ -116,6 +164,18 @@ static void at_registration_status(struct ofono_netreg=
 *netreg,
 		g_at_chat_send(nd->chat, "AT*ERINFO?", none_prefix,
 				NULL, NULL, NULL);
 =

+	/*
+	 * Send OSSYS, OCTI and OWCTI to find out the current tech
+	 */
+	if (nd->vendor =3D=3D OFONO_VENDOR_OPTION_HSO) {
+		g_at_chat_send(nd->chat, "AT_OSSYS?", none_prefix,
+				NULL, NULL, NULL);
+		g_at_chat_send(nd->chat, "AT_OCTI?", none_prefix,
+				NULL, NULL, NULL);
+		g_at_chat_send(nd->chat, "AT_OWCTI?", none_prefix,
+				NULL, NULL, NULL);
+	}
+
 	if (g_at_chat_send(nd->chat, "AT+CREG?", creg_prefix,
 				at_creg_cb, cbd, g_free) > 0)
 		return;
@@ -519,6 +579,8 @@ static void option_osigq_notify(GAtResult *result, gpoi=
nter user_data)
 =

 static void option_owcti_notify(GAtResult *result, gpointer user_data)
 {
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	int mode;
 	GAtResultIter iter;
 =

@@ -530,11 +592,17 @@ static void option_owcti_notify(GAtResult *result, gp=
ointer user_data)
 	if (!g_at_result_iter_next_number(&iter, &mode))
 		return;
 =

+	nd->owcti =3D mode;
+	ofono_netreg_status_notify(netreg, -1, -1, -1,
+				option_octi_owcti_to_tech(nd));
+
 	ofono_info("OWCTI mode: %d", mode);
 }
 =

 static void option_octi_notify(GAtResult *result, gpointer user_data)
 {
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	int mode;
 	GAtResultIter iter;
 =

@@ -546,6 +614,10 @@ static void option_octi_notify(GAtResult *result, gpoi=
nter user_data)
 	if (!g_at_result_iter_next_number(&iter, &mode))
 		return;
 =

+	nd->octi =3D mode;
+	ofono_netreg_status_notify(netreg, -1, -1, -1,
+				option_octi_owcti_to_tech(nd));
+
 	ofono_info("OCTI mode: %d", mode);
 }
 =

@@ -610,6 +682,8 @@ static void cind_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 =

 static void option_ossysi_notify(GAtResult *result, gpointer user_data)
 {
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	int mode;
 	GAtResultIter iter;
 =

@@ -621,6 +695,10 @@ static void option_ossysi_notify(GAtResult *result, gp=
ointer user_data)
 	if (!g_at_result_iter_next_number(&iter, &mode))
 		return;
 =

+	nd->ossysi =3D mode;
+	ofono_netreg_status_notify(netreg, -1, -1, -1,
+				option_octi_owcti_to_tech(nd));
+
 	ofono_info("OSSYSI mode: %d", mode);
 }
 =

@@ -754,8 +832,14 @@ static void creg_notify(GAtResult *result, gpointer us=
er_data)
 				&lac, &ci, &tech, nd->vendor) =3D=3D FALSE)
 		return;
 =

-	if ((status =3D=3D 1 || status =3D=3D 5) && tech =3D=3D -1)
-		tech =3D nd->tech;
+	if ((status =3D=3D 1 || status =3D=3D 5) && tech =3D=3D -1) {
+		switch (nd->vendor) {
+		case OFONO_VENDOR_OPTION_HSO:
+			tech =3D option_octi_owcti_to_tech(nd);
+		default:
+			tech =3D nd->tech;
+		}
+	}
 =

 	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
 }
@@ -873,6 +957,8 @@ static void at_creg_set_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 				NULL, NULL, NULL);
 		g_at_chat_send(nd->chat, "AT_OCTI?", none_prefix,
 				NULL, NULL, NULL);
+		g_at_chat_send(nd->chat, "AT_OWCTI?", none_prefix,
+				NULL, NULL, NULL);
 		g_at_chat_send(nd->chat, "AT_OSQI?", none_prefix,
 				NULL, NULL, NULL);
 =

@@ -975,6 +1061,9 @@ static int at_netreg_probe(struct ofono_netreg *netreg=
, unsigned int vendor,
 	nd->chat =3D chat;
 	nd->vendor =3D vendor;
 	nd->tech =3D -1;
+	nd->octi =3D -1;
+	nd->owcti =3D -1;
+	nd->ossysi =3D -1;
 	ofono_netreg_set_data(netreg, nd);
 =

 	g_at_chat_send(chat, "AT+CREG=3D?", creg_prefix,
diff --git a/src/network.c b/src/network.c
index 87a73e3..932039d 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1033,16 +1033,16 @@ void ofono_netreg_status_notify(struct ofono_netreg=
 *netreg, int status,
 	if (!netreg)
 		return;
 =

-	if (netreg->status !=3D status)
+	if (status !=3D -1 && netreg->status !=3D status)
 		set_registration_status(netreg, status);
 =

-	if (netreg->location !=3D lac)
+	if (lac !=3D -1 && netreg->location !=3D lac)
 		set_registration_location(netreg, lac);
 =

-	if (netreg->cellid !=3D ci)
+	if (ci !=3D -1 && netreg->cellid !=3D ci)
 		set_registration_cellid(netreg, ci);
 =

-	if (netreg->technology !=3D tech)
+	if (tech !=3D -1 && netreg->technology !=3D tech)
 		set_registration_technology(netreg, tech);
 =

 	if (netreg->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
-- =

1.6.6.1


--===============6286079144511077408==--

