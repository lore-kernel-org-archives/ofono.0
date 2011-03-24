Content-Type: multipart/mixed; boundary="===============8034472823252576046=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 04/12] src: add gnss atom and agent implementation
Date: Thu, 24 Mar 2011 15:46:28 +0200
Message-ID: <1300974396-15801-5-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1300974396-15801-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8034472823252576046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am     |    3 +-
 src/gnss.c      |  386 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/gnssagent.c |  158 +++++++++++++++++++++++
 src/gnssagent.h |   43 ++++++
 4 files changed, 589 insertions(+), 1 deletions(-)
 create mode 100644 src/gnss.c
 create mode 100644 src/gnssagent.c
 create mode 100644 src/gnssagent.h

diff --git a/Makefile.am b/Makefile.am
index bff2374..8d127af 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -385,7 +385,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/cdma-voicecall.c src/sim-auth.c \
 			src/message.h src/message.c src/gprs-provision.c \
 			src/emulator.c src/location-reporting.c \
-			src/cdma-connman.c
+			src/cdma-connman.c src/gnss.c \
+			src/gnssagent.c src/gnssagent.h
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/gnss.c b/src/gnss.c
new file mode 100644
index 0000000..e0c17e6
--- /dev/null
+++ b/src/gnss.c
@@ -0,0 +1,386 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2011 ST-Ericsson AB.
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
+
+#include "ofono.h"
+
+#include "common.h"
+#include "gnssagent.h"
+
+static GSList *g_drivers =3D NULL;
+
+struct ofono_gnss {
+	const struct ofono_gnss_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+	DBusMessage *pending;
+	struct gnss_agent *posr_agent;
+	ofono_bool_t enabled;
+};
+
+static void gnss_unregister_agent_cb(const struct ofono_error *error,
+					void *data)
+{
+	DBusMessage *reply;
+	struct ofono_gnss *gnss =3D data;
+
+	DBG("");
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Disabling Location Reporting Failed");
+		reply =3D __ofono_error_failed(gnss->pending);
+		__ofono_dbus_pending_reply(&gnss->pending, reply);
+		return;
+	}
+
+	gnss->enabled =3D FALSE;
+
+	if (gnss->posr_agent)
+		gnss_agent_free(gnss->posr_agent);
+
+	if (gnss->posr_agent) {
+		ofono_error("Releasing agent failed");
+		reply =3D __ofono_error_failed(gnss->pending);
+		__ofono_dbus_pending_reply(&gnss->pending, reply);
+		return;
+	}
+
+	if (gnss->pending) {
+		reply =3D dbus_message_new_method_return(gnss->pending);
+		__ofono_dbus_pending_reply(&gnss->pending, reply);
+	}
+}
+
+static void gnss_register_agent_cb(const struct ofono_error *error,
+					void *data)
+{
+	DBusMessage *reply;
+	struct ofono_gnss *gnss =3D data;
+
+	DBG("");
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Enabling Location Reporting Failed");
+		reply =3D __ofono_error_failed(gnss->pending);
+
+		if (gnss->posr_agent)
+			gnss_agent_free(gnss->posr_agent);
+
+		__ofono_dbus_pending_reply(&gnss->pending, reply);
+		return;
+	}
+
+	if (gnss->posr_agent) {
+		gnss->enabled =3D TRUE;
+		reply =3D dbus_message_new_method_return(gnss->pending);
+		__ofono_dbus_pending_reply(&gnss->pending, reply);
+	} else
+		gnss->driver->set_position_reporting(gnss, FALSE,
+						gnss_unregister_agent_cb,
+						gnss);
+}
+
+static void gnss_agent_notify(gpointer user_data)
+{
+	struct ofono_gnss *gnss =3D user_data;
+
+	if (gnss->enabled)
+		gnss->driver->set_position_reporting(gnss, FALSE,
+						gnss_unregister_agent_cb,
+						gnss);
+
+	gnss->posr_agent =3D NULL;
+}
+
+static DBusMessage *gnss_register_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_gnss *gnss =3D data;
+	const char *agent_path;
+
+	if (gnss->pending)
+		return __ofono_error_busy(msg);
+
+	if (gnss->posr_agent)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH,
+				&agent_path, DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (!__ofono_dbus_valid_object_path(agent_path))
+		return __ofono_error_invalid_format(msg);
+
+	gnss->posr_agent =3D gnss_agent_new(agent_path,
+					dbus_message_get_sender(msg),
+					FALSE);
+
+	if (gnss->posr_agent =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	gnss->enabled =3D FALSE;
+
+	gnss_agent_set_removed_notify(gnss->posr_agent,
+					gnss_agent_notify, gnss);
+
+	gnss->driver->set_position_reporting(gnss, TRUE, gnss_register_agent_cb,
+						gnss);
+
+	gnss->pending =3D dbus_message_ref(msg);
+
+	return NULL;
+}
+
+static DBusMessage *gnss_unregister_agent(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_gnss *gnss =3D data;
+	const char *agent_path;
+	const char *agent_bus =3D dbus_message_get_sender(msg);
+
+	if (gnss->pending)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (gnss->posr_agent =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	if (!gnss_agent_matches(gnss->posr_agent, agent_path, agent_bus))
+		return __ofono_error_failed(msg);
+
+	gnss->pending =3D dbus_message_ref(msg);
+
+	gnss->driver->set_position_reporting(gnss, FALSE,
+						gnss_unregister_agent_cb,
+						gnss);
+
+	return NULL;
+}
+
+static void gnss_send_element_cb(const struct ofono_error *error,
+				void *data)
+{
+	DBusMessage *reply;
+	struct ofono_gnss *gnss =3D data;
+
+	DBG("");
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Sending Positioning Element failed");
+
+		reply =3D __ofono_error_failed(gnss->pending);
+
+		goto out;
+	}
+
+	reply =3D dbus_message_new_method_return(gnss->pending);
+
+out:
+	__ofono_dbus_pending_reply(&gnss->pending, reply);
+}
+
+static DBusMessage *gnss_send_element(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	const char *caller =3D dbus_message_get_sender(msg);
+	struct ofono_gnss *gnss =3D data;
+	const char *xml;
+
+	DBG("");
+
+	if (gnss->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &xml,
+					DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	if (!gnss_agent_sender_matches(gnss->posr_agent, caller))
+		return __ofono_error_access_denied(msg);
+
+	gnss->pending =3D dbus_message_ref(msg);
+
+	gnss->driver->send_element(gnss, xml, gnss_send_element_cb, gnss);
+
+	return NULL;
+}
+
+static GDBusMethodTable gnss_methods[] =3D {
+	{ "SendPositioningElement",		"s",	"",
+				gnss_send_element, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "RegisterPositioningRequestAgent",	"o",	"",
+				gnss_register_agent,
+				G_DBUS_METHOD_FLAG_ASYNC },
+	{ "UnregisterPositioningRequestAgent",	"o",	"",
+				gnss_unregister_agent,
+				G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static void gnss_unregister(struct ofono_atom *atom)
+{
+	struct ofono_gnss *gnss =3D __ofono_atom_get_data(atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	if (gnss->posr_agent)
+		gnss_agent_free(gnss->posr_agent);
+
+	ofono_modem_remove_interface(modem, OFONO_GNSS_INTERFACE);
+	g_dbus_unregister_interface(conn, path, OFONO_GNSS_INTERFACE);
+}
+
+static void gnss_remove(struct ofono_atom *atom)
+{
+	struct ofono_gnss *gnss =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (gnss =3D=3D NULL)
+		return;
+
+	if (gnss->driver && gnss->driver->remove)
+		gnss->driver->remove(gnss);
+
+	g_free(gnss);
+}
+
+void ofono_gnss_register(struct ofono_gnss *gnss)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(gnss->atom);
+	const char *path =3D __ofono_atom_get_path(gnss->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+					OFONO_GNSS_INTERFACE,
+					gnss_methods, NULL, NULL,
+					gnss, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_GNSS_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_GNSS_INTERFACE);
+
+	__ofono_atom_register(gnss->atom, gnss_unregister);
+}
+
+int ofono_gnss_driver_register(const struct ofono_gnss_driver *d)
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
+void ofono_gnss_driver_unregister(const struct ofono_gnss_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
+}
+
+struct ofono_gnss *ofono_gnss_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver,
+					void *data)
+{
+	struct ofono_gnss *gnss;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	gnss =3D g_try_new0(struct ofono_gnss, 1);
+
+	if (gnss =3D=3D NULL)
+		return NULL;
+
+	gnss->enabled =3D FALSE;
+	gnss->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_GNSS,
+						gnss_remove, gnss);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_gnss_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(gnss, vendor, data) < 0)
+			continue;
+
+		gnss->driver =3D drv;
+		break;
+	}
+
+	return gnss;
+}
+
+void ofono_gnss_notify_posr_request(struct ofono_gnss *gnss, const char *x=
ml)
+{
+	if (gnss->posr_agent)
+		gnss_agent_receive_request(gnss->posr_agent, xml);
+}
+
+void ofono_gnss_notify_posr_reset(struct ofono_gnss *gnss)
+{
+	if (gnss->posr_agent)
+		gnss_agent_receive_reset(gnss->posr_agent);
+}
+
+void ofono_gnss_remove(struct ofono_gnss *gnss)
+{
+	__ofono_atom_free(gnss->atom);
+}
+
+void ofono_gnss_set_data(struct ofono_gnss *gnss, void *data)
+{
+	gnss->driver_data =3D data;
+}
+
+void *ofono_gnss_get_data(struct ofono_gnss *gnss)
+{
+	return gnss->driver_data;
+}
diff --git a/src/gnssagent.c b/src/gnssagent.c
new file mode 100644
index 0000000..0db9856
--- /dev/null
+++ b/src/gnssagent.c
@@ -0,0 +1,158 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2011 ST-Ericsson AB.
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
+#include "gnssagent.h"
+
+struct gnss_agent {
+	char *path;
+	char *bus;
+	guint disconnect_watch;
+	ofono_bool_t remove_on_terminate;
+	ofono_destroy_func removed_cb;
+	void *removed_data;
+};
+
+void gnss_agent_receive_request(struct gnss_agent *agent, const char *xml)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessage *message;
+
+	message =3D dbus_message_new_method_call(agent->bus, agent->path,
+					OFONO_GNSS_POSR_AGENT_INTERFACE,
+						"Request");
+
+	dbus_message_append_args(message,
+					DBUS_TYPE_STRING, &xml,
+					DBUS_TYPE_INVALID);
+
+	dbus_message_set_no_reply(message, TRUE);
+
+	g_dbus_send_message(conn, message);
+}
+
+static void gnss_agent_send_noreply(struct gnss_agent *agent,
+					const char *method)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessage *message;
+
+	message =3D dbus_message_new_method_call(agent->bus, agent->path,
+					OFONO_GNSS_POSR_AGENT_INTERFACE,
+						method);
+
+	dbus_message_set_no_reply(message, TRUE);
+
+	g_dbus_send_message(conn, message);
+}
+
+static inline void gnss_agent_send_release(struct gnss_agent *agent)
+{
+	gnss_agent_send_noreply(agent, "Release");
+}
+
+void gnss_agent_receive_reset(struct gnss_agent *agent)
+{
+	gnss_agent_send_noreply(agent, "ResetAssistanceData");
+}
+
+ofono_bool_t gnss_agent_matches(struct gnss_agent *agent,
+				const char *path, const char *sender)
+{
+	return !g_strcmp0(agent->path, path) && !g_strcmp0(agent->bus, sender);
+}
+
+ofono_bool_t gnss_agent_sender_matches(struct gnss_agent *agent,
+					const char *sender)
+{
+	return !g_strcmp0(agent->bus, sender);
+}
+
+void gnss_agent_set_removed_notify(struct gnss_agent *agent,
+					ofono_destroy_func destroy,
+					void *user_data)
+{
+	agent->removed_cb =3D destroy;
+	agent->removed_data =3D user_data;
+}
+
+void gnss_agent_free(struct gnss_agent *agent)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+
+	if (agent->disconnect_watch) {
+		gnss_agent_send_release(agent);
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
+static void gnss_agent_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	struct gnss_agent *agent =3D user_data;
+
+	ofono_debug("Agent exited without calling Unregister");
+
+	agent->disconnect_watch =3D 0;
+
+	gnss_agent_free(agent);
+}
+
+struct gnss_agent *gnss_agent_new(const char *path, const char *sender,
+				ofono_bool_t remove_on_terminate)
+{
+	struct gnss_agent *agent =3D g_try_new0(struct gnss_agent, 1);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (agent =3D=3D NULL)
+		return NULL;
+
+	agent->path =3D g_strdup(path);
+	agent->bus =3D g_strdup(sender);
+	agent->remove_on_terminate =3D remove_on_terminate;
+
+	agent->disconnect_watch =3D g_dbus_add_disconnect_watch(conn, sender,
+						gnss_agent_disconnect_cb,
+						agent, NULL);
+
+	return agent;
+}
diff --git a/src/gnssagent.h b/src/gnssagent.h
new file mode 100644
index 0000000..b03645b
--- /dev/null
+++ b/src/gnssagent.h
@@ -0,0 +1,43 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2011 ST-Ericsson AB.
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
+struct gnss_agent;
+
+
+struct gnss_agent *gnss_agent_new(const char *path, const char *sender,
+					ofono_bool_t remove_on_terminate);
+
+void gnss_agent_free(struct gnss_agent *agent);
+
+void gnss_agent_receive_request(struct gnss_agent *agent, const char *xml);
+
+void gnss_agent_receive_reset(struct gnss_agent *agent);
+
+void gnss_agent_set_removed_notify(struct gnss_agent *agent,
+					ofono_destroy_func removed_cb,
+					void *user_data);
+
+ofono_bool_t gnss_agent_matches(struct gnss_agent *agent,
+				const char *path, const char *sender);
+
+ofono_bool_t gnss_agent_sender_matches(struct gnss_agent *agent,
+					const char *sender);
-- =

1.7.0.4


--===============8034472823252576046==--

