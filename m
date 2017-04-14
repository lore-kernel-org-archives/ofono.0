Content-Type: multipart/mixed; boundary="===============6904001402145843256=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH QMI LTE v2 08/13] qmi: don't leak cbd and rely on destroy
 function
Date: Fri, 14 Apr 2017 23:36:41 +0200
Message-ID: <20170414213646.32066-9-jonas@southpole.se>
In-Reply-To: <20170414213646.32066-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6904001402145843256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/gprs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 05ad4bd..404c975 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -94,7 +94,7 @@ static void qmi_set_attached(struct ofono_gprs *gprs, int=
 attached,
 					ofono_gprs_cb_t cb, void *user_data)
 {
 	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
-	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	struct cb_data *cbd;
 	struct qmi_param *param;
 	uint8_t action;
 =

@@ -109,6 +109,7 @@ static void qmi_set_attached(struct ofono_gprs *gprs, i=
nt attached,
 	if (!param)
 		goto error;
 =

+	cbd =3D cb_data_new(cb, user_data);
 	if (qmi_service_send(data->nas, QMI_NAS_ATTACH_DETACH, param,
 					attach_detach_cb, cbd, g_free) > 0)
 		return;
@@ -117,8 +118,6 @@ static void qmi_set_attached(struct ofono_gprs *gprs, i=
nt attached,
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
-
-	g_free(cbd);
 }
 =

 static void get_ss_info_cb(struct qmi_result *result, void *user_data)
-- =

2.9.3


--===============6904001402145843256==--

