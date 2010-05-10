Content-Type: multipart/mixed; boundary="===============5315543109170925747=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 16/19] stkutil: Parse cdma tpdu in send sms parser
Date: Mon, 10 May 2010 18:38:59 +0800
Message-ID: <1273487942-27213-16-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273487942-27213-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5315543109170925747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   16 ++++++++++++----
 src/stkutil.h |    1 +
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index ebe1114..b6212b3 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2414,13 +2414,14 @@ static void destroy_send_sms(struct stk_command *co=
mmand)
 {
 	g_free(command->send_sms.alpha_id);
 	g_free(command->send_sms.address.number);
+	g_free(command->send_sms.cdma_sms.array);
 }
 =

 static gboolean parse_send_sms(struct stk_command *command, =

 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_send_sms *obj =3D &command->send_sms;
-	struct gsm_sms_tpdu tpdu;
+	struct gsm_sms_tpdu gsm_tpdu;
 	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
@@ -2434,7 +2435,9 @@ static gboolean parse_send_sms(struct stk_command *co=
mmand,
 				STK_DATA_OBJECT_TYPE_ADDRESS, 0,
 				&obj->address,
 				STK_DATA_OBJECT_TYPE_GSM_SMS_TPDU, 0,
-				&tpdu,
+				&gsm_tpdu,
+				STK_DATA_OBJECT_TYPE_CDMA_SMS_TPDU, 0,
+				&obj->cdma_sms,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
 				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
@@ -2448,8 +2451,13 @@ static gboolean parse_send_sms(struct stk_command *c=
ommand,
 =

 	command->destructor =3D destroy_send_sms;
 =

-	if (sms_decode(tpdu.tpdu, tpdu.len, TRUE, tpdu.len, &obj->gsm_sms)
-			=3D=3D FALSE) {
+	if (gsm_tpdu.len > 0) {
+		if (sms_decode(gsm_tpdu.tpdu, gsm_tpdu.len, TRUE, gsm_tpdu.len,
+				&obj->gsm_sms) =3D=3D FALSE) {
+			command->destructor(command);
+			return FALSE;
+		}
+	} else if (obj->cdma_sms.len =3D=3D 0) {
 		command->destructor(command);
 		return FALSE;
 	}
diff --git a/src/stkutil.h b/src/stkutil.h
index 143679f..b936ee9 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -850,6 +850,7 @@ struct stk_command_send_sms {
 	char *alpha_id;
 	struct stk_address address;
 	struct sms gsm_sms;
+	struct stk_common_byte_array cdma_sms;
 	struct stk_icon_id icon_id;
 	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
-- =

1.7.0.4


--===============5315543109170925747==--

