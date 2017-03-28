Content-Type: multipart/mixed; boundary="===============6379457276891275143=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/2] provision: add SIM PIN provisionning
Date: Tue, 28 Mar 2017 16:56:45 +0200
Message-ID: <20170328145646.27448-2-c.ronco@kerlink.fr>
In-Reply-To: <20170328145646.27448-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6379457276891275143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add framework to be able to have provisoning plugins for SIM codes
(PIN and others).
ICCID is given to provisioning plugin and it should return SIM PIN
if it knows this code.
If a PIN code is returned by a provisionning plugin, it will be tried
(one and only one time) on modem.
---
 Makefile.am                    |  5 +--
 include/sim-passwd-provision.h | 41 ++++++++++++++++++++++
 src/ofono.h                    |  5 +++
 src/sim-password-provision.c   | 80 ++++++++++++++++++++++++++++++++++++++=
++++
 src/sim.c                      | 35 ++++++++++++++++++
 5 files changed, 164 insertions(+), 2 deletions(-)
 create mode 100644 include/sim-passwd-provision.h
 create mode 100644 src/sim-password-provision.c

diff --git a/Makefile.am b/Makefile.am
index d9f9b086..e68a3323 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -22,7 +22,8 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/private-network.h include/cdma-netreg.h \
 			include/cdma-provision.h include/handsfree.h \
 			include/handsfree-audio.h include/siri.h \
-			include/netmon.h include/lte.h
+			include/netmon.h include/lte.h \
+			include/sim-passwd-provision.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

@@ -621,7 +622,7 @@ src_ofonod_SOURCES =3D $(builtin_sources) $(gatchat_sou=
rces) src/ofono.ver \
 			src/cdma-provision.c src/handsfree.c \
 			src/handsfree-audio.c src/bluetooth.h \
 			src/hfp.h src/siri.c \
-			src/netmon.c src/lte.c
+			src/netmon.c src/lte.c src/sim-password-provision.c
 =

 src_ofonod_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libadd) \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
diff --git a/include/sim-passwd-provision.h b/include/sim-passwd-provision.h
new file mode 100644
index 00000000..62ceae31
--- /dev/null
+++ b/include/sim-passwd-provision.h
@@ -0,0 +1,41 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2017  Kerlink SA.
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
+ */
+
+#ifndef __OFONO_SIM_PASSWD_PROVISION_H
+#define __OFONO_SIM_PASSWD_PROVISION_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct ofono_sim_passwd_provision_driver {
+	const char *name;
+	int priority;
+	int (*get_password)(const char *iccid,
+		enum ofono_sim_password_type password_type, char **pin);
+};
+
+int ofono_sim_password_provision_driver_register(
+		const struct ofono_sim_passwd_provision_driver *driver);
+void ofono_sim_password_provision_driver_unregister(
+		const struct ofono_sim_passwd_provision_driver *driver);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_SIM_PASSWD_PROVISION_H */
diff --git a/src/ofono.h b/src/ofono.h
index a797b7ff..d27fe989 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -506,6 +506,11 @@ void __ofono_gprs_provision_free_settings(
 				struct ofono_gprs_provision_data *settings,
 				int count);
 =

+#include <ofono/sim-passwd-provision.h>
+ofono_bool_t __ofono_sim_provision_get_password(const char *iccid,
+				enum ofono_sim_password_type password_type,
+				char **password);
+
 #include <ofono/emulator.h>
 =

 enum ofono_emulator_slc_condition {
diff --git a/src/sim-password-provision.c b/src/sim-password-provision.c
new file mode 100644
index 00000000..cd295b1e
--- /dev/null
+++ b/src/sim-password-provision.c
@@ -0,0 +1,80 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 201  Kerlink SA.
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
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <string.h>
+#include <glib.h>
+#include "ofono.h"
+
+static GSList *g_drivers =3D NULL;
+
+ofono_bool_t __ofono_sim_provision_get_password(const char *iccid,
+				enum ofono_sim_password_type password_type,
+				char **password)
+{
+	GSList *d;
+
+	if (iccid =3D=3D NULL || strlen(iccid) =3D=3D 0)
+		return FALSE;
+
+	for (d =3D g_drivers; d !=3D NULL; d =3D d->next) {
+		const struct ofono_sim_passwd_provision_driver *driver =3D
+									d->data;
+
+		if (driver->get_password =3D=3D NULL)
+			continue;
+
+		DBG("Calling sim password provisioning plugin '%s'",
+								driver->name);
+
+		if (driver->get_password(iccid, password_type, password) < 0)
+			continue;
+
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static gint compare_priority(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_sim_passwd_provision_driver *plugin1 =3D a;
+	const struct ofono_sim_passwd_provision_driver *plugin2 =3D b;
+
+	return plugin2->priority - plugin1->priority;
+}
+
+int ofono_sim_password_provision_driver_register(
+		const struct ofono_sim_passwd_provision_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	g_drivers =3D g_slist_insert_sorted(g_drivers, (void *) driver,
+							compare_priority);
+	return 0;
+}
+
+void ofono_sim_password_provision_driver_unregister(
+		const struct ofono_sim_passwd_provision_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, driver);
+}
diff --git a/src/sim.c b/src/sim.c
index ac5b6fde..7cb61991 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -61,6 +61,7 @@ struct ofono_sim {
 =

 	enum ofono_sim_password_type pin_type;
 	gboolean locked_pins[OFONO_SIM_PASSWORD_SIM_PUK]; /* Number of PINs */
+	gboolean tried_provisionned_pins;
 =

 	int pin_retries[OFONO_SIM_PASSWORD_INVALID];
 =

@@ -2828,6 +2829,38 @@ ofono_bool_t ofono_sim_remove_spn_watch(struct ofono=
_sim *sim, unsigned int *id)
 	return ret;
 }
 =

+static void sim_auto_enter_pin_cb(const struct ofono_error *error,
+								void *data)
+{
+	struct ofono_sim *sim =3D data;
+
+	__ofono_sim_recheck_pin(sim);
+}
+
+static void provision_password(struct ofono_sim *sim)
+{
+	char *password;
+
+	if (__ofono_sim_provision_get_password(sim->iccid, sim->pin_type,
+							&password) =3D=3D FALSE) {
+		DBG("SIM password provisioning failed");
+		return;
+	}
+
+	/* try to enter password */
+	if (password_is_pin(sim->pin_type) =3D=3D FALSE)
+		goto end;
+
+	if (!__ofono_is_valid_sim_pin(password, sim->pin_type))
+		goto end;
+
+	sim->tried_provisionned_pins =3D TRUE;
+	sim->driver->send_passwd(sim, password, sim_auto_enter_pin_cb, sim);
+
+end:
+	g_free(password);
+}
+
 static void sim_pin_query_cb(const struct ofono_error *error,
 				enum ofono_sim_password_type pin_type,
 				void *data)
@@ -2908,6 +2941,8 @@ static void sim_pin_query_cb(const struct ofono_error=
 *error,
 		sim_initialize_after_pin(sim);
 		break;
 	default:
+		if (!sim->tried_provisionned_pins)
+			provision_password(sim);
 		break;
 	}
 }
-- =

2.11.0


--===============6379457276891275143==--

