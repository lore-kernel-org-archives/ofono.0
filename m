Content-Type: multipart/mixed; boundary="===============7904827335852868969=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 20/27] stkutil: Add Select Item response builder.
Date: Sun, 16 May 2010 16:07:22 +0200
Message-ID: <1274018842-6904-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7904827335852868969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   21 +++++++++++++++++++++
 src/stkutil.h |    5 +++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 798e2a9..cf22361 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3047,6 +3047,21 @@ static inline gboolean stk_tlv_append_bytes(struct s=
tk_tlv_builder *iter,
 	return TRUE;
 }
 =

+/* Described in TS 102.223 Section 8.6 */
+static gboolean build_dataobj_item_id(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const unsigned char *item_id =3D data;
+
+	if (*item_id =3D=3D 0)
+		return TRUE;
+
+	return stk_tlv_open_container(tlv, cr,
+				STK_DATA_OBJECT_TYPE_ITEM_ID, FALSE) &&
+		stk_tlv_append_byte(tlv, *item_id) &&
+		stk_tlv_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.8 */
 static gboolean build_dataobj_duration(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -3210,6 +3225,12 @@ unsigned int stk_pdu_from_response(const struct stk_=
response *response,
 	case STK_COMMAND_TYPE_REFRESH:
 	case STK_COMMAND_TYPE_SETUP_MENU:
 		break;
+	case STK_COMMAND_TYPE_SELECT_ITEM:
+		ok =3D build_dataobj(&builder,
+					build_dataobj_item_id, DATAOBJ_FLAG_CR,
+					&response->select_item.item_id,
+					NULL);
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 96919f3..1810b8e 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1018,6 +1018,10 @@ struct stk_response_poll_interval {
 	struct stk_duration max_interval;
 };
 =

+struct stk_response_select_item {
+	unsigned char item_id;
+};
+
 struct stk_response {
 	unsigned char number;
 	unsigned char type;
@@ -1034,6 +1038,7 @@ struct stk_response {
 		struct stk_response_poll_interval poll_interval;
 		struct stk_response_generic refresh;
 		struct stk_response_generic set_up_menu;
+		struct stk_response_select_item select_item;
 		struct stk_response_generic send_sms;
 	};
 =

-- =

1.7.1.86.g0e460.dirty


--===============7904827335852868969==--

