Content-Type: multipart/mixed; boundary="===============0470700523356426907=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 12/15] emulator: Watch GPRS status changes
Date: Wed, 07 Jul 2010 18:01:49 +0800
Message-ID: <1278496912-13777-13-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278496912-13777-12-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0470700523356426907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Watch GPRS status changes to notify DUN client any unsolicited result,
like +CGREG status changes.
---
 include/gprs.h |   11 +++++++
 src/emulator.c |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/gprs.c     |   64 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+), 0 deletions(-)

diff --git a/include/gprs.h b/include/gprs.h
index a1cbcd9..ca23c45 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -36,6 +36,8 @@ typedef void (*ofono_gprs_status_cb_t)(const struct ofono=
_error *error,
 =

 typedef void (*ofono_gprs_cb_t)(const struct ofono_error *error, void *dat=
a);
 =

+typedef void (*ofono_gprs_status_notify_cb_t)(const int status, void *data=
);
+
 struct ofono_gprs_driver {
 	const char *name;
 	int (*probe)(struct ofono_gprs *gprs, unsigned int vendor,
@@ -67,6 +69,15 @@ void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
 void ofono_gprs_add_context(struct ofono_gprs *gprs,
 				struct ofono_gprs_context *gc);
 =

+unsigned int __ofono_gprs_add_status_watch(struct ofono_gprs *gprs,
+				ofono_gprs_status_notify_cb_t cb,
+				void *data, ofono_destroy_func destroy);
+
+gboolean __ofono_gprs_remove_status_watch(struct ofono_gprs *gprs,
+						unsigned int id);
+
+int ofono_gprs_get_status(struct ofono_gprs *gprs);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/emulator.c b/src/emulator.c
index 546a48b..3bb32ae 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -68,6 +68,10 @@ struct ofono_emulator {
 	int netreg_lac;
 	int netreg_ci;
 	int gprs_status;
+
+	struct ofono_gprs *gprs;
+	unsigned int gprs_watch;
+	unsigned int gprs_status_watch;
 };
 =

 static GSList *emulator_list;
@@ -767,6 +771,18 @@ static void emulator_remove(struct ofono_atom *atom)
 	if (e->driver->remove)
 		e->driver->remove(e);
 =

+	if (e->gprs_watch) {
+		if (e->gprs_status_watch) {
+			__ofono_gprs_remove_status_watch(e->gprs,
+						e->gprs_status_watch);
+			e->gprs_status_watch =3D 0;
+		}
+
+		__ofono_modem_remove_atom_watch(e->modem, e->gprs_watch);
+		e->gprs_watch =3D 0;
+		e->gprs =3D NULL;
+	}
+
 	__ofono_watchlist_free(e->status_watches);
 	ofono_emulator_release_id(e->id);
 	g_free(e);
@@ -794,6 +810,76 @@ void ofono_emulator_disable(struct ofono_emulator *e)
 	e->powered =3D FALSE;
 }
 =

+static void emulator_gprs_update(struct ofono_emulator *e)
+{
+	GAtServer *server =3D e->server;
+	char buf[256];
+
+	switch (e->modem_cgreg) {
+	case 0:
+		break;
+	case 1:
+		snprintf(buf, sizeof(buf), "+CGREG: %d", e->gprs_status);
+		g_at_server_send_unsolicited(server, buf);
+		break;
+	case 2:
+		snprintf(buf, sizeof(buf), "+CGREG: %d", e->gprs_status);
+		g_at_server_send_unsolicited(server, buf);
+		break;
+	default:
+		break;
+	}
+}
+
+static void gprs_status_changed(int status, void *data)
+{
+	struct ofono_emulator *e =3D data;
+
+	DBG("%d", status);
+
+	e->gprs_status =3D status;
+
+	emulator_gprs_update(e);
+}
+
+static void gprs_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_emulator *e =3D data;
+	struct ofono_gprs *gprs;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		e->gprs_status_watch =3D 0;
+		e->gprs =3D NULL;
+		return;
+	}
+
+	gprs =3D __ofono_atom_get_data(atom);
+	e->gprs =3D gprs;
+	e->gprs_status =3D ofono_gprs_get_status(gprs);
+	e->gprs_status_watch =3D __ofono_gprs_add_status_watch(e->gprs,
+					gprs_status_changed, e, NULL);
+
+	emulator_gprs_update(e);
+}
+
+static void add_gprs_watches(struct ofono_emulator *e)
+{
+	struct ofono_modem *modem =3D e->modem;
+	struct ofono_atom *gprs_atom;
+
+	e->gprs_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_GPRS,
+					gprs_watch, e, NULL);
+
+	gprs_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_GPRS);
+
+	if (gprs_atom && __ofono_atom_get_registered(gprs_atom))
+		gprs_watch(gprs_atom,
+				OFONO_ATOM_WATCH_CONDITION_REGISTERED, e);
+}
+
 static int set_powered(struct ofono_emulator *e, ofono_bool_t powered, int=
 fd)
 {
 	int val;
@@ -843,6 +929,8 @@ ofono_bool_t ofono_emulator_enable(struct ofono_emulato=
r *e, int fd)
 	g_at_server_register(e->server, "+CGATT", cgatt_cb, e, NULL);
 	g_at_server_register(e->server, "+CGDCONT", cgdcont_cb, e, NULL);
 =

+	add_gprs_watches(e);
+
 	g_io_channel_unref(channel);
 =

 	e->powered =3D TRUE;
diff --git a/src/gprs.c b/src/gprs.c
index cb83e23..3ed056a 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -142,6 +142,8 @@ static const char *gprs_context_type_to_string(int type)
 		return "mms";
 	case GPRS_CONTEXT_TYPE_WAP:
 		return "wap";
+	case GPRS_CONTEXT_TYPE_DUN:
+		return "dun";
 	}
 =

 	return NULL;
