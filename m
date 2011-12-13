Content-Type: multipart/mixed; boundary="===============4958157675502594179=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0] ofono: Add support of CDMA modems
Date: Tue, 13 Dec 2011 15:40:37 +0100
Message-ID: <1323787237-8307-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323787237-8307-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4958157675502594179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.c |  356 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 files changed, 345 insertions(+), 11 deletions(-)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index aa9a776..c071558 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -51,6 +51,9 @@
 #define OFONO_CM_INTERFACE		OFONO_SERVICE ".ConnectionManager"
 #define OFONO_CONTEXT_INTERFACE		OFONO_SERVICE ".ConnectionContext"
 =

+#define OFONO_CDMA_CM_INTERFACE		OFONO_SERVICE ".cdma.ConnectionManager"
+#define OFONO_CDMA_NETREG_INTERFACE	OFONO_SERVICE ".cdma.NetworkRegistrati=
on"
+
 #define MODEM_ADDED			"ModemAdded"
 #define MODEM_REMOVED			"ModemRemoved"
 #define PROPERTY_CHANGED		"PropertyChanged"
@@ -68,6 +71,8 @@ enum ofono_api {
 	OFONO_API_SIM =3D		0x1,
 	OFONO_API_NETREG =3D	0x2,
 	OFONO_API_CM =3D		0x4,
+	OFONO_API_CDMA_NETREG =3D	0x8,
+	OFONO_API_CDMA_CM =3D	0x10,
 };
 =

 /*
@@ -121,6 +126,9 @@ struct modem_data {
 	connman_bool_t set_powered;
 	connman_bool_t set_online;
 =

+	/* CDMA ConnectionManager Interface */
+	connman_bool_t cdma_cm_powered;
+
 	/* ConnectionManager Interface */
 	connman_bool_t attached;
 	connman_bool_t cm_powered;
@@ -137,6 +145,7 @@ struct modem_data {
 	/* Netreg Interface */
 	char *name;
 	uint8_t strength;
+	uint8_t data_strength; /* 1xEVDO signal strength */
 	connman_bool_t roaming;
 =

 	/* pending calls */
@@ -506,6 +515,56 @@ static int context_set_inactive(struct modem_data *mod=
em)
 	return err;
 }
 =

+static void cdma_cm_set_powered_reply(struct modem_data *modem,
+					connman_bool_t success)
+{
+	DBG("%s", modem->path);
+
+	if (success =3D=3D TRUE) {
+		/*
+		 * Don't handle do anything on success here. oFono will send
+		 * the change via PropertyChanged singal.
+		 */
+		return;
+	}
+
+	/*
+	 * Powered =3D True might fail due a timeout. That means oFono
+	 * still tries to go online. If we retry to set Powered =3D True,
+	 * we just get a InProgress error message. Should we power
+	 * cycle the modem in such cases?
+	 */
+
+	connman_network_set_error(modem->network,
+				CONNMAN_NETWORK_ERROR_ASSOCIATE_FAIL);
+}
+
+static int cdma_cm_set_powered(struct modem_data *modem)
+{
+	dbus_bool_t powered =3D TRUE;
+
+	DBG("%s", modem->path);
+
+	return set_property(modem, modem->path, OFONO_CDMA_CM_INTERFACE,
+				"Powered", DBUS_TYPE_BOOLEAN, &powered,
+				cdma_cm_set_powered_reply);
+}
+
+static int cdma_cm_shutdown(struct modem_data *modem)
+{
+	dbus_bool_t powered =3D FALSE;
+	int err;
+
+	DBG("%s", modem->path);
+
+	err =3D set_property(modem, modem->path, OFONO_CDMA_CM_INTERFACE,
+				"Powered", DBUS_TYPE_BOOLEAN, &powered, NULL);
+	if (err =3D=3D -EINPROGRESS)
+		return 0;
+
+	return err;
+}
+
 static void modem_set_online_reply(struct modem_data *modem,
 					connman_bool_t success)
 {
@@ -617,6 +676,12 @@ static uint8_t extract_interfaces(DBusMessageIter *arr=
ay)
 			interfaces |=3D OFONO_API_NETREG;
 		else if (g_str_equal(name, OFONO_CM_INTERFACE) =3D=3D TRUE)
 			interfaces |=3D OFONO_API_CM;
+		else if (g_str_equal(name,
+				OFONO_CDMA_CM_INTERFACE) =3D=3D TRUE)
+			interfaces |=3D OFONO_API_CDMA_CM;
+		else if (g_str_equal(name,
+				OFONO_CDMA_NETREG_INTERFACE) =3D=3D TRUE)
+			interfaces |=3D OFONO_API_CDMA_NETREG;
 =

 		dbus_message_iter_next(&entry);
 	}
