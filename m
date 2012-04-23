Content-Type: multipart/mixed; boundary="===============0611639644509821697=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v3 1/2] mmsutil: add mms_message_status_get_string API
Date: Mon, 23 Apr 2012 10:55:31 +0200
Message-ID: <1335171332-13855-2-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1335171332-13855-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0611639644509821697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/mmsutil.c |   18 ++++++++++++++++++
 src/mmsutil.h |    1 +
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/src/mmsutil.c b/src/mmsutil.c
index c507d6f..89f1c29 100644
--- a/src/mmsutil.c
+++ b/src/mmsutil.c
@@ -1661,3 +1661,21 @@ gboolean mms_message_encode(struct mms_message *msg,=
 int fd)
 =

 	return FALSE;
 }
+
+const char *mms_message_status_get_string(enum mms_message_status status)
+{
+	switch (status) {
+	case MMS_MESSAGE_STATUS_DOWNLOADED:
+		return "downloaded";
+	case MMS_MESSAGE_STATUS_RECEIVED:
+		return "received";
+	case MMS_MESSAGE_STATUS_READ:
+		return "read";
+	case MMS_MESSAGE_STATUS_SENT:
+		return "sent";
+	case MMS_MESSAGE_STATUS_DRAFT:
+		return "draft";
+	}
+
+	return NULL;
+}
diff --git a/src/mmsutil.h b/src/mmsutil.h
index b2a0418..79c74db 100644
--- a/src/mmsutil.h
+++ b/src/mmsutil.h
@@ -146,3 +146,4 @@ gboolean mms_message_decode(const unsigned char *pdu,
 				unsigned int len, struct mms_message *out);
 gboolean mms_message_encode(struct mms_message *msg, int fd);
 void mms_message_free(struct mms_message *msg);
+const char *mms_message_status_get_string(enum mms_message_status status);
-- =

1.7.4.4


--===============0611639644509821697==--

