Content-Type: multipart/mixed; boundary="===============7661889152486151106=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 2/2] provision: add SIM PIN provisionning plugin
Date: Tue, 28 Mar 2017 16:56:46 +0200
Message-ID: <20170328145646.27448-3-c.ronco@kerlink.fr>
In-Reply-To: <20170328145646.27448-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7661889152486151106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                  |   4 ++
 plugins/sim-file-provision.c | 156 +++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 160 insertions(+)
 create mode 100644 plugins/sim-file-provision.c

diff --git a/Makefile.am b/Makefile.am
index e68a3323..fab55226 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -560,6 +560,10 @@ builtin_sources +=3D plugins/cdma-provision.c
 builtin_modules +=3D file_provision
 builtin_sources +=3D plugins/file-provision.c
 =

+builtin_modules +=3D sim_file_provision
+builtin_sources +=3D plugins/sim-file-provision.c
+
+
 endif
 =

 if MAINTAINER_MODE
diff --git a/plugins/sim-file-provision.c b/plugins/sim-file-provision.c
new file mode 100644
index 00000000..16e63d65
--- /dev/null
+++ b/plugins/sim-file-provision.c
@@ -0,0 +1,156 @@
+/*
+ *
+ *  oFono - Open Source Telephony
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/modem.h>
+#include <ofono/log.h>
+#include <ofono/plugin.h>
+#include <ofono/sim.h>
+#include <ofono/sim-passwd-provision.h>
+
+#define CONFIG_FILE STORAGEDIR "/provisioning"
+
+struct passwd_type_dict {
+	enum ofono_sim_password_type passwd_enum;
+	const char *passwd_string;
+};
+
+static const struct passwd_type_dict passwd_dictionary[] =3D {
+	{ OFONO_SIM_PASSWORD_SIM_PIN, "pin" },
+	{ OFONO_SIM_PASSWORD_SIM_PUK, "puk" },
+	{ OFONO_SIM_PASSWORD_PHSIM_PIN, "phone" },
+	{ OFONO_SIM_PASSWORD_PHFSIM_PIN, "firstphone" },
+	{ OFONO_SIM_PASSWORD_PHFSIM_PUK, "firstphonepuk" },
+	{ OFONO_SIM_PASSWORD_PHNET_PIN, "network" },
+	{ OFONO_SIM_PASSWORD_PHNET_PUK, "networkpuk" },
+	{ OFONO_SIM_PASSWORD_PHNETSUB_PIN, "netsub" },
+	{ OFONO_SIM_PASSWORD_PHNETSUB_PUK, "netsubpuk" },
+	{ OFONO_SIM_PASSWORD_PHSP_PIN, "service" },
+	{ OFONO_SIM_PASSWORD_PHSP_PUK, "servicepuk" },
+	{ OFONO_SIM_PASSWORD_PHCORP_PIN, "corp" },
+	{ OFONO_SIM_PASSWORD_PHCORP_PUK, "corppuk" }
+};
+
+static const char *get_passwd_type_name(
+				enum ofono_sim_password_type passwd_enum)
+{
+	int i;
+	int passwd_dict_size;
+
+	passwd_dict_size =3D sizeof(passwd_dictionary) /
+					sizeof(struct passwd_type_dict);
+
+	for (i =3D 0; i < passwd_dict_size; i++) {
+		if (passwd_enum =3D=3D passwd_dictionary[i].passwd_enum)
+			return passwd_dictionary[i].passwd_string;
+	}
+
+	return NULL;
+}
+
+static int get_password(const char *iccid,
+				enum ofono_sim_password_type passwd_type,
+				char **password)
+{
+	int result =3D -ENOENT;
+	const char *passwd_type_name;
+	GKeyFile *key_file =3D NULL;
+	char *setting_group =3D NULL;
+	char *value =3D NULL;
+
+	passwd_type_name =3D get_passwd_type_name(passwd_type);
+
+	if (passwd_type_name =3D=3D NULL) {
+		DBG("unknown type %d", (int)passwd_type);
+		goto end;
+	}
+
+	DBG("Finding password for iccid %s, password type %s",
+						iccid, passwd_type_name);
+	key_file =3D g_key_file_new();
+
+	if (!g_key_file_load_from_file(key_file, CONFIG_FILE, 0, NULL))
+		goto end;
+
+	setting_group =3D g_try_malloc(strlen("sim:") + strlen(iccid) + 1);
+	if (setting_group =3D=3D NULL) {
+		result =3D -ENOMEM;
+		goto end;
+	}
+
+	/* try with iccid */
+	sprintf(setting_group, "sim:%s", iccid);
+	value =3D g_key_file_get_string(key_file, setting_group,
+						passwd_type_name, NULL);
+
+	if (value !=3D NULL)
+		goto end;
+
+	/* try default passwd */
+	value =3D g_key_file_get_string(key_file, "sim",
+						passwd_type_name, NULL);
+
+end:
+	if (key_file !=3D NULL)
+		g_key_file_free(key_file);
+
+	if (setting_group !=3D NULL)
+		g_free(setting_group);
+
+	if (value !=3D NULL) {
+		DBG("Found. Password:%s", value);
+		*password =3D value;
+		result =3D 0;
+	} else {
+		DBG("Not found. Result:%d", result);
+	}
+
+	return result;
+}
+
+static struct ofono_sim_passwd_provision_driver provision_driver =3D {
+	.name		=3D "PIN provisioning",
+	.priority	=3D OFONO_PLUGIN_PRIORITY_HIGH,
+	.get_password	=3D get_password,
+};
+
+static int sim_password_provision_init(void)
+{
+	return ofono_sim_password_provision_driver_register(
+						&provision_driver);
+}
+
+static void sim_password_provision_exit(void)
+{
+	ofono_sim_password_provision_driver_unregister(
+						&provision_driver);
+}
+
+OFONO_PLUGIN_DEFINE(sim_file_provision, "SIM File Provisioning Plugin",
+			VERSION, OFONO_PLUGIN_PRIORITY_HIGH,
+			sim_password_provision_init,
+			sim_password_provision_exit)
-- =

2.11.0


--===============7661889152486151106==--