@@ -1258,6 +1323,15 @@ static void netreg_update_strength(struct modem_data=
 *modem,
 	connman_network_update(modem->network);
 }
 =

+/* Retrieve 1xEVDO signal strength */
+static void netreg_update_datastrength(struct modem_data *modem,
+					DBusMessageIter *value)
+{
+	dbus_message_iter_get_basic(value, &modem->data_strength);
+
+	DBG("%s Data Strength %d", modem->path, modem->data_strength);
+}
+
 static void netreg_update_roaming(struct modem_data *modem,
 					DBusMessageIter *value)
 {
@@ -1366,6 +1440,101 @@ static int netreg_get_properties(struct modem_data =
*modem)
 			netreg_properties_reply, modem);
 }
 =

+static void add_cdma_network(struct modem_data *modem)
+{
+	/* Be sure that device is created before adding CDMA network */
+	if (modem->device =3D=3D NULL)
+		return;
+
+	/*
+	 * CDMA modems don't need contexts for data call, however the current
+	 * add_network() logic needs one, so we create one to proceed.
+	 */
+	if (modem->context =3D=3D NULL)
+		modem->context =3D network_context_alloc(modem->path);
+
+	add_network(modem);
+
+	if (modem->cdma_cm_powered =3D=3D TRUE)
+		set_connected(modem);
+}
+
+static gboolean cdma_netreg_changed(DBusConnection *connection,
+					DBusMessage *message,
+					void *user_data)
+{
+	const char *path =3D dbus_message_get_path(message);
+	struct modem_data *modem;
+	DBusMessageIter iter, value;
+	const char *key;
+
+	DBG("");
+
+	modem =3D g_hash_table_lookup(modem_hash, path);
+	if (modem =3D=3D NULL)
+		return TRUE;
+
+	if (modem->ignore =3D=3D TRUE)
+		return TRUE;
+
+	if (dbus_message_iter_init(message, &iter) =3D=3D FALSE)
+		return TRUE;
+
+	dbus_message_iter_get_basic(&iter, &key);
+
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_recurse(&iter, &value);
+
+	if (g_str_equal(key, "Name") =3D=3D TRUE)
+		netreg_update_name(modem, &value);
+	else if (g_str_equal(key, "Strength") =3D=3D TRUE)
+		netreg_update_strength(modem, &value);
+	else if (g_str_equal(key, "DataStrength") =3D=3D TRUE)
+		netreg_update_datastrength(modem, &value);
+	else if (g_str_equal(key, "Status") =3D=3D TRUE)
+		netreg_update_roaming(modem, &value);
+
+	add_cdma_network(modem);
+
+	return TRUE;
+}
+
+static void cdma_netreg_properties_reply(struct modem_data *modem,
+					DBusMessageIter *dict)
+{
+	DBG("%s", modem->path);
+
+	while (dbus_message_iter_get_arg_type(dict) =3D=3D DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter entry, value;
+		const char *key;
+
+		dbus_message_iter_recurse(dict, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (g_str_equal(key, "Name") =3D=3D TRUE)
+			netreg_update_name(modem, &value);
+		else if (g_str_equal(key, "Strength") =3D=3D TRUE)
+			netreg_update_strength(modem, &value);
+		else if (g_str_equal(key, "DataStrength") =3D=3D TRUE)
+			netreg_update_datastrength(modem, &value);
+		else if (g_str_equal(key, "Status") =3D=3D TRUE)
+			netreg_update_roaming(modem, &value);
+
+		dbus_message_iter_next(dict);
+	}
+
+	add_cdma_network(modem);
+}
+
+static int cdma_netreg_get_properties(struct modem_data *modem)
+{
+	return get_properties(modem->path, OFONO_CDMA_NETREG_INTERFACE,
+			cdma_netreg_properties_reply, modem);
+}
+
 static void cm_update_attached(struct modem_data *modem,
 				DBusMessageIter *value)
 {
@@ -1429,6 +1598,51 @@ static gboolean cm_changed(DBusConnection *connectio=
n, DBusMessage *message,
 	return TRUE;
 }
 =

+static gboolean cdma_cm_changed(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	const char *path =3D dbus_message_get_path(message);
+	struct modem_data *modem;
+	DBusMessageIter iter, value;
+	const char *key;
+
+	modem =3D g_hash_table_lookup(modem_hash, path);
+	if (modem =3D=3D NULL)
+		return TRUE;
+
+	if (modem->online =3D=3D TRUE && modem->network =3D=3D NULL)
+		cdma_netreg_get_properties(modem);
+
+	if (dbus_message_iter_init(message, &iter) =3D=3D FALSE)
+		return TRUE;
+
+	dbus_message_iter_get_basic(&iter, &key);
+
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_recurse(&iter, &value);
+
+	if (g_str_equal(key, "Powered") =3D=3D TRUE) {
+		dbus_message_iter_get_basic(&value, &modem->cdma_cm_powered);
+
+		DBG("%s CDMA cm Powered %d", modem->path,
+						modem->cdma_cm_powered);
+
+		if (modem->network !=3D NULL) {
+			if (modem->cdma_cm_powered =3D=3D TRUE)
+				set_connected(modem);
+			else
+				set_disconnected(modem);
+		}
+	} if (g_str_equal(key, "Settings") =3D=3D TRUE) {
+		DBG("%s Settings", modem->path);
+
+		if (modem->context !=3D NULL)
+			extract_ipv4_settings(&value, modem->context);
+	}
+
+	return TRUE;
+}
+
 static void cm_properties_reply(struct modem_data *modem, DBusMessageIter =
*dict)
 {
 	DBG("%s", modem->path);
@@ -1458,6 +1672,55 @@ static int cm_get_properties(struct modem_data *mode=
m)
 				cm_properties_reply, modem);
 }
 =

+static void cdma_cm_properties_reply(struct modem_data *modem,
+					DBusMessageIter *dict)
+{
+	DBG("%s", modem->path);
+
+	if (modem->online =3D=3D TRUE)
+		cdma_netreg_get_properties(modem);
+
+	while (dbus_message_iter_get_arg_type(dict) =3D=3D DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter entry, value;
+		const char *key;
+
+		dbus_message_iter_recurse(dict, &entry);
+		dbus_message_iter_get_basic(&entry, &key);;
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (g_str_equal(key, "Powered") =3D=3D TRUE) {
+			dbus_message_iter_get_basic(&value,
+						&modem->cdma_cm_powered);
+
+			DBG("%s Powered %d", modem->path,
+						modem->cdma_cm_powered);
+
+			if (modem->network !=3D NULL) {
+				if (modem->cdma_cm_powered =3D=3D TRUE)
+					set_connected(modem);
+				else
+					set_disconnected(modem);
+			}
+		} if (g_str_equal(key, "Settings") =3D=3D TRUE) {
+
+			DBG("%s Settings", modem->path);
+
+			if (modem->context !=3D NULL)
+				extract_ipv4_settings(&value, modem->context);
+		}
+
+		dbus_message_iter_next(dict);
+	}
+}
+
+static int cdma_cm_get_properties(struct modem_data *modem)
+{
+	return get_properties(modem->path, OFONO_CDMA_CM_INTERFACE,
+				cdma_cm_properties_reply, modem);
+}
+
 static void update_sim_imsi(struct modem_data *modem,
 				const char *imsi)
 {
@@ -1506,6 +1769,10 @@ static gboolean sim_changed(DBusConnection *connecti=
on, DBusMessage *message,
 						OFONO_API_CM) =3D=3D TRUE) {
 			if (ready_to_create_device(modem) =3D=3D TRUE)
 				create_device(modem);
+		} else if (has_interface(modem->interfaces,
+						OFONO_API_CDMA_CM) =3D=3D TRUE) {
+			if (ready_to_create_device(modem) =3D=3D TRUE)
+				create_device(modem);
 		}
 	}
 =

