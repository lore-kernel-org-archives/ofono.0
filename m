Content-Type: multipart/mixed; boundary="===============5411321273592152205=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 13/16] gprs: Add status watch functions
Date: Wed, 11 Aug 2010 10:26:38 +0800
Message-ID: <1281493601-14351-14-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281493601-14351-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5411321273592152205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So DUN server could watch GPRS status changes and notify client
unsolicited results like +CGREG.
---
 include/gprs.h |    9 +++++++++
 src/gprs.c     |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
 2 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/include/gprs.h b/include/gprs.h
index a1cbcd9..c0a0e2f 100644
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
@@ -67,6 +69,13 @@ void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
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
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/gprs.c b/src/gprs.c
index 95f7ab2..b91a099 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -92,6 +92,7 @@ struct ofono_gprs {
 	const struct ofono_gprs_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	struct ofono_watchlist *status_watches;
 	struct ofono_emulator *dun;
 	unsigned int dun_watch;
 	unsigned int dun_status_watch;
@@ -1467,6 +1468,51 @@ static GDBusSignalTable manager_signals[] =3D {
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
@@ -1476,6 +1522,8 @@ void ofono_gprs_detached_notify(struct ofono_gprs *gp=
rs)
 =

 	gprs_attached_update(gprs);
 =

+	notify_status_watches(gprs);
+
 	/* TODO: The network forced a detach, we should wait for some time
 	 * and try to re-attach
 	 */
@@ -1489,6 +1537,8 @@ void ofono_gprs_status_notify(struct ofono_gprs *gprs=
, int status)
 =

 	gprs->status =3D status;
 	gprs_attached_update(gprs);
+
+	notify_status_watches(gprs);
 }
 =

 void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
@@ -1972,6 +2022,9 @@ static void gprs_unregister(struct ofono_atom *atom)
 	const char *path =3D __ofono_atom_get_path(atom);
 	GSList *l;
 =

+	__ofono_watchlist_free(gprs->status_watches);
+	gprs->status_watches =3D NULL;
+
 	if (gprs->settings) {
 		storage_close(gprs->imsi, SETTINGS_STORE,
 				gprs->settings, TRUE);
@@ -2289,6 +2342,8 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
 	ofono_modem_add_interface(modem,
 				OFONO_DATA_CONNECTION_MANAGER_INTERFACE);
 =

+	gprs->status_watches =3D __ofono_watchlist_new(g_free);
+
 	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
 =

 	if (sim_atom) {
-- =

1.7.0.4


--===============5411321273592152205==--

