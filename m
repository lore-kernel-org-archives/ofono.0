Content-Type: multipart/mixed; boundary="===============2229592480052944154=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/20] stkutil: Add the Menu Selection envelope builder
Date: Mon, 07 Jun 2010 12:08:30 +0200
Message-ID: <1275905322-14768-8-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2229592480052944154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   25 +++++++++++++++++++++++++
 src/stkutil.h |    6 ++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index acdf34f..83ff5c7 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3561,6 +3561,20 @@ static gboolean build_dataobj_imei(struct stk_tlv_bu=
ilder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.21 */
+static gboolean build_dataobj_help_request(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const ofono_bool_t *help =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_HELP_REQUEST;
+
+	if (*help !=3D TRUE)
+		return TRUE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.22 */
 static gboolean build_dataobj_network_measurement_results(
 						struct stk_tlv_builder *tlv,
@@ -4242,6 +4256,17 @@ const unsigned char *stk_pdu_from_envelope(const str=
uct stk_envelope *envelope,
 					&envelope->cbs_pp_download.page,
 					NULL);
 		break;
+	case STK_ENVELOPE_TYPE_MENU_SELECTION:
+		ok =3D build_dataobj(&builder,
+					build_envelope_dataobj_device_ids,
+					DATAOBJ_FLAG_CR,
+					envelope,
+					build_dataobj_item_id, DATAOBJ_FLAG_CR,
+					&envelope->menu_selection.item_id,
+					build_dataobj_help_request, 0,
+					&envelope->menu_selection.help_request,
+					NULL);
+		break;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 65ccfd3..d4b5b23 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1182,6 +1182,11 @@ struct stk_envelope_cbs_pp_download {
 	struct cbs page;
 };
 =

+struct stk_envelope_menu_selection {
+	unsigned char item_id;
+	ofono_bool_t help_request;
+};
+
 struct stk_envelope {
 	enum stk_envelope_type type;
 	enum stk_device_identity_type src;
@@ -1189,6 +1194,7 @@ struct stk_envelope {
 	union {
 		struct stk_envelope_sms_pp_download sms_pp_download;
 		struct stk_envelope_cbs_pp_download cbs_pp_download;
+		struct stk_envelope_menu_selection menu_selection;
 	};
 };
 =

-- =

1.7.1.86.g0e460.dirty


--===============2229592480052944154==--

