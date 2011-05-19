Content-Type: multipart/mixed; boundary="===============3232115016424160071=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v6 2/5] private-network: add header into include and
 Makefile.am
Date: Thu, 19 May 2011 11:58:29 +0200
Message-ID: <1305799112-14289-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1305799112-14289-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3232115016424160071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am               |    4 +-
 include/private-network.h |   56 +++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 58 insertions(+), 2 deletions(-)
 create mode 100644 include/private-network.h

diff --git a/Makefile.am b/Makefile.am
index a413a47..d7e5626 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -16,8 +16,8 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/cdma-sms.h include/sim-auth.h \
 			include/gprs-provision.h include/emulator.h \
 			include/location-reporting.h \
-			include/cdma-connman.h \
-			include/gnss.h
+			include/cdma-connman.h include/gnss.h \
+			include/private-network.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

diff --git a/include/private-network.h b/include/private-network.h
new file mode 100644
index 0000000..983bf5b
--- /dev/null
+++ b/include/private-network.h
@@ -0,0 +1,56 @@
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
+#ifndef __OFONO_PRIVATE_NETWORK_H
+#define __OFONO_PRIVATE_NETWORK_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct ofono_private_network_settings {
+	int fd;
+	char *server_ip;
+	char *peer_ip;
+	char *primary_dns;
+	char *secondary_dns;
+};
+
+typedef void (ofono_private_network_cb_t)(
+		void *data,
+		const struct ofono_private_network_settings *settings);
+
+struct ofono_private_network_driver {
+	char *name;
+	int (*request)(ofono_private_network_cb_t cb, void *data);
+	void (*release)(int uid);
+};
+
+int ofono_private_network_driver_register(
+			const struct ofono_private_network_driver *d);
+void ofono_private_network_driver_unregister(
+			const struct ofono_private_network_driver *d);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_PRIVATE_NETWORK_H */
-- =

1.7.1


--===============3232115016424160071==--

