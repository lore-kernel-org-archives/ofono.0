Content-Type: multipart/mixed; boundary="===============3979542839480375741=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] unit: Update test_invalid() unit test
Date: Wed, 18 Jul 2012 17:13:23 +0200
Message-ID: <1342624403-3484-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3979542839480375741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-util.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/unit/test-util.c b/unit/test-util.c
index 079d775..f65f3ee 100644
--- a/unit/test-util.c
+++ b/unit/test-util.c
@@ -345,7 +345,9 @@ static void test_invalid(void)
 {
 	long nwritten;
 	long nread;
-	char *res;
+	short unsigned int exp_code;
+	long exp_res_length;
+	char *res, *temp, *exp_res =3D NULL;
 	unsigned char *gsm;
 =

 	res =3D convert_gsm_to_utf8(invalid_gsm_extended, 0, &nread, &nwritten,
@@ -356,15 +358,34 @@ static void test_invalid(void)
 	g_assert(res[0] =3D=3D '\0');
 	g_free(res);
 =

+	/*
+	 * In case of invalid GSM extended code, we should display
+	 * the character of the main default alphabet table.
+	 */
 	res =3D convert_gsm_to_utf8(invalid_gsm_extended,
 					sizeof(invalid_gsm_extended),
 					&nread, &nwritten, 0);
-	g_assert(res =3D=3D NULL);
-	g_assert(nread =3D=3D 1);
+
+	exp_code =3D gsm_to_unicode_map[invalid_gsm_extended[1]*2 + 1];
+
+	exp_res_length =3D UTF8_LENGTH(exp_code);
+	exp_res =3D g_try_malloc(exp_res_length + 1);
+
+	g_assert(exp_res !=3D NULL);
+
+	temp =3D exp_res;
+	temp +=3D g_unichar_to_utf8(exp_code, temp);
+	*temp =3D '\0';
+
+	g_assert(g_strcmp0(res, exp_res) =3D=3D 0);
+	g_assert(nread =3D=3D exp_res_length);
+	g_free(exp_res);
+	g_free(res);
 =

 	res =3D convert_gsm_to_utf8(invalid_gsm_extended_len,
 					sizeof(invalid_gsm_extended_len),
 					&nread, &nwritten, 0);
+
 	g_assert(res =3D=3D NULL);
 	g_assert(nread =3D=3D 3);
 =

-- =

1.7.5.4


--===============3979542839480375741==--

