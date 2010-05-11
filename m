Content-Type: multipart/mixed; boundary="===============1775581564041039592=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/2] Fix Use hashtable to record udev path
Date: Tue, 11 May 2010 09:04:28 +0800
Message-ID: <1273539869-23803-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1775581564041039592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sometimes, Udev device 'remove' event could not report correct parent
node of current udev_device. Current code replies on the devpath
attached on the parent node to find modem and then remove it.

This fix is to change the way to store the devpath info into a
hashtable. So that we search hashtable to get devpath and remove the
modem.
---
 plugins/udev.c |   58 +++++++++++++++++++++++++++++++++++++---------------=
---
 1 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 4aaeeb9..3a6ea28 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -36,6 +36,7 @@
 #include <ofono/log.h>
 =

 static GSList *modem_list =3D NULL;
+static GHashTable *devpath_list =3D NULL;
 =

 static struct ofono_modem *find_modem(const char *devpath)
 {
@@ -259,7 +260,7 @@ static void add_modem(struct udev_device *udev_device)
 {
 	struct ofono_modem *modem;
 	struct udev_device *parent;
-	const char *devpath, *driver;
+	const char *devpath, *curpath, *driver;
 =

 	parent =3D udev_device_get_parent(udev_device);
 	if (parent =3D=3D NULL)
@@ -295,6 +296,12 @@ static void add_modem(struct udev_device *udev_device)
 		modem_list =3D g_slist_prepend(modem_list, modem);
 	}
 =

+	curpath =3D udev_device_get_devpath(udev_device);
+	if (curpath =3D=3D NULL)
+		return;
+
+	g_hash_table_insert(devpath_list, g_strdup(curpath), g_strdup(devpath));
+
 	if (g_strcmp0(driver, "mbm") =3D=3D 0)
 		add_mbm(modem, udev_device);
 	else if (g_strcmp0(driver, "hso") =3D=3D 0)
@@ -307,30 +314,25 @@ static void add_modem(struct udev_device *udev_device)
 		add_novatel(modem, udev_device);
 }
 =

+static gboolean devpath_remove(gpointer key, gpointer value, gpointer user=
_data)
+{
+	const char *path =3D value;
+	const char *devpath =3D user_data;
+
+	return g_str_equal(path, devpath);
+}
+
 static void remove_modem(struct udev_device *udev_device)
 {
 	struct ofono_modem *modem;
-	struct udev_device *parent;
-	const char *devpath, *driver =3D NULL;
+	const char *curpath =3D udev_device_get_devpath(udev_device);
+	char *devpath, *remove;
 =

-	parent =3D udev_device_get_parent(udev_device);
-	if (parent =3D=3D NULL)
+	if (curpath =3D=3D NULL)
 		return;
 =

-	driver =3D get_driver(parent);
-	if (driver =3D=3D NULL) {
-		parent =3D udev_device_get_parent(parent);
-		driver =3D get_driver(parent);
-		if (driver =3D=3D NULL) {
-			parent =3D udev_device_get_parent(parent);
-			driver =3D get_driver(parent);
-			if (driver =3D=3D NULL)
-				return;
-		}
-	}
-
-	devpath =3D udev_device_get_devpath(parent);
-	if (devpath =3D=3D NULL)
+	devpath =3D g_hash_table_lookup(devpath_list, curpath);
+	if (!devpath)
 		return;
 =

 	modem =3D find_modem(devpath);
@@ -340,6 +342,12 @@ static void remove_modem(struct udev_device *udev_devi=
ce)
 	modem_list =3D g_slist_remove(modem_list, modem);
 =

 	ofono_modem_remove(modem);
+
+	remove =3D g_strdup(devpath);
+
+	g_hash_table_foreach_remove(devpath_list, devpath_remove, remove);
+
+	g_free(remove);
 }
 =

 static void enumerate_devices(struct udev *context)
@@ -444,15 +452,24 @@ static void udev_start(void)
 =

 static int udev_init(void)
 {
+	devpath_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, g_free);
+	if (!devpath_list) {
+		ofono_error("Failed to create udev path list");
+		return -ENOMEM;
+	}
+
 	udev_ctx =3D udev_new();
 	if (udev_ctx =3D=3D NULL) {
 		ofono_error("Failed to create udev context");
+		g_hash_table_destroy(devpath_list);
 		return -EIO;
 	}
 =

 	udev_mon =3D udev_monitor_new_from_netlink(udev_ctx, "udev");
 	if (udev_mon =3D=3D NULL) {
 		ofono_error("Failed to create udev monitor");
+		g_hash_table_destroy(devpath_list);
 		udev_unref(udev_ctx);
 		udev_ctx =3D NULL;
 		return -EIO;
@@ -484,6 +501,9 @@ static void udev_exit(void)
 	g_slist_free(modem_list);
 	modem_list =3D NULL;
 =

+	g_hash_table_destroy(devpath_list);
+	devpath_list =3D NULL;
+
 	if (udev_ctx =3D=3D NULL)
 		return;
 =

-- =

1.6.3.3


--===============1775581564041039592==--

