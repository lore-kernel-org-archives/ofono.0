Content-Type: multipart/mixed; boundary="===============6011969541736645569=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH] idmap: use UL for bitshift literals
Date: Tue, 04 Mar 2014 19:01:34 -0500
Message-ID: <1393977694-18423-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6011969541736645569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current bitshift logic in idmap incorrectly uses
the literal 1 for the value to shift in idmap_alloc(),
idmap_take(), and idmap_alloc_next().  This causes the
resulting value to be an int instead of a long, which
results in the wrong bit being set once the number of
bits to shift operand exceeds sizeof(int).  Also
on some platforms, the behavior of the left bitshift
operator is undefined when this overflow occurs.
---
 src/idmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/idmap.c b/src/idmap.c
index 63f5c7c..c097eb4 100644
--- a/src/idmap.c
+++ b/src/idmap.c
@@ -135,7 +135,7 @@ void idmap_put(struct idmap *idmap, unsigned int id)
 =

 	id %=3D BITS_PER_LONG;
 =

-	idmap->bits[offset] &=3D ~(1 << id);
+	idmap->bits[offset] &=3D ~(1UL << id);
 }
 =

 unsigned int idmap_alloc(struct idmap *idmap)
@@ -149,7 +149,7 @@ unsigned int idmap_alloc(struct idmap *idmap)
 		return idmap->max + 1;
 =

 	offset =3D bit / BITS_PER_LONG;
-	idmap->bits[offset] |=3D 1 << (bit % BITS_PER_LONG);
+	idmap->bits[offset] |=3D 1UL << (bit % BITS_PER_LONG);
 =

 	return bit + idmap->min;
 }
@@ -163,7 +163,7 @@ void idmap_take(struct idmap *idmap, unsigned int id)
 		return;
 =

 	offset =3D bit / BITS_PER_LONG;
-	idmap->bits[offset] |=3D 1 << (bit % BITS_PER_LONG);
+	idmap->bits[offset] |=3D 1UL << (bit % BITS_PER_LONG);
 }
 =

 /*
@@ -186,7 +186,7 @@ unsigned int idmap_alloc_next(struct idmap *idmap, unsi=
gned int last)
 		return idmap_alloc(idmap);
 =

 	offset =3D bit / BITS_PER_LONG;
-	idmap->bits[offset] |=3D 1 << (bit % BITS_PER_LONG);
+	idmap->bits[offset] |=3D 1UL << (bit % BITS_PER_LONG);
 =

 	return bit + idmap->min;
 }
-- =

1.9.0


--===============6011969541736645569==--

