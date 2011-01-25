Content-Type: multipart/mixed; boundary="===============8214826149489483343=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 4/4] gprs-provision: add example context provisioning driver
Date: Tue, 25 Jan 2011 14:15:14 +0200
Message-ID: <1295957714-21053-5-git-send-email-jukka.saunamaki@nokia.com>
In-Reply-To: <1295957714-21053-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8214826149489483343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am          |    3 ++
 examples/provision.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100644 examples/provision.c

diff --git a/Makefile.am b/Makefile.am
index 9c4f383..c70dcbf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -329,6 +329,9 @@ builtin_sources +=3D examples/history.c
 =

 builtin_modules +=3D example_nettime
 builtin_sources +=3D examples/nettime.c
+
+builtin_modules +=3D example_provision
+builtin_sources +=3D examples/provision.c
 endif
 =

 builtin_modules +=3D smart_messaging
diff --git a/examples/provision.c b/examples/provision.c
new file mode 100644
index 0000000..5a6103b
--- /dev/null
+++ b/examples/provision.c
@@ -0,0 +1,97 @@
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
+#include <string.h>
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+
+#include <ofono/modem.h>
+#include <ofono/gprs-provision.h>
+#include <ofono/types.h>
+
+#include "ofono.h"
+
+static void example_provision_get_settings(const char *mcc, const char *mn=
c,
+				const char *spn,
+				struct ofono_gprs_provision_data **settings,
+				int *count)
+{
+	ofono_debug("Provisioning...");
+	*count =3D 0;
+	*settings =3D NULL;
+
+	ofono_debug("Finding settings for MCC %s, MNC %s, SPN '%s'",
+			mcc, mnc, spn);
+
+	if (strcmp(mcc, "246") !=3D 0 || strcmp(mnc, "81") !=3D 0 ||
+			spn =3D=3D NULL || strcmp(spn, "oFono") !=3D 0)
+		return;
+
+	ofono_debug("Creating example settings for phonesim");
+
+	*settings =3D g_try_new0(struct ofono_gprs_provision_data, 2);
+	if (*settings =3D=3D NULL)
+		return;
+
+	*count =3D 2;
+
+	/* Internet context settings */
+	(*settings)[0].proto =3D OFONO_GPRS_PROTO_IP;
+	(*settings)[0].type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
+	(*settings)[0].name =3D g_strdup("Phonesim Internet");
+	(*settings)[0].apn =3D g_strdup("internetapn");
+
+	/* MMS context settings */
+	(*settings)[1].proto =3D OFONO_GPRS_PROTO_IP;
+	(*settings)[1].type =3D OFONO_GPRS_CONTEXT_TYPE_MMS;
+	(*settings)[1].name =3D g_strdup("Phonesim MMS");
+	(*settings)[1].apn =3D g_strdup("mmsapn");
+	(*settings)[1].username =3D g_strdup("mmsuser");
+	(*settings)[1].password =3D g_strdup("mmspass");
+	(*settings)[1].message_proxy =3D g_strdup("10.11.12.13:8080");
+	(*settings)[1].message_center =3D g_strdup("http://mms.example.com:8000");
+}
+
+static struct ofono_gprs_provision_driver example_driver =3D {
+	.name		=3D "Example GPRS context provisioning",
+	.priority       =3D OFONO_PLUGIN_PRIORITY_LOW,
+	.get_settings	=3D example_provision_get_settings,
+};
+
+static int example_provision_init(void)
+{
+	return ofono_gprs_provision_driver_register(&example_driver);
+}
+
+static void example_provision_exit(void)
+{
+	ofono_gprs_provision_driver_unregister(&example_driver);
+}
+
+OFONO_PLUGIN_DEFINE(example_provision, "Example Provisioning Plugin",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			example_provision_init,
+			example_provision_exit)
-- =

1.7.1


--===============8214826149489483343==--

