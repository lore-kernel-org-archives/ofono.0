Content-Type: multipart/mixed; boundary="===============2789112509906970901=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 1/3] core: notify watches of already registered atoms
Date: Tue, 29 Mar 2011 10:48:28 +0300
Message-ID: <1301384910-28272-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1301384910-28272-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2789112509906970901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 655994b..d22c718 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -271,6 +271,9 @@ unsigned int __ofono_modem_add_atom_watch(struct ofono_=
modem *modem,
 					void *data, ofono_destroy_func destroy)
 {
 	struct atom_watch *watch;
+	unsigned int id;
+	GSList *l;
+	struct ofono_atom *atom;
 =

 	if (notify =3D=3D NULL)
 		return 0;
@@ -282,8 +285,19 @@ unsigned int __ofono_modem_add_atom_watch(struct ofono=
_modem *modem,
 	watch->item.destroy =3D destroy;
 	watch->item.notify_data =3D data;
 =

-	return __ofono_watchlist_add_item(modem->atom_watches,
+	id =3D __ofono_watchlist_add_item(modem->atom_watches,
 					(struct ofono_watchlist_item *)watch);
+
+	for (l =3D modem->atoms; l; l =3D l->next) {
+		atom =3D l->data;
+
+		if (atom->type !=3D type || atom->unregister =3D=3D NULL)
+			continue;
+
+		notify(atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, data);
+	}
+
+	return id;
 }
 =

 gboolean __ofono_modem_remove_atom_watch(struct ofono_modem *modem,
-- =

1.7.1


--===============2789112509906970901==--

