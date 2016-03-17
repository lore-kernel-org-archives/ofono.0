Content-Type: multipart/mixed; boundary="===============7862555130175156075=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 1/9] idmap: add api for finding a certain id in map
Date: Thu, 17 Mar 2016 18:02:12 +0100
Message-ID: <1458234140-7936-2-git-send-email-dragos@endocode.com>
In-Reply-To: <1458234140-7936-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7862555130175156075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/idmap.c | 13 +++++++++++++
 src/idmap.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/src/idmap.c b/src/idmap.c
index c097eb4..3b72830 100644
--- a/src/idmap.c
+++ b/src/idmap.c
@@ -166,6 +166,19 @@ void idmap_take(struct idmap *idmap, unsigned int id)
 	idmap->bits[offset] |=3D 1UL << (bit % BITS_PER_LONG);
 }
 =

+int idmap_find(struct idmap *idmap, unsigned int id)
+{
+	unsigned int bit =3D id - idmap->min;
+	unsigned int offset;
+
+	if (bit >=3D idmap->size)
+		return 0;
+
+	offset =3D bit / BITS_PER_LONG;
+	return (idmap->bits[offset] & (1UL << (bit % BITS_PER_LONG))) !=3D 0;
+
+}
+
 /*
  * Allocate the next bit skipping the ids up to and including last.  If th=
ere
  * is no free ids until the max id is encountered, the counter is wrapped =
back
diff --git a/src/idmap.h b/src/idmap.h
index ebda177..97a6f04 100644
--- a/src/idmap.h
+++ b/src/idmap.h
@@ -25,6 +25,7 @@ struct idmap *idmap_new(unsigned int size);
 void idmap_free(struct idmap *idmap);
 void idmap_put(struct idmap *idmap, unsigned int id);
 void idmap_take(struct idmap *idmap, unsigned int id);
+int idmap_find(struct idmap *idmap, unsigned int id);
 unsigned int idmap_alloc(struct idmap *idmap);
 unsigned int idmap_alloc_next(struct idmap *idmap, unsigned int last);
 struct idmap *idmap_new_from_range(unsigned int min, unsigned int max);
-- =

2.5.0


--===============7862555130175156075==--

