Content-Type: multipart/mixed; boundary="===============4504622532175125418=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 01/12] qmi: remove unused fields of service_send_data
Date: Thu, 29 Mar 2018 15:57:50 +0200
Message-ID: <20180329135801.5981-2-jonas@southpole.se>
In-Reply-To: <20180329135801.5981-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4504622532175125418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After setting up the request structure, qmi_service_send makes no
further use of the 'param' and 'service' fields of the service_send_data
structure.  This patch removes those fields and frees 'param'
immediately after the request has been allocated and the parameter data
thereby copied into the send buffer.
---
 drivers/qmimodem/qmi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 257afd0d..caf099b1 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2238,8 +2238,6 @@ bool qmi_service_get_version(struct qmi_service *serv=
ice,
 }
 =

 struct service_send_data {
-	struct qmi_service *service;
-	struct qmi_param *param;
 	qmi_result_func_t func;
 	void *user_data;
 	qmi_destroy_func_t destroy;
@@ -2250,8 +2248,6 @@ static void service_send_free(struct service_send_dat=
a *data)
 	if (data->destroy)
 		data->destroy(data->user_data);
 =

-	qmi_param_free(data->param);
-
 	g_free(data);
 }
 =

@@ -2308,22 +2304,23 @@ uint16_t qmi_service_send(struct qmi_service *servi=
ce,
 	if (!data)
 		return 0;
 =

-	data->service =3D service;
-	data->param =3D param;
 	data->func =3D func;
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
 =

 	req =3D __request_alloc(service->type, service->client_id,
 				message, QMI_SERVICE_HDR_SIZE,
-				data->param ? data->param->data : NULL,
-				data->param ? data->param->length : 0,
+				param ? param->data : NULL,
+				param ? param->length : 0,
 				service_send_callback, data, (void **) &hdr);
+
 	if (!req) {
 		g_free(data);
 		return 0;
 	}
 =

+	qmi_param_free(param);
+
 	if (device->next_service_tid < 256)
 		device->next_service_tid =3D 256;
 =

-- =

2.15.1


--===============4504622532175125418==--

