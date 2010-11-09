Content-Type: multipart/mixed; boundary="===============2172230686971830616=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 1/3] modem: add modem online-offline watch
Date: Tue, 09 Nov 2010 10:59:36 +0200
Message-ID: <cb6fb563f8142ff4f4790d043d860a98f3bc2929.1289226246.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1289226246.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2172230686971830616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Andras Domokos <Andras.Domokos@nokia.com>
---
 src/modem.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 src/ofono.h |    8 ++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 3776461..f73cc1d 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -72,6 +72,7 @@ struct ofono_modem {
 	ofono_bool_t		powered_pending;
 	guint			timeout;
 	ofono_bool_t		online;
+	struct ofono_watchlist	*online_watches;
 	GHashTable		*properties;
 	struct ofono_sim	*sim;
 	unsigned int		sim_watch;
@@ -362,6 +363,22 @@ static void flush_atoms(struct ofono_modem *modem, enu=
m modem_state new_state)
 	}
 }
 =

+static void notify_online_watches(struct ofono_modem *modem)
+{
+	struct ofono_watchlist_item *item;
+	GSList *l;
+	ofono_modem_online_notify_func notify;
+
+	if (modem->online_watches =3D=3D NULL)
+		return;
+
+	for (l =3D modem->online_watches->items; l; l =3D l->next) {
+		item =3D l->data;
+		notify =3D item->notify;
+		notify(modem->online, item->notify_data);
+	}
+}
+
 static void modem_change_state(struct ofono_modem *modem,
 				enum modem_state new_state)
 {
@@ -404,11 +421,13 @@ static void modem_change_state(struct ofono_modem *mo=
dem,
 			__ofono_history_probe_drivers(modem);
 			__ofono_nettime_probe_drivers(modem);
 		}
+		notify_online_watches(modem);
 		break;
 =

 	case MODEM_STATE_ONLINE:
 		if (driver->post_online)
 			driver->post_online(modem);
+		notify_online_watches(modem);
 		break;
 	}
 }
@@ -437,6 +456,29 @@ static void sim_state_watch(enum ofono_sim_state new_s=
tate, void *user)
 	}
 }
 =

+unsigned __ofono_modem_add_online_watch(struct ofono_modem *modem,
+		ofono_modem_online_notify_func notify,
+		void *data, ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *item;
+
+	if (modem =3D=3D NULL || notify =3D=3D NULL)
+		return 0;
+
+	item =3D g_new0(struct ofono_watchlist_item, 1);
+
+	item->notify =3D notify;
+	item->destroy =3D destroy;
+	item->notify_data =3D data;
+
+	return __ofono_watchlist_add_item(modem->online_watches, item);
+}
+
+void __ofono_modem_remove_online_watch(struct ofono_modem *modem, unsigned=
 id)
+{
+	__ofono_watchlist_remove_item(modem->online_watches, id);
+}
+
 static void online_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_modem *modem =3D data;
@@ -1472,6 +1514,7 @@ int ofono_modem_register(struct ofono_modem *modem)
 	modem->driver_type =3D NULL;
 =

 	modem->atom_watches =3D __ofono_watchlist_new(g_free);
+	modem->online_watches =3D __ofono_watchlist_new(g_free);
 =

 	emit_modem_added(modem);
 	call_modemwatches(modem, TRUE);
@@ -1503,6 +1546,9 @@ static void modem_unregister(struct ofono_modem *mode=
m)
 	__ofono_watchlist_free(modem->atom_watches);
 	modem->atom_watches =3D NULL;
 =

+	__ofono_watchlist_free(modem->online_watches);
+	modem->online_watches =3D NULL;
+
 	modem->sim_watch =3D 0;
 	modem->sim_ready_watch =3D 0;
 =

diff --git a/src/ofono.h b/src/ofono.h
index ab6ecd2..35335b6 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -177,6 +177,14 @@ unsigned int __ofono_modemwatch_add(ofono_modemwatch_c=
b_t cb, void *user,
 					ofono_destroy_func destroy);
 gboolean __ofono_modemwatch_remove(unsigned int id);
 =

+typedef void (*ofono_modem_online_notify_func)(ofono_bool_t state,
+		void *data);
+unsigned int __ofono_modem_add_online_watch(struct ofono_modem *modem,
+		ofono_modem_online_notify_func notify,
+		void *data, ofono_destroy_func destroy);
+void __ofono_modem_remove_online_watch(struct ofono_modem *modem,
+		unsigned int id);
+
 #include <ofono/call-barring.h>
 =

 gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb);
-- =

1.7.0.4


--===============2172230686971830616==--

