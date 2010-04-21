Content-Type: multipart/mixed; boundary="===============5012132756710675431=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 15/15] Add parser for battery state objects
Date: Wed, 21 Apr 2010 12:55:59 +0800
Message-ID: <1271825759-8898-15-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271825759-8898-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5012132756710675431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 src/stkutil.h |    8 ++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index fcc396b..eec3fc2 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1553,6 +1553,14 @@ static gboolean parse_dataobj_network_search_mode(
 	return parse_dataobj_common_byte(iter, byte);
 }
 =

+/* Defined in TS 102.223 Section 8.76 */
+static gboolean parse_dataobj_battery_state(struct comprehension_tlv_iter =
*iter,
+						void *user)
+{
+	unsigned char *byte =3D user;
+	return parse_dataobj_common_byte(iter, byte);
+}
+
 /* Defined in TS 102.223 Section 8.80 */
 static gboolean parse_dataobj_frame_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -1712,6 +1720,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_imeisv;
 	case STK_DATA_OBJECT_TYPE_NETWORK_SEARCH_MODE:
 		return parse_dataobj_network_search_mode;
+	case STK_DATA_OBJECT_TYPE_BATTERY_STATE:
+		return parse_dataobj_battery_state;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
 		return parse_dataobj_frame_id;
 	default:
diff --git a/src/stkutil.h b/src/stkutil.h
index d973251..98da709 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -357,6 +357,14 @@ enum stk_technology_id {
 	STK_TECHNOLOGY_USB =3D 		0x04
 };
 =

+enum stk_battery_state {
+	STK_BATTERY_VERY_LOW =3D 	0x00,
+	STK_BATTERY_LOW =3D 	0x01,
+	STK_BATTERY_AVERAGE =3D 	0x02,
+	STK_BATTERY_GOOD =3D 	0x03,
+	STK_BATTERY_FULL =3D 	0x04
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
-- =

1.7.0.4


--===============5012132756710675431==--

