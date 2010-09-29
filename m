Content-Type: multipart/mixed; boundary="===============5641096861363874848=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 07/21] emulator: Add status watches for ofono emulator
Date: Wed, 29 Sep 2010 17:44:47 +0800
Message-ID: <1285753501-7668-8-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1285753501-7668-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5641096861363874848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The status watches monitor the emulator activities. Other atoms like
gprs, netreg could register notification to watch emulator status
changes.
---
 include/emulator.h |    6 +++++
 src/emulator.c     |   54 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h        |   11 ++++++++++
 3 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 2691928..99ae218 100644
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
 struct ofono_emulator_driver {
 	const char *name;
 	enum ofono_atom_type type;
diff --git a/src/emulator.c b/src/emulator.c
index 1ede79a..c68dbf8 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -39,6 +39,8 @@ struct ofono_emulator {
 	unsigned int id;
 	GAtServer *server;
 	struct ofono_emulator_driver *driver;
+	enum ofono_emulator_status status;
+	struct ofono_watchlist *status_watches;
 };
 =

 static GSList *emulator_drivers =3D NULL;
@@ -80,6 +82,20 @@ static void ofono_emulator_release_id(int id)
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
 int ofono_emulator_enable(struct ofono_emulator *e, GIOChannel *channel)
 {
 	if (channel =3D=3D NULL)
@@ -116,6 +132,11 @@ static void emulator_remove(struct ofono_atom *atom)
 	if (e->server)
 		emulator_disable(e);
 =

+	e->status =3D OFONO_EMULATOR_STATUS_DESTROY;
+	notify_status_watches(e, NULL);
+
+	__ofono_watchlist_free(e->status_watches);
+
 	ofono_emulator_release_id(e->id);
 =

 	if (e->driver->remove)
@@ -125,6 +146,37 @@ static void emulator_remove(struct ofono_atom *atom)
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
 struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
 					struct ofono_emulator_driver *driver)
 {
@@ -148,6 +200,8 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem,
 	}
 =

 	e->id =3D ofono_emulator_next_id();
+	e->status_watches =3D __ofono_watchlist_new(g_free);
+	e->status =3D OFONO_EMULATOR_STATUS_CREATE;
 =

 	return e;
 }
diff --git a/src/ofono.h b/src/ofono.h
index 29cfe57..4cc03f9 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -339,3 +339,14 @@ void __ofono_nettime_info_received(struct ofono_modem =
*modem,
 #include <ofono/emulator.h>
 =

 void __ofono_emulator_probe_drivers(struct ofono_modem *modem);
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


--===============5641096861363874848==--

