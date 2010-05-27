Content-Type: multipart/mixed; boundary="===============7346753398495399549=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 13/20] stkutil: Add the Run AT Command response builder
Date: Thu, 27 May 2010 06:59:52 +0200
Message-ID: <1274936399-20710-13-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1274936399-20710-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7346753398495399549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   29 +++++++++++++++++++++++++++++
 src/stkutil.h |    5 +++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 35db34c..5a53fc6 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3580,6 +3580,28 @@ static gboolean build_dataobj_datetime_timezone(stru=
ct stk_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.41 */
+static gboolean build_dataobj_at_response(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_AT_RESPONSE;
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
+	return stk_tlv_builder_open_container(tlv, cr, tag, TRUE) &&
+		stk_tlv_builder_append_bytes(tlv, data, len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.45 */
 static gboolean build_dataobj_language(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -4026,6 +4048,13 @@ unsigned int stk_pdu_from_response(const struct stk_=
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
index 8c1b0db..ac462e0 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1135,6 +1135,10 @@ struct stk_response_timer_mgmt {
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
@@ -1159,6 +1163,7 @@ struct stk_response {
 		struct stk_response_generic set_up_event_list;
 		struct stk_response_timer_mgmt timer_mgmt;
 		struct stk_response_generic set_up_idle_mode_text;
+		struct stk_response_run_at_command run_at_command;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============7346753398495399549==--

