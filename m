Content-Type: multipart/mixed; boundary="===============8425834876548459684=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Subject: [PATCH 2/4] udevng: make subsystem available for modem setup
Date: Sun, 03 Feb 2013 22:39:45 +0100
Message-ID: <1359927587-24353-3-git-send-email-bjorn@mork.no>
In-Reply-To: <1359927587-24353-1-git-send-email-bjorn@mork.no>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8425834876548459684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
---
 plugins/udevng.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index a4da374..9fee7c2 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -55,6 +55,7 @@ struct device_info {
 	char *number;
 	char *label;
 	char *sysattr;
+	char *subsystem;
 };
 =

 static gboolean setup_isi(struct modem_info *modem)
@@ -819,6 +820,7 @@ static void destroy_modem(gpointer data)
 		g_free(info->number);
 		g_free(info->label);
 		g_free(info->sysattr);
+		g_free(info->subsystem);
 		g_free(info);
 =

 		list->data =3D NULL;
@@ -877,7 +879,7 @@ static void add_device(const char *syspath, const char =
*devname,
 			const char *model, struct udev_device *device)
 {
 	struct udev_device *intf;
-	const char *devpath, *devnode, *interface, *number, *label, *sysattr;
+	const char *devpath, *devnode, *interface, *number, *label, *sysattr, *su=
bsystem;
 	struct modem_info *modem;
 	struct device_info *info;
 =

@@ -918,6 +920,7 @@ static void add_device(const char *syspath, const char =
*devname,
 	number =3D udev_device_get_property_value(device, "ID_USB_INTERFACE_NUM");
 =

 	label =3D udev_device_get_property_value(device, "OFONO_LABEL");
+	subsystem =3D udev_device_get_property_value(device, "SUBSYSTEM");
 =

 	if (modem->sysattr !=3D NULL)
 		sysattr =3D udev_device_get_sysattr_value(device, modem->sysattr);
@@ -939,6 +942,7 @@ static void add_device(const char *syspath, const char =
*devname,
 	info->number =3D g_strdup(number);
 	info->label =3D g_strdup(label);
 	info->sysattr =3D g_strdup(sysattr);
+	info->subsystem =3D g_strdup(subsystem);
 =

 	modem->devices =3D g_slist_insert_sorted(modem->devices, info,
 							compare_device);
-- =

1.7.10.4


--===============8425834876548459684==--

