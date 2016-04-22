Content-Type: multipart/mixed; boundary="===============0796572632413320134=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 14/24] phonebook: don't rely on undefined behavior when
 casting function pointers
Date: Fri, 22 Apr 2016 13:10:07 +0000
Message-ID: <1461330601-21333-15-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-14-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0796572632413320134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/phonebook.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/src/phonebook.c b/src/phonebook.c
index 531b5a6..07bfcae 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -233,23 +233,28 @@ static void vcard_printf_end(GString *vcards)
 	vcard_printf(vcards, "");
 }
 =

-static void print_number(struct phonebook_number *pn, GString *vcards)
+static void print_number(gpointer pointer, gpointer user_data)
 {
+	struct phonebook_number *pn =3D pointer;
+	GString *vcards =3D user_data;
 	vcard_printf_number(vcards, pn->number, pn->type, pn->category);
 }
 =

-static void destroy_number(struct phonebook_number *pn)
+static void destroy_number(gpointer pointer)
 {
+	struct phonebook_number *pn =3D pointer;
 	g_free(pn->number);
 	g_free(pn);
 }
 =

-static void print_merged_entry(struct phonebook_person *person, GString *v=
cards)
+static void print_merged_entry(gpointer pointer, gpointer user_data)
 {
+	struct phonebook_person *person =3D pointer;
+	GString *vcards =3D user_data;
 	vcard_printf_begin(vcards);
 	vcard_printf_text(vcards, person->text);
 =

-	g_slist_foreach(person->number_list, (GFunc) print_number, vcards);
+	g_slist_foreach(person->number_list, print_number, vcards);
 =

 	vcard_printf_group(vcards, person->group);
 	vcard_printf_email(vcards, person->email);
@@ -257,15 +262,15 @@ static void print_merged_entry(struct phonebook_perso=
n *person, GString *vcards)
 	vcard_printf_end(vcards);
 }
 =

-static void destroy_merged_entry(struct phonebook_person *person)
+static void destroy_merged_entry(gpointer pointer)
 {
+	struct phonebook_person *person =3D pointer;
 	g_free(person->text);
 	g_free(person->group);
 	g_free(person->email);
 	g_free(person->sip_uri);
 =

-	g_slist_foreach(person->number_list, (GFunc) destroy_number, NULL);
-	g_slist_free(person->number_list);
+	g_slist_free_full(person->number_list, destroy_number);
 =

 	g_free(person);
 }
@@ -419,10 +424,9 @@ static void export_phonebook_cb(const struct ofono_err=
or *error, void *data)
 =

 	/* convert the collected entries that are already merged to vcard */
 	phonebook->merge_list =3D g_slist_reverse(phonebook->merge_list);
-	g_slist_foreach(phonebook->merge_list, (GFunc) print_merged_entry,
+	g_slist_foreach(phonebook->merge_list, print_merged_entry,
 				phonebook->vcards);
-	g_slist_foreach(phonebook->merge_list, (GFunc) destroy_merged_entry,
-				NULL);
+	g_slist_free_full(phonebook->merge_list, destroy_merged_entry);
 	g_slist_free(phonebook->merge_list);
 	phonebook->merge_list =3D NULL;
 =

-- =

1.9.1

--===============0796572632413320134==--

