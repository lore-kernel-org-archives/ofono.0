Content-Type: multipart/mixed; boundary="===============2529150947962335940=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v7 13/16] dundee: Add driver helper functions
Date: Tue, 22 May 2012 18:33:21 +0200
Message-ID: <1337704404-5260-14-git-send-email-wagi@monom.org>
In-Reply-To: <1337704404-5260-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2529150947962335940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 dundee/device.c |   18 ++++++++++++++++++
 dundee/dundee.h |    5 +++++
 2 files changed, 23 insertions(+)

diff --git a/dundee/device.c b/dundee/device.c
index 9ed1687..1a83f76 100644
--- a/dundee/device.c
+++ b/dundee/device.c
@@ -41,6 +41,7 @@ struct dundee_device {
 	struct dundee_device_driver *driver;
 	gboolean registered;
 =

+	void *data;
 };
 =

 const char *__dundee_device_get_path(struct dundee_device *device)
@@ -135,6 +136,23 @@ void dundee_device_unregister(struct dundee_device *de=
vice)
 	g_hash_table_remove(device_hash, device->path);
 }
 =

+void dundee_device_set_data(struct dundee_device *device, void *data)
+{
+	device->data =3D data;
+}
+
+void *dundee_device_get_data(struct dundee_device *device)
+{
+	return device->data;
+}
+
+int dundee_device_set_name(struct dundee_device *device, const char *name)
+{
+	DBG("%p name %s", device, name);
+
+	return 0;
+}
+
 static void device_shutdown(gpointer key, gpointer value, gpointer user_da=
ta)
 {
 	struct dundee_device *device =3D value;
diff --git a/dundee/dundee.h b/dundee/dundee.h
index ae14e01..cf0c36a 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -126,6 +126,11 @@ struct dundee_device *dundee_device_create(struct dund=
ee_device_driver *d);
 int dundee_device_register(struct dundee_device *device);
 void dundee_device_unregister(struct dundee_device *device);
 =

+void dundee_device_set_data(struct dundee_device *device, void *data);
+void *dundee_device_get_data(struct dundee_device *device);
+
+int dundee_device_set_name(struct dundee_device *device, const char *name);
+
 typedef void (*dundee_device_foreach_func)(struct dundee_device *device,
 						void *data);
 void __dundee_device_foreach(dundee_device_foreach_func cb, void *userdata=
);
-- =

1.7.10.130.g36e6c


--===============2529150947962335940==--