@@ -1546,6 +1813,12 @@ static void sim_properties_reply(struct modem_data *=
modem,
 					cm_get_properties(modem);
 					cm_get_contexts(modem);
 				}
+			} else if (has_interface(modem->interfaces,
+					OFONO_API_CDMA_CM) =3D=3D TRUE) {
+				if (ready_to_create_device(modem) =3D=3D TRUE)
+					create_device(modem);
+				if (modem->device !=3D NULL)
+					cdma_cm_get_properties(modem);
 			}
 			return;
 		}
@@ -1598,13 +1871,21 @@ static gboolean modem_changed(DBusConnection *conne=
ction, DBusMessage *message,
 		if (modem->online =3D=3D FALSE)
 			return TRUE;
 =

-		if (has_interface(modem->interfaces, OFONO_API_CM) =3D=3D FALSE)
-			return TRUE;
-		if (ready_to_create_device(modem) =3D=3D TRUE)
-			create_device(modem);
-		if (modem->device !=3D NULL) {
-			cm_get_properties(modem);
-			cm_get_contexts(modem);
+		if (has_interface(modem->interfaces, OFONO_API_CM) =3D=3D FALSE) {
+			if (ready_to_create_device(modem) =3D=3D TRUE)
+				create_device(modem);
+			if (modem->device !=3D NULL) {
+				cm_get_properties(modem);
+				cm_get_contexts(modem);
+			}
+		} else if (has_interface(modem->interfaces,
+						OFONO_API_CDMA_CM) =3D=3D TRUE) {
+			if (ready_to_create_device(modem) =3D=3D TRUE)
+				create_device(modem);
+			if (modem->device !=3D NULL) {
+				cdma_cm_get_properties(modem);
+				cdma_netreg_get_properties(modem);
+			}
 		}
 	} else if (g_str_equal(key, "Interfaces") =3D=3D TRUE) {
 		modem->interfaces =3D extract_interfaces(&value);
@@ -1632,6 +1913,12 @@ static gboolean modem_changed(DBusConnection *connec=
tion, DBusMessage *message,
 				cm_get_contexts(modem);
 				return TRUE;
 			}
+		} else if (has_interface(modem->interfaces,
+					OFONO_API_CDMA_CM) =3D=3D TRUE) {
+				if (ready_to_create_device(modem) =3D=3D TRUE)
+					create_device(modem);
+				if (modem->device !=3D NULL)
+					cdma_cm_get_properties(modem);
 		} else {
 			if (modem->context !=3D NULL) {
 				remove_cm_context(modem,
@@ -1647,7 +1934,9 @@ static gboolean modem_changed(DBusConnection *connect=
ion, DBusMessage *message,
 		if (has_interface(modem->interfaces, OFONO_API_NETREG) =3D=3D TRUE) {
 			if (modem->attached =3D=3D TRUE)
 				netreg_get_properties(modem);
-		}
+		} else if (has_interface(modem->interfaces,
+				OFONO_API_CDMA_NETREG) =3D=3D TRUE)
+			cdma_netreg_get_properties(modem);
 	} else if (g_str_equal(key, "Serial") =3D=3D TRUE) {
 		char *serial;
 =

@@ -1665,6 +1954,12 @@ static gboolean modem_changed(DBusConnection *connec=
tion, DBusMessage *message,
 				cm_get_properties(modem);
 				cm_get_contexts(modem);
 			}
+		} else if (has_interface(modem->interfaces, OFONO_API_CDMA_CM)
+				=3D=3D TRUE) {
+			if (ready_to_create_device(modem) =3D=3D TRUE)
+				create_device(modem);
+			if (modem->device !=3D NULL)
+				cdma_cm_get_properties(modem);
 		}
 	}
 =

@@ -1754,6 +2049,12 @@ static void add_modem(const char *path, DBusMessageI=
ter *prop)
 			cm_get_properties(modem);
 			cm_get_contexts(modem);
 		}
+	} else if (has_interface(modem->interfaces, OFONO_API_CDMA_CM)
+			=3D=3D TRUE) {
+		if (ready_to_create_device(modem) =3D=3D TRUE)
+			create_device(modem);
+		if (modem->device !=3D NULL)
+			cdma_cm_get_properties(modem);
 	}
 }
 =

