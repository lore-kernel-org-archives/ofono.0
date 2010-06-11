Content-Type: multipart/mixed; boundary="===============4427953331066347223=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 10/15] stkutil: Add the MMS Transfer Status envelope builder
Date: Fri, 11 Jun 2010 12:39:55 +0200
Message-ID: <1276252800-27515-10-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276252800-27515-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4427953331066347223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   11 +++++++
 2 files changed, 95 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 2efd25a..ada63da 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3589,6 +3589,43 @@ static gboolean build_dataobj_ussd_string(struct stk=
_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.18 */
+static gboolean build_dataobj_file_list(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	GSList *l =3D (void *) data;
+	const struct stk_file *file;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_FILE_LIST;
+
+	if (stk_tlv_builder_open_container(tlv, cr, tag, TRUE) !=3D TRUE)
+		return FALSE;
+
+	if (stk_tlv_builder_append_byte(tlv, g_slist_length(l)) !=3D TRUE)
+		return FALSE;
+
+	for (; l; l =3D l->next) {
+		file =3D l->data;
+
+		if (stk_tlv_builder_append_bytes(tlv, file->file,
+							file->len) !=3D TRUE)
+			return FALSE;
+	}
+
+	return stk_tlv_builder_close_container(tlv);
+}
+
+/* Shortcut for a single File element */
+static gboolean build_dataobj_file(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	GSList l =3D {
+		.data =3D (void *) data,
+		.next =3D NULL,
+	};
+
+	return build_dataobj_file_list(tlv, &l, cr);
+}
+
 /* Described in TS 102.223 Section 8.19 */
 static gboolean build_dataobj_location_info(struct stk_tlv_builder *tlv,
 						const void *data, gboolean cr)
@@ -4319,6 +4356,40 @@ static gboolean build_dataobj_meid(struct stk_tlv_bu=
ilder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.83 */
+static gboolean build_dataobj_mms_id(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const struct stk_mms_id *id =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_MMS_ID;
+
+	/* Assume the length is never 0 for a valid ID, however the whole
+	 * data object's presence is conditional.  */
+	if (id->len =3D=3D 0)
+		return TRUE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_bytes(tlv, id->id, id->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.84 */
+static gboolean build_dataobj_mms_transfer_status(struct stk_tlv_builder *=
tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_mms_transfer_status *mts =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_MMS_TRANSFER_STATUS;
+
+	/* Assume the length is never 0 for a valid Result message, however
+	 * the whole data object's presence is conditional.  */
+	if (mts->len =3D=3D 0)
+		return TRUE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_bytes(tlv, mts->status, mts->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 131.111 Section 8.84 */
 static gboolean build_dataobj_i_wlan_access_status(struct stk_tlv_builder =
*tlv,
 						const void *data, gboolean cr)
@@ -5065,6 +5136,19 @@ const unsigned char *stk_pdu_from_envelope(const str=
uct stk_envelope *envelope,
 					&envelope->ussd_data_download.string,
 					NULL);
 		break;
+	case STK_ENVELOPE_TYPE_MMS_TRANSFER_STATUS:
+		ok =3D build_dataobj(&builder,
+					build_envelope_dataobj_device_ids,
+					DATAOBJ_FLAG_CR,
+					envelope,
+					build_dataobj_file, DATAOBJ_FLAG_CR,
+					&envelope->mms_status.transfer_file,
+					build_dataobj_mms_id, 0,
+					&envelope->mms_status.id,
+					build_dataobj_mms_transfer_status, 0,
+					&envelope->mms_status.transfer_status,
+					NULL);
+		break;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 74ec600..fdc79ed 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -32,6 +32,10 @@ enum stk_envelope_type {
 	STK_ENVELOPE_TYPE_EVENT_DOWNLOAD =3D	0xD6,
 	STK_ENVELOPE_TYPE_TIMER_EXPIRATION =3D	0xD7,
 	STK_ENVELOPE_TYPE_USSD_DOWNLOAD =3D	0xD9,
+	STK_ENVELOPE_TYPE_MMS_TRANSFER_STATUS =3D	0xDA,
+	STK_ENVELOPE_TYPE_MMS_NOTIFICATION =3D	0xDB,
+	STK_ENVELOPE_TYPE_TERMINAL_APP =3D	0xDC,
+	STK_ENVELOPE_TYPE_GEOLOCATION_REPORT =3D	0xDD,
 };
 =

 /* TS 102.223 Section 9.4 */
@@ -1437,6 +1441,12 @@ struct stk_envelope_ussd_data_download {
 	struct stk_ussd_string string;
 };
 =

+struct stk_envelope_mms_transfer_status {
+	struct stk_file transfer_file;
+	struct stk_mms_id id;
+	struct stk_mms_transfer_status transfer_status;
+};
+
 struct stk_envelope {
 	enum stk_envelope_type type;
 	enum stk_device_identity_type src;
@@ -1450,6 +1460,7 @@ struct stk_envelope {
 		struct stk_envelope_event_download event_download;
 		struct stk_envelope_timer_expiration timer_expiration;
 		struct stk_envelope_ussd_data_download ussd_data_download;
+		struct stk_envelope_mms_transfer_status mms_status;
 	};
 };
 =

-- =

1.7.1.86.g0e460.dirty


--===============4427953331066347223==--

