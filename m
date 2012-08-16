Content-Type: multipart/mixed; boundary="===============3296793866789435057=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH] gprs: data bearer for telit with PSNT
Date: Thu, 16 Aug 2012 10:11:16 +0200
Message-ID: <1345104676-12706-1-git-send-email-christopher.vogl@hale.at>
In-Reply-To: <5029F5D2.5060304@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3296793866789435057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: August Mayer <august.mayer@hale.at>

Telit neither supports '+CPSB' nor reports the data bearer through
'+CGREG'. It has its own +PSNT command.
---
 drivers/atmodem/gprs.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 65a8b7b..2182f03 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -247,6 +247,41 @@ static void huawei_mode_notify(GAtResult *result, gpoi=
nter user_data)
 	ofono_gprs_bearer_notify(gprs, bearer);
 }
 =

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
+	if (!g_at_result_iter_next_number(&iter,&nt))
+		return;
+
+	switch (nt) {
+	case 0:
+		bearer =3D 1;    /* GPRS */
+		break;
+	case 1:
+		bearer =3D 2;    /* EDGE */
+		break;
+	case 2:
+		bearer =3D 3;    /* UMTS */
+		break;
+	case 3:
+		bearer =3D 5;    /* HSDPA */
+		break;
+	default:
+		bearer =3D 0;
+		break;
+	}
+	=

+	ofono_gprs_bearer_notify(gprs, bearer);
+} =

+
 static void cpsb_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -281,6 +316,11 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 		g_at_chat_register(gd->chat, "^MODE:", huawei_mode_notify,
 						FALSE, gprs, NULL);
 		break;
+	case OFONO_VENDOR_TELIT:
+		g_at_chat_register(gd->chat, "#PSNT:", telit_mode_notify,
+						FALSE, gprs, NULL);
+		g_at_chat_send(gd->chat, "AT#PSNT=3D1", none_prefix,
+						NULL, NULL, NULL);
 	default:
 		g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify,
 						FALSE, gprs, NULL);
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============3296793866789435057==--

