Content-Type: multipart/mixed; boundary="===============5950891212068591511=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 2/3] cdma-netreg: Add cdma-netreg status watch
Date: Thu, 01 Dec 2011 17:40:33 +0100
Message-ID: <1322757634-18468-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1322757634-18468-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5950891212068591511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-netreg.c |   52 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++
 src/ofono.h       |   13 +++++++++++++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
index 222c3b7..34c11c0 100644
--- a/src/cdma-netreg.c
+++ b/src/cdma-netreg.c
@@ -35,6 +35,7 @@ struct ofono_cdma_netreg {
 	enum cdma_netreg_status status;
 	int strength;
 	int hdr_strength;
+	struct ofono_watchlist *status_watches;
 	const struct ofono_cdma_netreg_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -104,6 +105,53 @@ static GDBusSignalTable cdma_netreg_manager_signals[] =
=3D {
 	{ }
 };
 =

+unsigned int __ofono_cdma_netreg_add_status_watch(
+				struct ofono_cdma_netreg *netreg,
+				ofono_cdma_netreg_status_notify_cb_t notify,
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
+	return __ofono_watchlist_add_item(netreg->status_watches, item);
+}
+
+gboolean __ofono_cdma_netreg_remove_status_watch(
+					struct ofono_cdma_netreg *netreg,
+					unsigned int id)
+{
+	DBG("%p", netreg);
+
+	return __ofono_watchlist_remove_item(netreg->status_watches, id);
+}
+
+static void notify_status_watches(struct ofono_cdma_netreg *netreg)
+{
+	struct ofono_watchlist_item *item;
+	GSList *l;
+	ofono_cdma_netreg_status_notify_cb_t notify;
+
+	for (l =3D netreg->status_watches->items; l; l =3D l->next) {
+		item =3D l->data;
+		notify =3D item->notify;
+
+		notify(item->notify_data);
+	}
+}
+
 static void serving_system_callback(const struct ofono_error *error,
 					const char *sid, void *data)
 {
@@ -120,6 +168,8 @@ static void serving_system_callback(const struct ofono_=
error *error,
 	}
 =

 	DBG("Serving system Identifier: %s", sid);
+
+	notify_status_watches(cdma_netreg);
 }
 =

 static void set_registration_status(struct ofono_cdma_netreg *cdma_netreg,
@@ -152,6 +202,8 @@ void ofono_cdma_netreg_status_notify(struct ofono_cdma_=
netreg *cdma_netreg,
 =

 	if (cdma_netreg->status !=3D status)
 		set_registration_status(cdma_netreg, status);
+
+	notify_status_watches(cdma_netreg);
 }
 =

 static void strength_notify_common(struct ofono_cdma_netreg *netreg,
diff --git a/src/ofono.h b/src/ofono.h
index bfb534d..37b2b3f 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -492,3 +492,16 @@ void __ofono_gprs_provision_free_settings(
 void __ofono_private_network_release(int id);
 ofono_bool_t __ofono_private_network_request(ofono_private_network_cb_t cb,
 						int *id, void *data);
+
+#include <ofono/cdma-netreg.h>
+
+typedef void (*ofono_cdma_netreg_status_notify_cb_t)(void *data);
+
+unsigned int __ofono_cdma_netreg_add_status_watch(
+				struct ofono_cdma_netreg *netreg,
+				ofono_cdma_netreg_status_notify_cb_t cb,
+				void *data, ofono_destroy_func destroy);
+
+gboolean __ofono_cdma_netreg_remove_status_watch(
+					struct ofono_cdma_netreg *netreg,
+					unsigned int id);
-- =

1.7.1


--===============5950891212068591511==--

