Content-Type: multipart/mixed; boundary="===============5303348425595767753=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 24/24] unittest: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:08 +0000
Message-ID: <1461330601-21333-25-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-24-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5303348425595767753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 unit/test-sms.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/unit/test-sms.c b/unit/test-sms.c
index 259594e..3d0f016 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -1132,8 +1132,7 @@ static void test_assembly(void)
 =

 	utf8 =3D sms_decode_text(l);
 =

-	g_slist_foreach(l, (GFunc)g_free, NULL);
-	g_slist_free(l);
+	g_slist_free_full(l, g_free);
 =

 	sms_assembly_free(assembly);
 =

@@ -1214,8 +1213,7 @@ static void test_prepare_7bit(void)
 	g_assert(strcmp(expected_no_fragmentation_7bit, encoded_pdu) =3D=3D 0);
 =

 	g_free(encoded_pdu);
-	g_slist_foreach(r, (GFunc)g_free, NULL);
-	g_slist_free(r);
+	g_slist_free_full(r, g_free);
 }
 =

 struct sms_concat_data {
@@ -1273,8 +1271,7 @@ static void test_prepare_concat(gconstpointer data)
 		pdus =3D g_slist_append(pdus, strpdu);
 	}
 =

-	g_slist_foreach(r, (GFunc)g_free, NULL);
-	g_slist_free(r);
+	g_slist_free_full(r, g_free);
 =

 	for (l =3D pdus; l; l =3D l->next) {
 		long len;
@@ -1474,16 +1471,14 @@ static void test_cbs_assembly(void)
 	l =3D cbs_assembly_add_page(assembly, &dec1);
 	g_assert(l);
 	g_assert(g_slist_length(assembly->recv_cell) =3D=3D 1);
-	g_slist_foreach(l, (GFunc)g_free, NULL);
-	g_slist_free(l);
+	g_slist_free_full(l, g_free);
 =

 	/* Can we receive new updates ? */
 	dec1.update_number =3D 8;
 	l =3D cbs_assembly_add_page(assembly, &dec1);
 	g_assert(l);
 	g_assert(g_slist_length(assembly->recv_cell) =3D=3D 1);
-	g_slist_foreach(l, (GFunc)g_free, NULL);
-	g_slist_free(l);
+	g_slist_free_full(l, g_free);
 =

 	/* Do we ignore old pages ? */
 	l =3D cbs_assembly_add_page(assembly, &dec1);
@@ -1529,8 +1524,7 @@ static void test_cbs_assembly(void)
 	g_assert(strcmp(utf8, "BelconnenFraserBelconnen") =3D=3D 0);
 =

 	g_free(utf8);
-	g_slist_foreach(l, (GFunc)g_free, NULL);
-	g_slist_free(l);
+	g_slist_free_full(l, g_free);
 =

 	cbs_assembly_free(assembly);
 }
@@ -1621,8 +1615,7 @@ static void test_range_minimizer(void)
 			g_print("range: %s\n", rangestr);
 =

 		g_free(rangestr);
-		g_slist_foreach(r, (GFunc)g_free, NULL);
-		g_slist_free(r);
+		g_slist_free_full(r, g_free);
 	}
 }
 =

-- =

1.9.1

--===============5303348425595767753==--

