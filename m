Content-Type: multipart/mixed; boundary="===============5387902418615332968=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 03/16] emulator: Add status_watches and notify status
Date: Thu, 13 May 2010 18:02:26 +0800
Message-ID: <1273744959-3711-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5387902418615332968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add watchlist for ofono_emulator to notify the status change when an
emulator create, destroy or other status.
---
 src/emulator.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h    |   21 ++++++++++++++++
 2 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index ef8fe70..f9f7108 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -40,6 +40,7 @@
 struct ofono_emulator {
 	unsigned int emulator_ids;
 	GSList *emulator_list;
+	struct ofono_watchlist *status_watches;
 	struct ofono_atom *atom;
 };
 =

@@ -47,10 +48,12 @@ struct emulator {
 	struct ofono_emulator *oe;
 	unsigned int id;
 	enum ofono_emulator_type type;
+	enum ofono_emulator_status status;
 	GAtServer *server;
 	unsigned int timeout_source;
 };
 =

+static void notify_status_watches(struct emulator *e, void *data);
 static void emulator_dbus_unregister(void *data, void *user_data);
 =

 static unsigned int emulator_next_id(struct ofono_emulator *oe)
@@ -86,6 +89,20 @@ static enum ofono_emulator_type emulator_str_to_type(con=
st char *type)
 	return OFONO_EMULATOR_TYPE_NONE;
 }
 =

+static const char *emulator_type_to_str(enum ofono_emulator_type type)
+{
+	switch (type) {
+	case OFONO_EMULATOR_TYPE_DUN:
+		return "DUN";
+	case OFONO_EMULATOR_TYPE_HFPAG:
+		return "HFP AG";
+	case OFONO_EMULATOR_TYPE_SPP:
+		return "SPP";
+	default:
+		return "";
+	}
+}
+
 static const char *emulator_build_path(const struct ofono_emulator *oe,
 					const struct emulator *e)
 {
@@ -103,6 +120,10 @@ static void emulator_remove(void *data)
 	struct ofono_emulator *oe =3D e->oe;
 	GAtServer *server =3D e->server;
 =

+	e->status =3D OFONO_EMULATOR_STATUS_DESTROY;
+
+	notify_status_watches(e, NULL);
+
 	oe->emulator_list =3D g_slist_remove(oe->emulator_list, e);
 	emulator_release_id(oe, e->id);
 =

@@ -139,9 +160,12 @@ static struct emulator *emulator_create(struct ofono_e=
mulator *oe,
 	e->id =3D emulator_next_id(oe);
 	e->type =3D type;
 	e->server =3D server;
+	e->status =3D OFONO_EMULATOR_STATUS_CREATE;
 =

 	oe->emulator_list =3D g_slist_prepend(oe->emulator_list, e);
 =

+	notify_status_watches(e, NULL);
+
 	g_io_channel_unref(channel);
 =

 	return e;
@@ -284,6 +308,52 @@ static GDBusSignalTable emulator_manager_signals[] =3D=
 {
 	{ "PropertyChanged",	"sv" },
 };
 =

+unsigned int __ofono_emulator_add_status_watch(struct ofono_emulator *oe,
+				ofono_emulator_status_notify_cb_t notify,
+				void *data, ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *item;
+
+	DBG("%p", oe);
+
+	if (oe =3D=3D NULL)
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
+	return __ofono_watchlist_add_item(oe->status_watches, item);
+}
+
+gboolean __ofono_emulator_remove_status_watch(struct ofono_emulator *oe,
+						unsigned int id)
+{
+	DBG("%p", oe);
+
+	return __ofono_watchlist_remove_item(oe->status_watches, id);
+}
+
+static void notify_status_watches(struct emulator *e, void *data)
+{
+	struct ofono_watchlist_item *item;
+	ofono_emulator_status_notify_cb_t notify;
+	struct ofono_emulator *oe =3D e->oe;
+	GSList *l;
+
+	for (l =3D oe->status_watches->items; l; l =3D l->next) {
+		item =3D l->data;
+		notify =3D item->notify;
+
+		notify(e, e->status, data, item->notify_data);
+	}
+}
+
 static void emulator_remove_all(struct ofono_atom *atom)
 {
 	struct ofono_emulator *oe =3D __ofono_atom_get_data(atom);
@@ -299,6 +369,8 @@ static void emulator_remove_all(struct ofono_atom *atom)
 		g_slist_free(oe->emulator_list);
 	}
 =

+	__ofono_watchlist_free(oe->status_watches);
+
 	g_free(oe);
 }
 =

@@ -343,6 +415,7 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem)
 	if (oe =3D=3D NULL)
 		return NULL;
 =

+	oe->status_watches =3D __ofono_watchlist_new(g_free);
 	oe->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_EMULATOR,
 						emulator_remove_all, oe);
 =

diff --git a/src/ofono.h b/src/ofono.h
index 4995830..120238c 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -269,9 +269,30 @@ void __ofono_message_waiting_mwi(struct ofono_message_=
waiting *mw,
 =

 #include <ofono/emulator.h>
 =

+struct emulator;
+
+enum ofono_emulator_status {
+	OFONO_EMULATOR_STATUS_CREATE =3D 0,
+	OFONO_EMULATOR_STATUS_IDLE,
+	OFONO_EMULATOR_STATUS_DIAL_VOICECALL,
+	OFONO_EMULATOR_STATUS_GPRS_CONNECT,
+	OFONO_EMULATOR_STATUS_DESTROY,
+};
+
 enum ofono_emulator_type {
 	OFONO_EMULATOR_TYPE_NONE =3D 0,
 	OFONO_EMULATOR_TYPE_DUN,
 	OFONO_EMULATOR_TYPE_HFPAG,
 	OFONO_EMULATOR_TYPE_SPP,
 };
+
+typedef void (*ofono_emulator_status_notify_cb_t)(struct emulator *e,
+					enum ofono_emulator_status status,
+					void *data, void *user_data);
+
+unsigned int __ofono_emulator_add_status_watch(struct ofono_emulator *emul=
ator,
+				ofono_emulator_status_notify_cb_t notify,
+				void *data, ofono_destroy_func destroy);
+
+gboolean __ofono_emulator_remove_status_watch(struct ofono_emulator *emula=
tor,
+						unsigned int id);
-- =

1.6.3.3


--===============5387902418615332968==--

