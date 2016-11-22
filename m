Content-Type: multipart/mixed; boundary="===============4239195348654291439=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH] lte: fix early imsi free
Date: Tue, 22 Nov 2016 14:00:14 +0100
Message-ID: <1479819614-25999-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4239195348654291439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

storage_close was creating an empty sync file in /var/lib/ofono/lte
when it should have been closing the proper file
/var/lig/ofono/<imsi>/lte.

---
 src/lte.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/lte.c b/src/lte.c
index 82da868..518103a 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -259,9 +259,6 @@ static void lte_atom_remove(struct ofono_atom *atom)
 	if (lte =3D=3D NULL)
 		return;
 =

-	g_free(lte->imsi);
-	lte->imsi =3D NULL;
-
 	if (lte->settings) {
 		storage_close(lte->imsi, SETTINGS_STORE, lte->settings, TRUE);
 		lte->settings =3D NULL;
@@ -270,6 +267,9 @@ static void lte_atom_remove(struct ofono_atom *atom)
 	if (lte->driver && lte->driver->remove)
 		lte->driver->remove(lte);
 =

+	g_free(lte->imsi);
+	lte->imsi =3D NULL;
+
 	g_free(lte);
 }
 =

-- =

2.7.4


--===============4239195348654291439==--

