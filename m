Content-Type: multipart/mixed; boundary="===============2827097608957195670=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 10/11] Rename stk_icon_identifier to stk_icon_id
Date: Wed, 31 Mar 2010 17:17:02 +0800
Message-ID: <1270027023-21468-10-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270027023-21468-9-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2827097608957195670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 +-
 src/stkutil.h |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 4c9cb6a..b830291 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -729,7 +729,7 @@ static gboolean parse_dataobj_call_control_requested_ac=
tion(
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
 {
-	struct stk_icon_identifier *id =3D user;
+	struct stk_icon_id *id =3D user;
 	const unsigned char *data;
 =

 	if (comprehension_tlv_iter_get_length(iter) !=3D 2)
diff --git a/src/stkutil.h b/src/stkutil.h
index 3f2802e..4ff8c4b 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -442,7 +442,7 @@ struct stk_transaction_id {
  * Icon ID denotes a file on the SIM filesystem.  Since EF cannot have rec=
ord
  * ids of 0, we use icon_id with 0 to denote empty icon_identifier objects
  */
-struct stk_icon_identifier {
+struct stk_icon_id {
 	unsigned char qualifier;
 	unsigned char id;
 };
@@ -471,7 +471,7 @@ struct stk_text_attribute {
 =

 struct stk_command_display_text {
 	char *text;
-	struct stk_icon_identifier icon_id;
+	struct stk_icon_id icon_id;
 	ofono_bool_t immediate_response;
 	struct stk_duration duration;
 	struct stk_text_attribute text_attribute;
@@ -482,7 +482,7 @@ struct stk_command_get_input {
 	char *text;
 	struct stk_response_length response_length;
 	char *default_text;
-	struct stk_icon_identifier icon_id;
+	struct stk_icon_id icon_id;
 	struct stk_text_attribute text_attribute;
 	unsigned char frame_id; /* Values 0x10 to 0xFF reserved */
 };
@@ -491,7 +491,7 @@ struct stk_command_send_sms {
 	char *alpha_id;
 	struct stk_address address;
 	struct sms gsm_sms;
-	struct stk_icon_identifier icon_id;
+	struct stk_icon_id icon_id;
 	struct stk_text_attribute text_attribute;
 	unsigned char frame_id; /* Values 0x10 to 0xFF reserved */
 };
-- =

1.6.3.3


--===============2827097608957195670==--

