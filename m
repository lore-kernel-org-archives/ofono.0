Content-Type: multipart/mixed; boundary="===============5891933115162717548=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 3/6] coex: Added coex atom implementation
Date: Mon, 01 Oct 2018 16:04:07 +0530
Message-ID: <1538390047-6260-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5891933115162717548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara <antara.borwankar@intel.com>

Adding src/coex.c which implements the generic coex atom
---
 src/coex.c | 843 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 843 insertions(+)
 create mode 100644 src/coex.c

diff --git a/src/coex.c b/src/coex.c
new file mode 100644
index 0000000..a5fea91
--- /dev/null
+++ b/src/coex.c
@@ -0,0 +1,843 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+
+#include <glib.h>
+#include <gdbus.h>
+#include <errno.h>
+#include <time.h>
+#include <sys/time.h>
+
+#include "ofono.h"
+
+#include "common.h"
+#include "util.h"
+#include "coexagent.h"
+#include "storage.h"
+
+#define SETTINGS_GROUP "Settings"
+#define SETTINGS_STORE "coex"
+#define MAX_LTE_BAND_SIZE 16
+static GSList *g_drivers =3D NULL;
+
+struct ofono_coex {
+	const struct ofono_coex_driver *driver;
+	void* driver_data;
+	struct ofono_atom *atom;
+	DBusMessage *pending;
+	ofono_bool_t coex_bt_active;
+	ofono_bool_t coex_wlan_active;
+	enum ofono_wlan_bw coex_wlan_bw;
+	char* lte_band;
+
+	ofono_bool_t pending_coex_bt_active;
+	ofono_bool_t pending_coex_wlan_active;
+	enum ofono_wlan_bw pending_coex_wlan_bw;
+	ofono_bool_t lte_active;
+
+	GKeyFile *settings;
+	char *imsi;
+
+	struct coex_agent *session_agent;
+};
+
+const char *ofono_wlan_bw_to_string(int band);
+static gboolean coex_wlan_bw_from_string(const char *str,
+					enum ofono_wlan_bw *band);
+
+static void coex_remove_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct ofono_coex *coex =3D data;
+
+	DBG("");
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("COEX enable failure");
+		ofono_coex_remove(coex);
+		return;
+	}
+}
+
+static void coex_remove(struct ofono_atom *atom)
+{
+	struct ofono_coex *coex =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (coex =3D=3D NULL)
+		return;
+
+	if (coex->driver && coex->driver->remove)
+		coex->driver->remove(coex, coex_remove_callback, coex);
+
+	g_free(coex);
+}
+
+struct ofono_coex *ofono_coex_create(struct ofono_modem *modem,
+				unsigned int vendor,
+				const char *driver,
+				void *data)
+{
+	struct ofono_coex *coex;
+	GSList *l;
+
+	DBG("");
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	coex =3D g_try_new0(struct ofono_coex, 1);
+
+	if (coex =3D=3D NULL)
+		return NULL;
+
+	coex->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_COEX,
+						coex_remove, coex);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_coex_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(coex, vendor, data) < 0)
+			continue;
+
+		coex->driver =3D drv;
+		break;
+	}
+
+	return coex;
+}
+
+int ofono_coex_driver_register(const struct ofono_coex_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
+
+	return 0;
+}
+
+const char *ofono_wlan_bw_to_string(int band)
+{
+	switch (band) {
+	case OFONO_WLAN_BW_20MHZ:
+		return "20MHz";
+	case OFONO_WLAN_BW_40MHZ:
+		return "40MHz";
+	case OFONO_WLAN_BW_80MHZ:
+		return "80MHz";
+	case OFONO_WLAN_BW_UNSUPPORTED:
+		return "UnSupported";
+	}
+
+	return "";
+}
+
+static DBusMessage *coex_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_coex *coex =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	dbus_bool_t value;
+	const char *band =3D NULL;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	value =3D coex->coex_bt_active;
+	ofono_dbus_dict_append(&dict, "CoexBTActive",
+			DBUS_TYPE_BOOLEAN, &value);
+
+	value =3D coex->coex_wlan_active;
+	ofono_dbus_dict_append(&dict, "CoexWLANActive",DBUS_TYPE_BOOLEAN, &value);
+
+	band =3D ofono_wlan_bw_to_string(coex->coex_wlan_bw);
+	ofono_dbus_dict_append(&dict, "CoexWLANBandwidth",DBUS_TYPE_STRING, &band=
);
+
+	band =3D coex->lte_band;
+	ofono_dbus_dict_append(&dict, "LTEBand",DBUS_TYPE_STRING, &band);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static void coex_set_bt_active(struct ofono_coex *coex)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+
+	DBG("");
+	path =3D __ofono_atom_get_path(coex->atom);
+
+	if (coex->coex_bt_active!=3D coex->pending_coex_bt_active) {
+		coex->coex_bt_active =3D coex->pending_coex_bt_active;
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_COEX_INTERFACE,
+						"CoexBTActive",
+						DBUS_TYPE_BOOLEAN,
+						&(coex->coex_bt_active));
+
+		if (coex->settings) {
+			g_key_file_set_boolean(coex->settings,
+					SETTINGS_GROUP,
+					"CoexBTActive",
+					coex->coex_bt_active);
+			storage_sync(coex->imsi,
+				SETTINGS_STORE, coex->settings);
+		}
+	}
+}
+
+static void coex_set_bt_active_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct ofono_coex *coex =3D data;
+	DBusMessage *reply;
+
+	DBG("");
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error setting radio frequency band");
+
+		coex->pending_coex_bt_active =3D coex->coex_bt_active;
+
+		reply =3D __ofono_error_failed(coex->pending);
+		__ofono_dbus_pending_reply(&coex->pending, reply);
+
+		return;
+	}
+
+	reply =3D dbus_message_new_method_return(coex->pending);
+	__ofono_dbus_pending_reply(&coex->pending, reply);
+
+	coex_set_bt_active(coex);
+}
+
+static void coex_set_wlan_active(struct ofono_coex *coex)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	const char *str_band;
+
+	DBG("");
+	path =3D __ofono_atom_get_path(coex->atom);
+
+	if (coex->coex_wlan_active!=3D coex->pending_coex_wlan_active) {
+		coex->coex_wlan_active =3D coex->pending_coex_wlan_active;
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_COEX_INTERFACE,
+						"CoexWLANActive",
+						DBUS_TYPE_BOOLEAN,
+						&(coex->coex_wlan_active));
+
+		if (coex->settings) {
+			g_key_file_set_boolean(coex->settings,
+					SETTINGS_GROUP,
+					"CoexWLANActive",
+					coex->coex_wlan_active);
+			storage_sync(coex->imsi,
+				SETTINGS_STORE, coex->settings);
+		}
+	}
+
+	if (coex->coex_wlan_bw !=3D coex->pending_coex_wlan_bw) {
+		coex->coex_wlan_bw =3D coex->pending_coex_wlan_bw;
+		str_band =3D ofono_wlan_bw_to_string(coex->coex_wlan_bw);
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_COEX_INTERFACE,
+						"CoexWLANBandwidth",
+						DBUS_TYPE_STRING,
+						&str_band);
+
+		if (coex->settings) {
+			g_key_file_set_integer(coex->settings,
+					SETTINGS_GROUP,
+					"CoexWLANBandwidth",
+					coex->coex_wlan_bw);
+			storage_sync(coex->imsi,
+				SETTINGS_STORE, coex->settings);
+		}
+	}
+}
+
+static void coex_set_wlan_active_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct ofono_coex *coex =3D data;
+	DBusMessage *reply;
+
+	DBG("");
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error setting radio frequency band");
+
+		coex->pending_coex_wlan_active =3D coex->coex_wlan_active;
+		coex->pending_coex_wlan_bw =3D coex->coex_wlan_bw;
+
+		reply =3D __ofono_error_failed(coex->pending);
+		__ofono_dbus_pending_reply(&coex->pending, reply);
+
+		return;
+	}
+
+	reply =3D dbus_message_new_method_return(coex->pending);
+	__ofono_dbus_pending_reply(&coex->pending, reply);
+
+	coex_set_wlan_active(coex);
+}
+
+static gboolean coex_wlan_bw_from_string(const char *str,
+				enum ofono_wlan_bw *band)
+{
+	if (g_str_equal(str, "20")) {
+		*band =3D OFONO_WLAN_BW_20MHZ;
+		return TRUE;
+	} else if (g_str_equal(str, "40")) {
+		*band =3D OFONO_WLAN_BW_40MHZ;
+		return TRUE;
+	} else if (g_str_equal(str, "80")) {
+		*band =3D OFONO_WLAN_BW_80MHZ;
+		return TRUE;
+	} else
+		*band =3D OFONO_WLAN_BW_UNSUPPORTED;
+
+	return TRUE;
+}
+
+static DBusMessage *coex_set_property(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct ofono_coex *coex =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+	dbus_bool_t value;
+
+	if (coex->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (!strcmp(property, "CoexBTActive")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if (coex->coex_bt_active =3D=3D (ofono_bool_t) value)
+			return dbus_message_new_method_return(msg);
+
+		coex->pending_coex_bt_active =3D value;
+		coex->pending =3D dbus_message_ref(msg);
+
+		coex->driver->set_bt_active(coex, value,
+					coex_set_bt_active_callback, coex);
+		return NULL;
+	} else if (!strcmp(property, "CoexWLANActive")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if (coex->coex_wlan_active =3D=3D (ofono_bool_t) value)
+			return dbus_message_new_method_return(msg);
+
+		coex->pending_coex_wlan_active =3D value;
+		coex->pending =3D dbus_message_ref(msg);
+
+		coex->driver->set_wlan_active(coex, value, coex->coex_wlan_bw,
+					coex_set_wlan_active_callback, coex);
+		return NULL;
+	} else if (g_strcmp0(property, "CoexWLANBandwidth") =3D=3D 0) {
+		const char *value;
+		enum ofono_wlan_bw band;
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+		if (coex_wlan_bw_from_string(value, &band) =3D=3D FALSE)
+			return __ofono_error_invalid_args(msg);
+
+		if (coex->coex_wlan_bw =3D=3D band)
+			return dbus_message_new_method_return(msg);
+
+		coex->pending_coex_wlan_bw =3D band;
+		coex->pending =3D dbus_message_ref(msg);
+
+		coex->driver->set_wlan_active(coex, coex->coex_wlan_active,
+					 band, coex_set_wlan_active_callback,
+					 coex);
+		return NULL;
+	} else {
+		return __ofono_error_invalid_args(msg);
+	}
+
+	return dbus_message_new_method_return(msg);
+}
+
+
+static void coex_default_agent_notify(gpointer user_data)
+{
+	struct ofono_coex *coex =3D user_data;
+	coex->session_agent =3D NULL;
+}
+
+static void coex_enable_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct ofono_coex *coex =3D data;
+
+	DBG("");
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("COEX enable failure");
+		ofono_coex_remove(coex);
+		return;
+	}
+}
+
+static DBusMessage *coex_register_agent(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct ofono_coex *coex =3D data;
+	const char *agent_path;
+
+	if (dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_OBJECT_PATH, &agent_path,
+				DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (!dbus_validate_path(agent_path, NULL))
+		return __ofono_error_invalid_format(msg);
+
+	coex->session_agent =3D coex_agent_new(agent_path,
+					dbus_message_get_sender(msg),
+					FALSE);
+	if (coex->session_agent =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	coex_agent_set_removed_notify(coex->session_agent,
+				coex_default_agent_notify, coex);
+
+	if(coex->driver->enable) {
+		DBG("calling coex enable");
+		coex->driver->enable(coex, coex_enable_callback, coex);
+	}
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *coex_unregister_agent(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_coex *coex =3D data;
+	const char *agent_path;
+	const char *agent_bus =3D dbus_message_get_sender(msg);
+
+	if (dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (coex->session_agent =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	if (!coex_agent_matches(coex->session_agent, agent_path, agent_bus))
+		return __ofono_error_failed(msg);
+
+	coex_agent_send_release(coex->session_agent);
+	coex_agent_free(coex->session_agent);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static void append_plmn_properties(struct Plmnhist *list,
+					DBusMessageIter *dict)
+{
+	ofono_dbus_dict_append(dict, "MobileCountryCode",
+			DBUS_TYPE_UINT16, &list->mcc);
+	ofono_dbus_dict_append(dict, "MobileNetworkCode",
+			DBUS_TYPE_UINT16, &list->mnc);
+	ofono_dbus_dict_append(dict, "LteBandsFDD",
+			DBUS_TYPE_UINT32, &list->fdd);
+	ofono_dbus_dict_append(dict, "LteBandsTDD",
+			DBUS_TYPE_UINT32, &list->tdd);
+	ofono_dbus_dict_append(dict, "ChannelBandwidth",
+			DBUS_TYPE_UINT32, &list->bw);
+}
+
+static void append_plmn_history_struct_list(struct Plmnhist *list,
+					DBusMessageIter *arr)
+{
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(arr, DBUS_TYPE_STRUCT, NULL, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	append_plmn_properties(list, &dict);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	dbus_message_iter_close_container(arr, &iter);
+}
+
+
+static void get_plmn_history_callback(const struct ofono_error *error,
+		int list_size,
+		struct Plmnhist *list,
+		void *data)
+{
+	struct ofono_coex *coex =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter arr;
+	int i;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		__ofono_dbus_pending_reply(&coex->pending,
+					__ofono_error_failed(coex->pending));
+		return;
+	} else {
+
+		reply =3D dbus_message_new_method_return(coex->pending);
+		if(reply =3D=3D NULL)
+			return;
+
+		dbus_message_iter_init_append(reply, &iter);
+
+		dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_STRUCT_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+					DBUS_STRUCT_END_CHAR_AS_STRING,
+					&arr);
+
+		for(i=3D0;i<list_size;i++)
+			append_plmn_history_struct_list(list,&arr);
+
+		dbus_message_iter_close_container(&iter, &arr);
+	}
+
+	__ofono_dbus_pending_reply(&coex->pending, reply);
+	return;
+}
+
+static DBusMessage *coex_get_plmn_history(DBusConnection *conn,
+			DBusMessage *msg, void *data)
+{
+	struct ofono_coex *coex =3D data;
+
+	if (!coex->driver && !coex->driver->get_plmn_history)
+		return __ofono_error_not_implemented(msg);
+
+	if (coex->pending)
+		return __ofono_error_busy(msg);
+
+	coex->pending =3D dbus_message_ref(msg);
+
+	coex->driver->get_plmn_history(coex,
+					get_plmn_history_callback, coex);
+	return NULL;
+}
+
+static const GDBusMethodTable coex_methods[] =3D {
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			coex_get_properties) },
+	{ GDBUS_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, coex_set_property) },
+	{ GDBUS_METHOD("RegisterAgent",
+			GDBUS_ARGS({ "path", "o" }), NULL,
+			coex_register_agent) },
+	{ GDBUS_METHOD("UnregisterAgent",
+			GDBUS_ARGS({ "path", "o" }), NULL,
+			coex_unregister_agent) },
+	{ GDBUS_ASYNC_METHOD("GetPlmnHistory",
+			NULL, GDBUS_ARGS({ "plmnhistory", "a(a{sv})" }),
+			coex_get_plmn_history) },
+	{ }
+};
+
+static const GDBusSignalTable coex_signals[] =3D {
+	{ GDBUS_SIGNAL("PropertyChanged",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
+};
+
+void ofono_coex_driver_unregister(const struct ofono_coex_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
+}
+
+static void coex_unregister(struct ofono_atom *atom)
+{
+	struct ofono_coex *coex =3D __ofono_atom_get_data(atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	if (coex->session_agent)
+		coex_agent_free(coex->session_agent);
+
+	if (coex->settings) {
+		storage_close(coex->imsi, SETTINGS_STORE,
+				coex->settings, TRUE);
+
+		g_free(coex->imsi);
+		coex->imsi =3D NULL;
+		coex->settings =3D NULL;
+	}
+
+	ofono_modem_remove_interface(modem, OFONO_COEX_INTERFACE);
+	g_dbus_unregister_interface(conn, path, OFONO_COEX_INTERFACE);
+}
+
+static void coex_load_settings(struct ofono_coex *coex, const char *imsi)
+{
+	GError *error;
+
+	coex->settings =3D storage_open(imsi, SETTINGS_STORE);
+
+	if (coex->settings =3D=3D NULL) {
+		DBG("radiosetting storage open failed");
+		coex->coex_bt_active =3D FALSE;
+		coex->coex_wlan_active =3D FALSE;
+		coex->coex_wlan_bw =3D OFONO_WLAN_BW_20MHZ;
+		return;
+	}
+
+	coex->imsi =3D g_strdup(imsi);
+
+	error =3D NULL;
+	coex->coex_bt_active =3D g_key_file_get_boolean(coex->settings,
+						SETTINGS_GROUP,
+						"CoexBTActive",
+						&error);
+
+	if (error) {
+		g_error_free(error);
+		coex->coex_bt_active =3D FALSE;
+		g_key_file_set_boolean(coex->settings,
+				SETTINGS_GROUP,
+				"CoexBTActive",
+				coex->coex_bt_active);
+	}
+
+	error =3D NULL;
+	coex->coex_wlan_active =3D g_key_file_get_boolean(coex->settings,
+						SETTINGS_GROUP,
+						"CoexWLANActive",
+						&error);
+
+	if (error) {
+		g_error_free(error);
+		coex->coex_wlan_active =3D FALSE;
+		g_key_file_set_boolean(coex->settings,
+				SETTINGS_GROUP,
+				"CoexWLANActive",
+				coex->coex_wlan_active);
+	}
+
+	error =3D NULL;
+	coex->coex_wlan_bw =3D g_key_file_get_boolean(coex->settings,
+						SETTINGS_GROUP,
+						"CoexWLANBandwidth",
+						&error);
+
+	if (error) {
+		g_error_free(error);
+		coex->coex_wlan_bw =3D OFONO_WLAN_BW_20MHZ;
+		g_key_file_set_integer(coex->settings,
+				 SETTINGS_GROUP,
+				"CoexWLANBandwidth",
+				coex->coex_wlan_bw);
+	}
+
+	g_free(coex->lte_band);
+	coex->lte_band =3D g_strdup("INVALID");
+
+	storage_sync(imsi, SETTINGS_STORE, coex->settings);
+}
+
+void ofono_coex_register(struct ofono_coex *coex)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(coex->atom);
+	const char *path =3D __ofono_atom_get_path(coex->atom);
+	struct ofono_sim *sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+
+	if (sim =3D=3D NULL)
+		return;
+
+	coex_load_settings(coex, ofono_sim_get_imsi(sim));
+
+	if (!g_dbus_register_interface(conn, path, OFONO_COEX_INTERFACE,
+					coex_methods, coex_signals, NULL,
+					coex, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_COEX_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_COEX_INTERFACE);
+
+	__ofono_atom_register(coex->atom, coex_unregister);
+}
+
+void ofono_coex_remove(struct ofono_coex *coex)
+{
+	__ofono_atom_free(coex->atom);
+}
+
+void ofono_coex_set_data(struct ofono_coex *coex, void *data)
+{
+	coex->driver_data =3D data;
+}
+
+void* ofono_coex_get_data(struct ofono_coex *coex)
+{
+	return coex->driver_data;
+}
+
+void ofono_coex_ril_lte_band_notify(struct ofono_coex *coex,
+				const char *band)
+{
+	const char *path =3D __ofono_atom_get_path(coex->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	DBG("band =3D %s",band);
+	if(!strcmp(band, coex->lte_band))
+		return;
+
+	g_free(coex->lte_band);
+	coex->lte_band =3D g_strdup(band);
+
+	if(coex->lte_band =3D=3D NULL)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_COEX_INTERFACE,
+				"LTEBand", DBUS_TYPE_STRING, &coex->lte_band);
+
+}
+
+void ofono_bt_coex_status_notify(struct ofono_coex* coex, int rx_min, int =
rx_max,
+				int tx_min, int tx_max, int num_vector, int *vector)
+{
+	struct bt_coex_info bt;
+	int count;
+
+	bt.safe_rx_min =3D rx_min;
+	bt.safe_rx_max =3D rx_max;
+	bt.safe_tx_min =3D tx_min;
+	bt.safe_tx_max =3D tx_max;
+	bt.num_safe_vector =3D num_vector;
+
+	for(count =3D 0 ; count < bt.num_safe_vector; count++) {
+		bt.safe_vector[count] =3D vector[count];
+	}
+
+	if (coex->session_agent) {
+		coex_agent_coex_bt_notify(coex->session_agent, bt,
+							FALSE, NULL, NULL);
+	}
+}
+
+void ofono_wlan_coex_status_notify(struct ofono_coex* coex, int rx_min, in=
t rx_max,
+				int tx_min, int tx_max, int num_vector, int *vector)
+{
+	struct wl_coex_info wlan;
+	int count;
+
+	wlan.safe_rx_min =3D rx_min;
+	wlan.safe_rx_max =3D rx_max;
+	wlan.safe_tx_min =3D tx_min;
+	wlan.safe_tx_max =3D tx_max;
+	wlan.num_safe_vector =3D num_vector;
+
+	for(count =3D 0 ; count < wlan.num_safe_vector; count++) {
+		wlan.safe_vector[count] =3D vector[count];
+	}
+
+	if (coex->session_agent) {
+		coex_agent_coex_wlan_notify(coex->session_agent, wlan,
+							FALSE, NULL, NULL);
+	}
+}
+
+struct ofono_modem *ofono_coex_get_modem(struct ofono_coex *coex)
+{
+	return __ofono_atom_get_modem(coex->atom);
+}
+
+void ofono_lte_coex_status_notify(struct ofono_coex *coex,
+								ofono_bool_t lte_active)
+{
+	coex->lte_active =3D lte_active;
+}
-- =

1.9.1


--===============5891933115162717548==--

