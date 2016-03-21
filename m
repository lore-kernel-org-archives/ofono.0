Content-Type: multipart/mixed; boundary="===============0750069647842764707=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH] gprs: assume attached state when registered on LTE
Date: Mon, 21 Mar 2016 16:55:31 +0100
Message-ID: <1458575731-30914-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0750069647842764707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LTE doesn't really use the concept of an attached state. However,
the oFono API needs it. ConnMan needs it as well.
---
 src/gprs.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 9a85121..3acb412 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1585,12 +1585,27 @@ static void release_active_contexts(struct ofono_gp=
rs *gprs)
 	}
 }
 =

-static void gprs_attached_update(struct ofono_gprs *gprs)
+static void gprs_set_attached_property(struct ofono_gprs *gprs,
+					ofono_bool_t attached)
 {
-	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	dbus_bool_t value =3D attached;
+
+	if (gprs->attached =3D=3D attached)
+		return;
+
+	gprs->attached =3D attached;
+
+	path =3D __ofono_atom_get_path(gprs->atom);
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CONNECTION_MANAGER_INTERFACE,
+				"Attached", DBUS_TYPE_BOOLEAN, &value);
+}
+
+static void gprs_attached_update(struct ofono_gprs *gprs)
+{
 	ofono_bool_t attached;
-	dbus_bool_t value;
 =

 	attached =3D gprs->driver_attached &&
 		(gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
@@ -1613,13 +1628,7 @@ static void gprs_attached_update(struct ofono_gprs *=
gprs)
 		return;
 	}
 =

-	gprs->attached =3D attached;
-
-	path =3D __ofono_atom_get_path(gprs->atom);
-	value =3D attached;
-	ofono_dbus_signal_property_changed(conn, path,
-				OFONO_CONNECTION_MANAGER_INTERFACE,
-				"Attached", DBUS_TYPE_BOOLEAN, &value);
+	gprs_set_attached_property(gprs, attached);
 }
 =

 static void registration_status_cb(const struct ofono_error *error,
@@ -1690,6 +1699,13 @@ static void gprs_netreg_update(struct ofono_gprs *gp=
rs)
 =

 	DBG("attach: %u, driver_attached: %u", attach, gprs->driver_attached);
 =

+	if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
+			ACCESS_TECHNOLOGY_EUTRAN) {
+		/* Ignore attach logic for LTE. There is no such concept. */
+		gprs_set_attached_property(gprs, attach);
+		return;
+	}
+
 	if (gprs->driver_attached =3D=3D attach)
 		return;
 =

-- =

2.5.5


--===============0750069647842764707==--

