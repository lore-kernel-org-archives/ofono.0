Content-Type: multipart/mixed; boundary="===============0532208046629806346=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/11] stkutil: Add the Menu Selection envelope builder
Date: Mon, 31 May 2010 14:47:19 +0200
Message-ID: <1275310044-27469-6-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275310044-27469-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0532208046629806346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   22 ++++++++++++++++++++++
 src/stkutil.h |    6 ++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 755fefd..e5ea65a 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3528,6 +3528,20 @@ static gboolean build_dataobj_imei(struct stk_tlv_bu=
ilder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.21 */
+static gboolean build_dataobj_help_request(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const gboolean *help =3D data;
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
@@ -4200,6 +4214,14 @@ ofono_bool_t stk_pdu_from_envelope(const struct stk_=
envelope *envelope,
 					envelope->cbs_pp_download.page,
 					NULL);
 		break;
+	case STK_ENVELOPE_TYPE_MENU_SELECTION:
+		ok =3D build_dataobj(&builder,
+					build_dataobj_item_id, DATAOBJ_FLAG_CR,
+					&envelope->menu_selection.item_id,
+					build_dataobj_help_request, 0,
+					&envelope->menu_selection.help_request,
+					NULL);
+		break;
 	default:
 		return FALSE;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 8eb6c54..0e00b7e 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1182,6 +1182,11 @@ struct stk_envelope_cbs_pp_download {
 	unsigned char page[88];
 };
 =

+struct stk_envelope_menu_selection {
+	unsigned char item_id;
+	gboolean help_request;
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


--===============0532208046629806346==--

