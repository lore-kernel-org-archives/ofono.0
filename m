Content-Type: multipart/mixed; boundary="===============4668610594456503258=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH] reopen data device once if open data device failed
Date: Wed, 11 May 2011 10:25:09 +0800
Message-ID: <1305080709-1888-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4668610594456503258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sometimes when open the data device, it may fail. If open the data device
failed, retry once one second later.

---
 plugins/huawei.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index e791718..b888b0f 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -51,6 +51,7 @@
 #include <ofono/phonebook.h>
 #include <ofono/message-waiting.h>
 #include <ofono/log.h>
+#include <ofono.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -80,6 +81,8 @@ struct huawei_data {
 	gboolean ndis;
 	guint sim_poll_timeout;
 	guint sim_poll_count;
+	guint reopen_source;
+	ofono_bool_t online;
 };
 =

 #define MAX_SIM_POLL_COUNT 5
@@ -107,6 +110,11 @@ static void huawei_remove(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (data->reopen_source > 0) {
+		g_source_remove(data->reopen_source);
+		data->reopen_source =3D 0;
+	}
+
 	ofono_modem_set_data(modem, NULL);
 =

 	if (data->modem)
@@ -465,6 +473,14 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	return chat;
 }
 =

+static void huawei_disconnect(gpointer user_data);
+
+static gboolean reopen_callback(gpointer user_data)
+{
+	huawei_disconnect(user_data);
+	return FALSE;
+}
+
 static void huawei_disconnect(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -476,15 +492,26 @@ static void huawei_disconnect(gpointer user_data)
 	data->modem =3D NULL;
 =

 	data->modem =3D open_device(modem, "Modem", "Modem: ");
-	if (data->modem =3D=3D NULL)
+	/* retry once if failed */
+	if (data->modem =3D=3D NULL && data->reopen_source =3D=3D 0) {
+		data->reopen_source =3D
+			g_timeout_add_seconds(1, reopen_callback, modem);
+
+		ofono_debug("open device failed, try to reopen it.");
 		return;
+	}
+
+	if (data->reopen_source > 0)
+		data->reopen_source =3D 0;
 =

 	g_at_chat_set_disconnect_function(data->modem,
 						huawei_disconnect, modem);
 =

-	/* gprs_context has been destructed and needs not reopen */
-	if (data->gc =3D=3D NULL)
-		return;
+	/* gprs_context has been destructed, if offline needs not recreate.
+	    if device is online, need recreate.
+	 */
+	 if (data->gc =3D=3D NULL && data->online =3D=3D FALSE)
+		return;
 =

 	ofono_gprs_context_remove(data->gc);
 =

@@ -492,6 +519,13 @@ static void huawei_disconnect(gpointer user_data)
 			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
 		ofono_info("Reopened GPRS context channel");
 =

+		if (__ofono_modem_find_atom(modem,
+				OFONO_ATOM_TYPE_GPRS) =3D=3D NULL) {
+			data->gprs =3D ofono_gprs_create(modem,
+					OFONO_VENDOR_HUAWEI,
+					"atmodem", data->pcui);
+		}
+
 		data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
 								data->modem);
 =

@@ -559,6 +593,11 @@ static int huawei_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (data->reopen_source > 0) {
+		g_source_remove(data->reopen_source);
+		data->reopen_source =3D 0;
+	}
+
 	if (data->sim_poll_timeout > 0) {
 		g_source_remove(data->sim_poll_timeout);
 		data->sim_poll_timeout =3D 0;
@@ -588,6 +627,12 @@ static void set_online_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	ofono_modem_online_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
 =

+	if (ok) {
+		struct huawei_data *data =3D cbd->user;
+
+		data->online =3D TRUE;
+	}
+
 	decode_at_error(&error, g_at_result_final_response(result));
 	cb(&error, cbd->data);
 }
@@ -603,6 +648,7 @@ static void set_offline_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 		data->gc =3D NULL;
 		data->gprs =3D NULL;
+		data->online =3D FALSE;
 	}
 =

 	decode_at_error(&error, g_at_result_final_response(result));
-- =

1.7.5


--===============4668610594456503258==--

