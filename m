Content-Type: multipart/mixed; boundary="===============8047811368479229393=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] devinfo: Add support of IMEISV
Date: Thu, 31 Mar 2016 13:08:46 +0530
Message-ID: <1459409926-1968-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8047811368479229393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/devinfo.c | 44 ++++++++++++++++++++++++++++++++++++++++++=
+-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/rilmodem/devinfo.c b/drivers/rilmodem/devinfo.c
index bb1e642..2419762 100644
--- a/drivers/rilmodem/devinfo.c
+++ b/drivers/rilmodem/devinfo.c
@@ -96,6 +96,47 @@ static void ril_query_revision(struct ofono_devinfo *inf=
o,
 	CALLBACK_WITH_FAILURE(cb, NULL, data);
 }
 =

+static void query_svn_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_devinfo_query_cb_t cb =3D cbd->cb;
+	GRil *ril =3D cbd->user;
+	struct parcel rilp;
+	char *imeisv;
+
+	if (message->error !=3D RIL_E_SUCCESS)
+		goto error;
+
+	g_ril_init_parcel(message, &rilp);
+
+	imeisv =3D parcel_r_string(&rilp);
+
+	g_ril_append_print_buf(ril, "{%s}", imeisv);
+	g_ril_print_response(ril, message);
+
+	CALLBACK_WITH_SUCCESS(cb, imeisv, cbd->data);
+	g_free(imeisv);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
+static void ril_query_svn(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	GRil *ril =3D ofono_devinfo_get_data(info);
+	struct cb_data *cbd =3D cb_data_new(cb, data, ril);
+
+	if (g_ril_send(ril, RIL_REQUEST_GET_IMEISV, NULL,
+			query_svn_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
 static void query_serial_cb(struct ril_msg *message, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -178,7 +219,8 @@ static struct ofono_devinfo_driver driver =3D {
 	.query_manufacturer	=3D ril_query_manufacturer,
 	.query_model		=3D ril_query_model,
 	.query_revision		=3D ril_query_revision,
-	.query_serial		=3D ril_query_serial
+	.query_serial		=3D ril_query_serial,
+	.query_svn		=3D ril_query_svn
 };
 =

 void ril_devinfo_init(void)
-- =

1.9.1


--===============8047811368479229393==--

