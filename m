Content-Type: multipart/mixed; boundary="===============5492036899811928462=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 4/7] Add build_dataobj_ussd_text for ussd specific text string
 handling
Date: Fri, 10 Sep 2010 13:19:01 -0700
Message-ID: <1284149941-15095-1-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <4C8A6ADD.1030104@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5492036899811928462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 056f2e7..3cfe06a 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4170,6 +4170,23 @@ static gboolean build_dataobj_text(struct stk_tlv_bu=
ilder *tlv,
 	return stk_tlv_builder_close_container(tlv);
 }
 =

+/* Defined in TS 102.223 Section 8.15 - USSD specific case*/
+static gboolean build_dataobj_ussd_text(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const struct stk_ussd_text *text =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_TEXT;
+
+	stk_tlv_builder_open_container(tlv, cr, tag, TRUE);
+
+	if (text->len > 0) {
+		stk_tlv_builder_append_byte(tlv, text->dcs);
+		stk_tlv_builder_append_bytes(tlv, text->text, text->len);
+	}
+
+	return stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 131.111 Section 8.17 */
 static gboolean build_dataobj_ussd_string(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -5457,6 +5474,13 @@ const unsigned char *stk_pdu_from_response(const str=
uct stk_response *response,
 	case STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION:
 	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
 		break;
+	case STK_COMMAND_TYPE_SEND_USSD:
+		ok =3D build_dataobj(&builder,
+					build_dataobj_ussd_text,
+					DATAOBJ_FLAG_CR,
+					&response->send_ussd.text,
+					NULL);
+		break;
 	default:
 		return NULL;
 	};
-- =

1.7.0.4


--===============5492036899811928462==--

