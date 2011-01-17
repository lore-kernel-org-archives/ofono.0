Content-Type: multipart/mixed; boundary="===============6620258276984464458=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] Add SIM authentication atom's driver definitions.
Date: Mon, 17 Jan 2011 18:38:50 +0100
Message-ID: <1295285934-9306-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6620258276984464458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Structures and function declarations for the SIM authentication
atom as proposed by Pekka Pessi, with just one method at the moment.
---
 Makefile.am        |    2 +-
 include/sim-auth.h |   64 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/types.h    |    6 +++++
 3 files changed, 71 insertions(+), 1 deletions(-)
 create mode 100644 include/sim-auth.h

diff --git a/Makefile.am b/Makefile.am
index ce4799e..ada0a51 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -15,7 +15,7 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
 			include/ctm.h include/cdma-voicecall.h \
-			include/cdma-sms.h
+			include/cdma-sms.h include/sim-auth.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

diff --git a/include/sim-auth.h b/include/sim-auth.h
new file mode 100644
index 0000000..98c3dfc
--- /dev/null
+++ b/include/sim-auth.h
@@ -0,0 +1,64 @@
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
+#ifndef __OFONO_SIM_AUTH_H
+#define __OFONO_SIM_AUTH_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_sim_auth;
+
+typedef void (*ofono_sim_list_apps_cb_t)(const struct ofono_error *error,
+					struct ofono_sim_app_record *list,
+					int count, void *data);
+
+struct ofono_sim_auth_driver {
+	const char *name;
+	int (*probe)(struct ofono_sim_auth *sa, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_sim_auth *sa);
+
+	void (*list_apps)(struct ofono_sim_auth *sa,
+				ofono_sim_list_apps_cb_t cb, void *data);
+};
+
+int ofono_sim_auth_driver_register(const struct ofono_sim_auth_driver *d);
+void ofono_sim_auth_driver_unregister(const struct ofono_sim_auth_driver *=
d);
+
+struct ofono_sim_auth *ofono_sim_auth_create(struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver, void *data);
+
+void ofono_sim_auth_register(struct ofono_sim_auth *sa);
+void ofono_sim_auth_remove(struct ofono_sim_auth *sa);
+
+void ofono_sim_auth_set_data(struct ofono_sim_auth *sa, void *data);
+void *ofono_sim_auth_get_data(struct ofono_sim_auth *sa);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_SIM_AUTH_H */
diff --git a/include/types.h b/include/types.h
index 1b95eaa..7f3634e 100644
--- a/include/types.h
+++ b/include/types.h
@@ -122,6 +122,12 @@ struct ofono_uuid {
 =

 const char *ofono_uuid_to_str(const struct ofono_uuid *uuid);
 =

+struct ofono_sim_app_record {
+	unsigned char aid[16];
+	int aid_len;
+	char *label;
+};
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.1.86.g0e460.dirty


--===============6620258276984464458==--

