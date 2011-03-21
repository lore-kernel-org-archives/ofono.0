Content-Type: multipart/mixed; boundary="===============5169600834622102106=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 2/3] idmap.c: add get size function
Date: Mon, 21 Mar 2011 14:45:13 +0100
Message-ID: <1300715114-5790-3-git-send-email-olivier.guiter@linux.intel.com>
In-Reply-To: <1300715114-5790-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5169600834622102106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/idmap.c |    5 +++++
 src/idmap.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/idmap.c b/src/idmap.c
index 6d46e8a..967adbd 100644
--- a/src/idmap.c
+++ b/src/idmap.c
@@ -200,3 +200,8 @@ unsigned int idmap_get_max(struct idmap *idmap)
 {
 	return idmap->max;
 }
+
+unsigned int idmap_get_size(struct idmap *idmap)
+{
+	return idmap->size;
+}
diff --git a/src/idmap.h b/src/idmap.h
index d6141c2..6fc29fd 100644
--- a/src/idmap.h
+++ b/src/idmap.h
@@ -30,3 +30,4 @@ unsigned int idmap_alloc_next(struct idmap *idmap, unsign=
ed int last);
 struct idmap *idmap_new_from_range(unsigned int min, unsigned int max);
 unsigned int idmap_get_min(struct idmap *idmap);
 unsigned int idmap_get_max(struct idmap *idmap);
+unsigned int idmap_get_size(struct idmap *idmap);
-- =

1.7.1


--===============5169600834622102106==--

