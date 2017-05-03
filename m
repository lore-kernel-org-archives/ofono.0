Content-Type: multipart/mixed; boundary="===============7219034572886388044=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v5 2/5] hfp_hf_bluez5: Fix not creating modem during
 NewConnection
Date: Wed, 03 May 2017 16:19:46 +0300
Message-ID: <20170503131949.11322-2-luiz.dentz@gmail.com>
In-Reply-To: <20170503131949.11322-1-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7219034572886388044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case the UUIDs are not updated, as they are still being resolved, when
Paired property changes a modem will never be registered.

In order to fix this problem allow modems to be registered directly
during NewConnection.
---
 plugins/hfp_hf_bluez5.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 5f23b7f..6e4e499 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -598,10 +598,18 @@ static DBusMessage *profile_new_connection(DBusConnec=
tion *conn,
 =

 	modem =3D ofono_modem_find(device_path_compare, (void *) device);
 	if (modem =3D=3D NULL) {
-		close(fd);
-		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+		GDBusProxy *proxy;
+
+		proxy =3D g_dbus_proxy_new(bluez, device, BLUEZ_DEVICE_INTERFACE);
+		modem =3D modem_register(device, proxy);
+		g_dbus_proxy_unref(proxy);
+
+		if (!modem) {
+			close(fd);
+			return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
 						".Rejected",
 						"Unknown Bluetooth device");
+		}
 	}
 =

 	err =3D service_level_connection(modem, fd, version);
-- =

2.9.3


--===============7219034572886388044==--

