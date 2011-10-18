Content-Type: multipart/mixed; boundary="===============8671798925727142255=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv10 2/9] provision: Add provisioning plugin
Date: Tue, 18 Oct 2011 14:04:58 +0300
Message-ID: <1318935905-9087-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1318935905-9087-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8671798925727142255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |    7 +++
 configure.ac        |   23 +++++++---
 plugins/provision.c |  117 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 140 insertions(+), 7 deletions(-)
 create mode 100644 plugins/provision.c

diff --git a/Makefile.am b/Makefile.am
index 8771cb2..2704c75 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -381,6 +381,11 @@ builtin_libadd +=3D @BLUEZ_LIBS@
 endif
 endif
 =

+if PROVISION
+builtin_modules +=3D provision
+builtin_sources +=3D plugins/mbpi.c plugins/mbpi.h plugins/provision.c
+endif
+
 if MAINTAINER_MODE
 builtin_modules +=3D example_history
 builtin_sources +=3D examples/history.c
@@ -388,8 +393,10 @@ builtin_sources +=3D examples/history.c
 builtin_modules +=3D example_nettime
 builtin_sources +=3D examples/nettime.c
 =

+if !PROVISION
 builtin_modules +=3D example_provision
 builtin_sources +=3D examples/provision.c
+endif
 =

 builtin_modules +=3D example_emulator
 builtin_sources +=3D examples/emulator.c
diff --git a/configure.ac b/configure.ac
index 5e4d34f..ab8345f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -197,14 +197,23 @@ AC_SUBST(BLUEZ_CFLAGS)
 AC_SUBST(BLUEZ_LIBS)
 AM_CONDITIONAL(BLUETOOTH, test "${enable_bluetooth}" !=3D "no")
 =

-AC_MSG_CHECKING([for mobile-broadband-provider-info])
-PKG_CHECK_EXISTS(mobile-broadband-provider-info,
-	_PKG_CONFIG(PROVIDER_DATABASE, [variable=3Ddatabase],
+AC_ARG_ENABLE(provision, AC_HELP_STRING([--enable-provision],
+				[enable GPRS context settings provisioning]),
+					[enable_provision=3D${enableval}])
+if (test "${enable_provision}" =3D=3D "yes"); then
+	AC_MSG_CHECKING([for mobile-broadband-provider-info])
+	PKG_CHECK_EXISTS(mobile-broadband-provider-info,
+			_PKG_CONFIG(MBPI_DATABASE, [variable=3Ddatabase],
 					[mobile-broadband-provider-info])
-	AC_DEFINE_UNQUOTED(PROVIDER_DATABASE, "$pkg_cv_PROVIDER_DATABASE",
-					[Mobile provider database])
-	AC_MSG_RESULT([yes]),
-	AC_MSG_RESULT([no]))
+		AC_DEFINE_UNQUOTED(MBPI_DATABASE,
+					"$pkg_cv_MBPI_DATABASE",
+					[Provisioning database
+					(mobile-broadband-provider-info
+					package)])
+		AC_MSG_RESULT([yes]),
+		AC_MSG_ERROR(mobile-broadband-provider-info package is required))
+fi
+AM_CONDITIONAL(PROVISION, test "${enable_provision}" =3D=3D "yes")
 =

 AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--disable-datafiles],
 			[don't install configuration and data files]),
diff --git a/plugins/provision.c b/plugins/provision.c
new file mode 100644
index 0000000..3adc220
--- /dev/null
+++ b/plugins/provision.c
@@ -0,0 +1,117 @@
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
+#include <errno.h>
+#include <string.h>
+
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/types.h>
+#include <ofono/log.h>
+#include <ofono/plugin.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-provision.h>
+
+#include "mbpi.h"
+
+static int provision_get_settings(const char *mcc, const char *mnc,
+				const char *spn,
+				struct ofono_gprs_provision_data **settings,
+				int *count)
+{
+	GSList *l;
+	GSList *apns;
+	GError *error =3D NULL;
+	int ap_count;
+	int i;
+
+	DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
+
+	apns =3D mbpi_lookup(mcc, mnc, FALSE, &error);
+	if (apns =3D=3D NULL) {
+		if (error !=3D NULL) {
+			ofono_error("%s", error->message);
+			g_error_free(error);
+		}
+
+		return -ENOENT;
+	}
+
+	ap_count =3D g_slist_length(apns);
+
+	DBG("Found %d APs", ap_count);
+
+	*settings =3D g_try_new0(struct ofono_gprs_provision_data, ap_count);
+	if (*settings =3D=3D NULL) {
+		ofono_error("Provisioning failed: %s", g_strerror(errno));
+
+		for (l =3D apns; l; l =3D l->next)
+			mbpi_provision_data_free(l->data);
+
+		g_slist_free(apns);
+
+		return -ENOMEM;
+	}
+
+	*count =3D ap_count;
+
+	for (l =3D apns, i =3D 0; l; l =3D l->next, i++) {
+		struct ofono_gprs_provision_data *ap =3D l->data;
+
+		DBG("Name: '%s'", ap->name);
+		DBG("APN: '%s'", ap->apn);
+		DBG("Username: '%s'", ap->username);
+		DBG("Password: '%s'", ap->password);
+
+		memcpy(*settings + i, ap,
+			sizeof(struct ofono_gprs_provision_data));
+
+		g_free(ap);
+	}
+
+	g_slist_free(apns);
+
+	return 0;
+}
+
+static struct ofono_gprs_provision_driver provision_driver =3D {
+	.name		=3D "Provisioning",
+	.get_settings	=3D provision_get_settings
+};
+
+static int provision_init(void)
+{
+	return ofono_gprs_provision_driver_register(&provision_driver);
+}
+
+static void provision_exit(void)
+{
+	ofono_gprs_provision_driver_unregister(&provision_driver);
+}
+
+OFONO_PLUGIN_DEFINE(provision, "Provisioning Plugin", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			provision_init, provision_exit)
-- =

1.7.4.1


--===============8671798925727142255==--

