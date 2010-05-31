Content-Type: multipart/mixed; boundary="===============0631975373701728976=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/2] stk: Constraint the appearance of empty item
Date: Mon, 31 May 2010 19:13:21 +0800
Message-ID: <1275304402-23708-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0631975373701728976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If empty item turns out, it must be the only item in the list.
So the following situations are deemed as invalid:
1. Two empty items
2. Valid item + empty item
3. empty + valid item
---
 src/stkutil.c |   40 ++++++++++++++++++++++++++++------------
 1 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 2ca5c6a..a31ae20 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2014,6 +2014,12 @@ static dataobj_handler handler_for_type(enum stk_dat=
a_object_type type)
 	}
 }
 =

+static void destroy_stk_item(struct stk_item *item)
+{
+	g_free(item->text);
+	g_free(item);
+}
+
 static gboolean parse_item_list(struct comprehension_tlv_iter *iter,
 				void *data)
 {
@@ -2022,21 +2028,40 @@ static gboolean parse_item_list(struct comprehensio=
n_tlv_iter *iter,
 	struct comprehension_tlv_iter iter_old;
 	struct stk_item item;
 	GSList *list =3D NULL;
+	unsigned int count =3D 0;
+	gboolean has_empty =3D FALSE;
 =

 	do {
 		comprehension_tlv_iter_copy(iter, &iter_old);
 		memset(&item, 0, sizeof(item));
+		count++;
+
+		if (parse_dataobj_item(iter, &item) =3D=3D TRUE) {
+			if (item.id =3D=3D 0) {
+				has_empty =3D TRUE;
+				continue;
+			}
 =

-		if (parse_dataobj_item(iter, &item) =3D=3D TRUE)
 			list =3D g_slist_prepend(list,
 						g_memdup(&item, sizeof(item)));
+		}
 	} while (comprehension_tlv_iter_next(iter) =3D=3D TRUE &&
 			comprehension_tlv_iter_get_tag(iter) =3D=3D tag);
 =

 	comprehension_tlv_iter_copy(&iter_old, iter);
-	*out =3D g_slist_reverse(list);
 =

-	return TRUE;
+	if (!has_empty) {
+		*out =3D g_slist_reverse(list);
+		return TRUE;
+	}
+
+	if (count =3D=3D 1)
+		return TRUE;
+
+	g_slist_foreach(list, (GFunc)destroy_stk_item, NULL);
+	g_slist_free(list);
+	return FALSE;
+
 }
 =

 static gboolean parse_provisioning_list(struct comprehension_tlv_iter *ite=
r,
@@ -2342,12 +2367,6 @@ static gboolean parse_poll_interval(struct stk_comma=
nd *command,
 	return TRUE;
 }
 =

-static void destroy_stk_item(struct stk_item *item)
-{
-	g_free(item->text);
-	g_free(item);
-}
-
 static void destroy_setup_menu(struct stk_command *command)
 {
 	g_free(command->setup_menu.alpha_id);
@@ -2392,9 +2411,6 @@ static gboolean parse_setup_menu(struct stk_command *=
command,
 	if (ret =3D=3D FALSE)
 		return FALSE;
 =

-	if (obj->items =3D=3D NULL)
-		return FALSE;
-
 	return TRUE;
 }
 =

-- =

1.7.0.4


--===============0631975373701728976==--

