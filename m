Content-Type: multipart/mixed; boundary="===============9141799686571987311=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v5 12/16] dundee: Add device un/register
Date: Wed, 04 Jan 2012 18:17:46 +0100
Message-ID: <1325697470-22227-13-git-send-email-wagi@monom.org>
In-Reply-To: <1325697470-22227-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9141799686571987311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 dundee/device.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 dundee/dundee.h |   21 ++++++++++++++++
 2 files changed, 89 insertions(+), 1 deletions(-)

diff --git a/dundee/device.c b/dundee/device.c
index 1b89e97..bac8ead 100644
--- a/dundee/device.c
+++ b/dundee/device.c
@@ -33,14 +33,19 @@
 =

 #include "dundee.h"
 =

+static int next_device_id =3D 0;
 static GHashTable *device_hash;
 =

 struct dundee_device {
+	char *path;
+	struct dundee_device_driver *driver;
+	gboolean registered;
+
 };
 =

 const char *__dundee_device_get_path(struct dundee_device *device)
 {
-	return "/";
+	return device->path;
 }
 =

 void __dundee_device_append_properties(struct dundee_device *device,
@@ -64,15 +69,77 @@ void __dundee_device_foreach(dundee_device_foreach_func=
 func, void *userdata)
 	}
 }
 =

+static int register_device(struct dundee_device *device)
+{
+	return 0;
+}
+
+static int unregister_device(struct dundee_device *device)
+{
+	return 0;
+}
+
 static void destroy_device(gpointer user)
 {
 	struct dundee_device *device =3D user;
 =

+	g_free(device->path);
+
 	g_free(device);
 }
 =

+struct dundee_device *dundee_device_create(struct dundee_device_driver *d)
+{
+	struct dundee_device *device;
+
+	device =3D g_try_new0(struct dundee_device, 1);
+	if (device =3D=3D NULL)
+		return NULL;
+
+	device->driver =3D d;
+
+	device->path =3D g_strdup_printf("/device%d", next_device_id);
+	if (device->path =3D=3D NULL) {
+		g_free(device);
+		return NULL;
+	}
+
+	next_device_id +=3D 1;
+
+	return device;
+}
+
+int dundee_device_register(struct dundee_device *device)
+{
+	int err;
+
+	err =3D register_device(device);
+	if (err < 0)
+		return err;
+
+	device->registered =3D TRUE;
+
+	g_hash_table_insert(device_hash, g_strdup(device->path), device);
+
+	return 0;
+}
+
+void dundee_device_unregister(struct dundee_device *device)
+{
+	DBG("%p", device);
+
+	unregister_device(device);
+
+	device->registered =3D FALSE;
+
+	g_hash_table_remove(device_hash, device->path);
+}
+
 static void device_shutdown(gpointer key, gpointer value, gpointer user_da=
ta)
 {
+	struct dundee_device *device =3D value;
+
+	unregister_device(device);
 }
 =

 void __dundee_device_shutdown(void)
diff --git a/dundee/dundee.h b/dundee/dundee.h
index 01edd53..a32eebf 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -105,6 +105,27 @@ int __dundee_device_init(void);
 void __dundee_device_cleanup(void);
 void __dundee_device_shutdown(void);
 =

+typedef void (*dundee_device_connect_cb_t)(const struct dundee_error *erro=
r,
+						int fd, void *data);
+typedef void (*dundee_device_disconnect_cb_t)(const struct dundee_error *e=
rror,
+						void *data);
+
+struct dundee_device_driver {
+	const char *name;
+
+	/* Connect and dial */
+	void (*connect)(struct dundee_device *device,
+			dundee_device_connect_cb_t cb, void *data);
+
+	/* Hangup and disconnect */
+	void (*disconnect)(struct dundee_device *device,
+			dundee_device_disconnect_cb_t cb, void *data);
+};
+
+struct dundee_device *dundee_device_create(struct dundee_device_driver *d);
+int dundee_device_register(struct dundee_device *device);
+void dundee_device_unregister(struct dundee_device *device);
+
 typedef void (*dundee_device_foreach_func)(struct dundee_device *device,
 						void *data);
 void __dundee_device_foreach(dundee_device_foreach_func cb, void *userdata=
);
-- =

1.7.8.2.302.g17b4


--===============9141799686571987311==--

