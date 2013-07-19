Content-Type: multipart/mixed; boundary="===============8423763146750156149=="
MIME-Version: 1.0
From: Anthony Viallard <viallard@syscom-instruments.com>
Subject: [PATCH 6/6] SIMCOM: add a quirk to retrieve network technology used
Date: Fri, 19 Jul 2013 15:35:40 +0200
Message-ID: <1374240940-30892-6-git-send-email-viallard@syscom-instruments.com>
In-Reply-To: <1374240940-30892-1-git-send-email-viallard@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8423763146750156149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use CNSMOD command to get network technology and monitor
changes.
---
 drivers/atmodem/network-registration.c | 76 ++++++++++++++++++++++++++++++=
++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 8cc04b7..d634dbb 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -239,6 +239,14 @@ static void at_registration_status(struct ofono_netreg=
 *netreg,
 	cbd->user =3D nd;
 =

 	switch (nd->vendor) {
+	case OFONO_VENDOR_SIMCOM:
+		/*
+		 * Send +CNSMOD? to find out the current tech, it will be
+		 * intercepted in simcom_cnsmod_notify
+		 */
+		g_at_chat_send(nd->chat, "AT+CNSMOD?", none_prefix,
+				NULL, NULL, NULL);
+		break;
 	case OFONO_VENDOR_MBM:
 		/*
 		 * Send *ERINFO to find out the current tech, it will be
@@ -1329,6 +1337,66 @@ static int cnti_to_tech(const char *cnti)
 	return -1;
 }
 =

+static void simcom_cnsmod_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	GAtResultIter iter;
+	int n1,
+		n2,
+		mode;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "+CNSMOD:") =3D=3D FALSE)
+		return;
+
+	if (g_at_result_iter_next_number(&iter, &n1) =3D=3D FALSE)
+		return;
+
+	if (g_at_result_iter_next_number(&iter, &n2) =3D=3D FALSE)
+		n2 =3D -1;
+
+	if (n2 !=3D -1)
+		mode =3D n2;
+	else
+		mode =3D n1;
+
+	switch (mode) {
+	case 1:
+	case 2:
+		/* GSM, GPRS */
+		nd->tech =3D ACCESS_TECHNOLOGY_GSM;
+		break;
+	case 3:
+		/* EDGE */
+		nd->tech =3D ACCESS_TECHNOLOGY_GSM_EGPRS;
+		break;
+	case 4:
+		/* WCDMA */
+		nd->tech =3D ACCESS_TECHNOLOGY_UTRAN;
+		break;
+	case 5:
+		/* HSDPA */
+		nd->tech =3D ACCESS_TECHNOLOGY_UTRAN_HSDPA;
+		break;
+	case 6:
+		/* HSUPA */
+		nd->tech =3D ACCESS_TECHNOLOGY_UTRAN_HSUPA;
+		break;
+	case 7:	/* HSUPA and HSDPA */
+		nd->tech =3D ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA;
+		break;
+	default:
+	case 0:
+		/* no service */
+		nd->tech =3D -1;
+		break;
+	}
+
+	ofono_netreg_tech_notify(netreg, nd->tech);
+}
+
 static void gobi_cnti_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -1760,6 +1828,14 @@ static void at_creg_set_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 =

 		g_at_chat_register(nd->chat, "+CSQ:",
 				   csq_notify, FALSE, netreg, NULL);
+
+		/* Register for network technology change */
+		g_at_chat_register(nd->chat, "+CNSMOD:",
+				   simcom_cnsmod_notify, FALSE, netreg, NULL);
+
+		g_at_chat_send(nd->chat, "AT+CNSMOD=3D1", none_prefix,
+			       NULL, NULL, NULL);
+
 		break;
 	case OFONO_VENDOR_PHONESIM:
 		g_at_chat_register(nd->chat, "+CSQ:",
-- =

1.8.3.1


--===============8423763146750156149==--

