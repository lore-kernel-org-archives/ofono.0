Content-Type: multipart/mixed; boundary="===============0636810107862199818=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] Added missing DCS handling in stkutil and stk
Date: Thu, 02 Sep 2010 20:19:35 +0300
Message-ID: <1283447975-28849-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0636810107862199818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c     |    3 +++
 src/stkutil.c |   14 +++++++++++---
 src/stkutil.h |    2 ++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 3fda2af..3a16507 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1196,6 +1196,7 @@ static void request_confirmation_cb(enum stk_agent_re=
sult result,
 		rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
 		rsp.get_inkey.text.text =3D confirm ? "" : NULL;
 		rsp.get_inkey.text.yesno =3D TRUE;
+		rsp.get_inkey.text.dcs =3D -1;
 =

 		if (cmd->duration.interval) {
 			rsp.get_inkey.duration.unit =3D cmd->duration.unit;
@@ -1238,6 +1239,7 @@ static void request_key_cb(enum stk_agent_result resu=
lt, char *string,
 =

 		rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
 		rsp.get_inkey.text.text =3D string;
+		rsp.get_inkey.text.dcs =3D -1;
 =

 		if (cmd->duration.interval) {
 			rsp.get_inkey.duration.unit =3D cmd->duration.unit;
@@ -1342,6 +1344,7 @@ static void request_string_cb(enum stk_agent_result r=
esult, char *string,
 		rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
 		rsp.get_input.text.text =3D string;
 		rsp.get_input.text.packed =3D packed;
+		rsp.get_input.text.dcs =3D -1;
 =

 		if (stk_respond(stk, &rsp, stk_command_cb))
 			stk_command_cb(&error, stk);
diff --git a/src/stkutil.c b/src/stkutil.c
index ae4cc32..3c7460e 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4160,9 +4160,17 @@ static gboolean build_dataobj_text(struct stk_tlv_bu=
ilder *tlv,
 		ret =3D stk_tlv_builder_append_byte(tlv,
 						text->text ? 0x01 : 0x00);
 	} else if (text->packed)
-		ret =3D stk_tlv_builder_append_gsm_packed(tlv, text->text);
-	else
-		ret =3D stk_tlv_builder_append_text(tlv, -1, text->text);
+                ret =3D stk_tlv_builder_append_gsm_packed(tlv, text->text);
+	else if (text->dcs =3D=3D -1)
+		ret =3D stk_tlv_builder_append_text(tlv, text->dcs, text->text);
+	else {
+		if (stk_tlv_builder_append_byte(tlv, text->dcs) !=3D TRUE)
+			return FALSE;
+
+		ret =3D stk_tlv_builder_append_bytes(tlv,
+						(const guint8 *) text->text,
+						text->len);
+	}
 =

 	if (ret !=3D TRUE)
 		return ret;
diff --git a/src/stkutil.h b/src/stkutil.h
index 44d167a..da153ac 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1365,6 +1365,8 @@ struct stk_response_generic {
 =

 struct stk_answer_text {
 	char *text;
+	int len;
+	int dcs;
 	ofono_bool_t packed;
 	ofono_bool_t yesno;
 	/*
-- =

1.7.0.4



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============0636810107862199818==--

