Content-Type: multipart/mixed; boundary="===============4338513740534163034=="
MIME-Version: 1.0
From: Pau Espin Pedrol <pespin@sysmocom.de>
Subject: [PATCH 1/2] udevng: Track udev devices through devpath and not syspath
Date: Mon, 01 Apr 2019 20:31:38 +0200
Message-ID: <20190401183139.4710-1-pespin@sysmocom.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4338513740534163034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

syspath is not really needed in there, and catching devpath instead
allows us to easily match against DEVPATH_OLD in follow-up patches.
Furthermore, previous code was misleading retrieving syspath in
remove_device() and then passing it as devpath param of check_remove().
---
 plugins/udevng.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index f689b756..c518553a 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1427,16 +1427,16 @@ static gboolean check_remove(gpointer key, gpointer=
 value, gpointer user_data)
 =

 static void remove_device(struct udev_device *device)
 {
-	const char *syspath;
+	const char *devpath;
 =

-	syspath =3D udev_device_get_syspath(device);
-	if (syspath =3D=3D NULL)
+	devpath =3D udev_device_get_devpath(device);
+	if (devpath =3D=3D NULL)
 		return;
 =

-	DBG("%s", syspath);
+	DBG("%s", devpath);
 =

 	g_hash_table_foreach_remove(modem_list, check_remove,
-						(char *) syspath);
+						(char *) devpath);
 }
 =

 static gint compare_device(gconstpointer a, gconstpointer b)
@@ -1550,7 +1550,7 @@ static void add_device(const char *syspath, const cha=
r *devname,
 	struct device_info *info;
 	struct udev_device *parent;
 =

-	devpath =3D udev_device_get_syspath(device);
+	devpath =3D udev_device_get_devpath(device);
 	if (devpath =3D=3D NULL)
 		return;
 =

-- =

2.21.0


--===============4338513740534163034==--

