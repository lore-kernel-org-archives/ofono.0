Content-Type: multipart/mixed; boundary="===============1485494259011731847=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 04/30] qmi: request_alloc has no meaningful failure path
Date: Wed, 28 Mar 2018 20:59:50 +0200
Message-ID: <20180328190016.28509-5-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1485494259011731847==
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
index 0c95dd18..85ed9ddc 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -171,9 +171,7 @@ static struct qmi_request *__request_alloc(struct qmi_d=
evice* device,
 	struct qmi_message_hdr *msg;
 	uint16_t headroom;
 =

-	req =3D g_try_new0(struct qmi_request, 1);
-	if (!req)
-		return NULL;
+	req =3D calloc(1, sizeof(*req));
 =

 	if (service =3D=3D QMI_SERVICE_CONTROL)
 		headroom =3D QMI_CONTROL_HDR_SIZE;
@@ -182,11 +180,7 @@ static struct qmi_request *__request_alloc(struct qmi_=
device* device,
 =

 	req->len =3D QMI_MUX_HDR_SIZE + headroom + QMI_MESSAGE_HDR_SIZE + length;
 =

-	req->buf =3D g_try_malloc(req->len);
-	if (!req->buf) {
-		g_free(req);
-		return NULL;
-	}
+	req->buf =3D malloc(req->len);
 =

 	req->client =3D client;
 =

@@ -1280,10 +1274,6 @@ bool qmi_device_discover(struct qmi_device *device, =
qmi_discover_func_t func,
 	req =3D __request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_VERSION_INFO,
 			NULL, 0, discover_callback, data, (void **) &hdr);
-	if (!req) {
-		g_free(data);
-		return false;
-	}
 =

 	data->tid =3D hdr->transaction;
 =

@@ -1307,10 +1297,6 @@ static void release_client(struct qmi_device *device,
 			QMI_CTL_RELEASE_CLIENT_ID,
 			release_req, sizeof(release_req),
 			func, user_data, (void **) &hdr);
-	if (!req) {
-		func(0x0000, 0x0000, NULL, user_data);
-		return;
-	}
 =

 	__request_submit(device, req, hdr->transaction);
 }
@@ -2026,15 +2012,6 @@ static void service_create_discover(uint8_t count,
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

 	__request_submit(device, req, hdr->transaction);
 }
@@ -2320,11 +2297,6 @@ uint16_t qmi_service_send(struct qmi_service *servic=
e,
 =

 	qmi_param_free(param);
 =

-	if (!req) {
-		g_free(data);
-		return 0;
-	}
-
 	__request_submit(device, req, hdr->transaction);
 =

 	return hdr->transaction;
-- =

2.15.1


--===============1485494259011731847==--

