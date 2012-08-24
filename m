Content-Type: multipart/mixed; boundary="===============0046235635189149866=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 01/12] mmsutil: Define mms_delivery_ind struct
Date: Fri, 24 Aug 2012 15:06:00 +0200
Message-ID: <1345813571-15775-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1345813571-15775-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0046235635189149866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/mmsutil.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/mmsutil.h b/src/mmsutil.h
index cc3ec67..e32c761 100644
--- a/src/mmsutil.h
+++ b/src/mmsutil.h
@@ -122,6 +122,13 @@ struct mms_notification_resp_ind {
 	enum mms_message_notify_status notify_status;
 };
 =

+struct mms_delivery_ind {
+	enum mms_message_delivery_status dr_status;
+	char *msgid;
+	char *to;
+	time_t date;
+};
+
 struct mms_attachment {
 	unsigned char *data;
 	size_t offset;
@@ -143,6 +150,7 @@ struct mms_message {
 		struct mms_send_req sr;
 		struct mms_send_conf sc;
 		struct mms_notification_resp_ind nri;
+		struct mms_delivery_ind di;
 	};
 };
 =

-- =

1.7.9.5


--===============0046235635189149866==--

