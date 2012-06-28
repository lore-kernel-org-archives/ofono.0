Content-Type: multipart/mixed; boundary="===============2524113694558783875=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/4] bluetooth: watch for signals only on BLUEZ_SERVICE
Date: Thu, 28 Jun 2012 10:59:19 -0300
Message-ID: <1340891961-9809-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1340891961-9809-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2524113694558783875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index cb5fe24..91c8d18 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -840,22 +840,25 @@ static void bluetooth_ref(void)
 					bluetooth_connect,
 					bluetooth_disconnect, NULL, NULL);
 =

-	adapter_added_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
-						BLUEZ_MANAGER_INTERFACE,
+	adapter_added_watch =3D g_dbus_add_signal_watch(connection, BLUEZ_SERVICE,
+						NULL, BLUEZ_MANAGER_INTERFACE,
 						"AdapterAdded",
 						adapter_added, NULL, NULL);
 =

-	adapter_removed_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+	adapter_removed_watch =3D g_dbus_add_signal_watch(connection,
+						BLUEZ_SERVICE, NULL,
 						BLUEZ_MANAGER_INTERFACE,
 						"AdapterRemoved",
 						adapter_removed, NULL, NULL);
 =

-	device_removed_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+	device_removed_watch =3D g_dbus_add_signal_watch(connection,
+						BLUEZ_SERVICE, NULL,
 						BLUEZ_ADAPTER_INTERFACE,
 						"DeviceRemoved",
 						device_removed, NULL, NULL);
 =

-	property_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+	property_watch =3D g_dbus_add_signal_watch(connection,
+						BLUEZ_SERVICE, NULL,
 						BLUEZ_DEVICE_INTERFACE,
 						"PropertyChanged",
 						property_changed, NULL, NULL);
-- =

1.7.11.1


--===============2524113694558783875==--

