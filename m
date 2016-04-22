Content-Type: multipart/mixed; boundary="===============8271116714745712534=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 09/24] cbs: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:06 +0000
Message-ID: <1461330601-21333-10-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-9-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8271116714745712534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/cbs.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/src/cbs.c b/src/cbs.c
index fdc44a1..8e3296b 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -272,8 +272,7 @@ void ofono_cbs_notify(struct ofono_cbs *cbs, const unsi=
gned char *pdu,
 =

 out:
 	g_free(message);
-	g_slist_foreach(cbs_list, (GFunc)g_free, NULL);
-	g_slist_free(cbs_list);
+	g_slist_free_full(cbs_list, g_free);
 }
 =

 static DBusMessage *cbs_get_properties(DBusConnection *conn,
@@ -337,8 +336,7 @@ static void cbs_set_topics_cb(const struct ofono_error =
*error, void *data)
 	char *topics;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		g_slist_foreach(cbs->new_topics, (GFunc)g_free, NULL);
-		g_slist_free(cbs->new_topics);
+		g_slist_free_full(cbs->new_topics, g_free);
 		cbs->new_topics =3D NULL;
 =

 		DBG("Setting Cell Broadcast topics failed");
@@ -347,8 +345,7 @@ static void cbs_set_topics_cb(const struct ofono_error =
*error, void *data)
 		return;
 	}
 =

-	g_slist_foreach(cbs->topics, (GFunc)g_free, NULL);
-	g_slist_free(cbs->topics);
+	g_slist_free_full(cbs->topics, g_free);
 	cbs->topics =3D cbs->new_topics;
 	cbs->new_topics =3D NULL;
 =

@@ -590,21 +587,18 @@ static void cbs_unregister(struct ofono_atom *atom)
 	ofono_modem_remove_interface(modem, OFONO_CELL_BROADCAST_INTERFACE);
 =

 	if (cbs->topics) {
-		g_slist_foreach(cbs->topics, (GFunc) g_free, NULL);
-		g_slist_free(cbs->topics);
+		g_slist_free_full(cbs->topics, g_free);
 		cbs->topics =3D NULL;
 	}
 =

 	if (cbs->new_topics) {
-		g_slist_foreach(cbs->new_topics, (GFunc) g_free, NULL);
-		g_slist_free(cbs->new_topics);
+		g_slist_free_full(cbs->new_topics, g_free);
 		cbs->new_topics =3D NULL;
 	}
 =

 	if (cbs->efcbmid_length) {
 		cbs->efcbmid_length =3D 0;
-		g_slist_foreach(cbs->efcbmid_contents, (GFunc) g_free, NULL);
-		g_slist_free(cbs->efcbmid_contents);
+		g_slist_free_full(cbs->efcbmid_contents, g_free);
 		cbs->efcbmid_contents =3D NULL;
 	}
 =

@@ -729,15 +723,13 @@ static void cbs_got_file_contents(struct ofono_cbs *c=
bs)
 =

 	if (cbs->efcbmi_length) {
 		cbs->efcbmi_length =3D 0;
-		g_slist_foreach(cbs->efcbmi_contents, (GFunc) g_free, NULL);
-		g_slist_free(cbs->efcbmi_contents);
+		g_slist_free_full(cbs->efcbmi_contents, g_free);
 		cbs->efcbmi_contents =3D NULL;
 	}
 =

 	if (cbs->efcbmir_length) {
 		cbs->efcbmir_length =3D 0;
-		g_slist_foreach(cbs->efcbmir_contents, (GFunc) g_free, NULL);
-		g_slist_free(cbs->efcbmir_contents);
+		g_slist_free_full(cbs->efcbmir_contents, g_free);
 		cbs->efcbmir_contents =3D NULL;
 	}
 =

@@ -907,8 +899,7 @@ static void cbs_efcbmid_changed(int id, void *userdata)
 =

 	if (cbs->efcbmid_length) {
 		cbs->efcbmid_length =3D 0;
-		g_slist_foreach(cbs->efcbmid_contents, (GFunc) g_free, NULL);
-		g_slist_free(cbs->efcbmid_contents);
+		g_slist_free_full(cbs->efcbmid_contents, g_free);
 		cbs->efcbmid_contents =3D NULL;
 	}
 =

-- =

1.9.1

--===============8271116714745712534==--

