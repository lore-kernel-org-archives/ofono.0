Content-Type: multipart/mixed; boundary="===============3445635761906645442=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/11] stkutil: Add CBS-PP Data Download envelope builder
Date: Mon, 31 May 2010 14:47:16 +0200
Message-ID: <1275310044-27469-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275310044-27469-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3445635761906645442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   18 ++++++++++++++++++
 src/stkutil.h |    5 +++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index a29abfe..755fefd 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3339,6 +3339,17 @@ static gboolean build_dataobj_address(struct stk_tlv=
_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 131.111 Section 8.5 */
+static gboolean build_dataobj_cbs_page(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_CBS_PAGE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, TRUE) &&
+		stk_tlv_builder_append_bytes(tlv, data, 88) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.6 */
 static gboolean build_dataobj_item_id(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -4182,6 +4193,13 @@ ofono_bool_t stk_pdu_from_envelope(const struct stk_=
envelope *envelope,
 					&envelope->sms_pp_download.sms_tpdu,
 					NULL);
 		break;
+	case STK_ENVELOPE_TYPE_CBS_PP_DOWNLOAD:
+		ok =3D build_dataobj(&builder,
+					build_dataobj_cbs_page,
+					DATAOBJ_FLAG_CR,
+					envelope->cbs_pp_download.page,
+					NULL);
+		break;
 	default:
 		return FALSE;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 8f4ae36..8eb6c54 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1178,12 +1178,17 @@ struct stk_envelope_sms_pp_download {
 	struct stk_common_byte_array sms_tpdu;
 };
 =

+struct stk_envelope_cbs_pp_download {
+	unsigned char page[88];
+};
+
 struct stk_envelope {
 	enum stk_envelope_type type;
 	enum stk_device_identity_type src;
 	enum stk_device_identity_type dst;
 	union {
 		struct stk_envelope_sms_pp_download sms_pp_download;
+		struct stk_envelope_cbs_pp_download cbs_pp_download;
 	};
 };
 =

-- =

1.7.1.86.g0e460.dirty


--===============3445635761906645442==--

