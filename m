Content-Type: multipart/mixed; boundary="===============0282213042950255036=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/16] stkutil: Add the Run AT Command response builder.
Date: Sun, 23 May 2010 12:16:00 +0200
Message-ID: <1274609760-6878-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0282213042950255036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   29 +++++++++++++++++++++++++++++
 src/stkutil.h |    5 +++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index dd8381d..71fe9f9 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3315,6 +3315,28 @@ static gboolean build_dataobj_datetime_timezone(stru=
ct stk_tlv_builder *tlv,
 		stk_tlv_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.41 */
+static gboolean build_dataobj_at_response(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	int len;
+
+	if (data =3D=3D NULL)
+		return TRUE;
+
+	/* "If the AT Response string is longer than the maximum length
+	 * capable of being transmitted to the UICC then the AT Response
+	 * string shall be truncated to this length by the terminal." */
+	len =3D strlen(data);
+	if (len > 240) /* Safe pick */
+		len =3D 240;
+
+	return stk_tlv_open_container(tlv, cr,
+				STK_DATA_OBJECT_TYPE_AT_RESPONSE, FALSE) &&
+		stk_tlv_append_bytes(tlv, data, len) &&
+		stk_tlv_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.45 */
 static gboolean build_dataobj_language(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -3746,6 +3768,13 @@ unsigned int stk_pdu_from_response(const struct stk_=
response *response,
 		break;
 	case STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT:
 		break;
+	case STK_COMMAND_TYPE_RUN_AT_COMMAND:
+		ok =3D build_dataobj(&builder,
+					build_dataobj_at_response,
+					DATAOBJ_FLAG_CR,
+					response->run_at_command.at_response,
+					NULL);
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 62d0ecf..29cbb9a 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1088,6 +1088,10 @@ struct stk_response_timer_mgmt {
 	struct stk_timer_value value;
 };
 =

+struct stk_response_run_at_command {
+	const char *at_response;
+};
+
 struct stk_response {
 	unsigned char number;
 	unsigned char type;
@@ -1112,6 +1116,7 @@ struct stk_response {
 		struct stk_response_generic set_up_event_list;
 		struct stk_response_timer_mgmt timer_mgmt;
 		struct stk_response_generic set_up_idle_mode_text;
+		struct stk_response_run_at_command run_at_command;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============0282213042950255036==--

