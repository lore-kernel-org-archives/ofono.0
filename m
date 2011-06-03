Content-Type: multipart/mixed; boundary="===============7561298549584377260=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH v4] reopen once if open device failed
Date: Fri, 03 Jun 2011 17:00:10 +0800
Message-ID: <1307091610-23058-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7561298549584377260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sometimes when open the data device, it may fail. If open the data device f=
ailed,
retry once one second later.

---
 plugins/huawei.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index e791718..639ae0d 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -80,6 +80,7 @@ struct huawei_data {
 	gboolean ndis;
 	guint sim_poll_timeout;
 	guint sim_poll_count;
+	guint reopen_timeout;
 };
 =

 #define MAX_SIM_POLL_COUNT 5
@@ -107,6 +108,11 @@ static void huawei_remove(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (data->reopen_timeout > 0) {
+		g_source_remove(data->reopen_timeout);
+		data->reopen_timeout =3D 0;
+	}
+
 	ofono_modem_set_data(modem, NULL);
 =

 	if (data->modem)
@@ -465,6 +471,20 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	return chat;
 }
 =

+static void huawei_disconnect(gpointer user_data);
+
+static gboolean reopen_callback(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+
+	huawei_disconnect(user_data);
+
+	data->reopen_timeout =3D 0;
+
+	return FALSE;
+}
+
 static void huawei_disconnect(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -476,8 +496,17 @@ static void huawei_disconnect(gpointer user_data)
 	data->modem =3D NULL;
 =

 	data->modem =3D open_device(modem, "Modem", "Modem: ");
-	if (data->modem =3D=3D NULL)
+	/* retry once if failed */
+	if (data->modem =3D=3D NULL) {
+		if (data->reopen_timeout > 0)
+			return;
+
+		data->reopen_timeout =3D g_timeout_add_seconds(1,
+				reopen_callback, modem);
+
+		ofono_debug("open device failed, try to reopen it.");
 		return;
+	}
 =

 	g_at_chat_set_disconnect_function(data->modem,
 						huawei_disconnect, modem);
@@ -559,6 +588,11 @@ static int huawei_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (data->reopen_timeout > 0) {
+		g_source_remove(data->reopen_timeout);
+		data->reopen_timeout =3D 0;
+	}
+
 	if (data->sim_poll_timeout > 0) {
 		g_source_remove(data->sim_poll_timeout);
 		data->sim_poll_timeout =3D 0;
-- =

1.7.5


--===============7561298549584377260==--

