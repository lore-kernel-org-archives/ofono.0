Content-Type: multipart/mixed; boundary="===============6584419918698194899=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH] gril: Fix access to notify callbacks
Date: Mon, 02 Nov 2015 17:48:41 +0100
Message-ID: <1446482921-16956-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6584419918698194899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Entries to the table of notification callbacks can be added by the
callbacks while being called. This caused a glib error as gril was
using an iterator to the hash table while the table was being modified.
Fixed by avoiding the unnecesary loop.
---
 gril/gril.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/gril/gril.c b/gril/gril.c
index ead8206..d279c44 100644
--- a/gril/gril.c
+++ b/gril/gril.c
@@ -420,48 +420,36 @@ static gboolean node_check_destroyed(struct ril_notif=
y_node *node,
 =

 static void handle_unsol_req(struct ril_s *p, struct ril_msg *message)
 {
-	GHashTableIter iter;
 	struct ril_notify *notify;
-	int req_key;
-	gpointer key, value;
-	GList *list_item;
-	struct ril_notify_node *node;
-	gboolean found =3D FALSE;
 =

 	if (p->notify_list =3D=3D NULL)
 		return;
 =

 	p->in_notify =3D TRUE;
 =

-	g_hash_table_iter_init(&iter, p->notify_list);
+	notify =3D g_hash_table_lookup(p->notify_list, &message->req);
+	if (notify !=3D NULL) {
+		GSList *list_item;
 =

-	while (g_hash_table_iter_next(&iter, &key, &value)) {
-		req_key =3D *((int *)key);
-		notify =3D value;
-
-		if (req_key !=3D message->req)
-			continue;
+		for (list_item =3D notify->nodes; list_item;
+				list_item =3D g_slist_next(list_item)) {
+			struct ril_notify_node *node =3D list_item->data;
 =

-		list_item =3D (GList *) notify->nodes;
-
-		while (list_item !=3D NULL) {
-			node =3D list_item->data;
+			if (node->destroyed)
+				continue;
 =

 			node->callback(message, node->user_data);
-			found =3D TRUE;
-			list_item =3D (GList *) g_slist_next(list_item);
 		}
-	}
-
-	/* Only log events not being listended for... */
-	if (!found)
+	} else {
+		/* Only log events not being listended for... */
 		DBG("RIL Event slot %d: %s\n",
 			p->slot, unsol_request_to_string(p, message->req));
+	}
 =

 	p->in_notify =3D FALSE;
 =

 	/* Now destroy nodes possibly removed by callbacks */
-	if (found)
+	if (notify !=3D NULL)
 		ril_unregister_all(p, FALSE, node_check_destroyed,
 					GUINT_TO_POINTER(TRUE));
 }
-- =

2.1.4


--===============6584419918698194899==--

