Content-Type: multipart/mixed; boundary="===============1569702614623845176=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 5/8] stk: Fix the parser of send sms
Date: Wed, 26 May 2010 22:39:11 +0800
Message-ID: <1274884754-12977-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1274884754-12977-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1569702614623845176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   52 +++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 12af7fc..3adb9e3 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -61,11 +61,15 @@ typedef gboolean (*dataobj_writer)(struct stk_tlv_build=
er *,
 =

 /*
  * Defined in TS 102.223 Section 8.13
- * GSM SMS PDUs are limited to 164 bytes according to 23.040
+ * The type of gsm sms can be SMS-COMMAND AND SMS-SUBMIT. According to 23.=
040,
+ * the maximum length is 164 bytes. But for SMS-SUBMIT, sms may be packed =
by
+ * ME. Thus the maximum length of messsage could be 160 bytes, instead of =
140
+ * bytes. So the total maximum length could be 184 bytes. Refer TS 31.111,
+ * section 6.4.10 for details.
  */
 struct gsm_sms_tpdu {
 	unsigned int len;
-	unsigned char tpdu[164];
+	unsigned char tpdu[184];
 };
 =

 static char *decode_text(unsigned char dcs, int len, const unsigned char *=
data)
@@ -2453,6 +2457,7 @@ static gboolean parse_send_sms(struct stk_command *co=
mmand,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
 		return FALSE;
 =

+	memset(&gsm_tpdu, 0, sizeof(gsm_tpdu));
 	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ADDRESS, 0,
@@ -2469,20 +2474,49 @@ static gboolean parse_send_sms(struct stk_command *=
command,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

+	command->destructor =3D destroy_send_sms;
+
 	if (ret =3D=3D FALSE)
 		return FALSE;
 =

-	command->destructor =3D destroy_send_sms;
+	if (gsm_tpdu.len =3D=3D 0 && obj->cdma_sms.len =3D=3D 0)
+		return FALSE;
+
+	if (gsm_tpdu.len > 0 && obj->cdma_sms.len > 0)
+		return FALSE;
 =

 	if (gsm_tpdu.len > 0) {
 		if (sms_decode(gsm_tpdu.tpdu, gsm_tpdu.len, TRUE, gsm_tpdu.len,
-				&obj->gsm_sms) =3D=3D FALSE) {
-			command->destructor(command);
-			return FALSE;
+						&obj->gsm_sms) =3D=3D FALSE) {
+			/* packing by ME must be not required */
+			if ((command->qualifier & 0x01) =3D=3D 0)
+				return FALSE;
+
+			if (obj->gsm_sms.type !=3D SMS_TYPE_SUBMIT)
+				return FALSE;
+
+			if (obj->gsm_sms.submit.udl =3D=3D 0)
+				return FALSE;
+		}
+
+		/* packing is needed */
+		if (command->qualifier & 0x01) {
+			unsigned char *packed;
+			long packed_size;
+			unsigned char *in;
+			struct sms_submit *s =3D &obj->gsm_sms.submit;
+
+			if (obj->gsm_sms.type !=3D SMS_TYPE_SUBMIT)
+				return FALSE;
+
+			/* Set dcs to default alphabet */
+			s->dcs =3D 0xF0;
+
+			in =3D gsm_tpdu.tpdu + gsm_tpdu.len - s->udl;
+			packed =3D pack_7bit(in, s->udl, 0,
+						FALSE, &packed_size, 0);
+			memcpy(s->ud, packed, packed_size);
 		}
-	} else if (obj->cdma_sms.len =3D=3D 0) {
-		command->destructor(command);
-		return FALSE;
 	}
 =

 	return TRUE;
-- =

1.7.0.4


--===============1569702614623845176==--

