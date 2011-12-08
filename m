Content-Type: multipart/mixed; boundary="===============4544171588155641957=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v1 2/4] cdma-connman: Add dormant state notification API
 definition
Date: Thu, 08 Dec 2011 12:00:28 +0100
Message-ID: <1323342030-9175-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323342030-9175-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4544171588155641957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-connman.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 87cefd6..d796d9e 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -572,6 +572,23 @@ void ofono_cdma_connman_deactivated(struct ofono_cdma_=
connman *cm)
 				"Powered", DBUS_TYPE_BOOLEAN, &value);
 }
 =

+void ofono_cdma_connman_dormant_state_notify(struct ofono_cdma_connman *cm,
+						ofono_bool_t dormant)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+
+	if (cm =3D=3D NULL)
+		return;
+
+	cm->dormant =3D dormant;
+	path =3D __ofono_atom_get_path(cm->atom);
+
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE,
+				"Dormant", DBUS_TYPE_BOOLEAN, &dormant);
+}
+
 static void cdma_connman_unregister(struct ofono_atom *atom)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
-- =

1.7.1


--===============4544171588155641957==--

