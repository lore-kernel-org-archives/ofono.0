Content-Type: multipart/mixed; boundary="===============6041378831924720553=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/20] stkutil: Add CBS-PP Data Download envelope builder
Date: Mon, 07 Jun 2010 12:08:26 +0200
Message-ID: <1275905322-14768-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6041378831924720553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   26 ++++++++++++++++++++++++++
 src/stkutil.h |    5 +++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 661cfc6..acdf34f 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3357,6 +3357,22 @@ static gboolean build_dataobj_address(struct stk_tlv=
_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 131.111 Section 8.5 */
+static gboolean build_dataobj_cbs_page(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const struct cbs *page =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_CBS_PAGE;
+	unsigned char pdu[88];
+
+	if (cbs_encode(page, NULL, pdu) =3D=3D FALSE)
+		return FALSE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, TRUE) &&
+		stk_tlv_builder_append_bytes(tlv, pdu, 88) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.6 */
 static gboolean build_dataobj_item_id(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -4216,6 +4232,16 @@ const unsigned char *stk_pdu_from_envelope(const str=
uct stk_envelope *envelope,
 					&envelope->sms_pp_download.message,
 					NULL);
 		break;
+	case STK_ENVELOPE_TYPE_CBS_PP_DOWNLOAD:
+		ok =3D build_dataobj(&builder,
+					build_envelope_dataobj_device_ids,
+					DATAOBJ_FLAG_CR,
+					envelope,
+					build_dataobj_cbs_page,
+					DATAOBJ_FLAG_CR,
+					&envelope->cbs_pp_download.page,
+					NULL);
+		break;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index cc293ca..65ccfd3 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1178,12 +1178,17 @@ struct stk_envelope_sms_pp_download {
 	struct sms_deliver message;
 };
 =

+struct stk_envelope_cbs_pp_download {
+	struct cbs page;
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


--===============6041378831924720553==--

