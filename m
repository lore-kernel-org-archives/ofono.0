Content-Type: multipart/mixed; boundary="===============3059389475721742312=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 3/3] Interpret "" Alpha Id as empty data object
Date: Fri, 09 Jul 2010 22:52:08 +0800
Message-ID: <1278687128-8983-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1278687128-8983-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3059389475721742312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There needs to be a way to distinguish between no alphaid and "empty
data object" because on some occasions they have different meanings.  In
the Call Control envelope, no Alpha Identifier means the terminal can
inform the user about the call being modified by SIM while empty data
object means no hint should be given.
---
 src/stkutil.c       |    4 +++-
 unit/test-stkutil.c |   18 ++++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 94ff182..c45f985 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -297,8 +297,10 @@ static gboolean parse_dataobj_alpha_id(struct comprehe=
nsion_tlv_iter *iter,
 	char *utf8;
 =

 	len =3D comprehension_tlv_iter_get_length(iter);
-	if (len =3D=3D 0)
+	if (len =3D=3D 0) {
+		*alpha_id =3D g_try_malloc0(1);
 		return TRUE;
+	}
 =

 	data =3D comprehension_tlv_iter_get_data(iter);
 	utf8 =3D sim_string_to_utf8(data, len);
diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 0b95265..dbd5b5e 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -4974,7 +4974,8 @@ static struct setup_menu_test setup_menu_data_112 =3D=
 {
 static struct setup_menu_test setup_menu_data_113 =3D {
 	.pdu =3D setup_menu_113,
 	.pdu_len =3D sizeof(setup_menu_113),
-	.qualifier =3D 0x00
+	.qualifier =3D 0x00,
+	.alpha_id =3D ""
 };
 =

 static struct setup_menu_test setup_menu_data_121 =3D {
@@ -5442,7 +5443,8 @@ static struct setup_menu_test setup_menu_data_712 =3D=
 {
 static struct setup_menu_test setup_menu_data_713 =3D {
 	.pdu =3D setup_menu_713,
 	.pdu_len =3D sizeof(setup_menu_713),
-	.qualifier =3D 0x00
+	.qualifier =3D 0x00,
+	.alpha_id =3D ""
 };
 =

 static struct setup_menu_test setup_menu_data_811 =3D {
@@ -5472,7 +5474,8 @@ static struct setup_menu_test setup_menu_data_812 =3D=
 {
 static struct setup_menu_test setup_menu_data_813 =3D {
 	.pdu =3D setup_menu_813,
 	.pdu_len =3D sizeof(setup_menu_813),
-	.qualifier =3D 0x00
+	.qualifier =3D 0x00,
+	.alpha_id =3D ""
 };
 =

 static struct setup_menu_test setup_menu_data_911 =3D {
@@ -5502,7 +5505,8 @@ static struct setup_menu_test setup_menu_data_912 =3D=
 {
 static struct setup_menu_test setup_menu_data_913 =3D {
 	.pdu =3D setup_menu_913,
 	.pdu_len =3D sizeof(setup_menu_913),
-	.qualifier =3D 0x00
+	.qualifier =3D 0x00,
+	.alpha_id =3D ""
 };
 =

 static struct setup_menu_test setup_menu_data_neg_1 =3D {
@@ -7957,6 +7961,7 @@ static struct send_sms_test send_sms_data_171 =3D {
 	.pdu =3D send_sms_171,
 	.pdu_len =3D sizeof(send_sms_171),
 	.qualifier =3D 0x00,
+	.alpha_id =3D "",
 	.gsm_sms =3D {
 		{
 			.number_type =3D SMS_NUMBER_TYPE_INTERNATIONAL,
@@ -9474,6 +9479,7 @@ static struct send_ss_test send_ss_data_161 =3D {
 	.pdu =3D send_ss_161,
 	.pdu_len =3D sizeof(send_ss_161),
 	.qualifier =3D 0x00,
+	.alpha_id =3D "",
 	.ss =3D {
 		.ton_npi =3D 0x91,
 		.ss =3D "**21*01234567890123456789*10#"
@@ -10774,6 +10780,7 @@ static struct send_ussd_test send_ussd_data_181 =3D=
 {
 	.pdu =3D send_ussd_181,
 	.pdu_len =3D sizeof(send_ussd_181),
 	.qualifier =3D 0x00,
+	.alpha_id =3D "",
 	.ussd =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZ-abcdefghijklmnopqrstuvwxyz-"
 		"1234567890"
 };
@@ -14621,6 +14628,7 @@ static struct run_at_command_test run_at_command_da=
ta_121 =3D {
 	.pdu =3D run_at_command_121,
 	.pdu_len =3D sizeof(run_at_command_121),
 	.qualifier =3D 0x00,
+	.alpha_id =3D "",
 	.at_command =3D "AT+CGMI"
 };
 =

@@ -15319,6 +15327,7 @@ static struct send_dtmf_test send_dtmf_data_131 =3D=
 {
 	.pdu =3D send_dtmf_131,
 	.pdu_len =3D sizeof(send_dtmf_131),
 	.qualifier =3D 0x00,
+	.alpha_id =3D "",
 	.dtmf =3D "1cccccccccc2"
 };
 =

@@ -16039,6 +16048,7 @@ static struct launch_browser_test launch_browser_da=
ta_121 =3D {
 	.pdu =3D launch_browser_121,
 	.pdu_len =3D sizeof(launch_browser_121),
 	.qualifier =3D 0x00,
+	.alpha_id =3D "",
 	.url =3D "http://xxx.yyy.zzz"
 };
 =

-- =

1.7.0.4


--===============3059389475721742312==--

