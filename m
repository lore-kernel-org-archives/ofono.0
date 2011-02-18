Content-Type: multipart/mixed; boundary="===============8377047742633850917=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 3/4] netreg: add support for signal strength get and watch APIs
Date: Fri, 18 Feb 2011 17:34:07 +0100
Message-ID: <1298046848-24622-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1298046848-24622-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8377047742633850917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h   |   10 +++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/src/network.c b/src/network.c
index c059906..4a0e984 100644
--- a/src/network.c
+++ b/src/network.c
@@ -79,6 +79,7 @@ struct ofono_netreg {
 	GKeyFile *settings;
 	char *imsi;
 	struct ofono_watchlist *status_watches;
+	struct ofono_watchlist *strength_watches;
 	const struct ofono_netreg_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -1159,6 +1160,51 @@ static void notify_status_watches(struct ofono_netre=
g *netreg)
 	}
 }
 =

+unsigned int __ofono_netreg_add_strength_watch(struct ofono_netreg *netreg,
+				ofono_netreg_strength_notify_cb_t notify,
+				void *data, ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *item;
+
+	DBG("%p", netreg);
+
+	if (netreg =3D=3D NULL)
+		return 0;
+
+	if (notify =3D=3D NULL)
+		return 0;
+
+	item =3D g_new0(struct ofono_watchlist_item, 1);
+
+	item->notify =3D notify;
+	item->destroy =3D destroy;
+	item->notify_data =3D data;
+
+	return __ofono_watchlist_add_item(netreg->strength_watches, item);
+}
+
+gboolean __ofono_netreg_remove_strength_watch(struct ofono_netreg *netreg,
+						unsigned int id)
+{
+	DBG("%p", netreg);
+
+	return __ofono_watchlist_remove_item(netreg->strength_watches, id);
+}
+
+static void notify_strength_watches(struct ofono_netreg *netreg)
+{
+	struct ofono_watchlist_item *item;
+	GSList *l;
+	ofono_netreg_strength_notify_cb_t notify;
+
+	for (l =3D netreg->strength_watches->items; l; l =3D l->next) {
+		item =3D l->data;
+		notify =3D item->notify;
+
+		notify(netreg->signal_strength, item->notify_data);
+	}
+}
+
 static void reset_available(struct network_operator_data *old,
 				const struct ofono_network_operator *new)
 {
@@ -1400,6 +1446,8 @@ void ofono_netreg_strength_notify(struct ofono_netreg=
 *netreg, int strength)
 					OFONO_NETWORK_REGISTRATION_INTERFACE,
 					"Strength", DBUS_TYPE_BYTE,
 					&strength);
+
+		notify_strength_watches(netreg);
 	}
 }
 =

@@ -1599,6 +1647,14 @@ int ofono_netreg_get_status(struct ofono_netreg *net=
reg)
 	return netreg->status;
 }
 =

+int ofono_netreg_get_strength(struct ofono_netreg *netreg)
+{
+	if (netreg =3D=3D NULL)
+		return -1;
+
+	return netreg->signal_strength;
+}
+
 int ofono_netreg_get_technology(struct ofono_netreg *netreg)
 {
 	if (netreg =3D=3D NULL)
@@ -1659,6 +1715,9 @@ static void netreg_unregister(struct ofono_atom *atom)
 	__ofono_watchlist_free(netreg->status_watches);
 	netreg->status_watches =3D NULL;
 =

+	__ofono_watchlist_free(netreg->strength_watches);
+	netreg->strength_watches =3D NULL;
+
 	for (l =3D netreg->operator_list; l; l =3D l->next) {
 		struct network_operator_data *opd =3D l->data;
 =

@@ -1857,6 +1916,8 @@ void ofono_netreg_register(struct ofono_netreg *netre=
g)
 =

 	netreg->status_watches =3D __ofono_watchlist_new(g_free);
 =

+	netreg->strength_watches =3D __ofono_watchlist_new(g_free);
+
 	ofono_modem_add_interface(modem, OFONO_NETWORK_REGISTRATION_INTERFACE);
 =

 	if (netreg->driver->registration_status !=3D NULL)
diff --git a/src/ofono.h b/src/ofono.h
index 14dcd18..f82f447 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -404,6 +404,16 @@ unsigned int __ofono_netreg_add_status_watch(struct of=
ono_netreg *netreg,
 gboolean __ofono_netreg_remove_status_watch(struct ofono_netreg *netreg,
 						unsigned int id);
 =

+typedef void (*ofono_netreg_strength_notify_cb_t)(int signal_strength,
+							void *data);
+
+unsigned int __ofono_netreg_add_strength_watch(struct ofono_netreg *netreg,
+				ofono_netreg_strength_notify_cb_t cb,
+				void *data, ofono_destroy_func destroy);
+
+gboolean __ofono_netreg_remove_strength_watch(struct ofono_netreg *netreg,
+						unsigned int id);
+
 void __ofono_netreg_set_base_station_name(struct ofono_netreg *netreg,
 						const char *name);
 =

-- =

1.7.1


--===============8377047742633850917==--

