Content-Type: multipart/mixed; boundary="===============5984918135481052850=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v6 02/14] cdmamodem: create include file for CDMA netreg.
Date: Fri, 05 Aug 2011 15:21:03 +0200
Message-ID: <1312550475-8537-3-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312550475-8537-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5984918135481052850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am           |    2 +-
 include/cdma-netreg.h |   63 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h           |    1 +
 3 files changed, 65 insertions(+), 1 deletions(-)
 create mode 100644 include/cdma-netreg.h

diff --git a/Makefile.am b/Makefile.am
index 9c56711..95188a9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -17,7 +17,7 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/gprs-provision.h include/emulator.h \
 			include/location-reporting.h \
 			include/cdma-connman.h include/gnss.h \
-			include/private-network.h
+			include/private-network.h include/cdma-netreg.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

diff --git a/include/cdma-netreg.h b/include/cdma-netreg.h
new file mode 100644
index 0000000..8ee7737
--- /dev/null
+++ b/include/cdma-netreg.h
@@ -0,0 +1,63 @@
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
+#ifndef __OFONO_CDMA_NETREG_H
+#define __OFONO_CDMA_NETREG_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_cdma_netreg;
+
+struct ofono_cdma_netreg_driver {
+	const char *name;
+	int (*probe)(struct ofono_cdma_netreg *cdma_netreg,
+				unsigned int vendor,
+				void *data);
+	void (*remove)(struct ofono_cdma_netreg *cdma_netreg);
+};
+
+int ofono_cdma_netreg_driver_register(
+				const struct ofono_cdma_netreg_driver *d);
+void ofono_cdma_netreg_driver_unregister(
+				const struct ofono_cdma_netreg_driver *d);
+
+struct ofono_cdma_netreg *ofono_cdma_netreg_create(
+				struct ofono_modem *modem,
+				unsigned int vendor,
+				const char *driver,
+				void *data);
+
+void ofono_cdma_netreg_register(struct ofono_cdma_netreg *cdma_netreg);
+void ofono_cdma_netreg_remove(struct ofono_cdma_netreg *cdma_netreg);
+
+void ofono_cdma_netreg_set_data(struct ofono_cdma_netreg *cdma_netreg,
+				void *data);
+void *ofono_cdma_netreg_get_data(struct ofono_cdma_netreg *cdma_netreg);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CDMA_NETREG_H */
diff --git a/src/ofono.h b/src/ofono.h
index ef5e77d..5e3a6b5 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -481,6 +481,7 @@ void __ofono_gprs_provision_free_settings(
 #include <ofono/emulator.h>
 #include <ofono/gnss.h>
 #include <ofono/cdma-sms.h>
+#include <ofono/cdma-netreg.h>
 #include <ofono/private-network.h>
 =

 void __ofono_private_network_release(int id);
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============5984918135481052850==--

