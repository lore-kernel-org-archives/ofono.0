Content-Type: multipart/mixed; boundary="===============6190701671478889693=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 19/24] smsutil: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:07 +0000
Message-ID: <1461330601-21333-20-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-19-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6190701671478889693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/smsutil.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 19e2016..b6f7348 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2541,8 +2541,7 @@ void sms_assembly_free(struct sms_assembly *assembly)
 	for (l =3D assembly->assembly_list; l; l =3D l->next) {
 		struct sms_assembly_node *node =3D l->data;
 =

-		g_slist_foreach(node->fragment_list, (GFunc) g_free, 0);
-		g_slist_free(node->fragment_list);
+		g_slist_free_full(node->fragment_list, g_free);
 		g_free(node);
 	}
 =

@@ -2692,8 +2691,7 @@ void sms_assembly_expire(struct sms_assembly *assembl=
y, time_t before)
 =

 		sms_assembly_backup_free(assembly, node);
 =

-		g_slist_foreach(node->fragment_list, (GFunc) g_free, 0);
-		g_slist_free(node->fragment_list);
+		g_slist_free_full(node->fragment_list, g_free);
 		g_free(node);
 =

 		if (prev)
@@ -3506,8 +3504,7 @@ GSList *sms_datagram_prepare(const char *to,
 	}
 =

 	if (left > 0) {
-		g_slist_foreach(r, (GFunc) g_free, NULL);
-		g_slist_free(r);
+		g_slist_free_full(r, g_free);
 =

 		return NULL;
 	} else {
@@ -3698,8 +3695,7 @@ GSList *sms_text_prepare_with_alphabet(const char *to=
, const char *utf8,
 		g_free(ucs2_encoded);
 =

 	if (left > 0) {
-		g_slist_foreach(r, (GFunc) g_free, NULL);
-		g_slist_free(r);
+		g_slist_free_full(r, g_free);
 =

 		return NULL;
 	} else {
@@ -4214,8 +4210,7 @@ void cbs_assembly_free(struct cbs_assembly *assembly)
 	for (l =3D assembly->assembly_list; l; l =3D l->next) {
 		struct cbs_assembly_node *node =3D l->data;
 =

-		g_slist_foreach(node->pages, (GFunc) g_free, 0);
-		g_slist_free(node->pages);
+		g_slist_free_full(node->pages, g_free);
 		g_free(node);
 	}
 =

@@ -4294,8 +4289,7 @@ static void cbs_assembly_expire(struct cbs_assembly *=
assembly,
 		else
 			assembly->assembly_list =3D l->next;
 =

-		g_slist_foreach(node->pages, (GFunc) g_free, NULL);
-		g_slist_free(node->pages);
+		g_slist_free_full(node->pages, g_free);
 		g_free(node->pages);
 		tmp =3D l;
 		l =3D l->next;
@@ -4604,8 +4598,7 @@ GSList *cbs_extract_topic_ranges(const char *ranges)
 	}
 =

 	tmp =3D cbs_optimize_ranges(ret);
-	g_slist_foreach(ret, (GFunc) g_free, NULL);
-	g_slist_free(ret);
+	g_slist_free_full(ret, g_free);
 =

 	return tmp;
 }
-- =

1.9.1

--===============6190701671478889693==--

