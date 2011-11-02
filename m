Content-Type: multipart/mixed; boundary="===============6665900905072890850=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 5/6] cdma-connman: Add public api definition
Date: Wed, 02 Nov 2011 11:38:00 +0100
Message-ID: <1320230281-20743-6-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1320230281-20743-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6665900905072890850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-connman.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 42dcca2..f88353a 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -562,6 +562,24 @@ void ofono_cdma_connman_driver_unregister(
 	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

+void ofono_cdma_connman_deactivated(struct ofono_cdma_connman *cm)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	dbus_bool_t value;
+
+	if (cm =3D=3D NULL)
+		return;
+
+	cdma_connman_settings_reset(cm);
+	value =3D FALSE;
+	path =3D __ofono_atom_get_path(cm->atom);
+
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE,
+				"Powered", DBUS_TYPE_BOOLEAN, &value);
+}
+
 static void cdma_connman_unregister(struct ofono_atom *atom)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
-- =

1.7.1


--===============6665900905072890850==--

