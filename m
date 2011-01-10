Content-Type: multipart/mixed; boundary="===============3371841878282044014=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCH 1/4] Added GPRS context provisioning driver API sources
Date: Mon, 10 Jan 2011 15:11:09 +0200
Message-ID: <1294665072-13630-2-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1294665072-13630-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3371841878282044014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am              |    4 +-
 include/gprs-provision.h |   73 +++++++++++++++++++++++++
 src/gprs-provision.c     |  133 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 208 insertions(+), 2 deletions(-)
 create mode 100644 include/gprs-provision.h
 create mode 100644 src/gprs-provision.c

diff --git a/Makefile.am b/Makefile.am
index 8ad01cd..0f330a7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -15,7 +15,7 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
 			include/ctm.h include/cdma-voicecall.h \
-			include/cdma-sms.h
+			include/cdma-sms.h include/gprs-provision.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

@@ -331,7 +331,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
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

diff --git a/include/gprs-provision.h b/include/gprs-provision.h
new file mode 100644
index 0000000..97e356b
--- /dev/null
+++ b/include/gprs-provision.h
@@ -0,0 +1,73 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
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
+#ifndef __OFONO_GPRS_PROVISION_H
+#define __OFONO_GPRS_PROVISION_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "gprs-context.h"
+
+struct ofono_gprs_provisioning_data {
+	enum ofono_gprs_context_type type;
+	enum ofono_gprs_proto proto;
+	gchar *name;
+	gchar *apn;
+	gchar *username;
+	gchar *password;
+	gchar *message_proxy;
+	gchar *message_center;
+};
+
+/*
+ * Callback from provisioning plugin.
+ * settings: list of struct ofono_gprs_provisioning_data
+ *
+ * It is responsibility of callback function to free settings-list
+ * settings-list elements must be freed with ofono_gprs_provisioning_data_=
free()
+ */
+typedef void (*ofono_gprs_provision_cb_t)(GSList *settings, void *userdata=
);
+
+struct ofono_gprs_provision_driver {
+	const char *name;
+	int priority;
+	void (*get_settings) (struct ofono_modem *modem,
+				ofono_gprs_provision_cb_t cb,
+				void *userdata);
+};
+
+/* For provisioning drivers/plugins */
+int ofono_gprs_provision_driver_register(const struct ofono_gprs_provision=
_driver *driver);
+void ofono_gprs_provision_driver_unregister(const struct ofono_gprs_provis=
ion_driver *driver);
+
+/* For gprs */
+void ofono_gprs_provision_get_settings(struct ofono_modem *modem,
+					ofono_gprs_provision_cb_t cb,
+					void *data);
+void ofono_gprs_provisioning_data_free(struct ofono_gprs_provisioning_data=
 *data);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_GPRS_PROVISION_H */
diff --git a/src/gprs-provision.c b/src/gprs-provision.c
new file mode 100644
index 0000000..c143fb6
--- /dev/null
+++ b/src/gprs-provision.c
@@ -0,0 +1,133 @@
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
+#include <glib.h>
+
+#include "ofono.h"
+#include "gprs-provision.h"
+
+struct gprs_provisioning_request {
+	GSList *current_driver;
+	struct ofono_modem *modem;
+	ofono_gprs_provision_cb_t cb;
+	void *userdata;
+};
+
+static GSList *gprs_provision_drivers =3D NULL;
+
+
+void ofono_gprs_provisioning_data_free(struct ofono_gprs_provisioning_data=
 *data)
+{
+	if (data =3D=3D NULL)
+		return;
+
+	g_free(data->name);
+	g_free(data->apn);
+	g_free(data->username);
+	g_free(data->password);
+	g_free(data->message_proxy);
+	g_free(data->message_center);
+	g_free(data);
+}
+
+
+static void settings_cb(GSList *settings, void *userdata)
+{
+	GSList *d;
+	struct gprs_provisioning_request *req =3D userdata;
+
+	if (settings !=3D NULL)
+		DBG("Provisioning plugin returned settings for %d contexts",
+			g_slist_length(settings));
+	else
+		DBG("Provisioning plugin returned no settings");
+
+	d =3D req->current_driver->next;
+	if (settings =3D=3D NULL && d !=3D NULL) {
+		/* No success from this driver, try next */
+		const struct ofono_gprs_provision_driver *driver =3D d->data;
+		req->current_driver =3D d;
+		DBG("Calling provisioning plugin '%s'", driver->name);
+		driver->get_settings(req->modem, settings_cb, req);
+		return;
+	}
+
+	req->cb(settings, req->userdata);
+	g_free(req);
+}
+
+
+void ofono_gprs_provision_get_settings(struct ofono_modem *modem,
+					ofono_gprs_provision_cb_t cb,
+					void *userdata)
+{
+	struct gprs_provisioning_request *req;
+	const struct ofono_gprs_provision_driver *driver;
+
+	if (gprs_provision_drivers =3D=3D 0)
+		goto error;
+
+	req =3D g_try_new0(struct gprs_provisioning_request, 1);
+	if (req =3D=3D NULL)
+		goto error;
+
+	req->modem =3D modem;
+	req->cb =3D cb;
+	req->userdata =3D userdata;
+	req->current_driver =3D gprs_provision_drivers;
+
+	driver =3D gprs_provision_drivers->data;
+	DBG("Calling provisioning plugin '%s'", driver->name);
+	driver->get_settings(modem, settings_cb, req);
+	return;
+
+error:
+	cb(NULL, userdata);
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
+int ofono_gprs_provision_driver_register(const struct ofono_gprs_provision=
_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	gprs_provision_drivers =3D g_slist_insert_sorted(gprs_provision_drivers,
+							(void *) driver,
+							compare_priority);
+	return 0;
+}
+
+void ofono_gprs_provision_driver_unregister(const struct ofono_gprs_provis=
ion_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	gprs_provision_drivers =3D g_slist_remove(gprs_provision_drivers, driver);
+}
-- =

1.7.1


--===============3371841878282044014==--

