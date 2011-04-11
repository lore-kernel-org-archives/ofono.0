Content-Type: multipart/mixed; boundary="===============3004089919031909131=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 01/20] include: add generalised packet headers
Date: Mon, 11 Apr 2011 13:19:59 +0300
Message-ID: <1302517218-2147-2-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3004089919031909131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Files are just a copy-paste of the gprs, gprs-context
and gprs-provision.h. Just the names has been made
more generic.
---
 include/packet-context.h |  126 ++++++++++++++++++++++++++++++++++++++++++=
++++
 include/packet-service.h |   95 ++++++++++++++++++++++++++++++++++
 include/ps-provision.h   |   59 +++++++++++++++++++++
 3 files changed, 280 insertions(+), 0 deletions(-)
 create mode 100644 include/packet-context.h
 create mode 100644 include/packet-service.h
 create mode 100644 include/ps-provision.h

diff --git a/include/packet-context.h b/include/packet-context.h
new file mode 100644
index 0000000..44fd69f
--- /dev/null
+++ b/include/packet-context.h
@@ -0,0 +1,126 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright 2011 EB(Elektrobit).
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
+#ifndef __OFONO_PACKET_CONTEXT_H
+#define __OFONO_PACKET_CONTEXT_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_packet_context;
+
+#define OFONO_PS_MAX_APN_LENGTH 127
+#define OFONO_PS_MAX_USERNAME_LENGTH 63
+#define OFONO_PS_MAX_PASSWORD_LENGTH 255
+
+enum ofono_packet_proto {
+	OFONO_PACKET_PROTO_IP =3D 0,
+	OFONO_PACKET_PROTO_IPV6,
+	OFONO_PACKET_PROTO_IPV4V6,
+};
+
+enum ofono_packet_context_type {
+	OFONO_PACKET_CONTEXT_TYPE_ANY =3D 0,
+	OFONO_PACKET_CONTEXT_TYPE_INTERNET,
+	OFONO_PACKET_CONTEXT_TYPE_MMS,
+	OFONO_PACKET_CONTEXT_TYPE_WAP,
+	OFONO_PACKET_CONTEXT_TYPE_IMS,
+};
+
+struct ofono_packet_context_param {
+	unsigned int cid;
+	int direction;
+	char apn[OFONO_PS_MAX_APN_LENGTH + 1];
+	char username[OFONO_PS_MAX_USERNAME_LENGTH + 1];
+	char password[OFONO_PS_MAX_PASSWORD_LENGTH + 1];
+	enum ofono_packet_proto proto;
+};
+
+typedef void (*ofono_packet_context_cb_t)(const struct ofono_error *error,
+						void *data);
+
+struct ofono_packet_context_driver {
+	const char *name;
+	int (*probe)(struct ofono_packet_context *pc, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_packet_context *pc);
+	void (*activate_context)(struct ofono_packet_context *gc,
+				const struct ofono_packet_context_param *ctx,
+				ofono_packet_context_cb_t cb, void *data);
+	void (*deactivate_context)(struct ofono_packet_context *pc,
+					unsigned int id,
+					ofono_packet_context_cb_t cb,
+					void *data);
+};
+
+void ofono_packet_context_deactivated(struct ofono_packet_context *pc,
+					unsigned int id);
+
+int ofono_packet_context_driver_register(
+				const struct ofono_packet_context_driver *d);
+void ofono_packet_context_driver_unregister(
+				const struct ofono_packet_context_driver *d);
+
+struct ofono_packet_context *ofono_packet_context_create(
+						struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver, void *data);
+void ofono_packet_context_remove(struct ofono_packet_context *pc);
+
+void ofono_packet_context_set_data(struct ofono_packet_context *pc, void *=
data);
+void *ofono_packet_context_get_data(struct ofono_packet_context *pc);
+
+struct ofono_modem *ofono_packet_context_get_modem(
+					struct ofono_packet_context *pc);
+
+void ofono_packet_context_set_type(struct ofono_packet_context *pc,
+					enum ofono_packet_context_type type);
+
+void ofono_packet_context_set_interface(struct ofono_packet_context *pc,
+					const char *interface);
+
+void ofono_packet_context_set_ipv4_address(struct ofono_packet_context *pc,
+						const char *address,
+						gboolean static_ip);
+void ofono_packet_context_set_ipv4_netmask(struct ofono_packet_context *pc,
+						const char *netmask);
+void ofono_packet_context_set_ipv4_gateway(struct ofono_packet_context *pc,
+						const char *gateway);
+void ofono_packet_context_set_ipv4_dns_servers(struct ofono_packet_context=
 *pc,
+						const char **dns);
+
+void ofono_packet_context_set_ipv6_address(struct ofono_packet_context *pc,
+						const char *address);
+void ofono_packet_context_set_ipv6_prefix_length(struct ofono_packet_conte=
xt *gc,
+						unsigned char length);
+void ofono_packet_context_set_ipv6_gateway(struct ofono_packet_context *pc,
+						const char *gateway);
+void ofono_packet_context_set_ipv6_dns_servers(struct ofono_packet_context=
 *pc,
+						const char **dns);
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_PACKET_CONTEXT_H */
diff --git a/include/packet-service.h b/include/packet-service.h
new file mode 100644
index 0000000..bc5eceb
--- /dev/null
+++ b/include/packet-service.h
@@ -0,0 +1,95 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright 2011 EB(Elektrobit).
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
+#ifndef __OFONO_PACKET_SERVICE_H
+#define __OFONO_PACKET_SERVICE_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_packet_service;
+struct ofono_packet_context;
+
+typedef void (*ofono_packet_service_status_cb_t)(
+					const struct ofono_error *error,
+					int status, void *data);
+
+typedef void (*ofono_packet_service_cb_t)(const struct ofono_error *error,
+					void *data);
+
+struct ofono_packet_service_driver {
+	const char *name;
+	int (*probe)(struct ofono_packet_service *ps, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_packet_service *ps);
+	void (*set_attached)(struct ofono_packet_service *ps, int attached,
+				ofono_packet_service_cb_t cb, void *data);
+	void (*attached_status)(struct ofono_packet_service *ps,
+					ofono_packet_service_status_cb_t cb,
+					void *data);
+};
+
+enum packet_service_suspend_cause {
+	PACKET_SERVICE_SUSPENDED_DETACHED,
+	PACKET_SERVICE_SUSPENDED_SIGNALLING,
+	PACKET_SERVICE_SUSPENDED_CALL,
+	PACKET_SERVICE_SUSPENDED_NO_COVERAGE,
+	PACKET_SERVICE_SUSPENDED_UNKNOWN_CAUSE,
+};
+
+void ofono_packet_service_status_notify(struct ofono_packet_service *ps,
+						int status);
+void ofono_packet_service_detached_notify(struct ofono_packet_service *ps);
+void ofono_packet_service_suspend_notify(struct ofono_packet_service *ps,
+						int cause);
+void ofono_packet_service_resume_notify(struct ofono_packet_service *ps);
+void ofono_packet_service_bearer_notify(struct ofono_packet_service *ps,
+					int bearer);
+
+int ofono_packet_service_driver_register(
+				const struct ofono_packet_service_driver *d);
+void ofono_packet_service_driver_unregister(
+				const struct ofono_packet_service_driver *d);
+
+struct ofono_packet_service *ofono_packet_service_create(
+					struct ofono_modem *modem,
+					unsigned int vendor, const char *driver,
+					void *data);
+void ofono_packet_service_register(struct ofono_packet_service *ps);
+void ofono_packet_service_remove(struct ofono_packet_service *ps);
+
+void ofono_packet_service_set_data(struct ofono_packet_service *ps, void *=
data);
+void *ofono_packet_service_get_data(struct ofono_packet_service *ps);
+
+void ofono_packet_service_set_cid_range(struct ofono_packet_service *ps,
+				unsigned int min, unsigned int max);
+void ofono_packet_service_add_context(struct ofono_packet_service *ps,
+					struct ofono_packet_context *pc);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_PACKET_SERVICE_H */
diff --git a/include/ps-provision.h b/include/ps-provision.h
new file mode 100644
index 0000000..2570712
--- /dev/null
+++ b/include/ps-provision.h
@@ -0,0 +1,59 @@
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
+#ifndef __OFONO_PS_PROVISION_H
+#define __OFONO_PS_PROVISION_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "packet-context.h"
+
+struct ofono_ps_provision_data {
+	enum ofono_packet_context_type type;
+	enum ofono_packet_proto proto;
+	char *name;
+	char *apn;
+	char *username;
+	char *password;
+	char *message_proxy;
+	char *message_center;
+};
+
+struct ofono_ps_provision_driver {
+	const char *name;
+	int priority;
+	int (*get_settings)(const char *mcc, const char *mnc, const char *spn,
+				struct ofono_ps_provision_data **settings,
+				int *count);
+};
+
+int ofono_ps_provision_driver_register(
+			const struct ofono_ps_provision_driver *driver);
+void ofono_ps_provision_driver_unregister(
+			const struct ofono_ps_provision_driver *driver);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_PS_PROVISION_H */
-- =

1.7.0.4


--===============3004089919031909131==--

