Content-Type: multipart/mixed; boundary="===============1301203761659982250=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH 6/8] gprs: data bearer for telit with PSNT
Date: Mon, 13 Aug 2012 15:23:13 +0200
Message-ID: <1344864193-23132-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1301203761659982250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: August Mayer <august.mayer@hale.at>

Telit neither supports '+CPSB' nor reports the data bearer through
'+CGREG'. It has its own +PSNT command.
---
 drivers/atmodem/gprs.c |   76 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index f87548e..ffb8dfe 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -44,6 +44,7 @@
 =

 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
 static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
+static const char *psnt_prefix[] =3D { "#PSNT:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 struct gprs_data {
@@ -247,6 +248,73 @@ static void huawei_mode_notify(GAtResult *result, gpoi=
nter user_data)
 	ofono_gprs_bearer_notify(gprs, bearer);
 }
 =

+static gint psnt_to_bearer(gint network_type)
+{
+	gint bearer;
+
+	switch (network_type) {
+	case 0:
+		bearer =3D 1;	/* GPRS */
+		break;
+	case 1:
+		bearer =3D 2;	/* EDGE */
+		break;
+	case 2:
+		bearer =3D 3;	/* UMTS */
+		break;
+	case 3:
+		bearer =3D 5;	/* HSDPA */
+		break;
+	default:
+		bearer =3D 0;
+		break;
+	}
+
+	return bearer;
+}
+
+static void at_psnt_test_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	GAtResultIter iter;
+	gint nt, bearer;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "#PSNT:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, NULL))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &nt))
+		return;
+
+	bearer =3D psnt_to_bearer(nt);
+
+	ofono_gprs_bearer_notify(gprs, bearer);
+}
+
+static void telit_mode_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	GAtResultIter iter;
+	gint nt, bearer;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "#PSNT:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &nt))
+		return;
+
+	bearer =3D psnt_to_bearer(nt);
+
+	ofono_gprs_bearer_notify(gprs, bearer);
+}
+
 static void cpsb_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -281,6 +349,14 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 		g_at_chat_register(gd->chat, "^MODE:", huawei_mode_notify,
 						FALSE, gprs, NULL);
 		break;
+	case OFONO_VENDOR_TELIT:
+		g_at_chat_register(gd->chat, "#PSNT:", telit_mode_notify,
+						FALSE, gprs, NULL);
+		g_at_chat_send(gd->chat, "AT#PSNT=3D1", none_prefix,
+						NULL, NULL, NULL);
+		g_at_chat_send(gd->chat, "AT#PSNT?", psnt_prefix,
+			at_psnt_test_cb, gprs, NULL);
+		break;
 	default:
 		g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify,
 						FALSE, gprs, NULL);
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============1301203761659982250==--

