Content-Type: multipart/mixed; boundary="===============4605824713402437864=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] test-sms: Fixed memory leaks in the unit test
Date: Mon, 02 Jan 2017 14:15:08 +0300
Message-ID: <1483355708-27054-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4605824713402437864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-sms.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/unit/test-sms.c b/unit/test-sms.c
index 3d0f016..618d139 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -1145,6 +1145,8 @@ static void test_assembly(void)
 =

 	reencoded =3D sms_decode_text(l);
 =

+	g_slist_free_full(l, g_free);
+
 	if (g_test_verbose())
 		g_printf("ReEncoded:\n%s\n", reencoded);
 =

@@ -1304,6 +1306,8 @@ static void test_prepare_concat(gconstpointer data)
 	g_assert(decoded_str);
 	g_assert(strcmp(decoded_str, test->str) =3D=3D 0);
 	g_free(decoded_str);
+	g_slist_free_full(pdus, g_free);
+	g_slist_free_full(r, g_free);
 	sms_assembly_free(assembly);
 }
 =

@@ -1334,6 +1338,7 @@ static void test_limit(gunichar uni, int target_size,=
 gboolean use_16bit)
 	g_assert(g_utf8_strlen(decoded, -1) =3D=3D target_size);
 =

 	g_free(decoded);
+	g_slist_free_full(l, g_free);
 =

 	memcpy(utf8 + i, utf8_char, stride);
 	utf8[i+stride] =3D '\0';
-- =

1.9.1


--===============4605824713402437864==--

