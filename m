Content-Type: multipart/mixed; boundary="===============6664426401883018075=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH, RFC] Interpret "" Alpha Id as empty data object.
Date: Mon, 31 May 2010 14:44:37 +0200
Message-ID: <1275309877-26743-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6664426401883018075==
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
 unit/test-stkutil.c |   18 +++++++++++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 003d96e..7bbd1c9 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -296,8 +296,10 @@ static gboolean parse_dataobj_alpha_id(struct comprehe=
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
index 7505938..06d40a3 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -4920,7 +4920,8 @@ static struct setup_menu_test setup_menu_data_112 =3D=
 {
 static struct setup_menu_test setup_menu_data_113 =3D {
 	.pdu =3D setup_menu_113,
 	.pdu_len =3D sizeof(setup_menu_113),
-	.qualifier =3D 0x00
+	.qualifier =3D 0x00,
+	.alpha_id =3D "",
 };
 =

 static struct setup_menu_test setup_menu_data_121 =3D {
@@ -5388,7 +5389,8 @@ static struct setup_menu_test setup_menu_data_712 =3D=
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
@@ -5418,7 +5420,8 @@ static struct setup_menu_test setup_menu_data_812 =3D=
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
@@ -5448,7 +5451,8 @@ static struct setup_menu_test setup_menu_data_912 =3D=
 {
 static struct setup_menu_test setup_menu_data_913 =3D {
 	.pdu =3D setup_menu_913,
 	.pdu_len =3D sizeof(setup_menu_913),
-	.qualifier =3D 0x00
+	.qualifier =3D 0x00,
+	.alpha_id =3D "",
 };
 =

 /* Defined in TS 102.384 Section 27.22.4.7 */
@@ -7827,6 +7831,7 @@ static struct send_sms_test send_sms_data_171 =3D {
 	.pdu =3D send_sms_171,
 	.pdu_len =3D sizeof(send_sms_171),
 	.qualifier =3D 0x00,
+	.alpha_id =3D "",
 	.address =3D {
 		.ton_npi =3D 0x91,
 		.number =3D "112233445566778"
@@ -12108,6 +12113,7 @@ static struct run_at_command_test run_at_command_da=
ta_121 =3D {
 	.pdu =3D run_at_command_121,
 	.pdu_len =3D sizeof(run_at_command_121),
 	.qualifier =3D 0x00,
+	.alpha_id =3D "",
 	.at_command =3D "AT+CGMI"
 };
 =

@@ -12805,6 +12811,7 @@ static struct send_dtmf_test send_dtmf_data_131 =3D=
 {
 	.pdu =3D send_dtmf_131,
 	.pdu_len =3D sizeof(send_dtmf_131),
 	.qualifier =3D 0x00,
+	.alpha_id =3D "",
 	.dtmf =3D "1cccccccccc2"
 };
 =

@@ -13523,7 +13530,8 @@ static struct launch_browser_test launch_browser_da=
ta_121 =3D {
 	.pdu =3D launch_browser_121,
 	.pdu_len =3D sizeof(launch_browser_121),
 	.qualifier =3D 0x00,
-	.url =3D "http://xxx.yyy.zzz"
+	.url =3D "http://xxx.yyy.zzz",
+	.alpha_id =3D "",
 };
 =

 static struct launch_browser_test launch_browser_data_131 =3D {
-- =

1.7.1.86.g0e460.dirty


--===============6664426401883018075==--

