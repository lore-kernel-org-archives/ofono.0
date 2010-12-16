Content-Type: multipart/mixed; boundary="===============7845894567476347685=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 3/3] unit: remove usage of empty text for null case
Date: Thu, 16 Dec 2010 13:20:18 -0800
Message-ID: <1292534418-13351-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1292534418-13351-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7845894567476347685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 868d54b..ab8a003 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -2626,7 +2626,6 @@ static struct get_input_test get_input_data_1101 =3D {
 	.pdu =3D get_input_1101,
 	.pdu_len =3D sizeof(get_input_1101),
 	.qualifier =3D 0x00,
-	.text =3D "",
 	.resp_len =3D {
 		.min =3D 1,
 		.max =3D 5
@@ -14355,8 +14354,7 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_121 =3D {
 static struct setup_idle_mode_text_test setup_idle_mode_text_data_131 =3D {
 	.pdu =3D setup_idle_mode_text_131,
 	.pdu_len =3D sizeof(setup_idle_mode_text_131),
-	.qualifier =3D 0x00,
-	.text =3D ""
+	.qualifier =3D 0x00
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_171 =3D {
@@ -14407,7 +14405,6 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_241 =3D {
 	.pdu =3D setup_idle_mode_text_241,
 	.pdu_len =3D sizeof(setup_idle_mode_text_241),
 	.qualifier =3D 0x00,
-	.text =3D "",
 	.icon_id =3D {
 		.qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
 		.id =3D 0x01
-- =

1.7.0.4


--===============7845894567476347685==--

