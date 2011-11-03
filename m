Content-Type: multipart/mixed; boundary="===============4746315191389692132=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 2/3] include: Add uim atom public api
Date: Thu, 03 Nov 2011 10:45:54 +0100
Message-ID: <1320313555-10320-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1320313555-10320-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4746315191389692132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am    |    2 +-
 include/dbus.h |    1 +
 include/uim.h  |  141 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 143 insertions(+), 1 deletions(-)
 create mode 100644 include/uim.h

diff --git a/Makefile.am b/Makefile.am
index 83b7737..40144c2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -18,7 +18,7 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/location-reporting.h \
 			include/cdma-connman.h include/gnss.h \
 			include/private-network.h include/cdma-netreg.h \
-			include/handsfree.h
+			include/handsfree.h include/uim.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

diff --git a/include/dbus.h b/include/dbus.h
index 44faa7f..4594e90 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -66,6 +66,7 @@ extern "C" {
 #define OFONO_CDMA_CONNECTION_MANAGER_INTERFACE "org.ofono.cdma.Connection=
Manager"
 #define OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE \
 					"org.ofono.cdma.NetworkRegistration"
+#define OFONO_CDMA_UIM_MANAGER_INTERFACE "org.ofono.cdma.UimManager"
 =

 /* Essentially a{sv} */
 #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
diff --git a/include/uim.h b/include/uim.h
new file mode 100644
index 0000000..0b0fb07
--- /dev/null
+++ b/include/uim.h
@@ -0,0 +1,141 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_UIM_H
+#define __OFONO_UIM_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_uim;
+struct ofono_uim_context;
+
+enum ofono_uim_password_type {
+	OFONO_UIM_PASSWORD_NONE =3D 0,
+	OFONO_UIM_PASSWORD_UIM_PIN,
+	OFONO_UIM_PASSWORD_PHUIM_PIN,
+	OFONO_UIM_PASSWORD_PHFUIM_PIN,
+	OFONO_UIM_PASSWORD_UIM_PIN2,
+	OFONO_UIM_PASSWORD_PHNET_PIN,
+	OFONO_UIM_PASSWORD_PHNETSUB_PIN,
+	OFONO_UIM_PASSWORD_PHSP_PIN,
+	OFONO_UIM_PASSWORD_PHCORP_PIN,
+	OFONO_UIM_PASSWORD_UIM_PUK,
+	OFONO_UIM_PASSWORD_PHFUIM_PUK,
+	OFONO_UIM_PASSWORD_UIM_PUK2,
+	OFONO_UIM_PASSWORD_PHNET_PUK,
+	OFONO_UIM_PASSWORD_PHNETSUB_PUK,
+	OFONO_UIM_PASSWORD_PHSP_PUK,
+	OFONO_UIM_PASSWORD_PHCORP_PUK,
+	OFONO_UIM_PASSWORD_INVALID,
+};
+
+enum ofono_uim_state {
+	OFONO_UIM_STATE_NOT_PRESENT,
+	OFONO_UIM_STATE_INSERTED,
+	OFONO_UIM_STATE_LOCKED_OUT,
+	OFONO_UIM_STATE_READY,
+};
+
+typedef void (*ofono_uim_imsi_cb_t)(const struct ofono_error *error,
+					const char *imsi, void *data);
+
+typedef void (*ofono_uim_state_event_cb_t)(enum ofono_uim_state new_state,
+					void *data);
+
+typedef void (*ofono_uim_passwd_cb_t)(const struct ofono_error *error,
+					enum ofono_uim_password_type type,
+					void *data);
+
+typedef void (*ofono_uim_pin_retries_cb_t)(const struct ofono_error *error,
+			int retries[OFONO_UIM_PASSWORD_INVALID], void *data);
+
+typedef void (*ofono_uim_lock_unlock_cb_t)(const struct ofono_error *error,
+					void *data);
+
+typedef void (*ofono_uim_locked_cb_t)(const struct ofono_error *error,
+					int locked, void *data);
+
+struct ofono_uim_driver {
+	const char *name;
+	int (*probe)(struct ofono_uim *uim, unsigned int vendor, void *data);
+	void (*remove)(struct ofono_uim *uim);
+	void (*read_imsi)(struct ofono_uim *uim,
+			ofono_uim_imsi_cb_t cb, void *data);
+	void (*query_passwd_state)(struct ofono_uim *uim,
+			ofono_uim_passwd_cb_t cb, void *data);
+	void (*send_passwd)(struct ofono_uim *uim, const char *passwd,
+			ofono_uim_lock_unlock_cb_t cb, void *data);
+	void (*query_pin_retries)(struct ofono_uim *uim,
+				ofono_uim_pin_retries_cb_t cb, void *data);
+	void (*reset_passwd)(struct ofono_uim *uim, const char *puk,
+			const char *passwd,
+			ofono_uim_lock_unlock_cb_t cb, void *data);
+	void (*change_passwd)(struct ofono_uim *uim,
+			enum ofono_uim_password_type type,
+			const char *old_passwd, const char *new_passwd,
+			ofono_uim_lock_unlock_cb_t cb, void *data);
+	void (*lock)(struct ofono_uim *uim, enum ofono_uim_password_type type,
+			int enable, const char *passwd,
+			ofono_uim_lock_unlock_cb_t cb, void *data);
+	void (*query_locked)(struct ofono_uim *uim,
+			enum ofono_uim_password_type type,
+			ofono_uim_locked_cb_t cb, void *data);
+};
+
+int ofono_uim_driver_register(const struct ofono_uim_driver *d);
+void ofono_uim_driver_unregister(const struct ofono_uim_driver *d);
+
+struct ofono_uim *ofono_uim_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
+void ofono_uim_register(struct ofono_uim *uim);
+void ofono_uim_remove(struct ofono_uim *uim);
+
+void ofono_uim_set_data(struct ofono_uim *uim, void *data);
+void *ofono_uim_get_data(struct ofono_uim *uim);
+
+const char *ofono_uim_get_imsi(struct ofono_uim *uim);
+const char *ofono_uim_get_mcc(struct ofono_uim *uim);
+const char *ofono_uim_get_mnc(struct ofono_uim *uim);
+
+unsigned int ofono_uim_add_state_watch(struct ofono_uim *uim,
+					ofono_uim_state_event_cb_t cb,
+					void *data, ofono_destroy_func destroy);
+
+void ofono_uim_remove_state_watch(struct ofono_uim *uim, unsigned int id);
+
+enum ofono_uim_state ofono_uim_get_state(struct ofono_uim *uim);
+
+void ofono_uim_inserted_notify(struct ofono_uim *uim, ofono_bool_t inserte=
d);
+
+struct ofono_uim_context *ofono_uim_context_create(struct ofono_uim *uim);
+void ofono_uim_context_free(struct ofono_uim_context *context);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_UIM_H */
-- =

1.7.1


--===============4746315191389692132==--

