Content-Type: multipart/mixed; boundary="===============8448950261997272474=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 02/12] mmsutil: Decode delivery_ind msg
Date: Fri, 24 Aug 2012 15:06:01 +0200
Message-ID: <1345813571-15775-3-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1345813571-15775-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8448950261997272474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/mmsutil.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/mmsutil.c b/src/mmsutil.c
index a9a12eb..7042276 100644
--- a/src/mmsutil.c
+++ b/src/mmsutil.c
@@ -964,6 +964,24 @@ static gboolean decode_send_req(struct wsp_header_iter=
 *iter,
 	return TRUE;
 }
 =

+static gboolean decode_delivery_ind(struct wsp_header_iter *iter,
+						struct mms_message *out)
+{
+	return mms_parse_headers(iter, MMS_HEADER_MMS_VERSION,
+				HEADER_FLAG_MANDATORY | HEADER_FLAG_PRESET_POS,
+				&out->version,
+				MMS_HEADER_MESSAGE_ID,
+				HEADER_FLAG_MANDATORY, &out->di.msgid,
+				MMS_HEADER_TO,
+				HEADER_FLAG_MANDATORY, &out->di.to,
+				MMS_HEADER_DATE,
+				HEADER_FLAG_MANDATORY, &out->di.date,
+				MMS_HEADER_STATUS,
+				HEADER_FLAG_MANDATORY, &out->di.dr_status,
+				MMS_HEADER_INVALID);
+}
+
+
 #define CHECK_WELL_KNOWN_HDR(hdr)			\
 	if (wsp_header_iter_next(&iter) =3D=3D FALSE)	\
 		return FALSE;				\
@@ -1016,7 +1034,7 @@ gboolean mms_message_decode(const unsigned char *pdu,
 	case MMS_MESSAGE_TYPE_ACKNOWLEDGE_IND:
 		return FALSE;
 	case MMS_MESSAGE_TYPE_DELIVERY_IND:
-		return FALSE;
+		return decode_delivery_ind(&iter, out);
 	}
 =

 	return FALSE;
@@ -1051,6 +1069,8 @@ void mms_message_free(struct mms_message *msg)
 	case MMS_MESSAGE_TYPE_ACKNOWLEDGE_IND:
 		break;
 	case MMS_MESSAGE_TYPE_DELIVERY_IND:
+		g_free(msg->di.msgid);
+		g_free(msg->di.to);
 		break;
 	}
 =

-- =

1.7.9.5


--===============8448950261997272474==--

