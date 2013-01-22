Content-Type: multipart/mixed; boundary="===============1280999090277624075=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 04/10] hfp_hf_bluez5: Keep track of changes of devices Aliases
Date: Tue, 22 Jan 2013 18:43:19 -0300
Message-ID: <1358891005-24688-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358891005-24688-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1280999090277624075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the device Alias property changes we should also change the name of
the modem.
---
 plugins/hfp_hf_bluez5.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 35b9eb9..74ca570 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -285,12 +285,28 @@ static void proxy_removed(GDBusProxy *proxy, void *us=
er_data)
 static void property_changed(GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data)
 {
-	const char *interface, *path;
+	const char *interface, *path, *alias;
+	struct ofono_modem *modem;
+	DBusMessageIter alias_iter;
 =

 	interface =3D g_dbus_proxy_get_interface(proxy);
 	path =3D g_dbus_proxy_get_path(proxy);
 =

 	DBG("path: %s interface: %s", path, interface);
+
+	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
+		return;
+
+	if (g_dbus_proxy_get_property(proxy, "Alias", &alias_iter) =3D=3D FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&alias_iter, &alias);
+
+	modem =3D g_hash_table_lookup(modem_hash, path);
+	if (modem =3D=3D NULL)
+		return;
+
+	ofono_modem_set_name(modem, alias);
 }
 =

 static int hfp_init(void)
-- =

1.8.1.1


--===============1280999090277624075==--

