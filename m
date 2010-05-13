Content-Type: multipart/mixed; boundary="===============7345676738542328057=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 01/16] Refactor: use g_slist_find_custom for watchlist
Date: Thu, 13 May 2010 18:02:24 +0800
Message-ID: <1273744959-3711-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7345676738542328057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use g_slist_find_custom to search watchlist. Add method to remove all
watch items without freeing ofono_watchlist itself.
---
 src/ofono.h |    1 +
 src/watch.c |   75 ++++++++++++++++++++++++++++++-------------------------=
---
 2 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 7b13cce..f93760e 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -79,6 +79,7 @@ unsigned int __ofono_watchlist_add_item(struct ofono_watc=
hlist *watchlist,
 					struct ofono_watchlist_item *item);
 gboolean __ofono_watchlist_remove_item(struct ofono_watchlist *watchlist,
 					unsigned int id);
+void __ofono_watchlist_remove_all(struct ofono_watchlist *watchlist);
 void __ofono_watchlist_free(struct ofono_watchlist *watchlist);
 =

 #include <ofono/plugin.h>
diff --git a/src/watch.c b/src/watch.c
index f93b68c..0388669 100644
--- a/src/watch.c
+++ b/src/watch.c
@@ -46,59 +46,62 @@ unsigned int __ofono_watchlist_add_item(struct ofono_wa=
tchlist *watchlist,
 	return item->id;
 }
 =

-gboolean __ofono_watchlist_remove_item(struct ofono_watchlist *watchlist,
-					unsigned int id)
+static gint watchlist_item_compare_by_id(gconstpointer a, gconstpointer b)
 {
-	struct ofono_watchlist_item *item;
-	GSList *p;
-	GSList *c;
-
-	p =3D NULL;
-	c =3D watchlist->items;
-
-	while (c) {
-		item =3D c->data;
+	const struct ofono_watchlist_item *item =3D a;
+	unsigned int id =3D GPOINTER_TO_UINT(b);
 =

-		if (item->id !=3D id) {
-			p =3D c;
-			c =3D c->next;
-			continue;
-		}
+	if (item->id < id)
+		return -1;
 =

-		if (p)
-			p->next =3D c->next;
-		else
-			watchlist->items =3D c->next;
+	if (item->id > id)
+		return 1;
 =

-		if (item->destroy)
-			item->destroy(item->notify_data);
+	return 0;
+}
 =

-		if (watchlist->destroy)
-			watchlist->destroy(item);
-		g_slist_free_1(c);
+static void watchlist_remove_item(void *data, void *user_data)
+{
+	struct ofono_watchlist_item *item =3D data;
+	struct ofono_watchlist *watchlist =3D user_data;
 =

-		return TRUE;
-	}
+	if (item->destroy)
+		item->destroy(item->notify_data);
 =

-	return FALSE;
+	if (watchlist->destroy)
+		watchlist->destroy(item);
 }
 =

-void __ofono_watchlist_free(struct ofono_watchlist *watchlist)
+gboolean __ofono_watchlist_remove_item(struct ofono_watchlist *watchlist,
+					unsigned int id)
 {
 	struct ofono_watchlist_item *item;
 	GSList *l;
 =

-	for (l =3D watchlist->items; l; l =3D l->next) {
-		item =3D l->data;
+	l =3D g_slist_find_custom(watchlist->items, GUINT_TO_POINTER(id),
+						watchlist_item_compare_by_id);
+	if (l =3D=3D NULL)
+		return FALSE;
+
+	item =3D l->data;
 =

-		if (item->destroy)
-			item->destroy(item->notify_data);
+	watchlist->items =3D g_slist_remove(watchlist->items, item);
 =

-		if (watchlist->destroy)
-			watchlist->destroy(item);
-	}
+	watchlist_remove_item(item, watchlist);
 =

+	return TRUE;
+}
+
+void __ofono_watchlist_remove_all(struct ofono_watchlist *watchlist)
+{
+	g_slist_foreach(watchlist->items, watchlist_remove_item, watchlist);
 	g_slist_free(watchlist->items);
 	watchlist->items =3D NULL;
+	watchlist->next_id =3D 0;
+}
+
+void __ofono_watchlist_free(struct ofono_watchlist *watchlist)
+{
+	__ofono_watchlist_remove_all(watchlist);
 	g_free(watchlist);
 }
-- =

1.6.3.3


--===============7345676738542328057==--

