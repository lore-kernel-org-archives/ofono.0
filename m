Content-Type: multipart/mixed; boundary="===============4523700501338542004=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v3 12/13] dundee: Add dundee disconnect function
Date: Wed, 20 Mar 2013 19:26:41 -0300
Message-ID: <1363818402-17710-13-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1363818402-17710-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4523700501338542004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 dundee/device.c |   14 +++++++++++---
 dundee/dundee.h |    3 +++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/dundee/device.c b/dundee/device.c
index e5f6424..2d84aaa 100644
--- a/dundee/device.c
+++ b/dundee/device.c
@@ -270,11 +270,13 @@ err:
 	device->pending =3D NULL;
 }
 =

-static void disconnect_callback(const struct dundee_error *error, void *da=
ta)
+void dundee_device_disconnect(const struct dundee_error *error,
+						struct dundee_device *device)
 {
-	struct dundee_device *device =3D data;
+	if (device =3D=3D NULL)
+		return;
 =

-	DBG("%p", device);
+	DBG("%s", device->path);
 =

 	g_at_chat_unref(device->chat);
 	device->chat =3D NULL;
@@ -295,6 +297,12 @@ out:
 	device->pending =3D NULL;
 }
 =

+static void disconnect_callback(const struct dundee_error *error, void *da=
ta)
+{
+	struct dundee_device *device =3D data;
+	dundee_device_disconnect(error, device);
+}
+
 static gboolean ppp_connect_timeout(gpointer user_data)
 {
 	struct dundee_device *device =3D user_data;
diff --git a/dundee/dundee.h b/dundee/dundee.h
index daf78a5..1889d84 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -130,6 +130,9 @@ struct dundee_device *dundee_device_create(struct dunde=
e_device_driver *d);
 int dundee_device_register(struct dundee_device *device);
 void dundee_device_unregister(struct dundee_device *device);
 =

+void dundee_device_disconnect(const struct dundee_error *error,
+						struct dundee_device *device);
+
 void dundee_device_set_data(struct dundee_device *device, void *data);
 void *dundee_device_get_data(struct dundee_device *device);
 =

-- =

1.7.9.5


--===============4523700501338542004==--

