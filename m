Content-Type: multipart/mixed; boundary="===============3722378358895232737=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 06/12] service: Support M-Delivery.ind in
 mms_service_push_notify()
Date: Fri, 24 Aug 2012 15:06:05 +0200
Message-ID: <1345813571-15775-7-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1345813571-15775-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3722378358895232737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/src/service.c b/src/service.c
index ec1b1b9..8087477 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2325,6 +2325,21 @@ static void process_request_queue(struct mms_service=
 *service)
 						bearer_idle_timeout, service);
 }
 =

+static void dump_delivery_ind(struct mms_message *msg)
+{
+	char buf[128];
+
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&msg->di.date));
+	buf[127] =3D '\0';
+
+	mms_info("MMS version: %u.%u\n", (msg->version & 0x70) >> 4,
+						msg->version & 0x0f);
+	mms_info("Msg ID: %s\n", msg->di.msgid);
+	mms_info("To: %s\n", msg->di.to);
+	mms_info("Date: %s\n", buf);
+	mms_info("Delivery Report status: %d\n", msg->di.dr_status);
+}
+
 static void dump_notification_ind(struct mms_message *msg)
 {
 	char buf[128];
@@ -2370,6 +2385,22 @@ void mms_service_push_notify(struct mms_service *ser=
vice,
 	if (mms_message_decode(data + nread, len - nread, msg) =3D=3D FALSE)
 		goto error;
 =

+	if (msg->type =3D=3D MMS_MESSAGE_TYPE_DELIVERY_IND) {
+		msg->uuid =3D g_strdup(uuid);
+
+		dump_delivery_ind(msg);
+
+		meta =3D mms_store_meta_open(service->identity, uuid);
+		if (meta =3D=3D NULL)
+			goto error;
+
+		g_key_file_set_string(meta, "info", "state", "notification");
+
+		mms_store_meta_close(service->identity, uuid, meta, TRUE);
+
+		return;
+	}
+
 	if (msg->type !=3D MMS_MESSAGE_TYPE_NOTIFICATION_IND)
 		goto error;
 =

-- =

1.7.9.5


--===============3722378358895232737==--

