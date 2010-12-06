Content-Type: multipart/mixed; boundary="===============4798374769808296060=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 13/14] atmodem: add CNAP to call-settings
Date: Mon, 06 Dec 2010 18:12:41 -0200
Message-ID: <1291666362-19128-13-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291666362-19128-12-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4798374769808296060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/call-settings.c |   53 +++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/call-settings.c b/drivers/atmodem/call-setting=
s.c
index 7e1b422..b3e8ea6 100644
--- a/drivers/atmodem/call-settings.c
+++ b/drivers/atmodem/call-settings.c
@@ -45,6 +45,7 @@ static const char *colp_prefix[] =3D { "+COLP:", NULL };
 static const char *clip_prefix[] =3D { "+CLIP:", NULL };
 static const char *ccwa_prefix[] =3D { "+CCWA:", NULL };
 static const char *colr_prefix[] =3D { "+COLR:", NULL };
+static const char *cnap_prefix[] =3D { "+CNAP:", NULL };
 =

 static void ccwa_query_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
@@ -188,6 +189,57 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

+static void cnap_query_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
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
+	if (g_at_result_iter_next(&iter, "+CNAP:") =3D=3D FALSE)
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
+}
+
+static void at_cnap_query(struct ofono_call_settings *cs,
+				ofono_call_settings_status_cb_t cb, void *data)
+{
+	GAtChat *chat =3D ofono_call_settings_get_data(cs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	if (g_at_chat_send(chat, "AT+CNAP?", cnap_prefix,
+				cnap_query_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
 static void colp_query_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
 	struct cb_data *cbd =3D user_data;
@@ -404,6 +456,7 @@ static struct ofono_call_settings_driver driver =3D {
 	.probe =3D at_call_settings_probe,
 	.remove =3D at_call_settings_remove,
 	.clip_query =3D at_clip_query,
+	.cnap_query =3D at_cnap_query,
 	.colp_query =3D at_colp_query,
 	.clir_query =3D at_clir_query,
 	.clir_set =3D at_clir_set,
-- =

1.7.3.2


--===============4798374769808296060==--

