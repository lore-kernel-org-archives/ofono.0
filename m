Content-Type: multipart/mixed; boundary="===============9145853168602610307=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 22/24] ussd: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:07 +0000
Message-ID: <1461330601-21333-23-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-22-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9145853168602610307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/ussd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/ussd.c b/src/ussd.c
index bc8e0f6..99fa753 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -102,8 +102,10 @@ static struct ssc_entry *ssc_entry_create(const char *=
sc, void *cb, void *data,
 	return r;
 }
 =

-static void ssc_entry_destroy(struct ssc_entry *ca)
+static void ssc_entry_destroy(gpointer pointer)
 {
+	struct ssc_entry *ca =3D pointer;
+
 	if (ca->destroy)
 		ca->destroy(ca->user);
 =

@@ -790,12 +792,10 @@ static void ussd_unregister(struct ofono_atom *atom)
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 	const char *path =3D __ofono_atom_get_path(atom);
 =

-	g_slist_foreach(ussd->ss_control_list, (GFunc) ssc_entry_destroy, NULL);
-	g_slist_free(ussd->ss_control_list);
+	g_slist_free_full(ussd->ss_control_list, ssc_entry_destroy);
 	ussd->ss_control_list =3D NULL;
 =

-	g_slist_foreach(ussd->ss_passwd_list, (GFunc) ssc_entry_destroy, NULL);
-	g_slist_free(ussd->ss_passwd_list);
+	g_slist_free_full(ussd->ss_passwd_list, ssc_entry_destroy);
 	ussd->ss_passwd_list =3D NULL;
 =

 	ofono_modem_remove_interface(modem,
-- =

1.9.1

--===============9145853168602610307==--

