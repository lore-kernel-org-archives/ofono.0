Content-Type: multipart/mixed; boundary="===============3908210658430890295=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/2] cdma-netreg: Add various cdma-netreg watches
Date: Thu, 20 Oct 2011 17:41:31 +0200
Message-ID: <1319125292-6204-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1319125292-6204-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3908210658430890295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-netreg.h |    1 +
 src/cdma-netreg.c     |   58 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h           |   13 +++++++++++
 3 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/include/cdma-netreg.h b/include/cdma-netreg.h
index 25888d1..31ed289 100644
--- a/include/cdma-netreg.h
+++ b/include/cdma-netreg.h
@@ -50,6 +50,7 @@ void ofono_cdma_netreg_strength_notify(struct ofono_cdma_=
netreg *netreg,
 					int strength);
 void ofono_cdma_netreg_data_strength_notify(struct ofono_cdma_netreg *netr=
eg,
 						int data_strength);
+int ofono_cdma_netreg_get_status(struct ofono_cdma_netreg *netreg);
 =

 int ofono_cdma_netreg_driver_register(
 				const struct ofono_cdma_netreg_driver *d);
diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
index d88bfcc..d721098 100644
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
@@ -119,6 +120,53 @@ static void set_registration_status(struct ofono_cdma_=
netreg *cdma_netreg,
 				&str_status);
 }
 =

+unsigned int __ofono_cdma_netreg_add_status_watch(
+				struct ofono_cdma_netreg *cdma_netreg,
+				ofono_cdma_netreg_status_notify_cb_t notify,
+				void *data, ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *item;
+
+	DBG("%p", cdma_netreg);
+
+	if (cdma_netreg =3D=3D NULL)
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
+	return __ofono_watchlist_add_item(cdma_netreg->status_watches, item);
+}
+
+gboolean __ofono_cdma_netreg_remove_status_watch(
+					struct ofono_cdma_netreg *cdma_netreg,
+					unsigned int id)
+{
+	DBG("%p", cdma_netreg);
+
+	return __ofono_watchlist_remove_item(cdma_netreg->status_watches, id);
+}
+
+static void notify_status_watches(struct ofono_cdma_netreg *cdma_netreg)
+{
+	struct ofono_watchlist_item *item;
+	GSList *l;
+	ofono_cdma_netreg_status_notify_cb_t notify;
+
+	for (l =3D cdma_netreg->status_watches->items; l; l =3D l->next) {
+		item =3D l->data;
+		notify =3D item->notify;
+
+		notify(cdma_netreg->status, item->notify_data);
+	}
+}
+
 void ofono_cdma_netreg_status_notify(struct ofono_cdma_netreg *cdma_netreg,
 					enum cdma_netreg_status status)
 {
@@ -127,6 +175,8 @@ void ofono_cdma_netreg_status_notify(struct ofono_cdma_=
netreg *cdma_netreg,
 =

 	if (cdma_netreg->status !=3D status)
 		set_registration_status(cdma_netreg, status);
+
+	notify_status_watches(cdma_netreg);
 }
 =

 static void strength_notify_common(struct ofono_cdma_netreg *netreg,
@@ -173,6 +223,14 @@ void ofono_cdma_netreg_data_strength_notify(struct ofo=
no_cdma_netreg *netreg,
 					"DataStrength", &netreg->hdr_strength);
 }
 =

+int ofono_cdma_netreg_get_status(struct ofono_cdma_netreg *netreg)
+{
+	if (netreg =3D=3D NULL)
+		return -1;
+
+	return netreg->status;
+}
+
 int ofono_cdma_netreg_driver_register(const struct ofono_cdma_netreg_drive=
r *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
diff --git a/src/ofono.h b/src/ofono.h
index bd45560..ce2f0b6 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -485,7 +485,20 @@ void __ofono_gprs_provision_free_settings(
 #include <ofono/emulator.h>
 #include <ofono/gnss.h>
 #include <ofono/cdma-sms.h>
+
 #include <ofono/cdma-netreg.h>
+
+typedef void (*ofono_cdma_netreg_status_notify_cb_t)(int status, void *dat=
a);
+
+unsigned int __ofono_cdma_netreg_add_status_watch(
+				struct ofono_cdma_netreg *cdma_netreg,
+				ofono_cdma_netreg_status_notify_cb_t cb,
+				void *data, ofono_destroy_func destroy);
+
+gboolean __ofono_cdma_netreg_remove_status_watch(
+					struct ofono_cdma_netreg *cdma_netreg,
+					unsigned int id);
+
 #include <ofono/private-network.h>
 =

 void __ofono_private_network_release(int id);
-- =

1.7.1


--===============3908210658430890295==--

