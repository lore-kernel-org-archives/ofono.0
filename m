Content-Type: multipart/mixed; boundary="===============4412270036515269337=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: [PATCH] qmimodem: convert tid in service header to little endian.
Date: Fri, 18 Jan 2013 11:28:02 +0100
Message-ID: <1358504882-21514-1-git-send-email-cedric.jehasse@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4412270036515269337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Cedric Jehasse <cedric.jehasse@softathome.com>

---
 drivers/qmimodem/qmi.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 3389bb1..aaefe9e 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1867,6 +1867,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	struct service_send_data *data;
 	struct qmi_request *req;
 	struct qmi_service_hdr *hdr;
+	uint16_t tid;
 =

 	if (!service)
 		return 0;
@@ -1901,12 +1902,13 @@ uint16_t qmi_service_send(struct qmi_service *servi=
ce,
 	if (device->next_service_tid < 256)
 		device->next_service_tid =3D 256;
 =

+	tid =3D device->next_service_tid++;
 	hdr->type =3D 0x00;
-	hdr->transaction =3D device->next_service_tid++;
+	hdr->transaction =3D GUINT16_TO_LE(tid);
 =

 	__request_submit(device, req, hdr->transaction);
 =

-	return hdr->transaction;
+	return tid;
 }
 =

 bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
-- =

1.7.9.5


--===============4412270036515269337==--