@@ -1969,7 +2270,14 @@ static int network_connect(struct connman_network *n=
etwork)
 =

 	DBG("%s network %p", modem->path, network);
 =

-	return context_set_active(modem);
+	if (has_interface(modem->interfaces, OFONO_API_CM) =3D=3D TRUE)
+		return context_set_active(modem);
+	else if (has_interface(modem->interfaces, OFONO_API_CDMA_CM) =3D=3D TRUE)
+		return cdma_cm_set_powered(modem);
+	else
+		connman_error("No connection manager interface available...");
+
+	return -ENOSYS;
 }
 =

 static int network_disconnect(struct connman_network *network)
@@ -1978,7 +2286,14 @@ static int network_disconnect(struct connman_network=
 *network)
 =

 	DBG("%s network %p", modem->path, network);
 =

-	return context_set_inactive(modem);
+	if (has_interface(modem->interfaces, OFONO_API_CM) =3D=3D TRUE)
+		return context_set_inactive(modem);
+	else if (has_interface(modem->interfaces, OFONO_API_CDMA_CM) =3D=3D TRUE)
+		return cdma_cm_shutdown(modem);
+	else
+		connman_error("No connection manager interface available...");
+
+	return -ENOSYS;
 }
 =

 static struct connman_network_driver network_driver =3D {
@@ -2043,6 +2358,8 @@ static guint context_added_watch;
 static guint context_removed_watch;
 static guint netreg_watch;
 static guint context_watch;
+static guint cdma_cm_watch;
+static guint cdma_netreg_watch;
 =

 static int ofono_init(void)
 {
@@ -2112,12 +2429,25 @@ static int ofono_init(void)
 						netreg_changed,
 						NULL, NULL);
 =

+	cdma_cm_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						OFONO_CDMA_CM_INTERFACE,
+						PROPERTY_CHANGED,
+						cdma_cm_changed,
+						NULL, NULL);
+
+	cdma_netreg_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						OFONO_CDMA_NETREG_INTERFACE,
+						PROPERTY_CHANGED,
+						cdma_netreg_changed,
+						NULL, NULL);
+
 =

 	if (watch =3D=3D 0 || modem_added_watch =3D=3D 0 || modem_removed_watch =
=3D=3D 0 ||
 			modem_watch =3D=3D 0 || cm_watch =3D=3D 0 || sim_watch =3D=3D 0 ||
 			context_added_watch =3D=3D 0 ||
 			context_removed_watch =3D=3D 0 ||
-			context_watch =3D=3D 0 || netreg_watch =3D=3D 0) {
+			context_watch =3D=3D 0 || netreg_watch =3D=3D 0 ||
+			cdma_cm_watch =3D=3D 0 || cdma_netreg_watch =3D=3D 0) {
 		err =3D -EIO;
 		goto remove;
 	}
@@ -2135,6 +2465,8 @@ static int ofono_init(void)
 	return 0;
 =

 remove:
+	g_dbus_remove_watch(connection, cdma_netreg_watch);
+	g_dbus_remove_watch(connection, cdma_cm_watch);
 	g_dbus_remove_watch(connection, netreg_watch);
 	g_dbus_remove_watch(connection, context_watch);
 	g_dbus_remove_watch(connection, context_removed_watch);
@@ -2176,6 +2508,8 @@ static void ofono_exit(void)
 	connman_device_driver_unregister(&modem_driver);
 	connman_network_driver_unregister(&network_driver);
 =

+	g_dbus_remove_watch(connection, cdma_netreg_watch);
+	g_dbus_remove_watch(connection, cdma_cm_watch);
 	g_dbus_remove_watch(connection, netreg_watch);
 	g_dbus_remove_watch(connection, context_watch);
 	g_dbus_remove_watch(connection, context_removed_watch);
-- =

1.7.1


--===============4958157675502594179==--

