Content-Type: multipart/mixed; boundary="===============2631652935296497654=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 3/4] bluetooth: do not use ofono_dbus_get_connection
Date: Sun, 18 Jul 2010 19:57:28 -0300
Message-ID: <1279493849-22930-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1279493849-22930-2-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2631652935296497654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We can't rely on that function anymore, since bluetooth.c will be used
outside of ofonod now.
---
 plugins/bluetooth.c |    5 +++--
 plugins/bluetooth.h |    3 ++-
 plugins/hfp.c       |    2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index f74c9c5..9335607 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -482,14 +482,15 @@ static guint adapter_added_watch;
 static guint adapter_removed_watch;
 static guint property_watch;
 =

-int bluetooth_register_uuid(struct bluetooth_profile *profile)
+int bluetooth_register_uuid(DBusConnection *conn,
+					struct bluetooth_profile *profile)
 {
 	int err;
 =

 	if (uuid_hash)
 		goto done;
 =

-	connection =3D ofono_dbus_get_connection();
+	connection =3D conn;
 =

 	bluetooth_watch =3D g_dbus_add_service_watch(connection, BLUEZ_SERVICE,
 					NULL, bluetooth_disconnect, NULL, NULL);
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 1cb950b..552ad18 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -37,7 +37,8 @@ struct bluetooth_profile {
 	void (*set_alias)(const char *device, const char *);
 };
 =

-int bluetooth_register_uuid(struct bluetooth_profile *profile);
+int bluetooth_register_uuid(DBusConnection *conn,
+				struct bluetooth_profile *profile);
 void bluetooth_unregister_uuid(const char *uuid);
 =

 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
diff --git a/plugins/hfp.c b/plugins/hfp.c
index 76923f0..b934f3b 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -693,7 +693,7 @@ static int hfp_init()
 	if (err < 0)
 		return err;
 =

-	err =3D bluetooth_register_uuid(&hfp_profile);
+	err =3D bluetooth_register_uuid(connection, &hfp_profile);
 	if (err < 0) {
 		ofono_modem_driver_unregister(&hfp_driver);
 		return err;
-- =

1.7.1.1


--===============2631652935296497654==--

