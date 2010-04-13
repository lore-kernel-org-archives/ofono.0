Content-Type: multipart/mixed; boundary="===============7473092413166040840=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/8] Refactor netreg watchlist with atom watchlist
Date: Tue, 13 Apr 2010 22:18:13 +0800
Message-ID: <1271168299-4862-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1271168299-4862-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7473092413166040840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   32 +++++++++++---------------------
 1 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/src/network.c b/src/network.c
index b2e5821..c975c7d 100644
--- a/src/network.c
+++ b/src/network.c
@@ -79,7 +79,6 @@ struct ofono_netreg {
 	struct ofono_sim *sim;
 	GKeyFile *settings;
 	char *imsi;
-	struct ofono_watchlist *status_watches;
 	const struct ofono_netreg_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -978,23 +977,15 @@ unsigned int __ofono_netreg_add_status_watch(struct o=
fono_netreg *netreg,
 				ofono_netreg_status_notify_cb_t notify,
 				void *data, ofono_destroy_func destroy)
 {
-	struct ofono_watchlist_item *item;
-
 	DBG("%p", netreg);
 =

 	if (netreg =3D=3D NULL)
 		return 0;
 =

-	if (notify =3D=3D NULL)
-		return 0;
-
-	item =3D g_new0(struct ofono_watchlist_item, 1);
-
-	item->notify =3D notify;
-	item->destroy =3D destroy;
-	item->notify_data =3D data;
-
-	return __ofono_watchlist_add_item(netreg->status_watches, item);
+	return __ofono_atom_add_signal_watch(netreg->atom,
+					OFONO_SIGNAL_TYPE_NETREG_STATUS,
+					(ofono_signal_watch_func) notify,
+					data, destroy);
 }
 =

 gboolean __ofono_netreg_remove_status_watch(struct ofono_netreg *netreg,
@@ -1002,23 +993,27 @@ gboolean __ofono_netreg_remove_status_watch(struct o=
fono_netreg *netreg,
 {
 	DBG("%p", netreg);
 =

-	return __ofono_watchlist_remove_item(netreg->status_watches, id);
+	return __ofono_atom_remove_signal_watch(netreg->atom, id);
 }
 =

 static void notify_status_watches(struct ofono_netreg *netreg)
 {
 	struct ofono_watchlist_item *item;
-	GSList *l;
 	ofono_netreg_status_notify_cb_t notify;
 	const char *mcc =3D NULL;
 	const char *mnc =3D NULL;
+	GSList *status_watches;
+	GSList *l;
 =

 	if (netreg->current_operator) {
 		mcc =3D netreg->current_operator->mcc;
 		mnc =3D netreg->current_operator->mnc;
 	}
 =

-	for (l =3D netreg->status_watches->items; l; l =3D l->next) {
+	status_watches =3D __ofono_atom_get_signal_watches(netreg->atom,
+					OFONO_SIGNAL_TYPE_NETREG_STATUS);
+
+	for (l =3D status_watches; l; l =3D l->next) {
 		item =3D l->data;
 		notify =3D item->notify;
 =

@@ -1620,9 +1615,6 @@ static void netreg_unregister(struct ofono_atom *atom)
 	const char *path =3D __ofono_atom_get_path(atom);
 	GSList *l;
 =

-	__ofono_watchlist_free(netreg->status_watches);
-	netreg->status_watches =3D NULL;
-
 	for (l =3D netreg->operator_list; l; l =3D l->next) {
 		struct network_operator_data *opd =3D l->data;
 =

@@ -1765,8 +1757,6 @@ void ofono_netreg_register(struct ofono_netreg *netre=
g)
 		return;
 	}
 =

-	netreg->status_watches =3D __ofono_watchlist_new(g_free);
-
 	ofono_modem_add_interface(modem, OFONO_NETWORK_REGISTRATION_INTERFACE);
 =

 	if (netreg->driver->registration_status)
-- =

1.6.6.1


--===============7473092413166040840==--

