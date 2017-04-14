Content-Type: multipart/mixed; boundary="===============6686452676560004069=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH QMI LTE v2 07/13] qmi: read_settings needs to call start
 network
Date: Fri, 14 Apr 2017 23:36:40 +0200
Message-ID: <20170414213646.32066-8-jonas@southpole.se>
In-Reply-To: <20170414213646.32066-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6686452676560004069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For LTE networks, a default bearer is automatically activated when
the modem registers to the network.  QMI modems, however, do not
automatically enable the network interface just because the bearer
exists; a call to "start network" needs to be made in order to
get the packet handle before get_settings will return any data and
the network interface can be configured.

This patch makes read_settings call "start network" in order to
enable the interface for the default bearer.  No new bearer will
be created with this call and the settings for the bearer will come
from the default profile, irregardless of what parameters are passed
to the "start network" method.
---
 drivers/qmimodem/gprs-context.c | 58 ++++++++++++++++++++++---------------=
----
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index b72245c..1708ce0 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -150,31 +150,6 @@ done:
 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 }
 =

-static void qmi_gprs_read_settings(struct ofono_gprs_context* gc,
-					unsigned int cid,
-					ofono_gprs_context_cb_t cb,
-					void *user_data)
-{
-	struct cb_data *cbd =3D cb_data_new(cb, user_data);
-	struct gprs_context_data *data =3D ofono_gprs_context_get_data(gc);
-
-	DBG("cid %u", cid);
-
-	data->active_context =3D cid;
-
-	cbd->user =3D gc;
-
-	if (qmi_service_send(data->wds, QMI_WDS_GET_SETTINGS, NULL,
-					get_settings_cb, cbd, g_free) > 0)
-		return;
-
-	data->active_context =3D 0;
-
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
-
-	g_free(cbd);
-}
-
 static void start_net_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -212,8 +187,6 @@ static void start_net_cb(struct qmi_result *result, voi=
d *user_data)
 =

 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 =

-	g_free(cbd);
-
 	return;
 =

 error:
@@ -221,6 +194,37 @@ error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

+/*
+ * This function gets called for "automatic" contexts, those which are
+ * not activated via activate_primary.  For these, we will still need
+ * to call start_net in order to get the packet handle for the context.
+ * The process for automatic contexts is essentially identical to that
+ * for others.
+ */
+static void qmi_gprs_read_settings(struct ofono_gprs_context* gc,
+					unsigned int cid,
+					ofono_gprs_context_cb_t cb,
+					void *user_data)
+{
+	struct gprs_context_data *data =3D ofono_gprs_context_get_data(gc);
+	struct cb_data *cbd;
+
+	DBG("cid %u", cid);
+
+	data->active_context =3D cid;
+
+	cbd  =3D cb_data_new(cb, user_data);
+	cbd->user =3D gc;
+
+	if (qmi_service_send(data->wds, QMI_WDS_START_NET, NULL,
+					start_net_cb, cbd, g_free) > 0)
+		return;
+
+	data->active_context =3D 0;
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
 static void qmi_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
 				ofono_gprs_context_cb_t cb, void *user_data)
-- =

2.9.3


--===============6686452676560004069==--

