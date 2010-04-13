Content-Type: multipart/mixed; boundary="===============0661100400621827564=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/8] Add signal watches for atom
Date: Tue, 13 Apr 2010 22:18:12 +0800
Message-ID: <1271168299-4862-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1271168299-4862-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0661100400621827564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It replaces watch lists dispersed in each component. So that each
component like Voicecall, SMS can be watched in unique way.
---
 src/modem.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ofono.h |   19 +++++++++++++++++++
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index b935328..47ac172 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -86,6 +86,7 @@ struct ofono_atom {
 	void (*unregister)(struct ofono_atom *atom);
 	void *data;
 	struct ofono_modem *modem;
+	struct ofono_watchlist *signal_watches;
 };
 =

 struct ofono_atom_watch {
@@ -93,6 +94,11 @@ struct ofono_atom_watch {
 	enum ofono_atom_type type;
 };
 =

+struct ofono_signal_watch {
+	struct ofono_watchlist_item item;
+	enum ofono_signal_type type;
+};
+
 struct ofono_property {
 	enum ofono_property_type type;
 	void *value;
@@ -211,6 +217,8 @@ void __ofono_atom_register(struct ofono_atom *atom,
 =

 	atom->unregister =3D unregister;
 =

+	atom->signal_watches =3D __ofono_watchlist_new(g_free);
+
 	call_watches(atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED);
 }
 =

@@ -221,6 +229,9 @@ void __ofono_atom_unregister(struct ofono_atom *atom)
 =

 	call_watches(atom, OFONO_ATOM_WATCH_CONDITION_UNREGISTERED);
 =

+	__ofono_watchlist_free(atom->signal_watches);
+	atom->signal_watches =3D NULL;
+
 	atom->unregister(atom);
 }
 =

@@ -229,6 +240,50 @@ gboolean __ofono_atom_get_registered(struct ofono_atom=
 *atom)
 	return atom->unregister ? TRUE : FALSE;
 }
 =

+GSList *__ofono_atom_get_signal_watches(struct ofono_atom *atom,
+					enum ofono_signal_type type)
+{
+	struct ofono_signal_watch *item;
+	GSList *watches =3D NULL;
+	GSList *l;
+
+	for (l =3D atom->signal_watches->items; l; l =3D l->next) {
+		item =3D l->data;
+
+		if (item->type =3D=3D type)
+			watches =3D g_slist_prepend(watches, &item->item);
+	}
+
+	return watches;
+}
+
+unsigned int __ofono_atom_add_signal_watch(struct ofono_atom *atom,
+					enum ofono_signal_type type,
+					ofono_signal_watch_func notify,
+					void *data, ofono_destroy_func destroy)
+{
+	struct ofono_signal_watch *watch;
+
+	if (notify =3D=3D NULL)
+		return 0;
+
+	watch =3D g_new0(struct ofono_signal_watch, 1);
+
+	watch->type =3D type;
+	watch->item.notify =3D notify;
+	watch->item.destroy =3D destroy;
+	watch->item.notify_data =3D data;
+
+	return __ofono_watchlist_add_item(atom->signal_watches,
+					(struct ofono_watchlist_item *) watch);
+}
+
+gboolean __ofono_atom_remove_signal_watch(struct ofono_atom *atom,
+						unsigned int id)
+{
+	return __ofono_watchlist_remove_item(atom->signal_watches, id);
+}
+
 unsigned int __ofono_modem_add_atom_watch(struct ofono_modem *modem,
 					enum ofono_atom_type type,
 					ofono_atom_watch_func notify,
diff --git a/src/ofono.h b/src/ofono.h
index ff67728..115ad6b 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -121,12 +121,20 @@ enum ofono_atom_watch_condition {
 	OFONO_ATOM_WATCH_CONDITION_UNREGISTERED
 };
 =

+enum ofono_signal_type {
+	OFONO_SIGNAL_TYPE_NETREG_STATUS =3D 0,
+	OFONO_SIGNAL_TYPE_SIM_READY =3D 1,
+};
+
 typedef void (*ofono_atom_watch_func)(struct ofono_atom *atom,
 					enum ofono_atom_watch_condition cond,
 					void *data);
 =

 typedef void (*ofono_atom_func)(struct ofono_atom *atom, void *data);
 =

+typedef void (*ofono_signal_watch_func)(struct ofono_atom *atom,
+					void *data);
+
 struct ofono_atom *__ofono_modem_add_atom(struct ofono_modem *modem,
 					enum ofono_atom_type type,
 					void (*destruct)(struct ofono_atom *),
@@ -149,6 +157,17 @@ void __ofono_atom_unregister(struct ofono_atom *atom);
 =

 gboolean __ofono_atom_get_registered(struct ofono_atom *atom);
 =

+GSList *__ofono_atom_get_signal_watches(struct ofono_atom *atom,
+					enum ofono_signal_type type);
+
+unsigned int __ofono_atom_add_signal_watch(struct ofono_atom *atom,
+					enum ofono_signal_type type,
+					ofono_signal_watch_func notify,
+					void *data, ofono_destroy_func destroy);
+
+gboolean __ofono_atom_remove_signal_watch(struct ofono_atom *atom,
+						unsigned int id);
+
 unsigned int __ofono_modem_add_atom_watch(struct ofono_modem *modem,
 					enum ofono_atom_type type,
 					ofono_atom_watch_func notify,
-- =

1.6.6.1


--===============0661100400621827564==--

