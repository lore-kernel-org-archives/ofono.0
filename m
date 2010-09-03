Content-Type: multipart/mixed; boundary="===============8627388207741285002=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [alphabets-PATCHv2 2/5] Unit test for reduced charset
Date: Fri, 03 Sep 2010 16:22:57 +0300
Message-ID: <1283520180-20700-2-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1283520180-20700-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8627388207741285002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-util.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/unit/test-util.c b/unit/test-util.c
index de62848..4d9282a 100644
--- a/unit/test-util.c
+++ b/unit/test-util.c
@@ -486,6 +486,25 @@ static void test_valid_turkish()
 	}
 }
 =

+static void test_encode_translit()
+{
+	const char *utf8   =3D "=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD";
+	const char *expect =3D "EeYyIiAaEeUuIiOoAaYyUuOoIiAEUIOcAaOoYyUuIi";
+	long nwritten;
+	long nread;
+	unsigned char *res;
+
+	res =3D convert_utf8_to_gsm_with_lang(utf8, sizeof(utf8), &nread, &nwritt=
en,
+						0, GSM_DIALECT_REDUCED,
+						GSM_DIALECT_REDUCED);
+
+	g_assert(res);
+	g_assert(nread =3D=3D sizeof(utf8));
+	g_assert(memcmp(res, expect, nwritten) =3D=3D 0);
+
+	g_free(res);
+}
+
 static const char hex_packed[] =3D "493A283D0795C3F33C88FE06C9CB6132885EC6=
D34"
 					"1EDF27C1E3E97E7207B3A0C0A5241E377BB1D"
 					"7693E72E";
@@ -912,6 +931,7 @@ int main(int argc, char **argv)
 	g_test_add_func("/testutil/Invalid Conversions", test_invalid);
 	g_test_add_func("/testutil/Valid Conversions", test_valid);
 	g_test_add_func("/testutil/Valid Turkish National Variant Conversions", t=
est_valid_turkish);
+	g_test_add_func("/testutil/Encode with transliteration", test_encode_tran=
slit);
 	g_test_add_func("/testutil/Decode Encode", test_decode_encode);
 	g_test_add_func("/testutil/Pack Size", test_pack_size);
 	g_test_add_func("/testutil/CBS CR Handling", test_cr_handling);
-- =

1.7.0.4


--===============8627388207741285002==--

