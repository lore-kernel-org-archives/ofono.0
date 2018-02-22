Content-Type: multipart/mixed; boundary="===============6094965956053175492=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] phonebook: Fixed double deletion of merge_list
Date: Thu, 22 Feb 2018 17:18:54 +0200
Message-ID: <1519312734-32262-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6094965956053175492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/phonebook.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/phonebook.c b/src/phonebook.c
index 1e4efa2..f8936c5 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -428,7 +428,6 @@ static void export_phonebook_cb(const struct ofono_erro=
r *error, void *data)
 	g_slist_foreach(phonebook->merge_list, print_merged_entry,
 				phonebook->vcards);
 	g_slist_free_full(phonebook->merge_list, destroy_merged_entry);
-	g_slist_free(phonebook->merge_list);
 	phonebook->merge_list =3D NULL;
 =

 	phonebook->storage_index++;
-- =

1.9.1


--===============6094965956053175492==--

