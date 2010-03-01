Content-Type: multipart/mixed; boundary="===============5328213647929807070=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 4/4] Make sure watches only receive signal from BlueZ service
Date: Mon, 01 Mar 2010 18:10:41 +0200
Message-ID: <2d5a2c101003010810v33d26876p4133e5b7c364a792@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5328213647929807070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index e37c9fc..7a40d99 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -1125,17 +1125,17 @@ static int hfp_init()
 	bluetooth_exit_watch =3D g_dbus_add_service_watch(connection, BLUEZ_SERVI=
CE,
 			NULL, bluetooth_disconnect, NULL, NULL);

-	adapter_added_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+	adapter_added_watch =3D g_dbus_add_signal_watch(connection, BLUEZ_SERVICE=
, NULL,
 						BLUEZ_MANAGER_INTERFACE,
 						"AdapterAdded",
 						adapter_added, NULL, NULL);

-	adapter_removed_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+	adapter_removed_watch =3D g_dbus_add_signal_watch(connection,
BLUEZ_SERVICE, NULL,
 						BLUEZ_MANAGER_INTERFACE,
 						"AdapterRemoved",
 						adapter_removed, NULL, NULL);

-	uuid_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+	uuid_watch =3D g_dbus_add_signal_watch(connection, BLUEZ_SERVICE, NULL,
 						BLUEZ_DEVICE_INTERFACE,
 						"PropertyChanged",
 						property_changed, NULL, NULL);
-- =

1.6.3.3


-- =

Luiz Augusto von Dentz
Computer Engineer

--===============5328213647929807070==--

