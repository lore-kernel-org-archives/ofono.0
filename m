Content-Type: multipart/mixed; boundary="===============4100625308144813372=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v0 3/3] Monitor current technology used for Option modems
Date: Mon, 14 Jun 2010 13:14:20 +0200
Message-ID: <1276514060-16226-4-git-send-email-wagi@monom.org>
In-Reply-To: <1276514060-16226-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4100625308144813372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 drivers/atmodem/gprs.c |  156 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 156 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index bf82d06..0ed97f3 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -48,6 +48,9 @@ static const char *none_prefix[] =3D { NULL };
 struct gprs_data {
 	GAtChat *chat;
 	unsigned int vendor;
+	int ossysi; /* option hso 2G/3G info */
+	int octi; /* option hso 2G info details */
+	int ouwcti; /* otpion hso 3G info details */
 };
 =

 static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -142,6 +145,140 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

+static int option_octi_to_tech(struct gprs_data *gd)
+{
+	int tech =3D -1;
+	switch (gd->octi) {
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
+static int option_ouwcti_to_tech(struct gprs_data *gd)
+{
+	int tech =3D -1;
+
+	switch (gd->ouwcti) {
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
+
+	return tech;
+}
+
+static int option_get_tech(struct gprs_data *gd)
+{
+	int tech =3D -1;
+	int tech_2g, tech_3g;
+
+	switch (gd->ossysi) {
+	case -1:
+		tech_2g =3D option_octi_to_tech(gd);
+		tech_3g =3D option_ouwcti_to_tech(gd);
+
+		/* 3G tech takes precedence over 2G tech */
+		if (tech_3g =3D=3D -1)
+			tech =3D tech_2g;
+		else
+			tech =3D tech_3g;
+		break;
+	case 0: /* 2G */
+		tech =3D option_octi_to_tech(gd);
+		break;
+	case 2: /* 3G */
+		tech =3D option_ouwcti_to_tech(gd);
+		break;
+	case 3: /* Unknown */
+		/* reset all ossysi and octi */
+		gd->octi =3D -1;
+		gd->ossysi =3D -1;
+		break;
+	}
+
+	DBG("ossysi %d octi %d ouwcti %d tech %d",
+		gd->ossysi, gd->octi, gd->ouwcti, tech);
+
+	return tech;
+}
+
+static void option_ossysi_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "_OSSYSI:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &gd->ossysi))
+		return;
+
+	ofono_gprs_technology_notify(gprs, option_get_tech(gd));
+}
+
+static void option_octi_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	GAtResultIter iter;
+	int mode;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "_OCTI:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &gd->octi))
+		return;
+
+	/* Handle query responses too */
+	if (!g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
+		gd->octi =3D mode;
+
+	ofono_gprs_technology_notify(gprs, option_get_tech(gd));
+}
+
+static void option_ouwcti_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	GAtResultIter iter;
+	int mode;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "_OUWCTI:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &gd->ouwcti))
+		return;
+
+	/* Handle query responses too */
+	if (!g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
+		gd->ouwcti =3D mode;
+
+	ofono_gprs_technology_notify(gprs, option_get_tech(gd));
+}
+
 static void cgreg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -181,6 +318,25 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	struct ofono_gprs *gprs =3D user_data;
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 =

+	switch (gd->vendor) {
+	case OFONO_VENDOR_OPTION_HSO:
+		g_at_chat_register(gd->chat, "_OSSYSI:", option_ossysi_notify,
+					FALSE, gprs, NULL);
+		g_at_chat_register(gd->chat, "_OCTI:", option_octi_notify,
+					FALSE, gprs, NULL);
+		g_at_chat_register(gd->chat, "_OUWCTI:", option_ouwcti_notify,
+					FALSE, gprs, NULL);
+		g_at_chat_send(gd->chat, "AT_OCTI=3D1", none_prefix,
+				NULL, NULL, NULL);
+		g_at_chat_send(gd->chat, "AT_OUWCTI=3D1", none_prefix,
+				NULL, NULL, NULL);
+		g_at_chat_send(gd->chat, "AT_OCTI?", none_prefix,
+				NULL, NULL, NULL);
+		g_at_chat_send(gd->chat, "AT_OUWCTI?", none_prefix,
+				NULL, NULL, NULL);
+		break;
+	}
+
 	g_at_chat_register(gd->chat, "+CGEV:", cgev_notify, FALSE, gprs, NULL);
 	g_at_chat_register(gd->chat, "+CGREG:", cgreg_notify,
 				FALSE, gprs, NULL);
-- =

1.6.6.1


--===============4100625308144813372==--

