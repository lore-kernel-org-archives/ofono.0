Content-Type: multipart/mixed; boundary="===============5479322726373366263=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 3/4] cdma-connman: Add public api definition
Date: Fri, 04 Nov 2011 16:28:06 +0100
Message-ID: <1320420487-16334-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1320420487-16334-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5479322726373366263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-connman.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 518fcb5..ba71c6e 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -548,6 +548,25 @@ void ofono_cdma_connman_driver_unregister(
 	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

+void ofono_cdma_connman_deactivated(struct ofono_cdma_connman *cm)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	ofono_bool_t value;
+	const char *path;
+
+	if (cm =3D=3D NULL)
+		return;
+
+	cdma_connman_settings_reset(cm);
+	cm->powered =3D FALSE;
+	value =3D cm->powered;
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


--===============5479322726373366263==--

