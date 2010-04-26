Content-Type: multipart/mixed; boundary="===============1027286529764119554=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 3/6] stkutil: Use struct to represent frame id
Date: Mon, 26 Apr 2010 18:29:23 +0800
Message-ID: <1272277766-25432-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1272277766-25432-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1027286529764119554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use a field has_id to indicate if we have frame id or not. Originally we use
0xFF to indicate we don't have frame id. But in that way, we have to initia=
lize
each test case of proactive command when it doesn't have this comprehension
tlv to be 0xFF. To use has_id will save this effort, and keep consistency w=
ith
other implementations.
---
 src/stkutil.c |   13 +++----------
 src/stkutil.h |   12 +++++++++---
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 9f9b1a6..2b43e85 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1635,7 +1635,7 @@ static gboolean parse_dataobj_frames_info(struct comp=
rehension_tlv_iter *iter,
 static gboolean parse_dataobj_frame_id(struct comprehension_tlv_iter *iter,
 					void *user)
 {
-	unsigned char *frame_id =3D user;
+	struct stk_frame_id *fi =3D user;
 	const unsigned char *data;
 =

 	if (comprehension_tlv_iter_get_length(iter) !=3D 1)
@@ -1646,7 +1646,8 @@ static gboolean parse_dataobj_frame_id(struct compreh=
ension_tlv_iter *iter,
 	if (data[0] >=3D 0x10)
 		return FALSE;
 =

-	*frame_id =3D data[0];
+	fi->has_id =3D TRUE;
+	fi->id =3D data[0];
 =

 	return TRUE;
 }
@@ -2082,8 +2083,6 @@ static gboolean parse_display_text(struct stk_command=
 *command,
 	if (comprehension_tlv_iter_next(iter) !=3D TRUE)
 		return FALSE;
 =

-	obj->frame_id =3D 0xFF;
-
 	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
@@ -2127,8 +2126,6 @@ static gboolean parse_get_inkey(struct stk_command *c=
ommand,
 	if (comprehension_tlv_iter_next(iter) !=3D TRUE)
 		return FALSE;
 =

-	obj->frame_id =3D 0xFF;
-
 	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
@@ -2163,8 +2160,6 @@ static gboolean parse_get_input(struct stk_command *c=
ommand,
 	struct stk_command_get_input *obj =3D &command->get_input;
 	gboolean ret;
 =

-	obj->frame_id =3D 0xFF;
-
 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
 =

@@ -2211,8 +2206,6 @@ static gboolean parse_send_sms(struct stk_command *co=
mmand,
 	struct gsm_sms_tpdu tpdu;
 	gboolean ret;
 =

-	obj->frame_id =3D 0xFF;
-
 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
 =

diff --git a/src/stkutil.h b/src/stkutil.h
index 5d2a818..cbb6442 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -728,6 +728,12 @@ struct stk_frames_info {
 	unsigned int len;
 };
 =

+/* Defined in TS 102.223 Section 8.80 */
+struct stk_frame_id {
+	ofono_bool_t has_id;
+	unsigned char id;
+};
+
 /*
  * According to 102.223 Section 8.82 the length of CTLV is 1 byte. This me=
ans
  * that the maximum size is 127 according to the rules of CTLVs.
@@ -789,7 +795,7 @@ struct stk_command_display_text {
 	ofono_bool_t immediate_response;
 	struct stk_duration duration;
 	struct stk_text_attribute text_attribute;
-	unsigned char frame_id; /* Values 0x10 to 0xFF reserved */
+	struct stk_frame_id frame_id;
 };
 =

 struct stk_command_get_input {
@@ -798,7 +804,7 @@ struct stk_command_get_input {
 	char *default_text;
 	struct stk_icon_id icon_id;
 	struct stk_text_attribute text_attribute;
-	unsigned char frame_id; /* Values 0x10 to 0xFF reserved */
+	struct stk_frame_id frame_id;
 };
 =

 struct stk_command_send_sms {
@@ -807,7 +813,7 @@ struct stk_command_send_sms {
 	struct sms gsm_sms;
 	struct stk_icon_id icon_id;
 	struct stk_text_attribute text_attribute;
-	unsigned char frame_id; /* Values 0x10 to 0xFF reserved */
+	struct stk_frame_id frame_id;
 };
 =

 struct stk_command {
-- =

1.7.0.4


--===============1027286529764119554==--

