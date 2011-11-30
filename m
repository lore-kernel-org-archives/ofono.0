Content-Type: multipart/mixed; boundary="===============1852226370300803556=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/5] cdma-providers: add driver APIs header
Date: Wed, 30 Nov 2011 22:20:56 +0100
Message-ID: <1322688060-17588-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1322688060-17588-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1852226370300803556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-providers.h |   44 ++++++++++++++++++++++++++++++++++++++++++=
++
 1 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 include/cdma-providers.h

diff --git a/include/cdma-providers.h b/include/cdma-providers.h
new file mode 100644
index 0000000..8ee9e1e
--- /dev/null
+++ b/include/cdma-providers.h
@@ -0,0 +1,44 @@
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
+#ifndef __OFONO_CDMA_PROVIDERS_H
+#define __OFONO_CDMA_PROVIDERS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct ofono_cdma_providers_driver {
+	const char *name;
+	int priority;
+	int (*get_provider_name)(const char *sid, char **name);
+};
+
+int ofono_cdma_providers_driver_register(
+		const struct ofono_cdma_providers_driver *driver);
+void ofono_cdma_providers_driver_unregister(
+		const struct ofono_cdma_providers_driver *driver);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CDMA_PROVIDERS_H */
-- =

1.7.1


--===============1852226370300803556==--

