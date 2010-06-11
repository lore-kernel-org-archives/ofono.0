Content-Type: multipart/mixed; boundary="===============8329460243360180991=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/15] stkutil: Add the MMS Notification Download envelope
 builder
Date: Fri, 11 Jun 2010 12:39:56 +0200
Message-ID: <1276252800-27515-11-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276252800-27515-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8329460243360180991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   38 ++++++++++++++++++++++++++++++++++++++
 src/stkutil.h |    6 ++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index ada63da..f3610d8 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4402,6 +4402,32 @@ static gboolean build_dataobj_i_wlan_access_status(s=
truct stk_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.86 */
+static gboolean build_dataobj_mms_notification(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_common_byte_array *msg =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_MMS_NOTIFICATION;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, TRUE) &&
+		stk_tlv_builder_append_bytes(tlv, msg->array, msg->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.87 */
+static gboolean build_dataobj_last_envelope(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const ofono_bool_t *last =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_LAST_ENVELOPE;
+
+	if (!*last)
+		return TRUE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.90 */
 static gboolean build_dataobj_broadcast_network_information(
 						struct stk_tlv_builder *tlv,
@@ -5149,6 +5175,18 @@ const unsigned char *stk_pdu_from_envelope(const str=
uct stk_envelope *envelope,
 					&envelope->mms_status.transfer_status,
 					NULL);
 		break;
+	case STK_ENVELOPE_TYPE_MMS_NOTIFICATION:
+		ok =3D build_dataobj(&builder,
+					build_envelope_dataobj_device_ids,
+					DATAOBJ_FLAG_CR,
+					envelope,
+					build_dataobj_mms_notification,
+					DATAOBJ_FLAG_CR,
+					&envelope->mms_notification.msg,
+					build_dataobj_last_envelope, 0,
+					&envelope->mms_notification.last,
+					NULL);
+		break;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index fdc79ed..dac8dcc 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1447,6 +1447,11 @@ struct stk_envelope_mms_transfer_status {
 	struct stk_mms_transfer_status transfer_status;
 };
 =

+struct stk_envelope_mms_notification_download {
+	struct stk_common_byte_array msg;
+	ofono_bool_t last;
+};
+
 struct stk_envelope {
 	enum stk_envelope_type type;
 	enum stk_device_identity_type src;
@@ -1461,6 +1466,7 @@ struct stk_envelope {
 		struct stk_envelope_timer_expiration timer_expiration;
 		struct stk_envelope_ussd_data_download ussd_data_download;
 		struct stk_envelope_mms_transfer_status mms_status;
+		struct stk_envelope_mms_notification_download mms_notification;
 	};
 };
 =

-- =

1.7.1.86.g0e460.dirty


--===============8329460243360180991==--

