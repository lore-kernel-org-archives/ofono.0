Content-Type: multipart/mixed; boundary="===============4648304075205310100=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 4/8] teststk: Use check_common_text() to check string
Date: Wed, 26 May 2010 22:39:10 +0800
Message-ID: <1274884754-12977-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1274884754-12977-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4648304075205310100==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index e01cb17..2999412 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -91,7 +91,7 @@ static inline void check_address(const struct stk_address=
 *command,
 					const struct stk_address *test)
 {
 	g_assert(command->ton_npi =3D=3D test->ton_npi);
-	g_assert(g_str_equal(command->number, test->number));
+	check_common_text(command->number, test->number);
 }
 =

 /* Defined in TS 102.223 Section 8.2 */
@@ -139,11 +139,7 @@ static void check_item(const struct stk_item *command,
 					const struct stk_item *test)
 {
 	g_assert(command->id =3D=3D test->id);
-
-	if (command->text =3D=3D NULL)
-		g_assert(test->text =3D=3D NULL);
-	else
-		g_assert(g_str_equal(command->text, test->text));
+	check_common_text(command->text, test->text);
 }
 =

 /* Defined in TS 102.223 Section 8.10 */
@@ -181,8 +177,8 @@ static void check_gsm_sms_tpdu(const struct sms *comman=
d,
 {
 	g_assert(command->submit.mr =3D=3D test->submit.mr);
 	g_assert(command->submit.udl =3D=3D test->submit.udl);
-	g_assert(g_str_equal(command->submit.daddr.address,
-					test->submit.daddr.address));
+	check_common_text(command->submit.daddr.address,
+					test->submit.daddr.address);
 	g_assert(g_mem_equal(command->submit.ud, test->submit.ud,
 					test->submit.udl));
 }
-- =

1.7.0.4


--===============4648304075205310100==--

