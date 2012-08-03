Content-Type: multipart/mixed; boundary="===============6834013324842130273=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 2/2] unit: Add padding character decoding test
Date: Fri, 03 Aug 2012 15:00:32 +0200
Message-ID: <1343998832-8111-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1343998832-8111-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6834013324842130273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-sms.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/unit/test-sms.c b/unit/test-sms.c
index e510554..04a8874 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -1236,6 +1236,10 @@ static const char *cbs2 =3D "0110003201114679785E963=
71A8D46A3D168341A8D46A3D1683"
 	"41A8D46A3D168341A8D46A3D168341A8D46A3D168341A8D46A3D168341A8D46A3D168"
 	"341A8D46A3D168341A8D46A3D168341A8D46A3D168341A8D46A3D100";
 =

+static const char *cbs3 =3D "001000000111E280604028180E888462C168381E90886=
442A95"
+	"82E988C66C3E9783EA09068442A994EA8946AC56AB95EB0986C46ABD96EB89C6EC7EBF"
+	"97EC0A070482C1A8FC8A472C96C3A9FD0A8744AAD5AAFD8AC76CB05";
+
 static void test_cbs_encode_decode(void)
 {
 	unsigned char *decoded_pdu;
@@ -1389,6 +1393,58 @@ static void test_cbs_assembly(void)
 	cbs_assembly_free(assembly);
 }
 =

+static void test_cbs_padding_character(void)
+{
+	unsigned char *decoded_pdu;
+	long pdu_len;
+	gboolean ret;
+	struct cbs cbs;
+	GSList *l;
+	char iso639_lang[3];
+	char *utf8;
+
+	decoded_pdu =3D decode_hex(cbs3, -1, &pdu_len, 0);
+
+	g_assert(decoded_pdu);
+	g_assert(pdu_len =3D=3D (long)strlen(cbs1) / 2);
+	g_assert(pdu_len =3D=3D 88);
+
+	ret =3D cbs_decode(decoded_pdu, pdu_len, &cbs);
+
+	g_free(decoded_pdu);
+
+	g_assert(ret);
+
+	g_assert(cbs.gs =3D=3D CBS_GEO_SCOPE_CELL_IMMEDIATE);
+	g_assert(cbs.message_code =3D=3D 1);
+	g_assert(cbs.update_number =3D=3D 0);
+	g_assert(cbs.message_identifier =3D=3D 0);
+	g_assert(cbs.dcs =3D=3D 1);
+	g_assert(cbs.max_pages =3D=3D 1);
+	g_assert(cbs.page =3D=3D 1);
+
+	l =3D g_slist_append(NULL, &cbs);
+
+	utf8 =3D cbs_decode_text(l, iso639_lang);
+
+	g_assert(utf8);
+
+	if (g_test_verbose()) {
+		g_printf("%s\n", utf8);
+		if (iso639_lang[0] =3D=3D '\0')
+			g_printf("Lang: Unspecified\n");
+		else
+			g_printf("Lang: %s\n", iso639_lang);
+	}
+
+	g_assert(strlen(utf8) =3D=3D 122);
+	g_assert(strcmp(iso639_lang, "en") =3D=3D 0);
+
+	g_free(utf8);
+
+	g_slist_free(l);
+}
+
 static const char *ranges[] =3D { "1-5, 2, 3, 600, 569-900, 999",
 				"0-20, 33, 44, 50-60, 20-50, 1-5, 5, 3, 5",
 				NULL };
@@ -1679,6 +1735,8 @@ int main(int argc, char **argv)
 			test_cbs_encode_decode);
 	g_test_add_func("/testsms/Test CBS Assembly", test_cbs_assembly);
 =

+	g_test_add_func("/testsms/Test CBS Padding Character",
+			test_cbs_padding_character);
 	g_test_add_func("/testsms/Range minimizer", test_range_minimizer);
 =

 	g_test_add_func("/testsms/Status Report Assembly", test_sr_assembly);
-- =

1.7.5.4


--===============6834013324842130273==--

