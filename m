Content-Type: multipart/mixed; boundary="===============0553933129644249061=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH 1/3] atmodem: Share common devinfo utilities
Date: Tue, 11 Jan 2011 13:44:59 -0800
Message-ID: <1294782301-8592-2-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0553933129644249061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atutil.c  |   56 ++++++++++++++++++++++++++++++++++++++++++
 drivers/atmodem/atutil.h  |    2 +
 drivers/atmodem/devinfo.c |   59 +++--------------------------------------=
---
 3 files changed, 62 insertions(+), 55 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 427b098..7d7fa1b 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -438,3 +438,59 @@ gboolean at_util_parse_cscs_query(GAtResult *result,
 =

 	return FALSE;
 }
+
+typedef void (*at_util_attr_cb_t)(const struct ofono_error *error,
+					const char *attribute, void *data);
+
+const char *at_util_fixup_return(const char *line, const char *prefix)
+{
+	if (g_str_has_prefix(line, prefix) =3D=3D FALSE)
+		return line;
+
+	line +=3D strlen(prefix);
+
+	while (line[0] =3D=3D ' ')
+		line++;
+
+	return line;
+}
+
+void at_util_attr_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	at_util_attr_cb_t cb =3D cbd->cb;
+	const char *prefix =3D cbd->user;
+	struct ofono_error error;
+	int numlines =3D g_at_result_num_response_lines(result);
+	GAtResultIter iter;
+	const char *line;
+	int i;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	if (numlines =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	/*
+	 * We have to be careful here, sometimes a stray unsolicited
+	 * notification will appear as part of the response and we
+	 * cannot rely on having a prefix to recognize the actual
+	 * response line.  So use the last line only as the response
+	 */
+	for (i =3D 0; i < numlines; i++)
+		g_at_result_iter_next(&iter, NULL);
+
+	line =3D g_at_result_iter_raw_line(&iter);
+
+	cb(&error, at_util_fixup_return(line, prefix), cbd->data);
+}
+
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 3901801..cab9340 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -70,6 +70,8 @@ gboolean at_util_parse_sms_index_delivery(GAtResult *resu=
lt, const char *prefix,
 gboolean at_util_parse_cscs_supported(GAtResult *result, int *supported);
 gboolean at_util_parse_cscs_query(GAtResult *result,
 				enum at_util_charset *charset);
+const char *at_util_fixup_return(const char *line, const char *prefix);
+void at_util_attr_cb(gboolean ok, GAtResult *result, gpointer user_data);
 =

 struct cb_data {
 	void *cb;
diff --git a/drivers/atmodem/devinfo.c b/drivers/atmodem/devinfo.c
index 84ff898..b3ae9ad 100644
--- a/drivers/atmodem/devinfo.c
+++ b/drivers/atmodem/devinfo.c
@@ -35,57 +35,6 @@
 =

 #include "atmodem.h"
 =

-static const char *fixup_return(const char *line, const char *prefix)
-{
-	if (g_str_has_prefix(line, prefix) =3D=3D FALSE)
-		return line;
-
-	line =3D line + strlen(prefix);
-
-	while (line[0] =3D=3D ' ')
-		line++;
-
-	return line;
-}
-
-static void attr_cb(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	struct cb_data *cbd =3D user_data;
-	ofono_devinfo_query_cb_t cb =3D cbd->cb;
-	const char *prefix =3D cbd->user;
-	struct ofono_error error;
-	int numlines =3D g_at_result_num_response_lines(result);
-	GAtResultIter iter;
-	const char *line;
-	int i;
-
-	decode_at_error(&error, g_at_result_final_response(result));
-
-	if (!ok) {
-		cb(&error, NULL, cbd->data);
-		return;
-	}
-
-	if (numlines =3D=3D 0) {
-		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
-		return;
-	}
-
-	g_at_result_iter_init(&iter, result);
-
-	/* We have to be careful here, sometimes a stray unsolicited
-	 * notification will appear as part of the response and we
-	 * cannot rely on having a prefix to recognize the actual
-	 * response line.  So use the last line only as the response
-	 */
-	for (i =3D 0; i < numlines; i++)
-		g_at_result_iter_next(&iter, NULL);
-
-	line =3D g_at_result_iter_raw_line(&iter);
-
-	cb(&error, fixup_return(line, prefix), cbd->data);
-}
-
 static void at_query_manufacturer(struct ofono_devinfo *info,
 				ofono_devinfo_query_cb_t cb, void *data)
 {
@@ -98,7 +47,7 @@ static void at_query_manufacturer(struct ofono_devinfo *i=
nfo,
 	cbd->user =3D "+CGMI:";
 =

 	if (g_at_chat_send(chat, "AT+CGMI", NULL,
-				attr_cb, cbd, g_free) > 0)
+				at_util_attr_cb, cbd, g_free) > 0)
 		return;
 =

 error:
@@ -119,7 +68,7 @@ static void at_query_model(struct ofono_devinfo *info,
 	cbd->user =3D "+CGMM:";
 =

 	if (g_at_chat_send(chat, "AT+CGMM", NULL,
-				attr_cb, cbd, g_free) > 0)
+				at_util_attr_cb, cbd, g_free) > 0)
 		return;
 =

 error:
@@ -140,7 +89,7 @@ static void at_query_revision(struct ofono_devinfo *info,
 	cbd->user =3D "+CGMR:";
 =

 	if (g_at_chat_send(chat, "AT+CGMR", NULL,
-				attr_cb, cbd, g_free) > 0)
+				at_util_attr_cb, cbd, g_free) > 0)
 		return;
 =

 error:
@@ -161,7 +110,7 @@ static void at_query_serial(struct ofono_devinfo *info,
 	cbd->user =3D "+CGSN:";
 =

 	if (g_at_chat_send(chat, "AT+CGSN", NULL,
-				attr_cb, cbd, g_free) > 0)
+				at_util_attr_cb, cbd, g_free) > 0)
 		return;
 =

 error:
-- =

1.7.0.4


--===============0553933129644249061==--

