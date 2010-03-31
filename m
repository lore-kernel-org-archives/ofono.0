Content-Type: multipart/mixed; boundary="===============1490250875644439931=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 04/11] Add parser for cause objects
Date: Wed, 31 Mar 2010 17:16:56 +0800
Message-ID: <1270027023-21468-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270027023-21468-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1490250875644439931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   25 +++++++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index ec64af3..08d013b 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -628,6 +628,29 @@ static gboolean parse_dataobj_event_list(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.26 */
+static gboolean parse_dataobj_cause(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_cause *cause =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if ((len =3D=3D 1) || (len > sizeof(cause->cause)))
+		return FALSE;
+
+	cause->has_cause =3D TRUE;
+
+	if (len =3D=3D 0)
+		return TRUE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	cause->len =3D len;
+	memcpy(cause->cause, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -738,6 +761,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_items_next_action_indicator;
 	case STK_DATA_OBJECT_TYPE_EVENT_LIST:
 		return parse_dataobj_event_list;
+	case STK_DATA_OBJECT_TYPE_CAUSE:
+		return parse_dataobj_cause;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
diff --git a/src/stkutil.h b/src/stkutil.h
index be89c9b..21f6e8a 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -403,6 +403,15 @@ struct stk_event_list {
 };
 =

 /*
+ * According to 102.223 Section 8.26, the maximum length of cause is 30.
+ */
+struct stk_cause {
+	unsigned char cause[30];
+	unsigned int len;
+	ofono_bool_t has_cause;
+};
+
+/*
  * Defined in TS 102.223 Section 8.31
  * Icon ID denotes a file on the SIM filesystem.  Since EF cannot have rec=
ord
  * ids of 0, we use icon_id with 0 to denote empty icon_identifier objects
-- =

1.6.3.3


--===============1490250875644439931==--

