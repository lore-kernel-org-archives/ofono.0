Content-Type: multipart/mixed; boundary="===============9079916229661374772=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v4 2/5] private-network: add callback typedef drivers and
 settings
Date: Fri, 06 May 2011 16:01:50 +0200
Message-ID: <1304690513-3137-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1304690513-3137-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9079916229661374772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/private-network.h |   59 +++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 include/private-network.h

diff --git a/include/private-network.h b/include/private-network.h
new file mode 100644
index 0000000..ba84a36
--- /dev/null
+++ b/include/private-network.h
@@ -0,0 +1,59 @@
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
+
+#ifndef __OFONO_PRIVATE_NETWORK_H
+#define __OFONO_PRIVATE_NETWORK_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <glib.h>
+
+struct ofono_private_network_settings {
+	int fd;
+	const char *server_ip;
+	const char *peer_ip;
+	const char *primary_dns;
+	const char *secondary_dns;
+};
+
+
+typedef gboolean (ofono_private_network_cb_t)(
+		void *data, struct ofono_private_network_settings *settings);
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


--===============9079916229661374772==--

