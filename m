Content-Type: multipart/mixed; boundary="===============3185840179111532476=="
MIME-Version: 1.0
From: Pau Espin Pedrol <pespin@sysmocom.de>
Subject: [PATCH 2/2] udevng: Catch network interface renames
Date: Mon, 01 Apr 2019 20:31:39 +0200
Message-ID: <20190401183139.4710-2-pespin@sysmocom.de>
In-Reply-To: <20190401183139.4710-1-pespin@sysmocom.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3185840179111532476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If for whatever reason a network interface belonging to a modem is
renamed after ofono startup, ofono then keeps advertising the old
non-existing interface name instead of the new one.
To catch the changes we use udev's "move" action together with
DEVPATH_OLD variable, which points to the old devpath of the device.

Unfortunately current debian9 systemd version contains systemd bug which
prevents this feature to work fine if the iface is renamed more than
once, see [1] for more information.

[1] https://github.com/systemd/systemd/issues/9426
---
 plugins/udevng.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index c518553a..8338927b 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -56,6 +56,7 @@ struct modem_info {
 	};
 	struct ofono_modem *modem;
 	const char *sysattr;
+	gboolean needs_update;
 };
 =

 struct device_info {
@@ -1630,6 +1631,7 @@ static void add_device(const char *syspath, const cha=
r *devname,
 =

 	modem->devices =3D g_slist_insert_sorted(modem->devices, info,
 							compare_device);
+	modem->needs_update =3D TRUE;
 }
 =

 static struct {
@@ -1822,6 +1824,8 @@ static gboolean create_modem(gpointer key, gpointer v=
alue, gpointer user_data)
 	const char *syspath =3D key;
 	unsigned int i;
 =

+	modem->needs_update =3D FALSE;
+
 	if (modem->modem !=3D NULL)
 		return FALSE;
 =

@@ -1909,6 +1913,81 @@ static gboolean check_modem_list(gpointer user_data)
 	return FALSE;
 }
 =

+static void drop_old_device(gpointer key, gpointer value, gpointer user_da=
ta)
+{
+	const char *syspath =3D key;
+	struct modem_info *modem =3D value;
+	struct udev_device *device =3D user_data;
+	const char *devpath_old;
+	GSList *list;
+
+	devpath_old =3D udev_device_get_property_value(device, "DEVPATH_OLD");
+	if (!devpath_old)
+		return;
+
+	for (list =3D modem->devices; list; list =3D list->next) {
+		struct device_info *info =3D list->data;
+		struct udev_device *dev;
+
+		if (g_strcmp0(info->subsystem, "net") !=3D 0)
+			continue;
+
+		if (g_strcmp0(info->devpath, devpath_old) !=3D 0)
+			continue;
+
+		/* Drop no longer existing net iface device */
+		DBG("Dropping lost device %s", info->devpath);
+		modem->devices =3D g_slist_remove_link(modem->devices, list);
+		g_slist_free_1 (list);
+		device_info_free(info);
+		udev_device_unref(dev);
+		modem->needs_update =3D TRUE;
+	}
+}
+
+
+static void update_modem(gpointer key, gpointer value, gpointer user_data)
+{
+	const char *syspath =3D key;
+	struct modem_info *modem =3D value;
+	unsigned int i;
+
+	if (!modem->needs_update)
+		return;
+
+	DBG("Updating modem %s", syspath);
+
+	for (i =3D 0; driver_list[i].name; i++) {
+		if (g_str_equal(driver_list[i].name, modem->driver) =3D=3D FALSE)
+			continue;
+		if (driver_list[i].setup(modem) =3D=3D FALSE)
+			continue;
+	}
+}
+static void update_device(struct udev_device *device)
+{
+	const char *syspath;
+
+	syspath =3D udev_device_get_syspath(device);
+	if (syspath =3D=3D NULL)
+		return;
+
+	DBG("%s", syspath);
+
+	/* We only care about net iface renames for now */
+	if (g_strcmp0(udev_device_get_subsystem(device), "net") !=3D 0)
+		return;
+
+	/* Drop old device from modem */
+	g_hash_table_foreach(modem_list, drop_old_device, device);
+
+	/* Add new device to modem */
+	check_device(device);
+
+	/* Update modified modems */
+	g_hash_table_foreach(modem_list, update_modem, NULL);
+}
+
 static gboolean udev_event(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1936,8 +2015,11 @@ static gboolean udev_event(GIOChannel *channel, GIOC=
ondition cond,
 		check_device(device);
 =

 		udev_delay =3D g_timeout_add_seconds(1, check_modem_list, NULL);
-	} else if (g_str_equal(action, "remove") =3D=3D TRUE)
+	} else if (g_str_equal(action, "remove") =3D=3D TRUE) {
 		remove_device(device);
+	} else if (g_str_equal(action, "move") =3D=3D TRUE) {
+		update_device(device);
+	}
 =

 	udev_device_unref(device);
 =

-- =

2.21.0


--===============3185840179111532476==--

