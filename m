Content-Type: multipart/mixed; boundary="===============4148593543895742394=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/2] provision: add plugin to provision from config file
Date: Fri, 17 Feb 2017 15:44:47 +0100
Message-ID: <20170217144448.23940-2-c.ronco@kerlink.fr>
In-Reply-To: <20170217144448.23940-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4148593543895742394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This plugin allows to provision gprs-context data based on MCC and MNC.
This is useful when provisioning using mbpi fails (either because you
are using a private APN or because there are multiple internet type context
for your operator in mbpi database).
Config file is STORAGEDIR/provisioning.
Config file should look like that:
[operator:MCC1,MNC1]
internet.AccessPointName=3Dapn1
internet.Username=3DmyUsername
internet.Password=3DmyPassword
internet.AuthenticationMethod=3Dpap
internet.Protocol=3Dipv6
[operator:MCC2,MNC2]
internet.AccessPointName=3Dapn2

The only mandatory parameter for each operator is internet.AccessPointName.

Parameter description:
internet.AccessPointName: APN
internet.Username: Username
internet.Password: Password
internet.AuthenticationMethod: authentication method.
 Possible values are:
  - pap
  - chap
 Default is chap if unset.
internet.Protocol: protocol
 Possible values are:
  - ip: ipv4
  - ipv6
  - dual
 Default is ip if not set.

All parameters are prefixed with internet to be able to extend this plugin
to other type of contexts (MMS, ...).
---
 plugins/file-provision.c | 170 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 170 insertions(+)
 create mode 100644 plugins/file-provision.c

diff --git a/plugins/file-provision.c b/plugins/file-provision.c
new file mode 100644
index 00000000..d4846a65
--- /dev/null
+++ b/plugins/file-provision.c
@@ -0,0 +1,170 @@
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
+#include <ofono/gprs-provision.h>
+#include <ofono/log.h>
+#include <ofono/plugin.h>
+
+#define CONFIG_FILE STORAGEDIR "/provisioning"
+
+static int config_file_provision_get_settings(const char *mcc,
+				const char *mnc, const char *spn,
+				struct ofono_gprs_provision_data **settings,
+				int *count)
+{
+	int result =3D 0;
+	GKeyFile *key_file =3D NULL;
+	char *setting_group =3D NULL;
+	char *value;
+
+	DBG("Finding settings for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
+
+	*count =3D 0;
+	*settings =3D NULL;
+
+	key_file =3D g_key_file_new();
+
+	if (!g_key_file_load_from_file(key_file, CONFIG_FILE, 0, NULL)) {
+		result =3D -ENOENT;
+		goto error;
+	}
+
+	setting_group =3D g_try_malloc(strlen("operator:") + strlen(mcc) +
+							strlen(mnc) + 2);
+	if (setting_group =3D=3D NULL) {
+		result =3D -ENOMEM;
+		goto error;
+	}
+
+	sprintf(setting_group, "operator:%s,%s", mcc, mnc);
+
+	value =3D g_key_file_get_string(key_file, setting_group,
+					"internet.AccessPointName", NULL);
+
+	if (value =3D=3D NULL)
+		goto error;
+
+	*settings =3D g_try_new0(struct ofono_gprs_provision_data, 1);
+	if (*settings =3D=3D NULL) {
+		result =3D -ENOMEM;
+		goto error;
+	}
+
+	*count =3D 1;
+
+	(*settings)[0].type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
+	(*settings)[0].apn =3D value;
+
+	value =3D g_key_file_get_string(key_file, setting_group,
+					"internet.Username", NULL);
+
+	if (value !=3D NULL)
+		(*settings)[0].username =3D value;
+
+	value =3D g_key_file_get_string(key_file, setting_group,
+					"internet.Password", NULL);
+
+	if (value !=3D NULL)
+		(*settings)[0].password =3D value;
+
+	(*settings)[0].auth_method =3D OFONO_GPRS_AUTH_METHOD_CHAP;
+	value =3D g_key_file_get_string(key_file, setting_group,
+					"internet.AuthenticationMethod", NULL);
+
+	if (value !=3D NULL) {
+		if (g_strcmp0(value, "chap") =3D=3D 0)
+			(*settings)[0].auth_method =3D
+						OFONO_GPRS_AUTH_METHOD_CHAP;
+		else if (g_strcmp0(value, "pap") =3D=3D 0)
+			(*settings)[0].auth_method =3D
+						OFONO_GPRS_AUTH_METHOD_PAP;
+		else
+			DBG("Unknown auth method: %s", value);
+
+		g_free(value);
+	}
+
+	(*settings)[0].proto =3D OFONO_GPRS_PROTO_IP;
+	value =3D g_key_file_get_string(key_file, setting_group,
+					"internet.Protocol", NULL);
+
+	if (value !=3D NULL) {
+		DBG("CRO value:%s", value);
+		if (g_strcmp0(value, "ip") =3D=3D 0) {
+			DBG("CRO value=3Dip");
+			(*settings)[0].proto =3D OFONO_GPRS_PROTO_IP;
+		} else if (g_strcmp0(value, "ipv6") =3D=3D 0) {
+			DBG("CRO value=3Dipv6");
+			(*settings)[0].proto =3D OFONO_GPRS_PROTO_IPV6;
+		} else if (g_strcmp0(value, "dual") =3D=3D 0)
+			(*settings)[0].proto =3D OFONO_GPRS_PROTO_IPV4V6;
+		else
+			DBG("Unknown protocol: %s", value);
+
+		g_free(value);
+	}
+
+error:
+	if (key_file !=3D NULL)
+		g_key_file_free(key_file);
+
+	if (setting_group !=3D NULL)
+		g_free(setting_group);
+
+	if (result =3D=3D 0 && *count > 0)
+		DBG("Found. APN:%s, proto:%d, auth_method:%d",
+				(*settings)[0].apn, (*settings)[0].proto,
+				(*settings)[0].auth_method);
+	else
+		DBG("Not found. Result:%d", result);
+
+	return result;
+}
+
+static struct ofono_gprs_provision_driver config_file_provision_driver =3D=
 {
+	.name		=3D "GPRS context provisioning",
+	.get_settings	=3D config_file_provision_get_settings,
+};
+
+static int config_file_provision_init(void)
+{
+	return ofono_gprs_provision_driver_register(
+						&config_file_provision_driver);
+}
+
+static void config_file_provision_exit(void)
+{
+	ofono_gprs_provision_driver_unregister(
+						&config_file_provision_driver);
+}
+
+OFONO_PLUGIN_DEFINE(file_provision, "Gprs Provisioning Plugin",
+			VERSION, OFONO_PLUGIN_PRIORITY_HIGH,
+			config_file_provision_init,
+			config_file_provision_exit)
-- =

2.11.0


--===============4148593543895742394==--

