Content-Type: multipart/mixed; boundary="===============6640760781235319175=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: [PATCH 1/5] cdma-sms: Add CDMA SMS Support
Date: Wed, 08 Dec 2010 16:35:47 -0800
Message-ID: <1291854951-2378-2-git-send-email-lei.2.yu@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6640760781235319175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am        |    2 +-
 include/cdma-sms.h |   69 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/dbus.h     |    4 +++
 src/ofono.h        |    2 +
 4 files changed, 76 insertions(+), 1 deletions(-)
 create mode 100644 include/cdma-sms.h

diff --git a/Makefile.am b/Makefile.am
index cdb3166..13cbc37 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -14,7 +14,7 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/gprs.h include/gprs-context.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
-			include/ctm.h
+			include/ctm.h include/cdma-sms.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

diff --git a/include/cdma-sms.h b/include/cdma-sms.h
new file mode 100644
index 0000000..2e7834d
--- /dev/null
+++ b/include/cdma-sms.h
@@ -0,0 +1,69 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Nokia Corporation. All rights reserved.
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
+#ifndef __OFONO_CDMASMS_H
+#define __OFONO_CDMASMS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_cdmasms;
+
+typedef void (*ofono_cdmasms_submit_cb_t)(const struct ofono_error *error,
+				void *data);
+
+struct ofono_cdmasms_driver {
+	const char *name;
+	int (*probe)(struct ofono_cdmasms *cdmasms, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_cdmasms *cdmasms);
+	void (*submit)(struct ofono_cdmasms *cdmasms, unsigned char *tpdu,
+			int tpdu_len, ofono_cdmasms_submit_cb_t cb, void *data);
+};
+
+void ofono_cdmasms_deliver_notify(struct ofono_cdmasms *cdmasms,
+				unsigned char *pdu, int tpdu_len);
+
+int ofono_cdmasms_driver_register(const struct ofono_cdmasms_driver *d);
+void ofono_cdmasms_driver_unregister(const struct ofono_cdmasms_driver *d);
+
+struct ofono_cdmasms *ofono_cdmasms_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
+void ofono_cdmasms_register(struct ofono_cdmasms *cdmasms);
+void ofono_cdmasms_remove(struct ofono_cdmasms *cdmasms);
+
+void ofono_cdmasms_set_data(struct ofono_cdmasms *cdmasms, void *data);
+void *ofono_cdmasms_get_data(struct ofono_cdmasms *cdmasms);
+
+struct ofono_atom *ofono_cdmasms_get_atom(struct ofono_cdmasms *cdmasms);
+
+const char *ofono_cdmasms_get_path(struct ofono_cdmasms *cdmasms);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CDMASMS_H */
diff --git a/include/dbus.h b/include/dbus.h
index 9e29afb..0587e16 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -55,6 +55,10 @@ extern "C" {
 #define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
 #define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
 =

+/* CDMA Interfaces */
+#define OFONO_CDMA_MESSAGE_MANAGER_INTERFACE "org.ofono.cdma.MessageManage=
r"
+
+
 /* Essentially a{sv} */
 #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
 					DBUS_TYPE_STRING_AS_STRING \
diff --git a/src/ofono.h b/src/ofono.h
index 792134b..9eb58fa 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -126,6 +126,8 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_STK =3D 20,
 	OFONO_ATOM_TYPE_NETTIME =3D 21,
 	OFONO_ATOM_TYPE_CTM =3D 22,
+	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER =3D 23,
+	OFONO_ATOM_TYPE_CDMA_MESSAGE_MANAGER =3D 24,
 };
 =

 enum ofono_atom_watch_condition {
-- =

1.7.0.4


--===============6640760781235319175==--

