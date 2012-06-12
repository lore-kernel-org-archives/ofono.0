Content-Type: multipart/mixed; boundary="===============4430171217144852402=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 4/6] mmsutil: Encode delivery-report in send_req msg
Date: Tue, 12 Jun 2012 16:04:13 +0200
Message-ID: <1339509855-7467-5-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1339509855-7467-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4430171217144852402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/mmsutil.c |    9 ++++++++-
 src/mmsutil.h |    5 +++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/src/mmsutil.c b/src/mmsutil.c
index 89f1c29..a9a12eb 100644
--- a/src/mmsutil.c
+++ b/src/mmsutil.c
@@ -1395,7 +1395,7 @@ static header_encoder encoder_for_type(enum mms_heade=
r header)
 	case MMS_HEADER_DATE:
 		return NULL;
 	case MMS_HEADER_DELIVERY_REPORT:
-		return NULL;
+		return encode_short;
 	case MMS_HEADER_DELIVERY_TIME:
 		return NULL;
 	case MMS_HEADER_EXPIRY:
@@ -1614,12 +1614,19 @@ static gboolean mms_encode_send_req(struct mms_mess=
age *msg,
 {
 	const char *empty_from =3D "";
 	GSList *item;
+	enum mms_message_value_bool dr;
+
+	if (msg->sr.dr =3D=3D TRUE)
+		dr =3D MMS_MESSAGE_VALUE_BOOL_YES;
+	else
+		dr =3D MMS_MESSAGE_VALUE_BOOL_NO;
 =

 	if (mms_encode_headers(fb, MMS_HEADER_MESSAGE_TYPE, &msg->type,
 				MMS_HEADER_TRANSACTION_ID, &msg->transaction_id,
 				MMS_HEADER_MMS_VERSION, &msg->version,
 				MMS_HEADER_FROM, &empty_from,
 				MMS_HEADER_TO, &msg->sr.to,
+				MMS_HEADER_DELIVERY_REPORT, &dr,
 				MMS_HEADER_CONTENT_TYPE, &msg->sr.content_type,
 				MMS_HEADER_INVALID) =3D=3D FALSE)
 		return FALSE;
diff --git a/src/mmsutil.h b/src/mmsutil.h
index 6c7b37f..cc3ec67 100644
--- a/src/mmsutil.h
+++ b/src/mmsutil.h
@@ -73,6 +73,11 @@ enum mms_message_sender_visibility {
 	MMS_MESSAGE_SENDER_VISIBILITY_SHOW =3D		129,
 };
 =

+enum mms_message_value_bool {
+	MMS_MESSAGE_VALUE_BOOL_YES =3D			128,
+	MMS_MESSAGE_VALUE_BOOL_NO =3D			129,
+};
+
 enum mms_message_version {
 	MMS_MESSAGE_VERSION_1_0 =3D	0x90,
 	MMS_MESSAGE_VERSION_1_1 =3D	0x91,
-- =

1.7.4.1


--===============4430171217144852402==--

