Content-Type: multipart/mixed; boundary="===============1638647101222471665=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2 2/3] hfp_hf: Handle ServicesResolved signal
Date: Fri, 28 Apr 2017 10:40:04 +0300
Message-ID: <20170428074005.22543-2-luiz.dentz@gmail.com>
In-Reply-To: <20170428074005.22543-1-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1638647101222471665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds handling for ServicesResolved signal which tells when BlueZ
is done resolving the device services so the code will no longer ignore
devices that got its services resolved after Paired signal.
---
 plugins/hfp_hf_bluez5.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index fb7cc3f..636fb88 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -555,9 +555,9 @@ static struct ofono_modem *modem_register_from_proxy(GD=
BusProxy *proxy,
 =

 	dbus_message_iter_get_basic(&iter, &paired);
 =

-	if (paired =3D=3D FALSE) {
-		modem =3D ofono_modem_find(device_path_compare, (void *) path);
+	modem =3D ofono_modem_find(device_path_compare, (void *) path);
 =

+	if (paired =3D=3D FALSE) {
 		if (modem !=3D NULL) {
 			ofono_modem_remove(modem);
 			g_dbus_proxy_set_removed_watch(proxy, NULL, NULL);
@@ -566,6 +566,9 @@ static struct ofono_modem *modem_register_from_proxy(GD=
BusProxy *proxy,
 		return NULL;
 	}
 =

+	if (modem)
+		return modem;
+
 	if (g_dbus_proxy_get_property(proxy, "UUIDs", &iter) =3D=3D FALSE)
 		return NULL;
 =

@@ -808,7 +811,8 @@ static void property_changed(GDBusProxy *proxy, const c=
har *name,
 	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
 		return;
 =

-	if (g_str_equal("Paired", name) !=3D TRUE)
+	if (g_str_equal("Paired", name) !=3D TRUE ||
+			g_str_equal("ServicesResolved", name) =3D=3D TRUE)
 		return;
 =

 	modem_register_from_proxy(proxy, path);
-- =

2.9.3


--===============1638647101222471665==--

