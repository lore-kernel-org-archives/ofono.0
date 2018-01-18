Content-Type: multipart/mixed; boundary="===============2807233184966004777=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] unit: Improve idmap.c unit test coverage
Date: Thu, 18 Jan 2018 20:36:52 +0200
Message-ID: <1516300612-8822-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2807233184966004777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This brings function, line and branch coverage for idmap.c to 100%
---
 unit/test-idmap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/unit/test-idmap.c b/unit/test-idmap.c
index b072933..2d2e226 100644
--- a/unit/test-idmap.c
+++ b/unit/test-idmap.c
@@ -35,9 +35,12 @@ static void test_alloc(void)
 	idmap =3D idmap_new(2);
 =

 	g_assert(idmap);
+	g_assert(idmap_get_min(idmap) =3D=3D 1);
 =

 	bit =3D idmap_alloc(idmap);
 	g_assert(bit =3D=3D 1);
+	g_assert(idmap_find(idmap, bit));
+	g_assert(!idmap_find(idmap, idmap_get_max(idmap) + 1));
 =

 	bit =3D idmap_alloc(idmap);
 	g_assert(bit =3D=3D 2);
@@ -62,6 +65,12 @@ static void test_alloc(void)
 	bit =3D idmap_alloc(idmap);
 	g_assert(bit =3D=3D 1);
 =

+	idmap_put(idmap, 1);
+	idmap_take(idmap, 1);
+	idmap_take(idmap, 3);
+	bit =3D idmap_alloc(idmap);
+	g_assert(bit =3D=3D 2);
+
 	idmap_free(idmap);
 }
 =

@@ -80,9 +89,24 @@ static void test_alloc_next(void)
 	bit =3D idmap_alloc_next(idmap, 255);
 	g_assert(bit =3D=3D 1);
 =

+	while (idmap_alloc(idmap) < (sizeof(unsigned long) * 8) + 1);
+	bit =3D idmap_alloc_next(idmap, 1);
+	g_assert(bit =3D=3D (sizeof(unsigned long) * 8) + 2);
+
+	idmap_free(idmap);
+
+	idmap =3D idmap_new(2);
+
+	g_assert(idmap);
+	g_assert(idmap_alloc_next(idmap, 0) =3D=3D 3);
+	g_assert(idmap_alloc_next(idmap, 3) =3D=3D 3);
+
 	bit =3D idmap_alloc_next(idmap, 1);
 	g_assert(bit =3D=3D 2);
 =

+	bit =3D idmap_alloc_next(idmap, 2);
+	g_assert(bit =3D=3D 1);
+
 	idmap_free(idmap);
 }
 =

-- =

1.9.1


--===============2807233184966004777==--

