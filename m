Content-Type: multipart/mixed; boundary="===============8871608371955368218=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] modem:Add powered watches on modem.
Date: Mon, 31 Jan 2011 11:01:48 +0100
Message-ID: <1296468108-8347-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8871608371955368218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 src/ofono.h |    7 +++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 8e243d8..4e026cf 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -77,6 +77,7 @@ struct ofono_modem {
 	guint			timeout;
 	ofono_bool_t		online;
 	struct ofono_watchlist	*online_watches;
+	struct ofono_watchlist	*powered_watches;
 	GHashTable		*properties;
 	struct ofono_sim	*sim;
 	unsigned int		sim_watch;
@@ -383,6 +384,22 @@ static void notify_online_watches(struct ofono_modem *=
modem)
 	}
 }
 =

+static void notify_powered_watches(struct ofono_modem *modem)
+{
+	struct ofono_watchlist_item *item;
+	GSList *l;
+	ofono_modem_powered_notify_func notify;
+
+	if (modem->powered_watches =3D=3D NULL)
+		return;
+
+	for (l =3D modem->powered_watches->items; l; l =3D l->next) {
+		item =3D l->data;
+		notify =3D item->notify;
+		notify(modem->powered, item->notify_data);
+	}
+}
+
 static void modem_change_state(struct ofono_modem *modem,
 				enum modem_state new_state)
 {
@@ -462,6 +479,30 @@ void __ofono_modem_remove_online_watch(struct ofono_mo=
dem *modem,
 	__ofono_watchlist_remove_item(modem->online_watches, id);
 }
 =

+unsigned int __ofono_modem_add_powered_watch(struct ofono_modem *modem,
+					ofono_modem_powered_notify_func notify,
+					void *data, ofono_destroy_func destroy)
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
+	return __ofono_watchlist_add_item(modem->powered_watches, item);
+}
+
+void __ofono_modem_remove_powered_watch(struct ofono_modem *modem,
+					unsigned int id)
+{
+	__ofono_watchlist_remove_item(modem->powered_watches, id);
+}
+
 static void common_online_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_modem *modem =3D data;
@@ -723,6 +764,8 @@ static int set_powered(struct ofono_modem *modem, ofono=
_bool_t powered)
 	else if (err !=3D -EINPROGRESS)
 		modem->powered_pending =3D modem->powered;
 =

+	notify_powered_watches(modem);
+
 	return err;
 }
 =

@@ -1699,6 +1742,7 @@ int ofono_modem_register(struct ofono_modem *modem)
 =

 	modem->atom_watches =3D __ofono_watchlist_new(g_free);
 	modem->online_watches =3D __ofono_watchlist_new(g_free);
+	modem->powered_watches =3D __ofono_watchlist_new(g_free);
 =

 	emit_modem_added(modem);
 	call_modemwatches(modem, TRUE);
@@ -1732,6 +1776,9 @@ static void modem_unregister(struct ofono_modem *mode=
m)
 =

 	__ofono_watchlist_free(modem->online_watches);
 	modem->online_watches =3D NULL;
+	=

+	__ofono_watchlist_free(modem->powered_watches);
+	modem->powered_watches =3D NULL;
 =

 	modem->sim_watch =3D 0;
 	modem->sim_ready_watch =3D 0;
diff --git a/src/ofono.h b/src/ofono.h
index 6ba0187..82d857f 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -188,6 +188,13 @@ unsigned int __ofono_modem_add_online_watch(struct ofo=
no_modem *modem,
 void __ofono_modem_remove_online_watch(struct ofono_modem *modem,
 					unsigned int id);
 =

+typedef void (*ofono_modem_powered_notify_func)(ofono_bool_t powered, void=
 *data);
+unsigned int __ofono_modem_add_powered_watch(struct ofono_modem *modem,
+					ofono_modem_online_notify_func notify,
+					void *data, ofono_destroy_func destroy);
+void __ofono_modem_remove_powered_watch(struct ofono_modem *modem,
+					unsigned int id);
+
 #include <ofono/call-barring.h>
 =

 gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb);
-- =

1.7.1


--===============8871608371955368218==--

