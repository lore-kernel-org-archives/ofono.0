Content-Type: multipart/mixed; boundary="===============8423819205897285036=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 09/15] Add parser for date-time and time zone objects
Date: Fri, 02 Apr 2010 14:20:34 +0800
Message-ID: <1270189240-11650-9-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270189240-11650-8-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8423819205897285036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 5fea3a5..1846092 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -882,6 +882,23 @@ static gboolean parse_dataobj_timer_value(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.39 */
+static gboolean parse_dataobj_datetime_timezone(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct sms_scts *scts =3D user;
+	const unsigned char *data;
+	int offset =3D 0;
+
+	if (comprehension_tlv_iter_get_length(iter) !=3D 7)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	sms_decode_scts(data, 7, &offset, scts);
+
+	return TRUE;
+}
+
 /* Defined in 102.223 Section 8.43 */
 static gboolean parse_dataobj_imm_resp(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -998,6 +1015,8 @@ static dataobj_handler handler_for_type(enum stk_data_=
object_type type)
 		return parse_dataobj_timer_id;
 	case STK_DATA_OBJECT_TYPE_TIMER_VALUE:
 		return parse_dataobj_timer_value;
+	case STK_DATA_OBJECT_TYPE_DATETIME_TIMEZONE:
+		return parse_dataobj_datetime_timezone;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
 		return parse_dataobj_imm_resp;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
-- =

1.6.3.3


--===============8423819205897285036==--

