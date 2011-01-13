Content-Type: multipart/mixed; boundary="===============1092481810548968406=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH] AT modem: fix COLR reporting
Date: Thu, 13 Jan 2011 16:18:01 +0200
Message-ID: <1294928281-11905-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1092481810548968406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

AT+COLR does not have a local override; it cannot be factored with the
other commands.

This partially reverts commit f2baa88d7577649358f1f8587e5a9b6aa730ca41.
---
 drivers/atmodem/call-settings.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/call-settings.c b/drivers/atmodem/call-setting=
s.c
index 7b00357..eaab89e 100644
--- a/drivers/atmodem/call-settings.c
+++ b/drivers/atmodem/call-settings.c
@@ -331,7 +331,34 @@ error:
 =

 static void colr_query_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
-	query_template("+COLR:", ok, result, user_data);
+	struct cb_data *cbd =3D user_data;
+	ofono_call_settings_status_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	GAtResultIter iter;
+	int status;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "+COLR:") =3D=3D FALSE)
+		goto error;
+
+	if (g_at_result_iter_next_number(&iter, &status) =3D=3D FALSE)
+		goto error;
+
+	DBG("network: %d", status);
+
+	cb(&error, status, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 }
 =

 static void at_colr_query(struct ofono_call_settings *cs,
-- =

1.7.1


--===============1092481810548968406==--

