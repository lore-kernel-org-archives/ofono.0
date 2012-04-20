Content-Type: multipart/mixed; boundary="===============0996837159710991845=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH 1/3] mmsutil: add mms_message_status_get_string API
Date: Fri, 20 Apr 2012 18:39:04 +0200
Message-ID: <1334939946-8835-2-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1334939946-8835-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0996837159710991845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/mmsutil.c |   25 +++++++++++++++++++++++++
 src/mmsutil.h |    1 +
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/src/mmsutil.c b/src/mmsutil.c
index c507d6f..725849b 100644
--- a/src/mmsutil.c
+++ b/src/mmsutil.c
@@ -1661,3 +1661,28 @@ gboolean mms_message_encode(struct mms_message *msg,=
 int fd)
 =

 	return FALSE;
 }
+
+char *mms_message_status_get_string(enum mms_message_status status)
+{
+	char *status_str;
+
+	switch (status) {
+	case MMS_MESSAGE_STATUS_DOWNLOADED:
+		status_str =3D "downloaded";
+		break;
+	case MMS_MESSAGE_STATUS_RECEIVED:
+		status_str =3D "received";
+		break;
+	case MMS_MESSAGE_STATUS_READ:
+		status_str =3D "read";
+		break;
+	case MMS_MESSAGE_STATUS_SENT:
+		status_str =3D "sent";
+		break;
+	case MMS_MESSAGE_STATUS_DRAFT:
+		status_str =3D "draft";
+		break;
+	}
+
+	return status_str;
+}
diff --git a/src/mmsutil.h b/src/mmsutil.h
index b2a0418..d3b507f 100644
--- a/src/mmsutil.h
+++ b/src/mmsutil.h
@@ -146,3 +146,4 @@ gboolean mms_message_decode(const unsigned char *pdu,
 				unsigned int len, struct mms_message *out);
 gboolean mms_message_encode(struct mms_message *msg, int fd);
 void mms_message_free(struct mms_message *msg);
+char *mms_message_status_get_string(enum mms_message_status status);
-- =

1.7.4.4


--===============0996837159710991845==--

