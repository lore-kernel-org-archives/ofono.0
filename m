Content-Type: multipart/mixed; boundary="===============1461116074725958561=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 3/3] cdma-connman: Add RoamingAllowed support
Date: Thu, 01 Dec 2011 17:40:34 +0100
Message-ID: <1322757634-18468-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1322757634-18468-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1461116074725958561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to use status watch in case we are registered to a network
and we pass into roaming status. We have to deactivate the data
call.
---
 src/cdma-connman.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 69 insertions(+), 1 deletions(-)

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 87cefd6..34c2d24 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -52,6 +52,10 @@ struct cdma_connman_settings {
 struct ofono_cdma_connman {
 	ofono_bool_t powered;
 	ofono_bool_t dormant;
+	ofono_bool_t roaming_allowed;
+	struct ofono_cdma_netreg *cdma_netreg;
+	unsigned int cdma_netreg_watch;
+	unsigned int status_watch;
 	struct cdma_connman_settings *settings;
 	DBusMessage *pending;
 	const struct ofono_cdma_connman_driver *driver;
@@ -354,8 +358,10 @@ static ofono_bool_t network_registered(struct ofono_cd=
ma_connman *cm)
 =

 	switch (status) {
 	case NETWORK_REGISTRATION_STATUS_REGISTERED:
-	case NETWORK_REGISTRATION_STATUS_ROAMING:
 		return TRUE;
+	case NETWORK_REGISTRATION_STATUS_ROAMING:
+		if (cm->roaming_allowed =3D=3D TRUE)
+			return TRUE;
 	default:
 		break;
 	}
@@ -390,6 +396,10 @@ static DBusMessage *cdma_connman_get_properties(DBusCo=
nnection *conn,
 	value =3D cm->dormant;
 	ofono_dbus_dict_append(&dict, "Dormant", DBUS_TYPE_BOOLEAN, &value);
 =

+	value =3D cm->roaming_allowed;
+	ofono_dbus_dict_append(&dict, "RoamingAllowed",
+				DBUS_TYPE_BOOLEAN, &value);
+
 	if (cm->settings)
 		cdma_connman_settings_append_properties(cm, &dict);
 =

@@ -512,6 +522,19 @@ static DBusMessage *cdma_connman_set_property(DBusConn=
ection *conn,
 =

 		dbus_message_iter_get_basic(&var, &str);
 		return cdma_connman_set_password(cm, conn, msg, str);
+	} else if (!strcmp(property, "RoamingAllowed")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if (cm->roaming_allowed =3D=3D (ofono_bool_t) value)
+			return dbus_message_new_method_return(msg);
+
+		cm->roaming_allowed =3D value;
+
+		if (network_registered(cm) =3D=3D FALSE && cm->powered =3D=3D TRUE)
+			cm->driver->deactivate(cm, deactivate_callback, cm);
 	}
 =

 	/* TODO: Dormant property. Not yet supported. */
@@ -575,11 +598,24 @@ void ofono_cdma_connman_deactivated(struct ofono_cdma=
_connman *cm)
 static void cdma_connman_unregister(struct ofono_atom *atom)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_cdma_connman *cm =3D __ofono_atom_get_data(atom);
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 	const char *path =3D __ofono_atom_get_path(atom);
 =

 	DBG("");
 =

+	if (cm->cdma_netreg_watch) {
+		if (cm->status_watch) {
+			__ofono_cdma_netreg_remove_status_watch(cm->cdma_netreg,
+							cm->status_watch);
+			cm->status_watch =3D 0;
+		}
+
+		__ofono_modem_remove_atom_watch(modem, cm->cdma_netreg_watch);
+		cm->cdma_netreg_watch =3D 0;
+		cm->cdma_netreg =3D NULL;
+	}
+
 	g_dbus_unregister_interface(conn, path,
 				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE);
 	ofono_modem_remove_interface(modem,
@@ -639,6 +675,34 @@ struct ofono_cdma_connman *ofono_cdma_connman_create(
 	return cm;
 }
 =

+static void cdma_netreg_status_changed(void *data)
+{
+	struct ofono_cdma_connman *cm =3D data;
+
+	DBG("");
+
+	if (network_registered(cm) =3D=3D FALSE && cm->powered =3D=3D TRUE)
+		cm->driver->deactivate(cm, deactivate_callback, cm);
+}
+
+static void cdma_netreg_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_cdma_connman *cm =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		cm->cdma_netreg =3D NULL;
+		return;
+	}
+
+	cm->cdma_netreg =3D __ofono_atom_get_data(atom);
+	cm->status_watch =3D __ofono_cdma_netreg_add_status_watch(
+					cm->cdma_netreg,
+					cdma_netreg_status_changed, cm,
+					NULL);
+}
+
 void ofono_cdma_connman_register(struct ofono_cdma_connman *cm)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -659,6 +723,10 @@ void ofono_cdma_connman_register(struct ofono_cdma_con=
nman *cm)
 	ofono_modem_add_interface(modem,
 				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE);
 =

+	cm->cdma_netreg_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_CDMA_NETREG,
+					cdma_netreg_watch, cm, NULL);
+
 	__ofono_atom_register(cm->atom, cdma_connman_unregister);
 }
 =

-- =

1.7.1


--===============1461116074725958561==--

