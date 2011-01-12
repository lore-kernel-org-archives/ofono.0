Content-Type: multipart/mixed; boundary="===============3513195772734377534=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 7/9] atmodem: add cdip to call-settings
Date: Wed, 12 Jan 2011 09:27:45 -0200
Message-ID: <1294831667-7447-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294831667-7447-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3513195772734377534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/call-settings.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/call-settings.c b/drivers/atmodem/call-setting=
s.c
index 3340d5a..2529c8e 100644
--- a/drivers/atmodem/call-settings.c
+++ b/drivers/atmodem/call-settings.c
@@ -46,6 +46,7 @@ static const char *clip_prefix[] =3D { "+CLIP:", NULL };
 static const char *ccwa_prefix[] =3D { "+CCWA:", NULL };
 static const char *colr_prefix[] =3D { "+COLR:", NULL };
 static const char *cnap_prefix[] =3D { "+CNAP:", NULL };
+static const char *cdip_prefix[] =3D { "+CDIP:", NULL };
 =

 static void ccwa_query_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
@@ -199,6 +200,30 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

+static void cdip_query_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	query_template("+CDIP:", ok, result, user_data);
+}
+
+static void at_cdip_query(struct ofono_call_settings *cs,
+				ofono_call_settings_status_cb_t cb, void *data)
+{
+	GAtChat *chat =3D ofono_call_settings_get_data(cs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	if (g_at_chat_send(chat, "AT+CDIP?", cdip_prefix,
+				cdip_query_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
 static void cnap_query_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
 	query_template("+CNAP:", ok, result, user_data);
@@ -387,6 +412,7 @@ static struct ofono_call_settings_driver driver =3D {
 	.remove =3D at_call_settings_remove,
 	.clip_query =3D at_clip_query,
 	.cnap_query =3D at_cnap_query,
+	.cdip_query =3D at_cdip_query,
 	.colp_query =3D at_colp_query,
 	.clir_query =3D at_clir_query,
 	.clir_set =3D at_clir_set,
-- =

1.7.3.5


--===============3513195772734377534==--

