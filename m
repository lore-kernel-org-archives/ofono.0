Content-Type: multipart/mixed; boundary="===============0086627441898385653=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 2/4] SetProperty for UseDeliveryReports. test-sms.c.
Date: Mon, 07 Jun 2010 12:53:27 +0300
Message-ID: <1275904409-19829-3-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1275904409-19829-2-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0086627441898385653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-sms.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/unit/test-sms.c b/unit/test-sms.c
index d7d97f3..aec725b 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -685,7 +685,7 @@ static void test_assembly()
 	if (g_test_verbose())
 		g_printf("Text:\n%s\n", utf8);
 =

-	l =3D sms_text_prepare(utf8, ref, TRUE, NULL);
+	l =3D sms_text_prepare(utf8, ref, TRUE, NULL, FALSE);
 	g_assert(l);
 	g_assert(g_slist_length(l) =3D=3D 3);
 =

@@ -715,7 +715,7 @@ static void test_prepare_7bit()
 	int encoded_tpdu_len;
 	char *encoded_pdu;
 =

-	r =3D sms_text_prepare(test_no_fragmentation_7bit, 0, FALSE, NULL);
+	r =3D sms_text_prepare(test_no_fragmentation_7bit, 0, FALSE, NULL, FALSE);
 =

 	g_assert(r !=3D NULL);
 =

@@ -798,8 +798,7 @@ static void test_prepare_concat(gconstpointer data)
 	if (g_test_verbose())
 		g_print("strlen: %zd\n", strlen(test->str));
 =

-	r =3D sms_text_prepare(test->str, 0, TRUE, NULL);
-
+	r =3D sms_text_prepare(test->str, 0, TRUE, NULL, FALSE);
 	g_assert(r);
 	g_assert(g_slist_length(r) =3D=3D test->segments);
 =

@@ -875,7 +874,7 @@ static void test_limit(gunichar uni, int target_size, g=
boolean use_16bit)
 =

 	utf8[i] =3D '\0';
 =

-	l =3D sms_text_prepare(utf8, 0, use_16bit, NULL);
+	l =3D sms_text_prepare(utf8, 0, use_16bit, NULL, FALSE);
 =

 	g_assert(l);
 	g_assert(g_slist_length(l) =3D=3D 255);
@@ -888,7 +887,7 @@ static void test_limit(gunichar uni, int target_size, g=
boolean use_16bit)
 	memcpy(utf8 + i, utf8_char, stride);
 	utf8[i+stride] =3D '\0';
 =

-	l =3D sms_text_prepare(utf8, 0, use_16bit, NULL);
+	l =3D sms_text_prepare(utf8, 0, use_16bit, NULL, FALSE);
 =

 	g_assert(l =3D=3D NULL);
 	g_free(utf8);
-- =

1.6.0.4



--===============0086627441898385653==--

