Content-Type: multipart/mixed; boundary="===============6893576717389950790=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/2] coex: coex agent implementation
Date: Tue, 23 Oct 2018 14:26:46 +0530
Message-ID: <1540285006-8430-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6893576717389950790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara <antara.borwankar@intel.com>

Added implementation for coex agent
---
 src/coexagent.c | 385 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/coexagent.h |  77 ++++++++++++
 src/ofono.conf  |   1 +
 3 files changed, 463 insertions(+)
 create mode 100644 src/coexagent.c
 create mode 100644 src/coexagent.h

diff --git a/src/coexagent.c b/src/coexagent.c
new file mode 100644
index 0000000..d2d6eac
--- /dev/null
+++ b/src/coexagent.c
@@ -0,0 +1,385 @@
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
+#include <stdint.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+
+#include "common.h"
+#include "coexagent.h"
+
+#define OFONO_COEX_AGENT_INTERFACE OFONO_SERVICE ".LTECoexAgent"
+#define OFONO_COEX_INTERFACE OFONO_SERVICE ".LTECoex"
+
+struct coex_agent {
+	char *path;
+	char *bus;
+	guint disconnect_watch;
+	ofono_bool_t remove_on_terminate;
+	ofono_destroy_func removed_cb;
+	void *removed_data;
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	void *user_data;
+	int min_length;
+	int max_length;
+	ofono_bool_t hidden_entry;
+	ofono_destroy_func user_destroy;
+};
+
+#define CALLBACK_END()						\
+done:								\
+	if (result =3D=3D COEX_AGENT_RESULT_TERMINATE &&		\
+			agent->remove_on_terminate)		\
+		remove_agent =3D TRUE;				\
+	else							\
+		remove_agent =3D FALSE;				\
+								\
+error:								\
+	coex_agent_request_end(agent);				\
+	dbus_message_unref(reply);				\
+								\
+	if (remove_agent)					\
+		coex_agent_free(agent)				\
+
+ofono_bool_t coex_agent_matches(struct coex_agent *agent,
+			const char *path, const char *sender)
+{
+	return !strcmp(agent->path, path) && !strcmp(agent->bus, sender);
+}
+
+static int check_error(struct coex_agent *agent, DBusMessage *reply,
+		enum coex_agent_result *out_result)
+{
+	DBusError err;
+	int result =3D 0;
+
+	dbus_error_init(&err);
+
+	if (dbus_set_error_from_message(&err, reply) =3D=3D FALSE) {
+		*out_result =3D COEX_AGENT_RESULT_OK;
+		return 0;
+	}
+
+	ofono_debug("CoexAgent %s replied with error %s, %s",
+			agent->path, err.name, err.message);
+
+	result =3D -EINVAL;
+
+	dbus_error_free(&err);
+	return result;
+}
+
+void coex_agent_set_removed_notify(struct coex_agent *agent,
+					ofono_destroy_func destroy,
+					void *user_data)
+{
+	agent->removed_cb =3D destroy;
+	agent->removed_data =3D user_data;
+}
+
+static void coex_agent_send_noreply(struct coex_agent *agent, const char *=
method)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessage *message;
+
+	message =3D dbus_message_new_method_call(agent->bus, agent->path,
+					OFONO_COEX_INTERFACE,
+					method);
+	if (message =3D=3D NULL)
+		return;
+
+	dbus_message_set_no_reply(message, TRUE);
+
+	g_dbus_send_message(conn, message);
+}
+
+void coex_agent_send_release(struct coex_agent *agent)
+{
+	coex_agent_send_noreply(agent, "Release");
+}
+
+static void coex_agent_request_end(struct coex_agent *agent)
+{
+	if (agent->msg) {
+		dbus_message_unref(agent->msg);
+		agent->msg =3D NULL;
+	}
+
+	if (agent->call) {
+		dbus_pending_call_unref(agent->call);
+		agent->call =3D NULL;
+	}
+
+	if (agent->user_destroy)
+		agent->user_destroy(agent->user_data);
+
+	agent->user_destroy =3D NULL;
+	agent->user_data =3D NULL;
+}
+
+void coex_agent_free(struct coex_agent *agent)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (agent->disconnect_watch) {
+		coex_agent_send_release(agent);
+
+		g_dbus_remove_watch(conn, agent->disconnect_watch);
+		agent->disconnect_watch =3D 0;
+	}
+
+	if (agent->removed_cb)
+		agent->removed_cb(agent->removed_data);
+
+	g_free(agent->path);
+	g_free(agent->bus);
+	g_free(agent);
+}
+
+static void coex_agent_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	struct coex_agent *agent =3D user_data;
+
+	ofono_debug("Agent exited without calling Unregister");
+
+	agent->disconnect_watch =3D 0;
+
+	coex_agent_free(agent);
+}
+
+struct coex_agent* coex_agent_new(const char *path, const char *sender,
+				ofono_bool_t remove_on_terminate)
+{
+	struct coex_agent* agent =3D g_try_new0(struct coex_agent, 1);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	DBG("");
+	if (agent =3D=3D NULL)
+		return NULL;
+
+	agent->path =3D g_strdup(path);
+	agent->bus =3D g_strdup(sender);
+
+	agent->remove_on_terminate =3D remove_on_terminate;
+
+	agent->disconnect_watch =3D g_dbus_add_disconnect_watch(conn, sender,
+							coex_agent_disconnect_cb,
+							agent, NULL);
+
+	return agent;
+}
+
+static void coex_agent_coex_wlan_notify_cb(DBusPendingCall *call, void *da=
ta)
+{
+	struct coex_agent *agent =3D data;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum coex_agent_result result;
+	gboolean remove_agent;
+
+	DBG("");
+	if (check_error(agent, reply, &result) =3D=3D -EINVAL) {
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	if (result !=3D COEX_AGENT_RESULT_OK) {
+		goto done;
+	}
+
+	if (dbus_message_get_args(reply, NULL, DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("Can't parse the reply to DisplayText()");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	CALLBACK_END();
+}
+
+int coex_agent_coex_wlan_notify(struct coex_agent *agent,
+			const struct wl_coex_info wlan_info,
+			ofono_bool_t urgent,
+			void *user_data, ofono_destroy_func destroy)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessageIter wl_args, wl_dict, wl_array;
+	const dbus_int32_t *pwl_array =3D wlan_info.safe_vector;
+	dbus_int32_t value;
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+						OFONO_COEX_AGENT_INTERFACE,
+						"ReceiveWiFiNotification");
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_iter_init_append(agent->msg, &wl_args);
+
+	dbus_message_iter_open_container(&wl_args, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_INT32_AS_STRING, &wl_array);
+	dbus_message_iter_append_fixed_array(&wl_array, DBUS_TYPE_INT32,
+					&pwl_array, MAX_WL_SAFE_VECTOR);
+
+	dbus_message_iter_close_container(&wl_args, &wl_array);
+
+	dbus_message_iter_open_container(&wl_args, DBUS_TYPE_ARRAY,
+							"{sv}", &wl_dict);
+
+	value =3D wlan_info.safe_tx_min;
+	ofono_dbus_dict_append(&wl_dict, "SafeTxMin",
+			 DBUS_TYPE_UINT32, &value);
+	value =3D wlan_info.safe_tx_max;
+	ofono_dbus_dict_append(&wl_dict, "SafeTxMax",
+			 DBUS_TYPE_UINT32, &value);
+	value =3D wlan_info.safe_rx_min;
+	ofono_dbus_dict_append(&wl_dict, "SafeRxMin",
+			 DBUS_TYPE_UINT32, &value);
+	value =3D wlan_info.safe_rx_max;
+	ofono_dbus_dict_append(&wl_dict, "SafeRxMax",
+			 DBUS_TYPE_UINT32, &value);
+	value =3D wlan_info.num_safe_vector;
+	ofono_dbus_dict_append(&wl_dict, "NumSafeVector",
+			 DBUS_TYPE_UINT32, &value);
+
+	dbus_message_iter_close_container(&wl_args, &wl_dict);
+
+	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
+						-1) =3D=3D FALSE ||
+						agent->call =3D=3D NULL)
+		return -EIO;
+
+	agent->user_data =3D user_data;
+	agent->user_destroy =3D destroy;
+
+	dbus_pending_call_set_notify(agent->call, coex_agent_coex_wlan_notify_cb,
+					agent, NULL);
+
+	return 0;
+}
+
+static void coex_agent_coex_bt_notify_cb(DBusPendingCall *call, void *data)
+{
+	struct coex_agent *agent =3D data;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum coex_agent_result result;
+	gboolean remove_agent;
+
+	DBG("");
+	if (check_error(agent, reply,&result) =3D=3D -EINVAL) {
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	if (result !=3D COEX_AGENT_RESULT_OK) {
+		goto done;
+	}
+
+	if (dbus_message_get_args(reply, NULL, DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("Can't parse the reply to DisplayText()");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	CALLBACK_END();
+}
+
+int coex_agent_coex_bt_notify(struct coex_agent *agent,
+			const struct bt_coex_info bt_info,
+			ofono_bool_t urgent,
+			void *user_data, ofono_destroy_func destroy)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessageIter bt_args, bt_dict, bt_array;
+	const dbus_int32_t *pbt_array =3D bt_info.safe_vector;
+	int len =3D MAX_BT_SAFE_VECTOR;
+	dbus_int32_t value;
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+						OFONO_COEX_AGENT_INTERFACE,
+						"ReceiveBTNotification");
+
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	pbt_array =3D bt_info.safe_vector;
+
+	for(len =3D 0 ; len < MAX_BT_SAFE_VECTOR; len++)
+		DBG("pbt_array[%d] =3D %d", len, pbt_array[len]);
+
+	dbus_message_iter_init_append(agent->msg, &bt_args);
+
+	dbus_message_iter_open_container(&bt_args, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_INT32_AS_STRING, &bt_array);
+
+	dbus_message_iter_append_fixed_array(&bt_array, DBUS_TYPE_INT32,
+					&pbt_array, len);
+
+	dbus_message_iter_close_container(&bt_args, &bt_array);
+
+	dbus_message_iter_open_container(&bt_args,
+					DBUS_TYPE_ARRAY, "{sv}", &bt_dict);
+
+	value =3D bt_info.safe_tx_min;
+	DBG("value =3D %d", value);
+	ofono_dbus_dict_append(&bt_dict, "SafeTxMin",
+			DBUS_TYPE_UINT32, &value);
+	value =3D bt_info.safe_tx_max;
+	DBG("value =3D %d", value);
+	ofono_dbus_dict_append(&bt_dict, "SafeTxMax",
+			DBUS_TYPE_UINT32, &value);
+	value =3D bt_info.safe_rx_min;
+	DBG("value =3D %d", value);
+	ofono_dbus_dict_append(&bt_dict, "SafeRxMin",
+			DBUS_TYPE_UINT32, &value);
+	value =3D bt_info.safe_rx_max;
+	DBG("value =3D %d", value);
+	ofono_dbus_dict_append(&bt_dict, "SafeRxMax",
+			DBUS_TYPE_UINT32, &value);
+	value =3D bt_info.num_safe_vector;
+	DBG("value =3D %d", value);
+	ofono_dbus_dict_append(&bt_dict, "NumSafeVector",
+			DBUS_TYPE_UINT32, &value);
+
+	dbus_message_iter_close_container(&bt_args, &bt_dict);
+
+	if ((dbus_connection_send_with_reply(conn, agent->msg,
+					&agent->call, -1) =3D=3D FALSE) ||
+					agent->call =3D=3D NULL) {
+		return -EIO;
+	}
+
+	agent->user_data =3D user_data;
+	agent->user_destroy =3D destroy;
+
+	dbus_pending_call_set_notify(agent->call, coex_agent_coex_bt_notify_cb,
+				agent, NULL);
+
+	return 0;
+}
diff --git a/src/coexagent.h b/src/coexagent.h
new file mode 100644
index 0000000..2ba80ba
--- /dev/null
+++ b/src/coexagent.h
@@ -0,0 +1,77 @@
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
+#ifndef COEXAGENT_H
+#define COEXAGENT_H
+struct coex_agent;
+
+#define MAX_BT_SAFE_VECTOR 15
+#define MAX_WL_SAFE_VECTOR 13
+
+enum coex_agent_result {
+	COEX_AGENT_RESULT_OK,
+	COEX_AGENT_RESULT_BACK,
+	COEX_AGENT_RESULT_TERMINATE,
+	COEX_AGENT_RESULT_TIMEOUT,
+	COEX_AGENT_RESULT_BUSY,
+};
+
+struct bt_coex_info {
+	int safe_tx_min;
+	int safe_tx_max;
+	int safe_rx_min;
+	int safe_rx_max;
+	int safe_vector[MAX_BT_SAFE_VECTOR];
+	int num_safe_vector;
+};
+
+struct wl_coex_info {
+	int safe_tx_min;
+	int safe_tx_max;
+	int safe_rx_min;
+	int safe_rx_max;
+	int safe_vector[MAX_BT_SAFE_VECTOR];
+	int num_safe_vector;
+};
+
+struct coex_agent* coex_agent_new(const char *path, const char *sender,
+				ofono_bool_t remove_on_terminate);
+
+void coex_agent_set_removed_notify(struct coex_agent *agent,
+				ofono_destroy_func destroy, void *user_data);
+
+ofono_bool_t coex_agent_matches(struct coex_agent *agent,
+			const char *path, const char *sender);
+
+int coex_agent_coex_bt_notify(struct coex_agent *agent,
+			const struct bt_coex_info bt_info,
+			ofono_bool_t urgent,
+			void *user_data, ofono_destroy_func destroy);
+
+int coex_agent_coex_wlan_notify(struct coex_agent *agent,
+			const struct wl_coex_info wlan_info,
+			ofono_bool_t urgent,
+			void *user_data, ofono_destroy_func destroy);
+
+void coex_agent_send_release(struct coex_agent *agent);
+
+void coex_agent_free(struct coex_agent *agent);
+
+#endif
diff --git a/src/ofono.conf b/src/ofono.conf
index 61e0bde..5a3afaa 100644
--- a/src/ofono.conf
+++ b/src/ofono.conf
@@ -16,6 +16,7 @@
     <allow send_interface=3D"org.ofono.PositioningRequestAgent"/>
     <allow send_interface=3D"org.ofono.HandsfreeAudioAgent"/>
     <allow send_interface=3D"org.ofono.NetworkMonitorAgent"/>
+    <allow send_interface=3D"org.ofono.LTECoexAgent"/>
   </policy>
 =

   <policy at_console=3D"true">
-- =

1.9.1


--===============6893576717389950790==--