@@ -155,6 +157,8 @@ static enum gprs_context_type gprs_context_string_to_ty=
pe(const char *str)
 		return GPRS_CONTEXT_TYPE_WAP;
 	else if (g_str_equal(str, "mms"))
 		return GPRS_CONTEXT_TYPE_MMS;
+	else if (g_str_equal(str, "dun"))
+		return GPRS_CONTEXT_TYPE_DUN;
 =

 	return GPRS_CONTEXT_TYPE_INVALID;
 }
@@ -1467,6 +1471,51 @@ static GDBusSignalTable manager_signals[] =3D {
 	{ }
 };
 =

+unsigned int __ofono_gprs_add_status_watch(struct ofono_gprs *gprs,
+				ofono_gprs_status_notify_cb_t notify,
+				void *data, ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *item;
+
+	DBG("%p", gprs);
+
+	if (gprs =3D=3D NULL)
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
+	return __ofono_watchlist_add_item(gprs->status_watches, item);
+}
+
+gboolean __ofono_gprs_remove_status_watch(struct ofono_gprs *gprs,
+						unsigned int id)
+{
+	DBG("%p", gprs);
+
+	return __ofono_watchlist_remove_item(gprs->status_watches, id);
+}
+
+static void notify_status_watches(struct ofono_gprs *gprs)
+{
+	struct ofono_watchlist_item *item;
+	GSList *l;
+	ofono_gprs_status_notify_cb_t notify;
+
+	for (l =3D gprs->status_watches->items; l; l =3D l->next) {
+		item =3D l->data;
+		notify =3D item->notify;
+
+		notify(gprs->status, item->notify_data);
+	}
+}
+
 void ofono_gprs_detached_notify(struct ofono_gprs *gprs)
 {
 	if (gprs->driver_attached =3D=3D FALSE)
@@ -1476,6 +1525,8 @@ void ofono_gprs_detached_notify(struct ofono_gprs *gp=
rs)
 =

 	gprs_attached_update(gprs);
 =

+	notify_status_watches(gprs);
+
 	/* TODO: The network forced a detach, we should wait for some time
 	 * and try to re-attach
 	 */
@@ -1489,6 +1540,8 @@ void ofono_gprs_status_notify(struct ofono_gprs *gprs=
, int status)
 =

 	gprs->status =3D status;
 	gprs_attached_update(gprs);
+
+	notify_status_watches(gprs);
 }
 =

 void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
@@ -1944,6 +1997,14 @@ struct ofono_modem *ofono_gprs_context_get_modem(str=
uct ofono_gprs_context *gc)
 	return __ofono_atom_get_modem(gc->atom);
 }
 =

+int ofono_gprs_get_status(struct ofono_gprs *gprs)
+{
+	if (gprs =3D=3D NULL)
+		return -1;
+
+	return gprs->status;
+}
+
 int ofono_gprs_driver_register(const struct ofono_gprs_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -1971,6 +2032,9 @@ static void gprs_unregister(struct ofono_atom *atom)
 	const char *path =3D __ofono_atom_get_path(atom);
 	GSList *l;
 =

+	__ofono_watchlist_free(gprs->status_watches);
+	gprs->status_watches =3D NULL;
+
 	if (gprs->settings) {
 		storage_close(gprs->imsi, SETTINGS_STORE,
 				gprs->settings, TRUE);
-- =

1.6.3.3


--===============0470700523356426907==--

