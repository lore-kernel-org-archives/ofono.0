Content-Type: multipart/mixed; boundary="===============1105232561792165434=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 1/2] hfp_hf_bluez5: Improve Proxy property changed handling
Date: Wed, 30 Jan 2013 13:24:15 -0300
Message-ID: <1359563056-24294-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1105232561792165434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch removes unnecessary GDBusProxy object access when property
changed is triggered. The property name and the argument iterator is
informed in the function callback.
---
 plugins/hfp_hf_bluez5.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 2aabdd2..653829b 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -540,7 +540,6 @@ static void property_changed(GDBusProxy *proxy, const c=
har *name,
 {
 	const char *interface, *path, *alias;
 	struct ofono_modem *modem;
-	DBusMessageIter alias_iter;
 =

 	interface =3D g_dbus_proxy_get_interface(proxy);
 	path =3D g_dbus_proxy_get_path(proxy);
@@ -550,10 +549,10 @@ static void property_changed(GDBusProxy *proxy, const=
 char *name,
 	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
 		return;
 =

-	if (g_dbus_proxy_get_property(proxy, "Alias", &alias_iter) =3D=3D FALSE)
+	if (g_str_equal("Alias", name) =3D=3D FALSE)
 		return;
 =

-	dbus_message_iter_get_basic(&alias_iter, &alias);
+	dbus_message_iter_get_basic(iter, &alias);
 =

 	modem =3D g_hash_table_lookup(modem_hash, path);
 	if (modem =3D=3D NULL)
-- =

1.7.11.7


--===============1105232561792165434==--

