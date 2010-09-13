Content-Type: multipart/mixed; boundary="===============8121976462496644007=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 3/8] test-util: Add function for validating UCS2 to GSM bit
 conversion
Date: Mon, 13 Sep 2010 16:00:12 -0700
Message-ID: <1284418817-28575-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1284418817-28575-3-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8121976462496644007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-util.c |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/unit/test-util.c b/unit/test-util.c
index de62848..9df61dd 100644
--- a/unit/test-util.c
+++ b/unit/test-util.c
@@ -38,6 +38,10 @@ const unsigned char invalid_gsm_extended_len[] =3D {
 	0x1b, 0x28, 0x1b
 };
 =

+const unsigned char invalid_ucs2[] =3D {
+	0x03, 0x93, 0x00, 0x00
+};
+
 unsigned short gsm_to_unicode_map[] =3D
 {
 0x00,	0x0040,
@@ -342,6 +346,7 @@ static void test_invalid()
 	long nwritten;
 	long nread;
 	char *res;
+	unsigned char *gsm;
 =

 	res =3D convert_gsm_to_utf8(invalid_gsm_extended, 0, &nread, &nwritten,
 					0);
@@ -362,6 +367,19 @@ static void test_invalid()
 					&nread, &nwritten, 0);
 	g_assert(res =3D=3D NULL);
 	g_assert(nread =3D=3D 3);
+
+	gsm =3D convert_ucs2_to_gsm(invalid_ucs2,
+					sizeof(invalid_ucs2),
+					&nread, &nwritten, 0);
+	g_assert(gsm =3D=3D NULL);
+	g_assert(nread =3D=3D 1);
+
+	nread =3D 0;
+	gsm =3D convert_ucs2_to_gsm(invalid_ucs2,
+					sizeof(invalid_ucs2) - 1,
+					&nread, &nwritten, 0);
+	g_assert(gsm =3D=3D NULL);
+	g_assert(nread =3D=3D 0);
 }
 =

 static void test_valid()
@@ -905,6 +923,67 @@ static void test_sim()
 	g_assert(utf8 =3D=3D NULL);
 }
 =

+static void test_unicode_to_gsm()
+{
+	long nwritten;
+	long nread;
+	int i;
+	unsigned char *res;
+	char *utf8;
+	unsigned char buf[2];
+	unsigned char *back;
+	gunichar2 verify;
+
+	static int map_size =3D
+		sizeof(gsm_to_unicode_map) / sizeof(unsigned short) / 2;
+
+	for (i =3D 0; i < map_size; i++) {
+		unsigned short c =3D gsm_to_unicode_map[i*2+1];
+
+		buf[0] =3D c >> 8;
+		buf[1] =3D c & 0xff;
+
+		res =3D convert_ucs2_to_gsm(buf, 2, &nread, &nwritten, 0);
+		g_assert(res);
+
+		if (g_test_verbose())
+			g_print("nread:%ld, nwritten:%ld, %s\n",
+				nread, nwritten, res);
+
+		if (res[0] =3D=3D 0x1B)
+			g_assert(nwritten =3D=3D 2);
+		else
+			g_assert(nwritten =3D=3D 1);
+
+		utf8 =3D g_convert((const gchar *) buf, 2,
+				"UTF-8", "UCS-2BE",
+				NULL, NULL, NULL);
+		g_assert(utf8);
+
+		back =3D convert_utf8_to_gsm(utf8, strlen(utf8), &nread,
+						&nwritten, 0);
+		g_assert(back);
+
+		if (back[0] =3D=3D 0x1B) {
+			g_assert(nwritten =3D=3D 2);
+			verify =3D back[0] << 8 | back[1];
+		} else {
+			g_assert(nwritten =3D=3D 1);
+			verify =3D back[0];
+		}
+
+		if (g_test_verbose())
+			g_print("nwritten:%ld, verify: 0x%x\n",
+				nwritten, verify);
+
+		g_assert(verify =3D=3D gsm_to_unicode_map[i*2]);
+
+		g_free(res);
+		g_free(back);
+		g_free(utf8);
+	}
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -918,6 +997,7 @@ int main(int argc, char **argv)
 	g_test_add_func("/testutil/SMS Handling", test_sms_handling);
 	g_test_add_func("/testutil/Offset Handling", test_offset_handling);
 	g_test_add_func("/testutil/SIM conversions", test_sim);
+	g_test_add_func("/testutil/Valid Unicode to GSM Conversion", test_unicode=
_to_gsm);
 =

 	return g_test_run();
 }
-- =

1.7.0.4


--===============8121976462496644007==--

