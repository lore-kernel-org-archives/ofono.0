Content-Type: multipart/mixed; boundary="===============5986413404266324464=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v3 11/13] dundee: Add support for driver connect
Date: Wed, 20 Mar 2013 19:26:40 -0300
Message-ID: <1363818402-17710-12-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1363818402-17710-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5986413404266324464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch glues together the dundee driver interface with the
D-Bus Profile1 interface.

When the dundee driver requests a connection, it will call the
Device1's ConnectProfile.
---
 dundee/bluez5.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/dundee/bluez5.c b/dundee/bluez5.c
index fdf015d..c5a5ff0 100644
--- a/dundee/bluez5.c
+++ b/dundee/bluez5.c
@@ -114,7 +114,12 @@ static void bluetooth_device_destroy(gpointer user_dat=
a)
 static void bluetooth_device_connect(struct dundee_device *device,
 			dundee_device_connect_cb_t cb, void *data)
 {
-	DBG("");
+	struct bluetooth_device *bt_device =3D dundee_device_get_data(device);
+
+	DBG("%s", bt_device->path);
+
+	bt_connect_profile(ofono_dbus_get_connection(), bt_device->path,
+						DUN_UUID, NULL, NULL);
 }
 =

 static void bluetooth_device_disconnect(struct dundee_device *device,
-- =

1.7.9.5


--===============5986413404266324464==--

