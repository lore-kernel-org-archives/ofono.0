Content-Type: multipart/mixed; boundary="===============8616512569221389331=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 3/3] unit: Add test to check CBS padding character
Date: Fri, 31 Aug 2012 17:03:58 +0200
Message-ID: <1346425438-12220-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346425438-12220-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8616512569221389331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Zajac <guillaume.zajac@linux.intel.com>

This CBS unit test is used to check that the <CR> character can
be interpreted as a wanted carriage return and not necessarily
as a padding character.
---
 unit/test-sms.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 59 insertions(+)

diff --git a/unit/test-sms.c b/unit/test-sms.c
index e510554..31e18f8 100644
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
+	g_assert(strcmp(utf8, "b=C2=A3$=C2=A5=C3=A8=C3=A9=C3=B9=C3=AC=C3=B2=C3=87=
\x0A=C3=98=C3=B8\x0D=C3=85=C3=A5=CE=94_=CE=A6=CE=93=CE=9B=CE=A9=CE=A0=CE=A8=
=CE=A3=CE=98=CE=9E=C3=86=C3=A6=C3=9F=C3=89 !\"#=C2=A4"
+				"\x25&'()*+,-./0123456789:;<=3D>?=C2=A1ABCDEFGHIJKLM"
+				"NOPQRSTUVWXYZ=C3=84=C3=96") =3D=3D 0);
+	g_assert(strcmp(iso639_lang, "en") =3D=3D 0);
+
+	g_free(utf8);
+	g_slist_free(l);
+}
+
 static const char *ranges[] =3D { "1-5, 2, 3, 600, 569-900, 999",
 				"0-20, 33, 44, 50-60, 20-50, 1-5, 5, 3, 5",
 				NULL };
@@ -1679,6 +1735,9 @@ int main(int argc, char **argv)
 			test_cbs_encode_decode);
 	g_test_add_func("/testsms/Test CBS Assembly", test_cbs_assembly);
 =

+	g_test_add_func("/testsms/Test CBS Padding Character",
+			test_cbs_padding_character);
+
 	g_test_add_func("/testsms/Range minimizer", test_range_minimizer);
 =

 	g_test_add_func("/testsms/Status Report Assembly", test_sr_assembly);
-- =

1.7.9.5


--===============8616512569221389331==--

