Content-Type: multipart/mixed; boundary="===============1378342192487756332=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 4/8] qmi: implement read_settings for automatic contexts
Date: Tue, 11 Apr 2017 10:18:14 +0200
Message-ID: <20170411081818.19544-5-jonas@southpole.se>
In-Reply-To: <20170411081818.19544-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1378342192487756332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For LTE, a context is created automatically when the modem registers
to the network.  The read_settings function is called for these
automatic contexts to get their configuration.
---
 drivers/qmimodem/gprs-context.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index 1ae2a5a..3841c7e 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -153,6 +153,31 @@ done:
 	g_free(cbd);
 }
 =

+static void qmi_gprs_read_settings(struct ofono_gprs_context* gc,
+					unsigned int cid,
+					ofono_gprs_context_cb_t cb,
+					void *user_data)
+{
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	struct gprs_context_data *data =3D ofono_gprs_context_get_data(gc);
+
+	DBG("cid %u", cid);
+
+	data->active_context =3D cid;
+
+	cbd->user =3D gc;
+
+	if (qmi_service_send(data->wds, QMI_WDS_GET_SETTINGS, NULL,
+					get_settings_cb, cbd, NULL) > 0)
+		return;
+
+	data->active_context =3D 0;
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
 static void start_net_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -450,6 +475,7 @@ static struct ofono_gprs_context_driver driver =3D {
 	.remove			=3D qmi_gprs_context_remove,
 	.activate_primary	=3D qmi_activate_primary,
 	.deactivate_primary	=3D qmi_deactivate_primary,
+	.read_settings		=3D qmi_gprs_read_settings,
 };
 =

 void qmi_gprs_context_init(void)
-- =

2.9.3


--===============1378342192487756332==--

