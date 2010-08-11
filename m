Content-Type: multipart/mixed; boundary="===============6944303035195386916=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 02/16] emulator: Add status watches for ofono emulator
Date: Wed, 11 Aug 2010 10:26:27 +0800
Message-ID: <1281493601-14351-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281493601-14351-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6944303035195386916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The status watches monitor the emulator activities. Other atoms like
gprs, netreg could register notification to watch emulator status
changes.
---
 include/emulator.h |    6 +++++
 src/emulator.c     |   60 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h        |   11 +++++++++
 3 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 1033e59..29e87b9 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -30,6 +30,12 @@ extern "C" {
 =

 struct ofono_emulator;
 =

+enum ofono_emulator_status {
+	OFONO_EMULATOR_STATUS_IDLE =3D 0,
+	OFONO_EMULATOR_STATUS_CREATE,
+	OFONO_EMULATOR_STATUS_DESTROY,
+};
+
 struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
 						enum ofono_atom_type type,
 						GIOChannel *io);
diff --git a/src/emulator.c b/src/emulator.c
index 6219bb1..f9e82a0 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -39,6 +39,8 @@ struct ofono_emulator {
 	enum ofono_atom_type type;
 	unsigned int id;
 	GAtServer *server;
+	enum ofono_emulator_status status;
+	struct ofono_watchlist *status_watches;
 };
 =

 static unsigned int ofono_emulator_ids;
@@ -69,12 +71,31 @@ static void ofono_emulator_release_id(int id)
 	ofono_emulator_ids &=3D ~(0x1 << id);
 }
 =

+static void notify_status_watches(struct ofono_emulator *e, void *data)
+{
+	struct ofono_watchlist_item *item;
+	ofono_emulator_status_notify_cb_t notify;
+	GSList *l;
+
+	for (l =3D e->status_watches->items; l; l =3D l->next) {
+		item =3D l->data;
+		notify =3D item->notify;
+
+		notify(e, e->status, data, item->notify_data);
+	}
+}
+
 static void emulator_remove(struct ofono_atom *atom)
 {
 	struct ofono_emulator *e =3D  __ofono_atom_get_data(atom);
 =

 	DBG("");
 =

+	e->status =3D OFONO_EMULATOR_STATUS_DESTROY;
+	notify_status_watches(e, NULL);
+
+	__ofono_watchlist_free(e->status_watches);
+
 	g_at_server_shutdown(e->server);
 	g_at_server_unref(e->server);
 	e->server =3D NULL;
@@ -84,6 +105,37 @@ static void emulator_remove(struct ofono_atom *atom)
 	e =3D NULL;
 }
 =

+unsigned int __ofono_emulator_add_status_watch(struct ofono_emulator *e,
+				ofono_emulator_status_notify_cb_t notify,
+				void *data, ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *item;
+
+	DBG("%p", e);
+
+	if (e =3D=3D NULL)
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
+	return __ofono_watchlist_add_item(e->status_watches, item);
+}
+
+gboolean __ofono_emulator_remove_status_watch(struct ofono_emulator *e,
+						unsigned int id)
+{
+	DBG("%p", e);
+
+	return __ofono_watchlist_remove_item(e->status_watches, id);
+}
+
 static void emulator_disconnect(gpointer user_data)
 {
 	struct ofono_emulator *e =3D user_data;
@@ -91,6 +143,10 @@ static void emulator_disconnect(gpointer user_data)
 	__ofono_atom_free(e->atom);
 }
 =

+static void emulator_unregister(struct ofono_atom *atom)
+{
+}
+
 struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
 						enum ofono_atom_type type,
 						GIOChannel *channel)
@@ -115,7 +171,11 @@ struct ofono_emulator *ofono_emulator_create(struct of=
ono_modem *modem,
 	e->modem =3D modem;
 	e->type =3D type;
 	e->id =3D ofono_emulator_next_id();
+	e->status_watches =3D __ofono_watchlist_new(g_free);
+	e->status =3D OFONO_EMULATOR_STATUS_CREATE;
 	e->atom =3D __ofono_modem_add_atom(modem, type, emulator_remove, e);
 =

+	__ofono_atom_register(e->atom, emulator_unregister);
+
 	return e;
 }
diff --git a/src/ofono.h b/src/ofono.h
index 8982a95..a7a9849 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -292,3 +292,14 @@ void __ofono_nettime_info_received(struct ofono_modem =
*modem,
 					struct ofono_network_time *info);
 =

 #include <ofono/emulator.h>
+
+typedef void (*ofono_emulator_status_notify_cb_t)(struct ofono_emulator *e,
+					enum ofono_emulator_status status,
+					void *data, void *user_data);
+
+unsigned int __ofono_emulator_add_status_watch(struct ofono_emulator *e,
+				ofono_emulator_status_notify_cb_t notify,
+				void *data, ofono_destroy_func destroy);
+
+gboolean __ofono_emulator_remove_status_watch(struct ofono_emulator *e,
+						unsigned int id);
-- =

1.7.0.4


--===============6944303035195386916==--

