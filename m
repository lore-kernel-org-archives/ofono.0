Content-Type: multipart/mixed; boundary="===============7283496336273592885=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v3 08/13] dundee: Add dundee device driver skeleton
Date: Wed, 20 Mar 2013 19:26:37 -0300
Message-ID: <1363818402-17710-9-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1363818402-17710-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7283496336273592885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the functions to be called when the dundee will
connect or disconnect with a Bluetooth device.
---
 dundee/bluez5.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/dundee/bluez5.c b/dundee/bluez5.c
index f0c51df..c78c445 100644
--- a/dundee/bluez5.c
+++ b/dundee/bluez5.c
@@ -52,6 +52,24 @@ static void bluetooth_device_destroy(gpointer user_data)
 	g_free(bt_device);
 }
 =

+static void bluetooth_device_connect(struct dundee_device *device,
+			dundee_device_connect_cb_t cb, void *data)
+{
+	DBG("");
+}
+
+static void bluetooth_device_disconnect(struct dundee_device *device,
+				dundee_device_disconnect_cb_t cb, void *data)
+{
+	DBG("");
+}
+
+struct dundee_device_driver bluetooth_driver =3D {
+	.name =3D "bluetooth",
+	.connect =3D bluetooth_device_connect,
+	.disconnect =3D bluetooth_device_disconnect,
+};
+
 static struct bluetooth_device *bluetooth_device_create(const char *path,
 					const char *address, const char *alias)
 {
-- =

1.7.9.5


--===============7283496336273592885==--

