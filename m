Content-Type: multipart/mixed; boundary="===============3997252830475718317=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 2/6] qmi: request_alloc has no meaningful failure path
Date: Tue, 03 Apr 2018 16:50:52 +0200
Message-ID: <20180403145056.25817-2-jonas@southpole.se>
In-Reply-To: <20180403145056.25817-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3997252830475718317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The only way request_alloc can fail is if one of the memory allocation
routines fail to allocate memory.  However, Linux memory allocation
doesn't really fail in this manner; memory can be overcommited and the
out-of-memory reaper will take care of re-establishing the balance when
excess memory is actually accessed.

Given this, request_alloc will never return anything other than success
and the failure paths will never be exercised.
---
 drivers/qmimodem/qmi.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 436f96a0..a980839b 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -170,9 +170,7 @@ static struct qmi_request *__request_alloc(uint8_t serv=
ice,
 	struct qmi_message_hdr *msg;
 	uint16_t headroom;
 =

-	req =3D g_try_new0(struct qmi_request, 1);
-	if (!req)
-		return NULL;
+	req =3D g_new0(struct qmi_request, 1);
 =

 	if (service =3D=3D QMI_SERVICE_CONTROL)
 		headroom =3D QMI_CONTROL_HDR_SIZE;
@@ -181,11 +179,7 @@ static struct qmi_request *__request_alloc(uint8_t ser=
vice,
 =

 	req->len =3D QMI_MUX_HDR_SIZE + headroom + QMI_MESSAGE_HDR_SIZE + length;
 =

-	req->buf =3D g_try_malloc(req->len);
-	if (!req->buf) {
-		g_free(req);
-		return NULL;
-	}
+	req->buf =3D g_malloc(req->len);
 =

 	req->client =3D client;
 =

@@ -1282,10 +1276,6 @@ bool qmi_device_discover(struct qmi_device *device, =
qmi_discover_func_t func,
 	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_VERSION_INFO,
 			NULL, 0, discover_callback, data, (void **) &hdr);
-	if (!req) {
-		g_free(data);
-		return false;
-	}
 =

 	data->tid =3D hdr->transaction;
 =

@@ -1309,10 +1299,6 @@ static void release_client(struct qmi_device *device,
 			QMI_CTL_RELEASE_CLIENT_ID,
 			release_req, sizeof(release_req),
 			func, user_data, (void **) &hdr);
-	if (!req) {
-		func(0x0000, 0x0000, NULL, user_data);
-		return;
-	}
 =

 	__request_submit(device, req);
 }
@@ -2028,15 +2014,6 @@ static void service_create_discover(uint8_t count,
 			QMI_CTL_GET_CLIENT_ID,
 			client_req, sizeof(client_req),
 			service_create_callback, data, (void **) &hdr);
-	if (!req) {
-		if (data->timeout > 0)
-			g_source_remove(data->timeout);
-
-		data->timeout =3D g_timeout_add_seconds(0,
-						service_create_reply, data);
-		__qmi_device_discovery_started(device, &data->super);
-		return;
-	}
 =

 	__request_submit(device, req);
 }
@@ -2320,11 +2297,6 @@ uint16_t qmi_service_send(struct qmi_service *servic=
e,
 				param ? param->length : 0,
 				service_send_callback, data, (void **) &hdr);
 =

-	if (!req) {
-		g_free(data);
-		return 0;
-	}
-
 	qmi_param_free(param);
 =

 	__request_submit(device, req);
-- =

2.15.1


--===============3997252830475718317==--

