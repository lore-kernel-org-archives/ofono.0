Content-Type: multipart/mixed; boundary="===============8660570529552763351=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 3/6] gprs-provision: add driver API sources
Date: Thu, 20 Jan 2011 15:11:36 +0200
Message-ID: <1295529099-21082-4-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1295529099-21082-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8660570529552763351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am          |    2 +-
 src/gprs-provision.c |  219 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 220 insertions(+), 1 deletions(-)
 create mode 100644 src/gprs-provision.c

diff --git a/Makefile.am b/Makefile.am
index 7a03f08..97480d5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -353,7 +353,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
-			src/cdma-voicecall.c
+			src/cdma-voicecall.c src/gprs-provision.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/gprs-provision.c b/src/gprs-provision.c
new file mode 100644
index 0000000..380d126
--- /dev/null
+++ b/src/gprs-provision.c
@@ -0,0 +1,219 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  Nokia Corporation and/or its subsidiary(-ies).
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
+#include <stdlib.h>
+#include <glib.h>
+
+#include "ofono.h"
+#include "gprs-provision.h"
+
+static GSList *g_drivers =3D NULL;
+static GSList *provision_requests =3D NULL;
+
+struct gprs_provision_request {
+	GSList *drivers; /* Provisioning drivers to be called */
+	struct ofono_modem *modem;
+	ofono_gprs_provision_cb_t cb;
+	void *user_data;
+	const char *current_name;
+};
+
+static struct ofono_gprs_provision_context *gprs_provision_context_create(
+			struct ofono_modem *modem,
+			struct ofono_gprs_provision_driver *driver)
+{
+	struct ofono_gprs_provision_context *context;
+
+	if (driver->probe =3D=3D NULL)
+		return NULL;
+
+	context =3D g_try_new0(struct ofono_gprs_provision_context, 1);
+	if (context =3D=3D NULL)
+		return NULL;
+
+	context->driver =3D driver;
+	context->modem =3D modem;
+
+	if (driver->probe(context) < 0) {
+		g_free(context);
+		return NULL;
+	}
+
+	return context;
+}
+
+static void clean_active_requests(gpointer data, gpointer user_data)
+{
+	struct gprs_provision_request *req =3D data;
+	struct ofono_gprs_provision_context *context =3D user_data;
+
+	req->drivers =3D g_slist_remove(req->drivers, context);
+}
+
+static void context_remove(struct ofono_atom *atom)
+{
+	struct ofono_gprs_provision_context *context =3D
+		__ofono_atom_get_data(atom);
+
+	g_slist_foreach(provision_requests, clean_active_requests, context);
+
+	if (context->driver->remove)
+		context->driver->remove(context);
+
+	g_free(context);
+}
+
+void __ofono_gprs_provision_probe_drivers(struct ofono_modem *modem)
+{
+	struct ofono_gprs_provision_driver *driver;
+	struct ofono_gprs_provision_context *context;
+	GSList *l;
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		driver =3D l->data;
+		context =3D gprs_provision_context_create(modem, driver);
+		if (context =3D=3D NULL)
+			continue;
+
+		__ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_GPRS_PROVISION,
+						context_remove, context);
+	}
+}
+
+/*
+ * Calls next driver that has callable get_settings()
+ * Returns TRUE if a driver was called.
+ */
+static gboolean call_driver_get_settings(struct gprs_provision_request *re=
q,
+						ofono_gprs_provision_cb_t cb)
+{
+	struct ofono_gprs_provision_context *context;
+
+	while (req->drivers !=3D NULL) {
+		context =3D req->drivers->data;
+		req->drivers =3D g_slist_delete_link(req->drivers, req->drivers);
+
+		if (context->driver->get_settings !=3D NULL) {
+			DBG("Calling provisioning plugin '%s'",
+				context->driver->name);
+
+			req->current_name =3D context->driver->name;
+			provision_requests =3D g_slist_append(provision_requests,
+								req);
+			context->driver->get_settings(context, cb, req);
+			return TRUE;
+		}
+	}
+
+	return FALSE;
+}
+
+static void settings_cb(const struct ofono_gprs_provision_data settings[],
+			int count, void *user_data)
+{
+	struct gprs_provision_request *req =3D user_data;
+
+	provision_requests =3D g_slist_remove(provision_requests, req);
+
+	if (count =3D=3D 0) {
+		ofono_warn("Provisioning plugin '%s' returned no settings",
+			req->current_name);
+
+		/* No success from this driver, try next */
+		if (call_driver_get_settings(req, settings_cb) =3D=3D TRUE)
+			return;
+	} else
+		DBG("Plugin '%s' returned settings for %d contexts",
+			req->current_name, count);
+
+	req->cb(settings, count, req->user_data);
+	g_slist_free(req->drivers);
+	g_free(req);
+}
+
+static void prepend_provision_driver(struct ofono_atom *atom, void *data)
+{
+	struct ofono_gprs_provision_context *context =3D
+		__ofono_atom_get_data(atom);
+	GSList **drivers =3D data;
+
+	*drivers =3D g_slist_prepend(*drivers, context);
+}
+
+void __ofono_gprs_provision_get_settings(struct ofono_modem *modem,
+						ofono_gprs_provision_cb_t cb,
+						void *user_data)
+{
+	struct gprs_provision_request *req;
+
+	req =3D g_try_new0(struct gprs_provision_request, 1);
+	if (req =3D=3D NULL)
+		goto error;
+
+	req->modem =3D modem;
+	req->cb =3D cb;
+	req->user_data =3D user_data;
+
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_GPRS_PROVISION,
+					prepend_provision_driver,
+					&req->drivers);
+
+	if (call_driver_get_settings(req, settings_cb) =3D=3D TRUE)
+		return;
+
+	DBG("No callable GPRS provision drivers");
+
+	g_slist_free(req->drivers);
+
+error:
+	g_free(req);
+	cb(NULL, 0, user_data);
+}
+
+static gint compare_priority(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_gprs_provision_driver *plugin1 =3D a;
+	const struct ofono_gprs_provision_driver *plugin2 =3D b;
+
+	return plugin2->priority - plugin1->priority;
+}
+
+int ofono_gprs_provision_driver_register(
+			const struct ofono_gprs_provision_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	g_drivers =3D g_slist_insert_sorted(g_drivers, (void *) driver,
+						compare_priority);
+	return 0;
+}
+
+void ofono_gprs_provision_driver_unregister(
+			const struct ofono_gprs_provision_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, driver);
+}
-- =

1.7.1


--===============8660570529552763351==--

