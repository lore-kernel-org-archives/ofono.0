Content-Type: multipart/mixed; boundary="===============0262815595312350091=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH 2/6] include: added IpMultimediaSystem interface
Date: Wed, 04 Oct 2017 09:12:28 +0530
Message-ID: <1507088548-25106-2-git-send-email-ankit.p.navik@intel.com>
In-Reply-To: <1507088548-25106-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0262815595312350091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am    |  2 +-
 include/dbus.h |  1 +
 include/ims.h  | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 include/ims.h

diff --git a/Makefile.am b/Makefile.am
index 3ce6d50..165235e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -22,7 +22,7 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/private-network.h include/cdma-netreg.h \
 			include/cdma-provision.h include/handsfree.h \
 			include/handsfree-audio.h include/siri.h \
-			include/netmon.h include/lte.h
+			include/netmon.h include/lte.h include/ims.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

diff --git a/include/dbus.h b/include/dbus.h
index a6519c7..0a8f2e5 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -63,6 +63,7 @@ extern "C" {
 #define OFONO_NETMON_INTERFACE OFONO_SERVICE ".NetworkMonitor"
 #define OFONO_NETMON_AGENT_INTERFACE OFONO_SERVICE ".NetworkMonitorAgent"
 #define OFONO_LTE_INTERFACE OFONO_SERVICE ".LongTermEvolution"
+#define OFONO_IMS_INTERFACE OFONO_SERVICE ".IpMultimediaSystem"
 =

 /* CDMA Interfaces */
 #define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
diff --git a/include/ims.h b/include/ims.h
new file mode 100644
index 0000000..f3a33d5
--- /dev/null
+++ b/include/ims.h
@@ -0,0 +1,70 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_IMS_H
+#define __OFONO_IMS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_ims;
+
+typedef void (*ofono_ims_register_cb_t)(const struct ofono_error *error,
+						void *data);
+typedef void (*ofono_ims_status_cb_t)(const struct ofono_error *error,
+						int reg_info, int ext_info,
+						void *data);
+
+struct ofono_ims_driver {
+	const char *name;
+	int (*probe)(struct ofono_ims *ims, void *data);
+	void (*remove)(struct ofono_ims *ims);
+	void (*ims_register)(struct ofono_ims *ims,
+				ofono_ims_register_cb_t cb, void *data);
+	void (*ims_unregister)(struct ofono_ims *ims,
+				ofono_ims_register_cb_t cb, void *data);
+	void (*registration_status)(struct ofono_ims *ims,
+				ofono_ims_status_cb_t cb, void *data);
+};
+
+void ofono_ims_status_notify(struct ofono_ims *ims, int reg_info,
+							int ext_info);
+
+int ofono_ims_driver_register(const struct ofono_ims_driver *d);
+void ofono_ims_driver_unregister(const struct ofono_ims_driver *d);
+
+struct ofono_ims *ofono_ims_create(struct ofono_modem *modem,
+					const char *driver, void *data);
+
+void ofono_ims_register(struct ofono_ims *ims);
+void ofono_ims_remove(struct ofono_ims *ims);
+
+void ofono_ims_set_data(struct ofono_ims *ims, void *data);
+void *ofono_ims_get_data(const struct ofono_ims *ims);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
-- =

1.9.1


--===============0262815595312350091==--

