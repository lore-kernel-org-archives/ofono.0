Content-Type: multipart/mixed; boundary="===============2216034462953271497=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v5 13/16] dundee: Add driver helper functions
Date: Wed, 04 Jan 2012 18:17:47 +0100
Message-ID: <1325697470-22227-14-git-send-email-wagi@monom.org>
In-Reply-To: <1325697470-22227-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2216034462953271497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 dundee/device.c |   18 ++++++++++++++++++
 dundee/dundee.h |    5 +++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/dundee/device.c b/dundee/device.c
index bac8ead..6f2a7ea 100644
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
index a32eebf..5149f8b 100644
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

1.7.8.2.302.g17b4


--===============2216034462953271497==--

