Content-Type: multipart/mixed; boundary="===============4492891504675500758=="
MIME-Version: 1.0
From: Tomasz Gregorek <tomasz.gregorek@gmail.com>
Subject: [PATCH] plugins-mbm: Combining mbm_disable and reopen_callback
Date: Wed, 12 Jan 2011 14:45:42 +0100
Message-ID: <1294839942-9071-1-git-send-email-tomasz.gregorek@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4492891504675500758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tomasz Gregorek <tomasz.gregorek@stericsson.com>

Combining mbm_disable and reopen_callback into one and removing 1 second
delay between them to avoid call to reopen_callback after modem being
disconnected.
---
 plugins/mbm.c |   41 +++++++++++------------------------------
 1 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index dca9bd8..d1529ac 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -66,7 +66,6 @@ struct mbm_data {
 	gboolean have_sim;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
-	guint reopen_source;
 	enum mbm_variant variant;
 };
 =

@@ -297,21 +296,26 @@ static GAtChat *create_port(const char *device)
 	return chat;
 }
 =

-static void mbm_disconnect(gpointer user_data);
-
-static gboolean reopen_callback(gpointer user_data)
+static void mbm_disconnect(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct mbm_data *data =3D ofono_modem_get_data(modem);
 	const char *data_dev;
 =

-	data->reopen_source =3D 0;
+	DBG("");
+
+	if (data->gc)
+		ofono_gprs_context_remove(data->gc);
+
+	g_at_chat_unref(data->data_port);
+	data->data_port =3D NULL;
 =

 	data_dev =3D ofono_modem_get_string(modem, "DataDevice");
 =

 	data->data_port =3D create_port(data_dev);
+
 	if (data->data_port =3D=3D NULL)
-		return FALSE;
+		return;
 =

 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(data->data_port, mbm_debug, "Data: ");
@@ -323,30 +327,12 @@ static gboolean reopen_callback(gpointer user_data)
 =

 	data->gc =3D ofono_gprs_context_create(modem, 0,
 					"atmodem", data->data_port);
+
 	if (data->gprs && data->gc) {
 		ofono_gprs_context_set_type(data->gc,
 					OFONO_GPRS_CONTEXT_TYPE_MMS);
 		ofono_gprs_add_context(data->gprs, data->gc);
 	}
-
-	return FALSE;
-}
-
-static void mbm_disconnect(gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct mbm_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("");
-
-	if (data->gc)
-		ofono_gprs_context_remove(data->gc);
-
-	g_at_chat_unref(data->data_port);
-	data->data_port =3D NULL;
-
-	/* Waiting for the +CGEV: ME DEACT might also work */
-	data->reopen_source =3D g_timeout_add_seconds(1, reopen_callback, modem);
 }
 =

 static int mbm_enable(struct ofono_modem *modem)
@@ -425,11 +411,6 @@ static int mbm_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	if (data->reopen_source > 0) {
-		g_source_remove(data->reopen_source);
-		data->reopen_source =3D 0;
-	}
-
 	if (data->modem_port =3D=3D NULL)
 		return 0;
 =

-- =

1.7.1


--===============4492891504675500758==--

