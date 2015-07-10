Content-Type: multipart/mixed; boundary="===============0178896993021224685=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH] hfp_hf_bluez5: Fix crash on repairing a Device.
Date: Fri, 10 Jul 2015 17:08:01 +0200
Message-ID: <1436540881-20121-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0178896993021224685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It may happen that a Device object is unpaired an paired again
without being removed from DBus. This in turn triggers second
modem object to be created, but not fully initialized.
If this modem object is used, oFono will crash.
---
 plugins/hfp_hf_bluez5.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 5ee70c5..713c789 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -738,8 +738,17 @@ static void modem_register_from_proxy(GDBusProxy *prox=
y, const char *path)
 		return;
 =

 	dbus_message_iter_get_basic(&iter, &paired);
-	if (paired =3D=3D FALSE)
+
+	if (paired =3D=3D FALSE) {
+		modem =3D ofono_modem_find(device_path_compare, (void *) path);
+
+		if (modem !=3D NULL) {
+			ofono_modem_remove(modem);
+			g_dbus_proxy_set_removed_watch(proxy, NULL, NULL);
+			g_dbus_proxy_set_property_watch(proxy, NULL, NULL);
+		}
 		return;
+	}
 =

 	if (g_dbus_proxy_get_property(proxy, "UUIDs", &iter) =3D=3D FALSE)
 		return;
-- =

1.7.11.7

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Prof. Dr. Hermann Eul
Chairperson of the Supervisory Board: Tiffany Doon Silva
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============0178896993021224685==--

