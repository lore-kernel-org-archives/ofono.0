Content-Type: multipart/mixed; boundary="===============7004236526595709783=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] atmodem/gprs: initial Gemalto vendor-specific support
Date: Sun, 23 Sep 2018 07:23:06 +0200
Message-ID: <20180923052306.8052-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7004236526595709783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs.c | 128 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 5 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index fc0d8aa3..84ee5c7d 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -672,6 +672,91 @@ static void ublox_ureg_notify(GAtResult *result, gpoin=
ter user_data)
 	ofono_gprs_bearer_notify(gprs, bearer);
 }
 =

+static void gemalto_ciev_ceer_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	const char *report;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIEV: ceer,"))
+		return;
+	/*
+	 * No need to check release cause group
+	 * as we only subscribe to no. 5
+	 */
+	if (!g_at_result_iter_skip_next(&iter))
+		return;
+	if (!g_at_result_iter_next_string(&iter, &report))
+		return;
+
+	/* TODO: Handle more of these? */
+
+	if (g_str_equal(report, "Regular deactivation")) {
+		ofono_gprs_detached_notify(gprs);
+		return;
+	}
+}
+
+static void gemalto_ciev_bearer_notify(GAtResult *result, gpointer user_da=
ta)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	int bearer;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIEV: psinfo,"))
+		return;
+	if (!g_at_result_iter_next_number(&iter, &bearer))
+		return;
+
+	/* Go from Gemalto representation to oFono representation */
+	switch (bearer) {
+	case 0: /* GPRS/EGPRS not available */
+		/* Same as "no bearer"? */
+		bearer =3D 0;
+		break;
+	case 1: /* GPRS available, ignore this one */
+		return;
+	case 2: /* GPRS attached */
+		bearer =3D 1;
+		break;
+	case 3: /* EGPRS available, ignore this one */
+		return;
+	case 4: /* EGPRS attached */
+		bearer =3D 2;
+		break;
+	case 5: /* UMTS available, ignore this one */
+		return;
+	case 6: /* UMTS attached */
+		bearer =3D 3;
+		break;
+	case 7: /* HSDPA available, ignore this one */
+		return;
+	case 8: /* HSDPA attached */
+		bearer =3D 5;
+		break;
+	case 9: /* HSDPA/HSUPA available, ignore this one */
+		return;
+	case 10: /* HSDPA/HSUPA attached */
+		bearer =3D 6;
+		break;
+	/* TODO: Limit these cases to ALS3? */
+	case 16: /* E-UTRA available, ignore this one */
+		return;
+	case 17: /* E-UTRA attached */
+		bearer =3D 7;
+		break;
+	default: /* Assume that non-parsable values mean "no bearer" */
+		bearer =3D 0;
+		break;
+	}
+
+	ofono_gprs_bearer_notify(gprs, bearer);
+}
+
 static void cpsb_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -696,8 +781,13 @@ static void gprs_initialized(struct ofono_gprs *gprs)
 {
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 =

-	g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL,
-								NULL);
+	switch (gd->vendor) {
+	case OFONO_VENDOR_GEMALTO:
+		break;
+	default:
+		g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL,
+									NULL);
+	}
 =

 	switch (gd->vendor) {
 	case OFONO_VENDOR_MBM:
@@ -710,6 +800,12 @@ static void gprs_initialized(struct ofono_gprs *gprs)
 		g_at_chat_send(gd->chat, "AT+CGEREP=3D1", none_prefix,
 			NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_GEMALTO:
+		g_at_chat_send(gd->chat, "AT+CGEREP=3D2", NULL,
+					NULL, NULL, NULL);
+		g_at_chat_send(gd->chat, "AT^SIND=3D\"psinfo\",1", none_prefix,
+			NULL, NULL, NULL);
+		break;
 	default:
 		g_at_chat_send(gd->chat, "AT+CGEREP=3D2,1", none_prefix,
 			NULL, NULL, NULL);
@@ -744,6 +840,12 @@ static void gprs_initialized(struct ofono_gprs *gprs)
 		g_at_chat_send(gd->chat, "AT#PSNT=3D1", none_prefix,
 						NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_GEMALTO:
+		g_at_chat_register(gd->chat, "+CIEV: psinfo,",
+			gemalto_ciev_bearer_notify, FALSE, gprs, NULL);
+		g_at_chat_register(gd->chat, "+CIEV: ceer,",
+			gemalto_ciev_ceer_notify, FALSE, gprs, NULL);
+		break;
 	default:
 		g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify,
 						FALSE, gprs, NULL);
@@ -815,7 +917,13 @@ retry:
 =

 	g_at_result_iter_close_list(&iter);
 =

-	if (cgreg1) {
+	if (gd->vendor =3D=3D OFONO_VENDOR_GEMALTO) {
+		/*
+		 * Gemalto prefers to print as much information as available
+		 * for support purposes
+		 */
+		sprintf(buf, "AT+%s=3D%d",ind, range[1]);
+	} else if (cgreg1) {
 		sprintf(buf,"AT+%s=3D1", ind);
 	} else if (cgreg2) {
 		sprintf(buf,"AT+%s=3D2", ind);
@@ -931,6 +1039,8 @@ static int at_gprs_probe(struct ofono_gprs *gprs,
 {
 	GAtChat *chat =3D data;
 	struct gprs_data *gd;
+	int autoattach;
+	struct ofono_modem* modem=3Dofono_gprs_get_modem(gprs);
 =

 	gd =3D g_try_new0(struct gprs_data, 1);
 	if (gd =3D=3D NULL)
@@ -941,8 +1051,16 @@ static int at_gprs_probe(struct ofono_gprs *gprs,
 =

 	ofono_gprs_set_data(gprs, gd);
 =

-	g_at_chat_send(gd->chat, "AT+CGDCONT=3D?", cgdcont_prefix,
-			at_cgdcont_test_cb, gprs, NULL);
+	if (gd->vendor =3D=3D OFONO_VENDOR_GEMALTO) {
+		autoattach=3Dofono_modem_get_integer(modem, "GemaltoAutoAttach");
+		/* set autoattach */
+		gd->auto_attach =3D (autoattach =3D=3D 1);
+		/* skip the cgdcont scanning: set manually */
+		test_and_set_regstatus(gprs);
+	} else {
+		g_at_chat_send(gd->chat, "AT+CGDCONT=3D?", cgdcont_prefix,
+						at_cgdcont_test_cb, gprs, NULL);
+	}
 =

 	return 0;
 }
-- =

2.17.1


--===============7004236526595709783==--

